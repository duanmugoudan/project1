<template>
  <div class="news-detail">
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







    <!-- 主要内容区 -->
    <div class="main-content">
      <div class="detail-container">
        <!-- 面包屑导航 -->
        <el-breadcrumb separator="/" class="breadcrumb">
          <el-breadcrumb-item :to="{ path: '/index' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>新闻详情</el-breadcrumb-item>
        </el-breadcrumb>

        <!-- 新闻标题 -->
        <h1 class="news-title">{{ newsData.title }}</h1>

        <!-- 新闻元信息 -->
        <div class="news-meta">
          <span class="meta-item">
            <i class="el-icon-user"></i> {{ newsData.staff_name }}
          </span>
          <span class="meta-item">
            <i class="el-icon-time"></i> {{ newsData.timex }}
          </span>
          <span class="meta-item">
            <i class="el-icon-view"></i> {{ newsData.look }} 阅读
          </span>
          <span class="meta-item">
            <i class="el-icon-collection-tag"></i> {{ newsData.cate }}
          </span>
        </div>

        <!-- 新闻摘要 -->
        <div class="news-summary">
          {{ newsData.simple }}
        </div>

        <!-- 新闻主图 -->
        <div class="news-image">
          <img :src="newsData.pic" alt="新闻主图" />
        </div>

        <!-- 新闻内容 -->
        <div class="news-content">
          <!-- <p class="image-caption">{{ newsData.content }}</p> -->
          <p>{{ newsData.content }}</p>
        </div>







        <!-- 收藏按钮 -->
        <div class="collect-box">
          <el-button :type="isCollected ? 'warning' : 'primary'"
            :icon="isCollected ? 'el-icon-star-on' : 'el-icon-star-off'" @click="handleCollect">
            {{ isCollected ? '已收藏' : '收藏' }} ({{ collectCount }})
          </el-button>
        </div>

        <!-- 评论区域 -->
        <div class="comment-section">
          <el-card class="comment-card">
            <div slot="header" class="comment-header">
              <span>用户评论（{{ comments.length }}）</span>
            </div>

            <!-- 评论列表 -->
            <div class="comment-list">
              <div v-for="(comment, index) in comments" :key="index" class="comment-item">
                <!-- <div class="user-avatar">
                  <el-avatar
                    :src="comment.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'"></el-avatar>
                </div> -->
                <div class="comment-content">
                  <div class="user-info">
                    <span class="username">{{ comment.username }}</span>
                    <span class="comment-time">{{ comment.timex }}</span>
                  </div>
                  <div class="comment-text">{{ comment.content }}</div>
                </div>
              </div>
            </div>

            <!-- 发表评论 -->
            <div class="post-comment">
              <el-input type="textarea" :rows="3" placeholder="请输入您的评论（200字以内）" v-model="commentForm.content"
                maxlength="200" show-word-limit></el-input>
              <div class="comment-action">
                <el-button type="primary" size="medium" @click="submitComment" :disabled="!commentForm.content.trim()">
                  发表评论
                </el-button>
              </div>
            </div>
          </el-card>



        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NewsDetail',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('honey-user')),
      isCollected: false, // 收藏状态
      collectCount: 0,   // 收藏数量
      comments: [],       // 评论列表
      commentForm: {
        content: ''      // 评论内容
      },




      activeIndex: '1',
      loginDialogVisible: false,
      registerDialogVisible: false,
      newsData: {

      },


      relatedNews: [

      ]
    }
  },

  created() {
    this.load(this.$route.query.menuid);
    this.loadComments();
    // 加载收藏状态
    if (localStorage.getItem('honey-user')) {
      this.$request({
        url: '/mall/collect_status',
        method: 'POST',
        data: {
          newsId: this.$route.query.menuid,
          user_id: this.user.id,
        }
      }).then(res => {
        this.isCollected = res.isCollected;
        this.collectCount = res.collectCount;
      })
    }
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
    load(id) {
      this.$request({
        url: '/mall/select_news_byid',
        method: 'POST',
        data: {
          id: id,
        }
      }).then(res => {
        this.newsData = res
        // this.performance.artists = res.performer.split(',')
      })
    },
    goBack() {
      this.$router.go(-1);
    },







    // 处理收藏
    handleCollect() {
      if (!localStorage.getItem('honey-user')) {
        this.$message.warning('请先登录');
        return this.$router.push('/login');
      }

      this.$request({
        url: '/mall/collect',
        method: 'POST',
        data: {
          newsId: this.$route.query.menuid,
          status: !this.isCollected,
          user_id: this.user.id,
        }
      }).then(res => {

        if (res.code == 'ok') {
          this.isCollected = !this.isCollected;
          this.collectCount = res.save_num;
          this.$message.success(this.isCollected ? '收藏成功' : '已取消收藏');
        } else {
          this.$message.error('收藏失败');
        }

      })
    },

    // 提交评论
    submitComment() {
      if (!localStorage.getItem('honey-user')) {
        this.$message.warning('请先登录');
        return this.$router.push('/login');
      }

      this.$request({
        url: '/mall/comment',
        method: 'POST',
        data: {
          newsId: this.$route.query.menuid,
          user_id: this.user.id,
          content: this.commentForm.content
        }
      }).then(res => {
        this.loadComments();
        this.commentForm.content = '';
        this.$message.success('评论发表成功');
      })
    },

    // 加载评论
    loadComments() {
      this.$request({
        url: '/mall/getComment',
        method: 'Post',
        data: {
          newsId: this.$route.query.menuid
        }
      }).then(res => {
        this.comments = res.data;
      })
    }




  }
}
</script>

