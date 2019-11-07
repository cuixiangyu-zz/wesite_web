<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="IP">
        <el-input v-model="listQuery.ip" clearable placeholder="请输入ip" />
      </el-form-item>
      <el-form-item label="设备类型">
        <el-select v-model="listQuery.type" placeholder="请选择" clearable>
          <el-option label="小屏" value="1" />
          <el-option label="大屏" value="2" />
          <el-option label="声音程序" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item style="margin-right: 50px;">
        <el-button type="primary" @click="getAllDevice">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleDeviceAdd">新增设备</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="exportExcel">导出</el-button>
      </el-form-item>
      <el-form-item label="照片" label-width="100px" prop="imgUrl">
        <img :src="imgSrc" style="width: 60%;height: 60%">
      </el-form-item>
    </el-form>

    <!-- 表格数据 -->
    <el-table :data="tableData.list" border style="width: 100%">
      <el-table-column prop="name" label="名称" />
      <el-table-column prop="ipAddress" label="ip地址" />
      <el-table-column prop="bigScreenHeight" label="设备高度" />
      <el-table-column prop="bigScreenWidth" label="设备宽度" />
      <el-table-column prop="type" label="设备类型" />
      <el-table-column prop="address" min-width="120" label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="primary"
            @click="handleDeviceEdit(scope.$index, scope.row)"
          >编辑</el-button>
          <el-button size="mini" type="danger" @click="deleteDevice(scope.$index, scope.row)">删除</el-button>
          <el-button size="mini" @click="getDetail(scope.$index, scope.row)">详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.total"
      :current-page="listQuery.pageNum"
      :page-sizes="[1, 5, 10, 20, 30]"
      :page-size="listQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />

    <!-- 新增设备弹窗 -->
    <el-dialog :title="formTitle" :visible.sync="deviceAddFormVisible" width="30%">
      <el-form ref="deviceForm" :model="deviceAddForm" :rules="rules">
        <el-form-item label="ip地址" label-width="100px" prop="ipAddress">
          <el-input v-model="deviceAddForm.ipAddress" autocomplete="off" />
        </el-form-item>
        <el-form-item label="设备名称" label-width="100px" prop="name">
          <el-input v-model="deviceAddForm.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="设备类型" label-width="100px">
          <el-select v-model="deviceAddForm.type" placeholder="请选择">
            <el-option label="小屏" :value="1" />
            <el-option label="大屏" :value="2" />
            <el-option label="声音程序" :value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="设备高度" label-width="100px">
          <el-input v-model="deviceAddForm.bigScreenHeight" type="number" autocomplete="off" />
        </el-form-item>
        <el-form-item label="设备宽度" label-width="100px">
          <el-input v-model="deviceAddForm.bigScreenWidth" type="number" autocomplete="off" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmForm">保 存</el-button>
        <el-button @click="deviceAddFormVisible = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 设备详情弹窗 -->
    <el-dialog title="诊室信息" :visible.sync="deviceDetailVisible" width="30%">
      <div v-if="deviceDetail">
        <el-table :data="deviceDetail" height="600" border style="width: 100%">
          <el-table-column prop="id" label="id" fixed="left" />
          <el-table-column prop="sectionsId" label="sectionsId" />
          <el-table-column prop="hisCode" label="hisCode" />
          <el-table-column prop="clinicNo" label="clinicNo" />
          <el-table-column prop="clinicName" label="clinicName" />
        </el-table>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import {
  getAllDevice,
  addDevice,
  exportExcel,
  deleteDevice,
  getDetail
} from '@/api/manageDevice'
export default {
  data() {
    return {
      tableData: [],
      listQuery: {
        pageNum: 1,
        pageSize: 10,
        ip: '',
        type: ''
      },
      deviceAddFormVisible: false,
      deviceAddForm: {
        id: '',
        ipAddress: '',
        name: '',
        type: null,
        remark: '',
        bigScreenHeight: '',
        bigScreenWidth: '',
        createTime: '',
        creater: ''
      },
      rules: {
        ipAddress: [
          { required: true, message: '请填写Ip地址', trigger: 'blur' }
        ],

        name: [{ required: true, message: '请填写设备名称', trigger: 'blur' }]
      },
      formTitle: '',
      deviceDetailVisible: false,
      deviceDetail: null,
      imgSrc: 'http://127.0.0.1:8081/website/resources/_MG_0138.jpg'
    }
  },
  created() {
    // this.getAllDevice()
  },
  methods: {
    getAllDevice() {
      getAllDevice(this.listQuery).then(res => {
        res.list.forEach(item => {
          if (item.type === 1) {
            item.type = '小屏'
          }
          if (item.type === 2) {
            item.type = '大屏'
          }
          if (item.type === 3) {
            item.type = '声音程序'
          }
        })
        this.tableData = res
      })
    },
    handleCurrentChange(index) {
      this.listQuery.pageNum = index
      this.getAllDevice()
    },
    handleSizeChange(pageSize) {
      this.listQuery.pageSize = pageSize
      this.getAllDevice()
    },
    deleteDevice(index, row) {
      this.$confirm('此操作将删除该设备, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteDevice({ id: row.id }).then(res => {
          this.getAllDevice()
        })
      })
    },
    handleDeviceAdd() {
      // 重置查询参数
      for (var i in this.deviceAddForm) {
        this.deviceAddForm[i] = ''
      }
      this.formTitle = '新增设备'
      this.deviceAddFormVisible = true
    },
    exportExcel() {
      exportExcel(this.defaultQuery).then(res => {
        if (res) {
          const url = window.URL.createObjectURL(new Blob([res]))
          console.log(res.fileNames)
          const link = document.createElement('a')
          link.style.display = 'none'
          link.href = url
          link.setAttribute('download', '设备信息.xlsx')
          document.body.appendChild(link)
          link.click()
        } else {
          return
        }
      })
    },
    confirmForm() {
      this.$refs.deviceForm.validate(valid => {
        if (valid) {
          if (this.formTitle === '新增设备') {
            addDevice(this.deviceAddForm).then(res => {
              this.deviceAddFormVisible = false
              this.getAllDevice()
            })
          } else if (this.formTitle === '编辑设备') {
            addDevice(this.deviceAddForm).then(res => {
              this.deviceAddFormVisible = false
              this.getAllDevice()
            })
          }
        } else {
          return false
        }
      })
    },
    handleDeviceEdit(index, row) {
      const { id, ipAddress, name, bigScreenHeight, bigScreenWidth, type } = row
      this.deviceAddForm = {
        id,
        ipAddress,
        name,
        bigScreenHeight,
        bigScreenWidth,
        type
      }
      if (this.deviceAddForm.type === '小屏') {
        this.deviceAddForm.type = 1
      }
      if (this.deviceAddForm.type === '大屏') {
        this.deviceAddForm.type = 2
      }
      if (this.deviceAddForm.type === '声音程序') {
        this.deviceAddForm.type = 3
      }
      this.formTitle = '编辑设备'
      this.deviceAddFormVisible = true
    },
    getDetail(index, row) {
      getDetail({ id: row.id }).then(res => {
        this.deviceDetail = res.clinicList
        this.deviceDetailVisible = true
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
