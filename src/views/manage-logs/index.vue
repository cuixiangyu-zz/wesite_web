<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <!-- <el-form-item label="设备IP">
        <el-input v-model="defaultQuery.ip" clearable placeholder="请输入设备IP" />
      </el-form-item>-->
      <el-form-item label="操作类型">
        <el-select v-model="defaultQuery.type" placeholder="--请选择--" clearable>
          <el-option value="0" label="--请选择--" />
          <el-option value="1" label="新增" />
          <el-option value="2" label="修改" />
          <el-option value="3" label="删除" />
          <el-option value="4" label="其他" />
          <el-option value="5" label="登录" />
        </el-select>
      </el-form-item>

      <span class="demonstration">开始日期</span>
      <el-date-picker v-model="defaultQuery.startTime" value-format="yyyy-MM-dd" type="date" placeholder="选择日期" />
      <span class="demonstration">结束日期</span>
      <el-date-picker v-model="defaultQuery.endTime" value-format="yyyy-MM-dd" type="date" format="yyyy-MM-dd" placeholder="选择日期" />

      <el-form-item style="margin-right: 50px;">
        <el-button type="primary" @click="getLogs">查询</el-button>
      </el-form-item>
    </el-form>
    <!-- 表格数据 -->
    <!-- :data是element组件引入数据源的入口，相当于被赋值后自动解析数据源 -->
    <el-table border :data="tableData.list" height="600">
      <el-table-column align="center" prop="operaterName" label="操作人员" />
      <el-table-column align="center" prop="type" label="操作类型" />
      <el-table-column align="center" prop="ip" label="IP地址" />
      <el-table-column align="center" prop="dateStr" label="操作时间" />
      <!-- <el-table-column align="center" prop="address" min-width="120" label="操作">
      <template slot-scope="scope">
        <el-button size="mini" type="primary" @click="handleDeviceEdit(scope.$index, scope.row)">编辑</el-button>
      </template>
      </el-table-column>-->
    </el-table>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.total"
      :current-page="defaultQuery.pageNum"
      :page-sizes="[1, 5, 10, 20, 30]"
      :page-size="defaultQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>
<script>
import { getLogList } from '@/api/manageLogs'

export default {
  data() {
    return {
      tableData: null,
      defaultQuery: {
        pageNum: 1,
        pageSize: 10,
        type: '',
        startTime: '',
        endTime: ''
      }
    }
  },

  // 钩子函数 页面加载时触发
  created() {
    this.getLogs()
  },

  methods: {
    // vue里面的方法
    getLogs() {
      // 是引进的request api
      // 此处的this作用域在default{...}
      getLogList(this.defaultQuery).then(res => {
        const list = res.list
        list.forEach(item => {
          if (item.type === 1) {
            item.type = '新增'
          } else if (item.type === 2) {
            item.type = '修改'
          } else if (item.type === 3) {
            item.type = '删除'
          } else if (item.type === 4) {
            item.type = '其他'
          } else if (item.type === 5) {
            item.type = '登录'
          }
        })
        // .then是回调函数 响应就是res
        this.tableData = res
      })
    },
    handleSizeChange(index) {
      this.defaultQuery.pageSize = index
      this.getLogs()
    },
    handleCurrentChange(index) {
      this.defaultQuery.pageNum = index
      this.getLogs()
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
}
</style>

