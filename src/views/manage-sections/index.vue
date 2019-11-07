<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="科室名称">
        <el-input v-model="defaultQuery.name" clearable placeholder="" />
      </el-form-item>
      <el-form-item label="HIS编码">
        <el-input v-model="defaultQuery.hisCode" clearable placeholder="" />
      </el-form-item>
      <el-form-item style="margin-right: 50px;">
        <el-button type="primary" @click="getSections">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="exportExcel">导出</el-button>
      </el-form-item>
    </el-form>

    <!-- 表格数据 -->
    <el-table border :data="tableData.list" style="width: 100%">
      <el-table-column prop="id" label="ID" />
      <el-table-column prop="name" label="科室名称" width="180" />
      <el-table-column prop="hisCode" label="HIS编码" />
      <el-table-column prop="passVisitNum" label="过号插入数" />
      <el-table-column prop="reVisitNum" label="复诊插入数" />
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
</template>s
<script>
import { getSectionsPage, exportExcel } from '@/api/manageSections'
export default {
  data() {
    return {
      tableData: null,
      defaultQuery: {
        pageNum: 1,
        pageSize: 10,
        name: '',
        hisCode: ''
      }
    }
  },
  // 钩子函数 页面加载时触发
  created() {
    this.getSections()
  },
  methods: {
    getSections() {
      getSectionsPage(this.defaultQuery).then(res => {
        this.tableData = res
      })
    },
    handleSizeChange(index) {
      this.defaultQuery.pageSize = index
      this.getSections()
    },
    handleCurrentChange(index) {
      this.defaultQuery.pageNum = index
      this.getSections()
    },
    exportExcel() {
      exportExcel(this.defaultQuery).then(res => {
        if (res) {
          const url = window.URL.createObjectURL(new Blob([res]))
          console.log(res.fileNames)
          const link = document.createElement('a')
          link.style.display = 'none'
          link.href = url
          link.setAttribute('download', '科室信息.xlsx')
          document.body.appendChild(link)
          link.click()
        } else {
          return
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
}
</style>
