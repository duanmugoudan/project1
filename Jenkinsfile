pipeline {
  agent any

  environment {
    HARBOR    = '10.0.0.31:80'
    K8S_HOST  = '10.0.0.23'

    IMG_FRONT = "${HARBOR}/frontend/vue-app"
    IMG_BACK  = "${HARBOR}/backend/django-app"

    /* 凭据 ID 需与 Jenkins 中一致 */
    K8S_CREDS = credentials('k8s-root-pw')
  }

  stages {
    /* 1. 确保目录和 Dockerfile 存在 */
    stage('Ensure dirs') {
      steps {
        sh '''
          mkdir -p frontend backend k8s
          test -f frontend/Dockerfile || echo "FROM nginx:alpine" > frontend/Dockerfile
          test -f backend/Dockerfile  || echo "FROM python:3.9-slim" > backend/Dockerfile
        '''
      }
    }
      /* 2.1 SonarQube 静态代码扫描 */
    stage('SonarQube Scan') {
      steps {
        withSonarQubeEnv('mysonarqube') {
          script {
            def scannerHome = tool 'sq-scanner'   // 与全局工具名称保持一致
            sh """
              # 前端
              if [ -f frontend/package.json ]; then
                ${scannerHome}/bin/sonar-scanner \
                  -Dsonar.projectKey=frontend \
                  -Dsonar.sources=frontend/src \
                  -Dsonar.host.url=\${SONAR_HOST_URL} \
                  -Dsonar.login=\${SONAR_AUTH_TOKEN}
              fi

              # 后端
              if [ -f backend/manage.py ]; then
                ${scannerHome}/bin/sonar-scanner \
                  -Dsonar.projectKey=backend \
                  -Dsonar.sources=backend \
                  -Dsonar.host.url=\${SONAR_HOST_URL} \
                  -Dsonar.login=\${SONAR_AUTH_TOKEN}
              fi
            """
          }
        }
      }
    }


    /* 2. 并行构建并推送镜像 */
    stage('Build & Push') {
      parallel {
        stage('Backend') {
          steps {
            script {
              def img = "${IMG_BACK}:${BUILD_NUMBER}"
              sh """
                cd backend
                docker build -t ${img} .
                docker tag ${img} ${IMG_BACK}:latest
                docker login -u admin -p Lzp12345 ${HARBOR}
                docker push ${img}
                docker push ${IMG_BACK}:latest
              """
            }
          }
        }

        stage('Frontend') {
          steps {
            script {
              def img = "${IMG_FRONT}:${BUILD_NUMBER}"
              sh """
                cd frontend
                docker build -t ${img} .
                docker tag ${img} ${IMG_FRONT}:latest
                docker login -u admin -p Lzp12345 ${HARBOR}
                docker push ${img}
                docker push ${IMG_FRONT}:latest
              """
            }
          }
        }
      }
    }

    /* 3. 部署到 K8s（同时下发 Deployment + Service） */
    stage('Deploy & Expose') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'k8s-root-pw',
            usernameVariable: 'USER',
            passwordVariable: 'PASS'
          )
        ]) {
          sh """
            sshpass -p '${PASS}' scp -o StrictHostKeyChecking=no -r ${WORKSPACE}/k8s/* root@${K8S_HOST}:/tmp/k8s-deploy/
            sshpass -p '${PASS}' ssh -o StrictHostKeyChecking=no root@${K8S_HOST} <<'EOF'
set -e
docker login -u admin -p Lzp12345 ${HARBOR}
docker pull ${IMG_FRONT}:${BUILD_NUMBER}
docker pull ${IMG_BACK}:${BUILD_NUMBER}

mkdir -p /tmp/k8s-deploy
sed -i "s|\\\${IMG_FRONT}:.*|${IMG_FRONT}:${BUILD_NUMBER}|g" /tmp/k8s-deploy/frontend.yaml
sed -i "s|\\\${IMG_BACK}:.*|${IMG_BACK}:${BUILD_NUMBER}|g"  /tmp/k8s-deploy/backend.yaml

kubectl apply -f /tmp/k8s-deploy/
kubectl rollout status deploy/frontend
kubectl rollout status deploy/backend

# 前端 NodePort
kubectl patch svc frontend -p '{"spec":{"type":"NodePort"}}' 2>/dev/null || true
NODEPORT=\$(kubectl get svc frontend -o jsonpath='{.spec.ports[0].nodePort}')
echo "Frontend NodePort: \$NODEPORT"
echo "FrontendAccess URL: http://10.0.0.23:\$NODEPORT"

# 后端 NodePort
kubectl patch svc backend -p '{"spec":{"type":"NodePort"}}' 2>/dev/null || true
BACKEND_NODEPORT=\$(kubectl get svc backend -o jsonpath='{.spec.ports[0].nodePort}')
echo "Backend NodePort: \$BACKEND_NODEPORT"
echo "Backend Access URL: http://10.0.0.23:\$BACKEND_NODEPORT"

EOF
          """
        }
      }
    }
  }
}