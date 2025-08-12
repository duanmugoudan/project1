<template>
  <div>
    <br>
    <el-table :data="tableData" stripe :header-cell-style="{ backgroundColor: 'aliceblue', color: '#666' }"
      @selection-change="handleSelectionChange">
      <el-table-column prop="code" label="订单号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="user" label="下单人"></el-table-column>
      <el-table-column prop="tablex_id" label="桌号"></el-table-column>
      <el-table-column prop="foodlist" label="食物清单" show-overflow-tooltip></el-table-column>
      <el-table-column prop="date" label="下单时间" show-overflow-tooltip></el-table-column>
      <el-table-column prop="price" label="订单总价"></el-table-column>
      <el-table-column prop="status" label="订单状态"></el-table-column>
      <el-table-column label="操作" align="center" width="180">
        <template v-slot="scope">
          <el-button type="primary" icon="el-icon-edit" v-if="scope.row.status == '已下单,待出餐'"
            @click="handleEdit(scope.row)">出餐</el-button>
          <el-button type="danger" icon="el-icon-delete" @click="del(scope.row.id)"></el-button>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination @current-change="handleCurrentChange" :current-page="pageNum" :page-size="pageSize"
        layout="total, prev, pager, next" :total="total">
      </el-pagination>
    </div>



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
          url: '/mall/del_orderx_byid',
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
      // this.fromVisible = true   // 打开弹窗
      this.$confirm('您确认出餐吗？', '确认出餐', { type: "warning" }).then(response => {

        this.form.status = '已出餐'
        this.$request({
          url: '/mall/update_orderx_byid',
          method: 'POST',
          data:this.form
        }).then(res => {
          if (res.code === 'ok') {  // 表示成功保存
            this.$message.success('出餐成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })

      }).catch(() => { })
    },
    handleAdd() {   // 新增数据
      this.form = { role: '用户' }  // 新增数据的时候清空数据
      this.fromVisible = true   // 打开弹窗
    },

    reset() {
      this.name = ''
      this.username = ''
      this.load()
    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/mall/select_orderx_all', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          user_id: "",
        }
      }).then(res => {
        this.tableData = res.data
        this.total = res.total_count
      })
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped></style>