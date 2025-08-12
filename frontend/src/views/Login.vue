<template>
  <div style="height: 100vh; display: flex; align-items: center; justify-content: center; background-color: #ADD8E6">
    <!---#0f9876--->
    <div style="background-color: white; width: 30%;height: 60%; border-radius: 20px; overflow: hidden">
      <div style="flex: 1; display: flex;align-items: center; justify-content: center;margin-top: 20px;">
        <el-form :model="user" style="width: 80%" :rules="rules" ref="loginRef">
          <div style="font-size: 20px;  color: black; font-weight: bold; text-align: center; margin-bottom: 20px">登录新闻系统
          </div>
          <el-form-item prop="username">
            <el-input prefix-icon="el-icon-user" size="medium" placeholder="请输入账号" v-model="user.username"></el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input prefix-icon="el-icon-lock" size="medium" show-password placeholder="请输入密码"
              v-model="user.password"></el-input>
          </el-form-item>
          <el-form-item label="角色" prop="role">
            <el-radio-group v-model="user.role">
              <el-radio label="admin">管理员</el-radio>
              <el-radio label="user">用户</el-radio>
              <el-radio label="staff">发布员</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" style="width: 100%" @click="login">登 录</el-button>
          </el-form-item>



          <div style="display: flex">
            <div style="flex: 1">还没有账号？请 <span style="color: #0f9876; cursor: pointer"
                @click="$router.push('/register')">注册</span></div>
            <!-- <div style="flex: 1; text-align: right"><span style="color: #0f9876; cursor: pointer"
                @click="handleForgetPass">忘记密码</span></div> -->
          </div>
        </el-form>
      </div>
    </div>


    <el-dialog title="忘记密码" :visible.sync="forgetPassDialogVis" width="30%">
      <el-form :model="forgetUserForm" label-width="80px" style="padding-right: 20px">
        <el-form-item label="用户名">
          <el-input v-model="forgetUserForm.username" autocomplete="off" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="forgetUserForm.phone" autocomplete="off" placeholder="请输入手机号"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="forgetPassDialogVis = false">取 消</el-button>
        <el-button type="primary" @click="resetPassword">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import ValidCode from "@/conponents/ValidCode";

export default {
  name: "Login",
  components: {
    ValidCode
  },
  data() {

    return {
      forgetUserForm: {},   // 忘记密码的表单数据
      forgetPassDialogVis: false,
      code: '',  // 验证码组件传递过来的code
      user: {
        code: '',   // 表单里用户输入的code 验证码
        username: '',
        password: ''
      },
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ],
      }
    }
  },
  created() {

  },
  methods: {
    handleForgetPass() {   //  初始化表单的数据
      this.forgetUserForm = {}
      this.forgetPassDialogVis = true
    },
    resetPassword() {
      this.$request.put('/password', this.forgetUserForm).then(res => {
        if (res.code === '200') {
          this.$message.success('重置成功,密码为123')
          this.forgetPassDialogVis = false
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    getCode(code) {
      this.code = code.toLowerCase()
    },
    login() {
      this.$refs['loginRef'].validate((valid) => {
        if (valid) {
          // 验证通过
          this.$request.post('/mall/login', this.user).then(res => {
            if (res.code === 'ok') {

              if (res.role === 'admin') {
                this.$message.success('登录成功')
                localStorage.setItem("honey-user", JSON.stringify(res))  // 存储用户数据
                this.$router.push('/user')

              } else if (res.role === 'user') {
                this.$router.push('/index')
                this.$message.success('登录成功')
                localStorage.setItem("honey-user", JSON.stringify(res))  // 存储用户数据
              }else if (res.role === 'staff') {
                this.$router.push('/news')
                this.$message.success('登录成功')
                localStorage.setItem("honey-user", JSON.stringify(res))  // 存储用户数据
              }  


            } else {
              this.$message.error(res.message)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped></style>