<style>
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





.main-content {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}

.detail-container {
  background-color: #fff;
  border-radius: 8px;
  padding: 30px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.breadcrumb {
  margin-bottom: 20px;
  font-size: 14px;
  color: #909399;
}

.news-title {
  font-size: 28px;
  color: #303133;
  line-height: 1.4;
  margin: 0 0 20px 0;
  font-weight: 600;
  text-align: center;
}

.news-meta {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 1px solid #ebeef5;
}

.meta-item {
  margin: 0 15px;
  font-size: 14px;
  color: #909399;
}

.meta-item i {
  margin-right: 5px;
}

.news-summary {
  font-size: 16px;
  line-height: 1.8;
  color: #606266;
  background-color: #f8f9fa;
  padding: 15px 20px;
  border-radius: 4px;
  margin-bottom: 30px;
  border-left: 4px solid #409EFF;
}

.news-image {
  margin: 30px 0;
  text-align: center;
}

.news-image img {
  max-width: 100%;
  max-height: 500px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  transition: transform 0.3s;
}

.news-image img:hover {
  transform: scale(1.02);
}

.image-caption {
  font-size: 14px;
  color: #909399;
  text-align: center;
  margin-top: 10px;
}

.news-content {
  font-size: 16px;
  line-height: 1.8;
  color: #606266;
  margin: 40px 0;
}

.news-content p {
  margin-bottom: 20px;
}

.news-content h3 {
  font-size: 20px;
  color: #303133;
  margin: 30px 0 15px 0;
  font-weight: 600;
}

.related-news {
  margin: 50px 0 30px 0;
  padding-top: 30px;
  border-top: 1px solid #ebeef5;
}

.related-title {
  font-size: 20px;
  color: #303133;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #ebeef5;
}

.related-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.related-item {
  padding: 12px 0;
  border-bottom: 1px dashed #e6e6e6;
}

.related-item:last-child {
  border-bottom: none;
}

.related-item a {
  font-size: 16px;
  color: #606266;
  text-decoration: none;
  transition: color 0.3s;
}

.related-item a:hover {
  color: #409EFF;
}

.related-time {
  float: right;
  font-size: 14px;
  color: #909399;
}

.back-btn {
  text-align: center;
  margin-top: 40px;
}

.back-btn .el-button {
  padding: 12px 30px;
  font-size: 16px;
}


















/* 收藏按钮样式 */
.collect-box {
  text-align: center;
  margin: 30px 0;
}

.collect-box .el-button {
  padding: 12px 30px;
  font-size: 16px;
}

/* 评论区域样式 */
.comment-section {
  margin: 40px 0;
}

.comment-card {
  border-radius: 8px;
}

.comment-header {
  font-size: 18px;
  color: #303133;
  font-weight: 600;
}

.comment-item {
  display: flex;
  padding: 15px 0;
  border-bottom: 1px solid #ebeef5;
}

.user-avatar {
  margin-right: 15px;
}

.comment-content {
  flex: 1;
}

.user-info {
  margin-bottom: 8px;
}

.username {
  font-weight: 600;
  color: #303133;
  margin-right: 10px;
}

.comment-time {
  font-size: 12px;
  color: #909399;
}

.comment-text {
  color: #606266;
  line-height: 1.6;
}

.post-comment {
  margin-top: 20px;
}

.comment-action {
  margin-top: 15px;
  text-align: right;
}
</style>