<template>
  <div>
    <!-- 导航栏 -->
    <!-- 导航栏 -->
    <el-header class="header">
      <div class="logo">新闻头条</div>

      <el-menu mode="horizontal" background-color="#409EFF" text-color="#fff" active-text-color="#ffd04b">
        <el-menu-item @click="index">首页</el-menu-item>
        <el-menu-item v-if="this.user != null" style="color: red;">{{ user.nickname }}</el-menu-item>
        <el-menu-item @click="login" v-if="this.user == null">登录</el-menu-item>
        <el-menu-item @click="logout">退出</el-menu-item>
        <el-menu-item @click="touserPerson">个人中心</el-menu-item>
      </el-menu>
      <div class="search-box">
        <el-input placeholder="请输入搜索内容" class="search-input" v-model="title" prefix-icon="el-icon-search"></el-input>
        <el-button type="primary" class="search-btn" @click="load(1)">搜索</el-button>
      </div>
    </el-header>


    <el-card style="width: 50%;margin-left: 350px;margin-top: 50px;">
      <el-form :model="user" label-width="80px" style="padding-right: 20px">
        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="user.nickname" placeholder="昵称"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="user.name" placeholder="姓名"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="user.phone" placeholder="电话"></el-input>
        </el-form-item>
        <el-form-item label="生日" prop="date">
          <el-input type="date" v-model="user.date" placeholder="生日"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="user.email" placeholder="邮箱"></el-input>
        </el-form-item>
        <el-form-item label="QQ" prop="qq">
          <el-input v-model="user.qq" placeholder="QQ"></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-radio-group v-model="user.sex">
            <el-radio label="男">男</el-radio>
            <el-radio label="女">女</el-radio>
          </el-radio-group>
        </el-form-item>


        <div style="text-align: center; margin-bottom: 20px">
          <el-button type="primary" @click="update">保 存</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "Person",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('honey-user') || '{}')
    }
  },
  created() {

  },
  methods: {
    logout() {
      localStorage.removeItem('honey-user')  // 清除当前的token和用户数据
      this.$router.push('/index')
    },
    index() {
      this.$router.push('/index')
    },
    login() {
      this.$router.push('/login')
    },
    touserPerson() {
      if (this.user.role != 'user') {
        window.location.reload()
      } else {
        this.$router.push('/userperson')
      }
    },
    order() {
      if (this.user.role != 'user') {
        window.location.reload()
      } else {
        this.$router.push('/userorder')
      }
    },

    update() {


      this.$request({
        url: '/mall/update_user_byid',
        method: 'POST',
        data: this.user
      }).then(res => {
        if (res.code === 'ok') {  // 表示成功保存
          this.$message.success('保存成功')
          localStorage.setItem('honey-user', JSON.stringify(this.user))
        } else {
          this.$message.error(res.msg)  // 弹出错误的信息
        }
      })



    },
    handleAvatarSuccess(response, file, fileList) {
      // 把user的头像属性换成上传的图片的链接
      this.user.avatar = response.data
    },
  }
}
</script>

<style scoped>
/* .nav-bar {
  background: #000;
  padding: 0 50px;
}

.nav-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 60px;
}

.logo {
  color: #ff69b4;
  font-size: 24px;
  font-weight: bold;
}

.nav-items {
  display: flex;
  gap: 40px;
}

.nav-item {
  color: #fff;
  cursor: pointer;
  transition: color 0.3s;
}

.nav-item.active {
  color: #ff69b4;
} */


.news-container {
  background: #f5f7fa;
  min-height: 100vh;
}

.header {
  display: flex;
  align-items: center;
  background: #409EFF;
  padding: 0 50px;
}

.logo {
  color: white;
  font-size: 24px;
  margin-right: 40px;
}

.search-box {
  margin-left: auto;
  display: flex;
  align-items: center;
}

.search-input {
  width: 300px;
  margin-right: 10px;
}

.search-btn {
  background: #66b1ff;
  border-color: #66b1ff;
}




/deep/.el-form-item__label {
  font-weight: bold;
}

/deep/.el-upload {
  border-radius: 50%;
}

/deep/.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  border-radius: 50%;
}

/deep/.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
  border-radius: 50%;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
  border-radius: 50%;
}
</style>