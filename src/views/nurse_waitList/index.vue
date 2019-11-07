<template>
  <div v-if="tableData" class="main">
    <!-- 查询用户表单 -->
    <el-form :inline="true">
      <el-form-item label="患者姓名">
        <el-input v-model="defaltQuery.userName" clearable placeholder="请输入患者姓名" />
      </el-form-item>
      <el-form-item label="票号">
        <el-input v-model="defaltQuery.queueNo" clearable placeholder="请输入票号" />
      </el-form-item>
      <el-form-item label="科室">
        <el-select v-model="defaltQuery.sectionsId" placeholder="请选择" value-key="id">
          <el-option
            v-for="item in sectionsList"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="医生">
        <el-select v-model="defaltQuery.doctor" placeholder="请选择" value-key="id" clearable>
          <el-option
            v-for="item in doctorList"
            :key="item.name"
            :label="item.name"
            :value="item.name"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getNotCompleteList">查询</el-button>
      </el-form-item>
      <el-form-item style="margin-left: 50px;">
        <el-button type="primary" @click="batchEdit">批量转诊</el-button>
      </el-form-item>
    </el-form>

    <!-- 用户数据表格 -->
    <el-table :data="tableData.list" border style="width: 100%" @selection-change="changeFun">
      <el-table-column type="selection" prop="checked" label="批量转诊" align="center" />
      <el-table-column prop="name" label="患者姓名" align="center" width="150%" />
      <el-table-column prop="sex" label="性别" align="center" width="120%" />
      <el-table-column prop="status" label="就诊状态" align="center" width="120%" />
      <el-table-column prop="queueNo" label="票号" align="center" width="120%" />
      <el-table-column prop="orderNo" label="排队号" align="center" width="120%" />
      <el-table-column prop="sections.name" label="科室名" align="center" width="150%" />
      <el-table-column prop="doctor.name" label="医生名" align="center" width="150%" />
      <el-table-column prop="clinic.clinicName" label="诊室名" align="center" width="150%" />
      <el-table-column prop="edit" label="操作">
        <template slot-scope="scope">
          <el-button size="mini" type="primary" @click="insertQueue(scope.$index, scope.row)">插队</el-button>
          <el-button size="mini" @click="changeClinicById(scope.$index, scope.row)">转诊</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 转诊弹窗 -->
    <el-dialog title="转诊" :visible.sync="changeClinicFormVisible" width="30%" align="center">
      <el-form :model="changeClinic">
        <el-form-item label="医生">
          <el-select v-model="changeClinic.doctor" placeholder="请选择" value-key="id">
            <el-option
              v-for="item in changeClinicDoctorList"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmEdit">保 存</el-button>
        <el-button @click="changeClinicFormVisible = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 插队弹窗 -->
    <el-dialog title="插队" :visible.sync="insertQueueFormVisible" width="30%" align="center">
      <el-form ref="insertForm" :model="insertQueueData" :rules="rules">
        <el-form-item label="插队票号" prop="orderNo">
          <el-input v-model.number="insertQueueData.orderNo" placeholder="请输入票号" clearable />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmInsert">确 定</el-button>
        <el-button @click="insertQueueFormVisible = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.total"
      :current-page="defaltQuery.pageNum"
      :page-sizes="[1, 5, 10, 20, 30]"
      :page-size="defaltQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>

<script>
// const moment = require('moment')
import {
  getNotCompleteList,
  batchEdit,
  insertQueues,
  getSignDoctor
} from '@/api/nurseWaitList'
export default {
  data() {
    return {
      name: '',
      sex: '',
      status: '',
      queueNo: '',
      orderNo: '',
      sectionName: '',
      doctorName: '',
      clinicName: '',
      checked: true,
      checkBoxVisible: true,
      changeClinicFormVisible: false,
      insertQueueFormVisible: false,
      defaltQuery: {
        pageNum: 1,
        pageSize: 10,
        sectionsId: '',
        userName: '',
        doctor: '',
        queueNo: ''
      },
      changeClinic: {
        doctor: '',
        selectData: {}
      },
      insertQueueData: {
        orderNo: '',
        patientId: ''
      },
      rules: {
        orderNo: [
          { required: true, message: '请输入要插入的票号', trigger: 'blur' },
          { type: 'number', message: '票号必须为数字值' }
        ]
      },
      doctorList: {},
      changeClinicDoctorList: {},
      sectionsList: {},
      tableData: null
    }
  },
  created() {
    this.getNotCompleteList()
  },
  methods: {
    getNotCompleteList() {
      getNotCompleteList(this.defaltQuery).then(res => {
        for (const item of res.pageInfos.list) {
          if (item.sex === 0) {
            item.sex = '男'
          } else {
            item.sex = '女'
          }
          if (item.status === 1) {
            item.status = '候诊'
          } else if (item.status === 2) {
            item.status = '就诊'
          } else {
            item.status = '就诊完成'
          }
        }
        this.tableData = res.pageInfos
        this.doctorList = res.allSignDoctorBySectionId
        this.sectionsList = res.sections
      })
    },
    handleSizeChange(pageSize) {
      this.defaltQuery.pageSize = pageSize
      this.getNotCompleteList()
    },
    handleCurrentChange(index) {
      this.defaltQuery.pageNum = index
      this.getNotCompleteList()
    },

    changeFun(val) {
      const arr = []
      val.forEach(element => {
        arr.push(element.id)
      })
      this.changeClinic.selectData = arr
    },
    batchEdit() {
      if (
        this.changeClinic.selectData === undefined ||
        this.changeClinic.selectData.length <= 0 ||
        this.changeClinic.selectData.length === undefined
      ) {
        alert('请选择转诊患者')
      } else {
        this.getSignDoctor()
        this.changeClinicFormVisible = true
      }
    },
    confirmEdit() {
      if (this.changeClinic.selectData === null) {
        this.changeClinicFormVisible = false
        return
      }
      batchEdit(this.changeClinic).then(res => {
        this.changeClinicFormVisible = false
        this.getNotCompleteList()
      })
    },
    changeClinicById(index, row) {
      const arr = []
      arr.push(row.id)
      this.changeClinic.selectData = arr
      this.batchEdit()
    },
    insertQueue(index, row) {
      this.insertQueueData.patientId = row.id
      this.insertQueueFormVisible = true
    },
    confirmInsert() {
      this.$refs.insertForm.validate(valid => {
        if (valid) {
          // console.log(this.insertQueueData)
          insertQueues(this.insertQueueData).then(res => {
            this.insertQueueFormVisible = false
            this.getNotCompleteList()
          })
        } else {
          return false
        }
      })
    },
    getSignDoctor() {
      this.changeClinic.doctor = ''
      this.changeClinicDoctorList = ''
      getSignDoctor(this.changeClinic).then(res => {
        console.log(res)
        this.changeClinicDoctorList = res
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
