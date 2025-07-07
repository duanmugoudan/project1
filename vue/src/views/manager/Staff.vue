<template>
  <div>
    <div>
      <el-input style="width: 200px; margin: 0 5px" placeholder="根据姓名查询" v-model="name"></el-input>
      <el-button icon="el-icon-search" @click="load(1)"></el-button>
      <el-button type="success"  style="margin-left: 720px;"  @click="handleAdd">新增</el-button>
    </div>
    <br>
    <el-table :data="tableData" border style="width: 100%"
      @selection-change="handleSelectionChange">
      <el-table-column prop="name" label="姓名"></el-table-column>
      <el-table-column prop="phone" label="手机号"></el-table-column>
      <el-table-column prop="sex" label="性别"></el-table-column>
      <el-table-column prop="addr" label="工位"></el-table-column>
      <el-table-column prop="pic" label="照片">
        <template v-slot="scope">
          <div style="display: flex; align-items: center">
            <el-image style="width: 50px; height: 50px;border-radius: 50px;" v-if="scope.row.pic" :src="scope.row.pic"
              :preview-src-list="[scope.row.pic]"></el-image>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180">
        <template v-slot="scope">
          <el-button type="primary" icon="el-icon-edit" @click="handleEdit(scope.row)"></el-button>
          <el-button type="danger" icon="el-icon-delete" @click="del(scope.row.id)"></el-button>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination @current-change="handleCurrentChange" :current-page="pageNum" :page-size="pageSize"
        layout="total, prev, pager, next" :total="total">
      </el-pagination>
    </div>

    <el-dialog title="员工信息" :visible.sync="fromVisible" width="30%">
      <el-form :model="form" label-width="80px" style="padding-right: 20px" :rules="rules" ref="formRef">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" placeholder="姓名"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="form.phone" placeholder="电话"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input prefix-icon="el-icon-lock" show-password v-model="form.password" placeholder="密码"></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-radio-group v-model="form.sex">
            <el-radio label="男"></el-radio>
            <el-radio label="女"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="照片" prop="pic">
          <el-upload class="avatar-uploader" :action="$baseUrl + '/mall/upload_file_perform'" :file-list="form.pic"
            list-type="picture" :on-success="handleAvatarSuccess1">
            <el-button type="primary">上传照片</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="工位" prop="addr">
          <el-input v-model="form.addr" placeholder="工位"></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>
export default {
  name: "User",
  data() {
    return {
      options: [
      ], // 下拉框的选项列表
      options2: [],
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 5,  // 每页显示的个数
      username: '',
      name: '',
      total: 0,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('honey-user') || '{}'),
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ]
      },
    }
  },
  created() {
    this.load()
  },
  methods: {
    del(id) {
      this.$confirm('您确认删除吗？', '确认删除', { type: "warning" }).then(response => {


        this.$request({
          url: '/mall/del_staff_byid',
          method: 'POST',
          data: {
            id: id,
          }
        }).then(res => {
          if (res.code === 'ok') {  // 表示成功保存
            this.$message.success('删除成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })

      }).catch(() => { })


    },
    handleEdit(row) {   // 编辑数据
      this.form = JSON.parse(JSON.stringify(row))  // 给form对象赋值  注意要深拷贝数据
      this.fromVisible = true   // 打开弹窗
    },
    handleAdd() {   // 新增数据
      this.form = { role: '用户' }  // 新增数据的时候清空数据
      this.fromVisible = true   // 打开弹窗
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/mall/update_staff_byid' : '/mall/add_staff',
            method: 'POST',
            data: this.form
          }).then(res => {
            if (res.code === 'ok') {  // 表示成功保存
              this.$message.success('保存成功')
              this.load(1)
              this.fromVisible = false
            } else {
              this.$message.error(res.msg)  // 弹出错误的信息
            }
          })
        }
      })
    },
    reset() {
      this.name = ''
      this.username = ''
      this.load()
    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/mall/select_staff_all', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          name: this.name
        }
      }).then(res => {
        this.tableData = res.data
        this.total = res.total_count
      })
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleAvatarSuccess1(response, file, fileList) {
      this.form.pic = response.url
    },
  }
}
</script>

<style scoped></style>