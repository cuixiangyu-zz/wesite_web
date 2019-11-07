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
        <el-button type="primary" @click="getCompleteList">查询</el-button>
      </el-form-item>
      <el-form-item style="margin-left: 50px;">
        <el-button v-if="checkBoxVisible" type="primary" @click="batchEdit">转入未诊队列</el-button>
      </el-form-item>
    </el-form>

    <!-- 用户数据表格 -->
    <el-table :data="tableData.list" border style="width: 100%" @selection-change="changeFun">
      <el-table-column
        v-if="checkBoxVisible"
        type="selection"
        prop="checked"
        label="批量转诊"
        align="center"
      />
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
          <el-button
            size="mini"
            type="primary"
            @click="changetoWaitListById(scope.$index, scope.row)"
          >转入未诊队列</el-button>
        </template>
      </el-table-column>
    </el-table>

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
import { getCompleteList, changetoWaitList } from '@/api/nurseDoneList'
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
      defaltQuery: {
        pageNum: 1,
        pageSize: 10,
        sectionsId: '',
        userName: '',
        doctor: '',
        queueNo: ''
      },
      changetoWaitList: {
        doctor: '',
        selectData: {}
      },
      doctorList: {},
      sectionsList: {},
      tableData: null
    }
  },
  created() {
    this.getCompleteList()
  },
  methods: {
    // getUsersList() {
    //   getUsersList(this.defaltQuery).then(res => {
    //     res.list.forEach(item => {
    //       if (item.sex === 0) {
    //         item.sex = '男'
    //       }
    //       if (item.sex === 1) {
    //         item.sex = '女'
    //       }
    //       item.createTime = moment(item.createTime).format('YYYY-MM-DD')
    //     })
    //     this.tableData = res
    //   })
    // },
    getCompleteList() {
      getCompleteList(this.defaltQuery).then(res => {
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
      this.getCompleteList()
    },
    handleCurrentChange(index) {
      this.defaltQuery.pageNum = index
      this.getCompleteList()
    },
    // selectPatient() {
    //   if (this.checkBoxVisible === true) {
    //     this.checkBoxVisible = false
    //   } else {
    //     this.checkBoxVisible = true
    //   }
    // },
    changeFun(val) {
      const arr = []
      val.forEach(element => {
        arr.push(element.id)
      })
      this.changetoWaitList.selectData = arr
    },
    batchEdit() {
      if (
        this.changetoWaitList.selectData === undefined ||
        this.changetoWaitList.selectData.length <= 0 ||
        this.changetoWaitList.selectData.length === undefined
      ) {
        alert('请选择转诊患者')
      } else {
        changetoWaitList(this.changetoWaitList).then(res => {
          this.changeClinicFormVisible = false
          this.getCompleteList()
        })
      }
    },

    changetoWaitListById(index, row) {
      const arr = []
      arr.push(row.id)
      this.changetoWaitList.selectData = arr
      this.batchEdit()
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
}
</style>
