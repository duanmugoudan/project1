<template>
  <div class="news-container">
    <!-- 导航栏 -->
    <el-header class="header">
      <div class="logo">我是后端</div>
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

    <!-- 轮播图 -->
    <div class="carousel-container">
      <el-carousel :interval="4000" type="card" height="300px">
        <el-carousel-item v-for="(item, index) in carouselItems" :key="index">
          <img :src="item.image" class="carousel-image" />
          <div class="carousel-title">{{ item.title }}</div>
        </el-carousel-item>
      </el-carousel>
    </div>

    <!-- 主体内容 -->
    <div class="main-content">
      <!-- 最新新闻 -->
      <div class="news-list">
        <h2 class="section-title">最新新闻</h2>
        <div v-for="(news, index) in newsList" :key="index" class="news-item">
          <el-card shadow="hover">
            <div class="news-content"  @click="navigateTo(news.id)">
              <img :src="news.pic" class="news-img">
              <div class="news-info">
                <h3>{{ news.title }}</h3>
                <p class="news-desc">{{ news.simple }}</p>
                <div class="news-meta">
                  <span class="source">{{ news.cate }}</span>
                  &nbsp;&nbsp;
                  <span class="time">{{ news.timex }}</span>
                </div>
              </div>
            </div>
          </el-card>
        </div>


        <!-- 分页器 -->
        <div style="display: flex; justify-content: center;">
          <div style="margin: 10px 0">
            <el-pagination @current-change="handleCurrentChange" :current-page="pageNum" :page-size="pageSize"
              layout="total, prev, pager, next" :total="total">
            </el-pagination>
          </div>
        </div>

      </div>

      <!-- 排行榜 -->
      <div class="ranking">
        <h2 class="section-title">点击量排行榜</h2>
        <el-card class="ranking-list">
          <div v-for="(item, index) in ranking" :key="index" class="ranking-item">
            <span class="rank-num">{{ index + 1 }}</span>
            <span class="rank-title"  @click="navigateTo(item.id)">{{ item.title }}</span>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
import { processImageUrls } from '@/utils/imageUtils'


export default {
  data() {
    return {
      title: "",
      pageNum: 1,   // 当前的页码
      pageSize: 5,  // 每页显示的个数
      total: 0,
      user: JSON.parse(localStorage.getItem('honey-user')),
      carouselItems: [
        {
          image: require('@/assets/bbx1.jpeg'),
          title: '全球气候变化峰会今日召开'
        },
        {
          image: require('@/assets/bbx2.jpeg'),
          title: '科技创新引领未来发展'
        },
        {
          image: require('@/assets/bbx3.jpg'),
          title: '体育赛事精彩瞬间回顾'
        },
      ],
      newsList: [
        {
          title: '国家发布最新经济政策，助力中小企业发展',
          content: '近日，国家发布了一系列支持中小企业发展的政策措施...',
          source: '经济日报',
          time: '2025-05-15 10:30'
        },
        // 其他新闻数据...
      ],
      ranking: [
        { title: '国家发布最新经济政策，助力中小企业发展' },
        // 其他排行榜数据...
      ]
    }
  },

  created() {
    this.load()
  },
  methods: {
    logout() {
      localStorage.removeItem('honey-user')  // 清除当前的token和用户数据
      location.reload();
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


    navigateTo(cardid) {
      if (this.user != null) {
        window.location.href = '/detail?menuid=' + cardid;
      }else{
        this.$message.error('请先登录');
      }

    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/mall/select_news_allx', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title
        }
      }).then(res => {
        this.newsList = processImageUrls(res.data, 'pic')
        this.total = res.total_count
      })



      this.$request.get('/mall/select_news_ally').then(res => {
        res.data.sort((b,a)=>a.look-b.look)
        this.ranking=res.data
      })

    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleSearch() {
      // 处理搜索逻辑
      console.log('搜索内容:', this.searchText);
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

/* .carousel {
  margin-top: 20px;
}

.carousel-item {
  height: 400px;
  background: #fff;
  position: relative;
}

.carousel-item h3 {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0,0,0,0.5);
  color: white;
  padding: 20px;
} */


.carousel-container {
  margin-bottom: 30px;
}

.carousel-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.carousel-title {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 15px;
  background: rgba(0, 0, 0, 0.5);
  color: #fff;
  font-size: 18px;
}

.content-container {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}


.main-content {
  display: flex;
  margin: 20px 50px;
}

.news-list {
  flex: 3;
  margin-right: 20px;
}

.ranking {
  flex: 1;
}

.section-title {
  color: #409EFF;
  border-left: 4px solid #409EFF;
  padding-left: 10px;
  margin: 20px 0;
}

.news-item {
  margin-bottom: 20px;
}

.news-content {
  display: flex;
}

.news-img {
  width: 200px;
  height: 150px;
  margin-right: 20px;
}

.news-desc {
  color: #666;
  line-height: 1.5;
}

.news-meta {
  margin-top: 10px;
  color: #999;
}

.ranking-list {
  padding: 15px;
}

.ranking-item {
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.rank-num {
  display: inline-block;
  width: 20px;
  color: #409EFF;
  font-weight: bold;
}

.rank-title {
  margin-left: 10px;
  cursor: pointer;
}
</style>