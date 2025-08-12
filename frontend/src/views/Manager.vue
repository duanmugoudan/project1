<template>
  <div>
    <el-container style="height: 100vh; border: 1px solid #eee">
      <!--    侧边栏  -->
      <el-aside width="200px" style="background-color:#ADD8E6">
        <div
          style="color:white;font-size: 20px; margin-top:20px; margin-left:-35px; text-align: center;height: 30px;line-height: 30px;font-weight:bold;">
          新闻系统</div>

        <el-menu style="border: none" background-color="#ADD8E6" text-color="white" active-text-color="yellow" router
          :default-active="$route.path">

          <el-submenu index="yonghuadmin" v-if="user.role === 'admin'">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item index="/user" v-if="user.role === 'admin'">
              用户信息</el-menu-item>
          </el-submenu>


          <el-submenu index="staffadmin" v-if="user.role === 'admin'">
            <template slot="title">
              <i class="el-icon-s-custom"></i>
              <span>发布员管理</span>
            </template>
            <el-menu-item index="/staff" v-if="user.role === 'admin'">
              发布员信息</el-menu-item>
          </el-submenu>





          <el-submenu index="newsadmin" v-if="user.role === 'admin'">
            <template slot="title">
              <i class="el-icon-folder"></i>
              <span>新闻管理</span>
            </template>
            <el-menu-item index="/newsadmin" v-if="user.role === 'admin'">
              新闻审核</el-menu-item>
          </el-submenu>

















          <el-submenu index="newstaff" v-if="user.role === 'staff'">
            <template slot="title">
              <i class="el-icon-folder"></i>
              <span>新闻管理</span>
            </template>
            <el-menu-item index="/news" v-if="user.role === 'staff'">
              新闻发布</el-menu-item>
          </el-submenu>















        </el-menu>

      </el-aside>

      <el-container>
        <!--        头部区域-->
        <el-header>


          <div style="flex: 1; width: 0; display: flex; align-items: center; justify-content: flex-end">

            <el-dropdown placement="bottom" v-if="this.user.role=='admin' || this.user.role=='staff'">
              <div style="display: flex; align-items: center; cursor: default">
                <span>{{ user.name }}</span>
              </div>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>


            <el-dropdown placement="bottom" v-if="this.user.role=='用户'">
              <div style="display: flex; align-items: center; cursor: default">
                <span>{{ user.name }}</span>
              </div>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item @click.native="$router.push('/index')">返回首页</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>

        </el-header>

        <!--        主体区域-->
        <el-main>
          <router-view @update:user="updateUser" />
        </el-main>

      </el-container>


    </el-container>
  </div>
</template>

<script>

import user from "@/views/manager/User";

export default {
  name: 'HomeView',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('honey-user') || '{}'),
    }
  },
  mounted() {   // 页面加载完成之后触发
    if (!this.user) {   // 当前的浏览器没有用户信息
      this.$router.push('/login')
    }
  },
  methods: {
    updateUser(user) {   // 获取子组件传过来的数据  更新当前页面的数据
      this.user = JSON.parse(JSON.stringify(user))  // 让父级的对象跟子级的对象毫无关联
    },
    logout() {
      localStorage.removeItem('honey-user')  // 清除当前的token和用户数据
      this.$router.push('/index')
    },
  }
}
</script>

<style>
.el-header {
  box-shadow: 2px 0 6px rgba(0, 21, 41, .35);
  display: flex;
  align-items: center;
}
</style>
