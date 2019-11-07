<template>
  <div v-if="tableData" class="main">
    <!-- 表格数据 -->
    <el-table border :data="tableData.list" style="width: 100%">
      <el-table-column align="center" prop="clinic.clinicName" label="诊室" width="180" />
      <el-table-column prop="clinic.clinicNo" label="诊室号" width="180" />
      <el-table-column prop="doctor.name" label="签到医生" width="180" />
      <el-table-column prop="edit" min-width="120" label="操作">
        <template slot-scope="scope">
          <el-button size="mini" type="primary" @click="doctorSignn(scope.$index, scope.row)">签到</el-button>
          <el-button size="mini" type="danger" @click="doctorSignn(scope.$index, scope.row)">替换医生</el-button>
          <el-button size="mini" @click="backSign(scope.$index, scope.row)">签退</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 签到弹窗 -->
    <el-dialog title="医生签到" :visible.sync="doctorSignFormVisible" width="30%">
      <el-form :model="signDoctor">
        <el-form-item label="医生姓名">
          <el-select v-model="signDoctor.doctorId" placeholder="请选择" value-key="id">
            <el-option
              v-for="item in doctorList"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmSign">确定</el-button>
        <el-button @click="doctorSignFormVisible = false">取 消</el-button>
      </div>
    </el-dialog>
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
import {
  getClinicList,
  backSign,
  doctorSignn,
  getNotSignDoctorBySectionId
} from '@/api/doctorSign'
export default {
  data() {
    return {
      tableData: null,
      doctorSignFormVisible: false,
      defaultQuery: {
        pageNum: 1,
        pageSize: 10,
        sectionId: ''
      },
      selectDoctor: {
        doctor: ''
      },
      doctorList: {},
      signDoctor: {
        doctorId: '',
        clinicId: ''
      }
    }
  },
  // 钩子函数 页面加载时触发
  created() {
    this.getClinic()
  },
  methods: {
    // vue里面的方法
    getClinic() {
      // 是引进的request api
      getClinicList(this.defaultQuery).then(res => {
        // .then是回调函数 响应就是res
        this.tableData = res
      })
    },
    handleSizeChange(index) {
      this.defaultQuery.pageSize = index
      this.getClinic()
    },
    handleCurrentChange(index) {
      this.defaultQuery.pageNum = index
      this.getClinic()
    },

    doctorSignn(index, row) {
      console.log(row)
      this.signDoctor.doctorId = ''
      this.signDoctor.clinicId = row.clinic.id
      this.defaultQuery.sectionId = row.clinic.sectionsId
      this.getNotSignDoctorBySectionId()
      this.doctorSignFormVisible = true
    },
    confirmSign() {
      this.doctorSignFormVisible = false
      doctorSignn(this.signDoctor).then(res => {
        this.$message({
          message: '上班成功!',
          type: 'success'
        })
        this.getClinic()
      })
    },
    backSign(index, row) {
      this.$confirm('医生确定下班？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.signDoctor.doctorId = row.doctor.id
        backSign(this.signDoctor).then(res => {
          this.$message({
            message: '下班成功!',
            type: 'success'
          })
          this.getClinic()
        })
      })
    },
    getNotSignDoctorBySectionId() {
      getNotSignDoctorBySectionId(this.defaultQuery).then(res => {
        // .then是回调函数 响应就是res
        this.doctorList = res
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
