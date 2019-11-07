<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="科室">
        <el-select v-model="defaultQuery.sectionsId" clearable filterable placeholder="请选择">
          <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="诊室号">
        <el-input v-model="defaultQuery.clinicNo" clearable placeholder />
      </el-form-item>
      <el-form-item label="诊室名称">
        <el-input v-model="defaultQuery.clinicName" clearable placeholder />
      </el-form-item>
      <el-form-item style="margin-right: 50px;">
        <el-button type="primary" @click="getClinic">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="addClinic">新增诊室</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="exportExcel">导出</el-button>
      </el-form-item>
      <!-- <el-form-item label="照片" label-width="100px" prop="imgUrl">
        <img :src="imgSrc" style="width: 60%;height: 60%">
      </el-form-item> -->
    </el-form>

    <!-- 表格数据 -->
    <el-table border :data="tableData.list" style="width: 100%">
      <el-table-column prop="clinicName" label="诊室" width="180" />
      <el-table-column prop="clinicNo" label="诊室号" width="180" />
      <el-table-column prop="hisCode" label="HIS编码" />
      <el-table-column prop="sectionname" label="科室" />
      <el-table-column prop="address" min-width="120" label="操作">
        <template slot-scope="scope">
          <el-button size="mini" type="primary" @click="editClinic(scope.$index, scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="deleteClinic(scope.$index, scope.row)">删除</el-button>
          <el-button size="mini" type="danger" @click="assignDevice(scope.$index, scope.row)">分配设备</el-button>
        </template>
      </el-table-column>
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

    <!-- 新增诊室 -->
    <el-dialog :title="formTitle" :visible.sync="clinicAddFormVisible" width="30%">
      <el-form ref="clinicForm" :model="formQuery" :rules="formRules" class="demo-ruleForm">
        <el-form-item v-if="formTitle==='编辑诊室'" hidden="true" label="ID" label-width="100px">
          <el-input v-model="formQuery.id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="诊室号" label-width="100px" prop="clinicNo">
          <el-input v-model="formQuery.clinicNo" autocomplete="off" />
        </el-form-item>
        <el-form-item label="诊室名" label-width="100px" prop="clinicName">
          <el-input v-model="formQuery.clinicName" autocomplete="off" />
        </el-form-item>
        <el-form-item label="科室" label-width="100px" prop="sectionsId">
          <el-select v-model="formQuery.sectionsId" filterable placeholder="请选择">
            <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :disabled="btnLoading" @click="confirmForm">保 存</el-button>
        <el-button @click="cancle">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 分配设备弹窗 -->
    <el-dialog title="分配设备" :visible.sync="changeDeviceVisible" width="30%">
      <el-cascader-multi
        v-model="clinicDevicepojo.checkList"
        :data="deviceList"
        filterable
        reserve-keyword
      />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="addDevices">保 存</el-button>
        <el-button @click="changeDeviceVisible = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import {
  getClinicList,
  addClinic,
  updateClinic,
  deleteClinic,
  getClinicDevice,
  setClinicDevice,
  exportExcel
} from '@/api/manageClinic'
import { getSectionsList } from '@/api/manageSections'
export default {
  data() {
    return {
      tableData: null,
      defaultQuery: {
        pageNum: 1,
        pageSize: 10,
        sectionsId: '',
        clinicNo: '',
        clinicName: ''
      },
      formRules: {
        clinicNo: {
          required: true,
          message: '请输入诊室号！',
          trigger: 'blur'
        },
        clinicName: {
          required: true,
          message: '请输入诊室名称！',
          trigger: 'blur'
        },
        sectionsId: { required: true, message: '请选择科室！', trigger: 'blur' }
      },
      clinicAddFormVisible: false,
      formQuery: {
        id: '',
        clinicName: '',
        clinicNo: '',
        sectionsId: ''
      },
      secitonsOption: '',
      btnLoading: false,
      formTitle: '新增诊室',
      deviceList: '',
      changeDeviceVisible: false,
      selectedOptions: null,
      props: { multiple: true },
      clinicDevicepojo: {
        checkList: null,
        clinicId: null
      },
      imgSrc: 'E:/picture/_MG_0138.jpg'
    }
  },
  // 钩子函数 页面加载时触发
  created() {
    // this.getSections()
  },
  methods: {
    // vue里面的方法
    getClinic() {
      // 是引进的request api
      getClinicList(this.defaultQuery).then(res => {
        // .then是回调函数 响应就是res
        res.list.forEach(item => {
          this.options.forEach(list => {
            if (item.sectionsId === list.id) {
              item.sectionname = list.name
            }
          })
        })
        this.tableData = res
      })
    },
    getSections() {
      // 是引进的request api
      getSectionsList().then(res => {
        // .then是回调函数 响应就是res
        this.options = res
        this.getClinic()
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
    deleteClinic(index, row) {
      this.$confirm('此操作将删除该诊室, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteClinic({ id: row.id }).then(res => {
          this.getClinic()
        })
      })
    },
    addClinic() {
      this.formTitle = '新增诊室'
      this.clinicAddFormVisible = true
      this.formQuery = {
        id: '',
        clinicName: '',
        clinicNo: '',
        sectionsId: ''
      }
    },
    editClinic(index, row) {
      const { id, clinicName, clinicNo, sectionsId } = row
      this.formQuery = {
        id,
        clinicName,
        clinicNo,
        sectionsId
      }
      this.formTitle = '编辑诊室'
      this.clinicAddFormVisible = true
    },
    exportExcel() {
      exportExcel(this.defaultQuery).then(res => {
        if (res) {
          const url = window.URL.createObjectURL(new Blob([res]))
          console.log(res.fileNames)
          const link = document.createElement('a')
          link.style.display = 'none'
          link.href = url
          link.setAttribute('download', '诊室信息.xlsx')
          document.body.appendChild(link)
          link.click()
        } else {
          return
        }
      })
    },
    confirmForm() {
      this.$refs.clinicForm.validate(valid => {
        if (valid) {
          this.btnLoading = true
          if (this.formTitle === '新增诊室') {
            addClinic(this.formQuery)
              .then(res => {
                this.clinicAddFormVisible = false
                this.btnLoading = false
                this.getClinic()
              })
              .catch(() => {
                this.btnLoading = false
              })
          } else {
            updateClinic(this.formQuery)
              .then(res => {
                this.clinicAddFormVisible = false
                this.btnLoading = false
                this.getClinic()
              })
              .catch(() => {
                this.btnLoading = false
              })
          }
        } else {
          return false
        }
      })
    },
    resetForm() {
      this.$refs.clinicForm.resetFields()
      this.$refs.clinicForm.clearValidate()
    },
    cancle() {
      this.resetForm()
      this.clinicAddFormVisible = false
    },
    assignDevice(index, row) {
      this.clinicDevicepojo.clinicId = row.id
      getClinicDevice({ id: row.id }).then(res => {
        console.log(res)
        this.changeDeviceVisible = true
        this.deviceList = res.childList
        console.log(this.clinicDevicepojo)
        this.clinicDevicepojo.checkList = res.checkList
      })
    },
    confirmChangeDevice() {},
    addDevices() {
      setClinicDevice(this.clinicDevicepojo).then(res => {
        this.changeDeviceVisible = false
        this.getClinic()
      })
    },
    changeDevice(val) {
      console.log(val)
      console.log(this.selectedOptions)
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
}
</style>
