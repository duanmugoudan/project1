import Vue from 'vue'
import VueRouter from 'vue-router'


const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Manager',
    component: () => import('../views/Manager.vue'),
    redirect: '/home',  // 重定向到主页
    children: [
      { path: '403', name: 'Auth', meta: { name: '无权限' }, component: () => import('../views/manager/Auth') },
      { path: 'home', name: 'Home', meta: { name: '系统首页' }, component: () => import('../views/manager/Home') },
      { path: 'user', name: 'User', meta: { name: '用户信息' }, component: () => import('../views/manager/User') },
      { path: 'staff', name: 'Staff', meta: { name: '员工信息' }, component: () => import('../views/manager/Staff') },
      { path: 'person', name: 'Person', meta: { name: '个人信息' }, component: () => import('../views/manager/Person') },
      

      { path: 'order', name: 'Order', meta: { name: '订单管理' }, component: () => import('../views/manager/Order') },

     
     
     

      { path: 'tablex', name: 'Tablex', meta: { name: '餐桌信息' }, component: () => import('../views/manager/Tablex') },
      { path: 'news', name: 'News', meta: { name: '新闻信息' }, component: () => import('../views/manager/News') },
     
      { path: 'newsadmin', name: 'Newsadmin', meta: { name: '新闻审核' }, component: () => import('../views/manager/Newsadmin') },
     
     
    ]
  },
 



  { path: '/userorder', name: 'UserOrder', meta: { name: '用户订单' }, component: () => import('../views/UserOrder.vue') },
  
  { path: '/userperson', name: 'Userperson', meta: { name: '用户个人信息' }, component: () => import('../views/UserPerson.vue') },
  { path: '/detail', name: 'Detail', meta: { name: '套餐详情' }, component: () => import('../views/Detail.vue') },
 
  { path: '/index', name: 'Index', meta: { name: '主页' }, component: () => import('../views/Index.vue') },
  { path: '/register', name: 'Register', meta: { name: '注册' }, component: () => import('../views/Register.vue') },
  { path: '/login', name: 'Login', meta: { name: '登录' }, component: () => import('../views/Login.vue') },
  { path: '*', name: '404', meta: { name: '无法访问' }, component: () => import('../views/404.vue') },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})



export default router
