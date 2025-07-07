<template>
  <div>

        <div>
      <el-input style="width: 200px; margin: 0 5px" placeholder="根据标题查询" v-model="title"></el-input>
      <el-button icon="el-icon-search" @click="load(1)"></el-button>
    </div>
    <br>
    <el-table :data="tableData" border style="width: 100%"
      @selection-change="handleSelectionChange">
      <el-table-column prop="title" label="标题"></el-table-column>
      <el-table-column prop="cate" label="分类"></el-table-column>
      <el-table-column prop="simple" label="摘要" show-overflow-tooltip></el-table-column>
      <el-table-column prop="content" label="内容" show-overflow-tooltip></el-table-column>
      <el-table-column prop="staff" label="发布人"></el-table-column>
      <el-table-column prop="pic" label="图片">
        <template v-slot="scope">
          <div style="display: flex; align-items: center">
            <el-image style="width: 70px; height: 70px;" v-if="scope.row.pic" :src="scope.row.pic"
              :preview-src-list="[scope.row.pic]"></el-image>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="timex" label="发布时间" width="200px"></el-table-column>
      <el-table-column prop="status" label="状态"></el-table-column>
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

    <el-dialog title="新闻内容" :visible.sync="fromVisible" width="60%">
      <el-form :model="form" label-width="80px" style="padding-right: 20px" :rules="rules" ref="formRef">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="标题"></el-input>
        </el-form-item>
        <el-form-item label="摘要" prop="simple">
          <el-input type="textarea" v-model="form.simple" placeholder="摘要"></el-input>
        </el-form-item>
        <el-form-item label="分类" prop="cate">
          <el-select v-model="form.cate" placeholder="分类">
            <el-option v-for="item in options" :key="item.value" :label="item.value" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="图片" prop="pic">
          <el-upload class="avatar-uploader" :action="$baseUrl + '/mall/upload_file_perform'" :file-list="form.pic"
            list-type="picture" :on-success="handleAvatarSuccess1">
            <el-button type="primary">上传照片</el-button>
          </el-upload>
        </el-form-item>

        <el-form-item label="内容" prop="content">
          <el-input type="textarea" v-model="form.content" placeholder="内容"></el-input>
        </el-form-item>


        <el-form-item label="审核" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="通过">通过</el-radio>
            <el-radio label="不通过">不通过</el-radio>
          </el-radio-group>
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
        { value: '财经新闻', label: '财经新闻' },
        { value: '科技新闻', label: '科技新闻' },
        { value: '时政新闻', label: '时政新闻' },
        { value: '体育新闻', label: '体育新闻' },
      ],
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 5,  // 每页显示的个数
      username: '',
      name: '',
       title: '',
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
          url: '/mall/del_news_byid',
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
            url: this.form.id ? '/mall/update_news_byid' : '/mall/add_news',
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
      this.$request.get('/mall/select_news_all', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          staff_id: "",
          title: this.title,
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