<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="科室">
        <el-select v-model="defaultQuery.sectionsId" clearable filterable placeholder="请选择">
          <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="医生姓名">
        <el-input v-model="defaultQuery.name" clearable placeholder />
      </el-form-item>
      <el-form-item label="HIS编码">
        <el-input v-model="defaultQuery.hisId" clearable placeholder />
      </el-form-item>
      <el-form-item style="margin-right: 50px;">
        <el-button type="primary" @click="getDoctor">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="exportExcel">导出</el-button>
      </el-form-item>
    </el-form>

    <!-- 表格数据 -->
    <el-table border :data="tableData.list" style="width: 100%">
      <el-table-column prop="userName" label="用户名" width="180" />
      <el-table-column prop="name" label="姓名" width="180" />
      <el-table-column prop="hisId" label="HIS编码" />
      <el-table-column prop="sectionname" label="签到科室" />
      <el-table-column prop="address" min-width="120" label="操作">
        <template slot-scope="scope">
          <el-button size="mini" type="primary" @click="editDoctor(scope.$index, scope.row)">编辑</el-button>
          <el-button
            size="mini"
            type="primary"
            @click="findSectionByID(scope.$index, scope.row)"
          >所属科室</el-button>
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

    <!-- 修改医生 -->
    <el-dialog :title="formTitle" :visible.sync="doctorAddFormVisible" width="30%">
      <el-form ref="doctorForm" :model="formQuery" :rules="formRules" class="demo-ruleForm">
        <el-form-item v-if="formTitle==='编辑医生'" hidden="true" label="id" label-width="100px">
          <el-input v-model="formQuery.id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="医生姓名" label-width="100px" prop="name">
          <el-input v-model="formQuery.name" :disabled="true" autocomplete="off" />
        </el-form-item>
        <el-form-item label="用户名" label-width="100px" prop="userName">
          <el-input v-model="formQuery.userName" autocomplete="off" />
        </el-form-item>
        <el-form-item label="HIS编码" label-width="100px" prop="hisId">
          <el-input v-model="formQuery.hisId" :disabled="true" autocomplete="off" />
        </el-form-item>
        <el-form-item label="科室" label-width="100px" prop="sectionsId">
          <el-select v-model="formQuery.sectionsId" :disabled="true" filterable placeholder="请选择">
            <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="照片" label-width="100px" prop="imgUrl">
          <img :src="imgSrc" style="width: 60%;height: 60%">
        </el-form-item>
        <el-form-item label="上传" label-width="100px">
          <el-upload
            v-model="formQuery.imgUrl"
            action="doctor/upload"
            list-type="picture-card"
            :on-preview="handlePictureCardPreview"
            :on-remove="handleRemove"
            :on-success="handSuccess"
          >
            <i class="el-icon-plus" />
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl">
          </el-dialog>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :disabled="btnLoading" @click="confirmForm">保 存</el-button>
        <el-button @click="cancle">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="所属科室" :visible.sync="sectionVisible" width="30%">
      <div v-for="item in sectionsList" :key="item.id" class="sectionName">{{ item.name }}</div>
    </el-dialog>
  </div>
</template>
<script>
import { getDoctorList, updateDoctor, exportExcel } from '@/api/manageDoctor'
import { getSectionsList, getSectionsBydoctorId } from '@/api/manageSections'
export default {
  data() {
    return {
      tableData: null,
      defaultQuery: {
        pageNum: 1,
        pageSize: 10,
        sectionsId: '',
        name: '',
        hisId: ''
      },
      formRules: {
        userName: { required: true, message: '请输入用户名！', trigger: 'blur' }
      },
      doctorAddFormVisible: false,
      formQuery: {
        id: '',
        name: '',
        userName: '',
        hisId: '',
        sectionsId: '',
        imgUrl: ''
      },
      options: [],
      secitonsOption: '',
      btnLoading: false,
      formTitle: '修改医生',
      dialogImageUrl: '',
      dialogVisible: false,
      imgSrc: '',
      sectionVisible: false,
      sectionsList: null
    }
  },
  // 钩子函数 页面加载时触发
  created() {
    this.getSections()
  },
  mounted() {
    // this.getDoctor()
  },
  methods: {
    getDoctor() {
      getDoctorList(this.defaultQuery).then(res => {
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
      getSectionsList().then(res => {
        this.options = res
        this.getDoctor()
      })
    },
    handleSizeChange(index) {
      this.defaultQuery.pageSize = index
      this.getDoctor()
    },
    handleCurrentChange(index) {
      this.defaultQuery.pageNum = index
      this.getDoctor()
    },
    editDoctor(index, row) {
      const { id, name, userName, hisId, sectionsId, imgUrl } = row
      this.formQuery = {
        id,
        name,
        userName,
        hisId,
        sectionsId,
        imgUrl
      }
      this.imgSrc = '/doctor/getImg?imgUrl=' + this.formQuery.imgUrl
      this.doctorAddFormVisible = true
    },
    exportExcel() {
      exportExcel(this.defaultQuery).then(res => {
        if (res) {
          const url = window.URL.createObjectURL(new Blob([res]))
          console.log(res.fileNames)
          const link = document.createElement('a')
          link.style.display = 'none'
          link.href = url
          link.setAttribute('download', '医生信息.xlsx')
          document.body.appendChild(link)
          link.click()
        } else {
          return
        }
      })
    },
    confirmForm() {
      this.$refs.doctorForm.validate(valid => {
        if (valid) {
          this.btnLoading = true
          updateDoctor(this.formQuery)
            .then(res => {
              this.doctorAddFormVisible = false
              this.btnLoading = false
              this.getDoctor()
            })
            .catch(() => {
              this.btnLoading = false
            })
        } else {
          return false
        }
      })
    },
    resetForm() {
      this.$refs.doctorForm.resetFields()
    },
    handleRemove(file, fileList) {},
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    handSuccess(res, file) {
      this.formQuery.imgUrl = res.data
    },
    cancle() {
      this.resetForm()
      this.doctorAddFormVisible = false
    },
    findSectionByID(index, row) {
      this.sectionVisible = true
      console.log(row.id)
      getSectionsBydoctorId({ doctorId: row.id }).then(res => {
        console.log(res)
        this.sectionsList = res
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
  .sectionName{
    display: inline-block;
    font-size: 18px;
    padding: 20px;
  }
}
</style>
