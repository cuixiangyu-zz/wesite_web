<template>
  <div v-if="tableData" class="main">
    <!-- 查询用户表单 -->
    <el-form :model="defaltQuery" :inline="true">
      <el-form-item label="用户名">
        <el-input v-model="defaltQuery.userName" clearable placeholder="请输入用户名" />
      </el-form-item>
      <el-form-item label="年龄">
        <el-input v-model="defaltQuery.age" clearable placeholder="请输入年龄" />
      </el-form-item>
      <el-form-item label="性别">
        <el-select v-model="defaltQuery.sex" placeholder="男/女" clearable>
          <el-option label="男" :value="0" />
          <el-option label="女" :value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getUsersList">查询</el-button>
      </el-form-item>
      <el-form-item style="margin-left: 50px;">
        <el-button type="primary" @click="handleUserAdd">新增用户</el-button>
      </el-form-item>
    </el-form>

    <!-- 用户数据表格 -->
    <el-table :data="tableData.list" border style="width: 100%">
      <el-table-column prop="userName" label="用户名" />
      <el-table-column prop="name" label="姓名" />
      <el-table-column prop="sex" label="性别" />
      <el-table-column prop="age" label="年龄" />
      <el-table-column prop="createTime" label="注册时间" />
      <el-table-column prop="address" label="操作" min-width="390">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleUserEdit(scope.$index, scope.row)">编辑用户</el-button>
          <el-button size="mini" type="primary" @click="handleRole(scope.$index, scope.row)">分配角色</el-button>
          <el-button size="mini" type="info" @click="handleSections(scope.$index, scope.row)">配置科室</el-button>
          <el-button size="mini" type="warning" @click="pwdEdit(scope.$index, scope.row)">修改密码</el-button>
          <el-button size="mini" type="danger" @click="handleUserDelete(scope.$index, scope.row)">删除用户</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.totals"
      :current-page="defaltQuery.pageNum"
      :page-sizes="[1, 5, 10, 20, 30]"
      :page-size="defaltQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />

    <!-- 新增用户弹窗 -->
    <el-dialog title="新增用户" :visible.sync="userAddFormFormVisible" width="30%">
      <el-form ref="addForm" :model="userAddForm" :rules="rules">
        <el-form-item label="用户名" label-width="100px" prop="userName">
          <el-input v-model="userAddForm.userName" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码" label-width="100px" prop="password">
          <el-input v-model="userAddForm.password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="姓名" label-width="100px" prop="name">
          <el-input v-model="userAddForm.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="年龄" label-width="100px" prop="age">
          <el-input v-model.number="userAddForm.age" type="age" autocomplete="off" />
        </el-form-item>
        <el-form-item label="电话" label-width="100px" prop="tel">
          <el-input v-model="userAddForm.tel" autocomplete="off" />
        </el-form-item>
        <el-form-item label="邮箱" label-width="100px" prop="email">
          <el-input v-model="userAddForm.email" autocomplete="off" />
        </el-form-item>
        <el-form-item label="性别" label-width="100px" prop="sex">
          <el-select v-model="userAddForm.sex" placeholder="男/女" clearable>
            <el-option label="男" :value="0" />
            <el-option label="女" :value="1" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmUserAdd">保 存</el-button>
        <el-button @click="cancelAdd">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 修改用户弹窗 -->
    <el-dialog title="修改用户" :visible.sync="userEditFormFormVisible" width="30%">
      <el-form ref="editForm" :model="userEditForm" :rules="rules">
        <el-form-item label="用户名" label-width="100px" prop="userName">
          <el-input v-model="userEditForm.userName" autocomplete="off" />
        </el-form-item>
        <el-form-item label="姓名" label-width="100px" prop="name">
          <el-input v-model="userEditForm.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="年龄" label-width="100px" prop="age">
          <el-input v-model.number="userEditForm.age" type="age" autocomplete="off" />
        </el-form-item>
        <el-form-item label="电话" label-width="100px">
          <el-input v-model="userEditForm.tel" autocomplete="off" />
        </el-form-item>
        <el-form-item label="邮箱" label-width="100px">
          <el-input v-model="userEditForm.email" autocomplete="off" />
        </el-form-item>
        <el-form-item label="性别" label-width="100px">
          <el-select v-model="userEditForm.sex" placeholder="男/女">
            <el-option label="男" :value="0" />
            <el-option label="女" :value="1" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmUserEdit">保 存</el-button>
        <el-button @click="userEditFormFormVisible = false">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 修改密码弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="updateFormVisible" width="30%" :modal-append-to-body="false">
      <el-form ref="updatepassword" :model="updatepassword">
        <el-form-item label="初始密码" label-width="100px" prop="oldpassword">
          <el-input
            v-model="updatepassword.oldpassword"
            type="password"
            autocomplete="off"
            placeholder="请输入初始密码"
            clearable
          />
        </el-form-item>
        <el-form-item label="新密码" label-width="100px" prop="newpassword">
          <el-input
            v-model="updatepassword.newpassword"
            type="password"
            autocomplete="off"
            placeholder="请输入新密码"
            clearable
          />
        </el-form-item>
        <el-form-item label="确认密码" label-width="100px" prop="surepassword">
          <el-input v-model="updatepassword.surepassword" type="password" autocomplete="off" placeholder="请再次输入密码" clearable />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :plain="true" @click="updatepsd">保 存</el-button>
        <el-button @click="updateFormVisible=flase">关 闭</el-button>
      </div>
    </el-dialog>
    <!-- 分配角色弹窗 -->
    <el-dialog title="分配角色" :visible.sync="roleListVisible" width="30%">
      <el-tree
        ref="tree"
        :data="roleList"
        :default-checked-keys="defaltChecked"
        show-checkbox
        node-key="id"
      />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmRole">保 存</el-button>
        <el-button @click="roleListVisible = false">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 配置科室 -->
    <el-dialog title="配置科室" :visible.sync="sectionListVisible" width="30%">
      <el-tree
        ref="tree"
        :data="sectionList"
        :default-checked-keys="sectionChecked"
        show-checkbox
        node-key="id"
      />
      <span slot="footer" class="dialog-footer">
        <el-button @click="sectionListVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmSection">保 存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
const moment = require('moment')
import {
  getUsersList,
  userAdd,
  userDelete,
  getRolesById,
  addRoles,
  getAllSection,
  addUserSectionRelation,
  updatePwd
} from '@/api/manageUsers'
export default {
  data() {
    return {
      userAddFormFormVisible: false,
      userEditFormFormVisible: false,
      updateFormVisible: false,
      roleListVisible: false,
      sectionListVisible: false,
      roleList: null,
      sectionList: null,
      id: null,
      defaltChecked: [],
      sectionChecked: [],
      userAddForm: {
        userName: '',
        password: '',
        name: '',
        age: '',
        sex: null,
        tel: '',
        email: ''
      },
      updatepassword: {
        oldpassword: '',
        newpassword: '',
        surepassword: ''
      },
      dialogTitle: null,
      userEditForm: {
        userName: '',
        password: '',
        name: '',
        age: '',
        sex: null,
        tel: '',
        email: ''
      },
      defaltQuery: {
        userName: '',
        age: '',
        sex: '',
        pageSize: 10,
        pageNum: 1
      },
      tableData: null,
      rules: {
        userName: [
          { required: true, message: '请填写用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请填写密码', trigger: 'blur' },
          { min: 6, max: 15, message: '长度在 6 到 15 个字符', trigger: 'blur' }
        ],
        name: [{ required: true, message: '请填写姓名', trigger: 'blur' }],
        sex: [
          { required: true, message: '请选择用户性别', trigger: 'change' }
        ],
        age: [
          { required: true, message: '请填写年龄', trigger: 'blur' },
          { type: 'number', message: '年龄必须为数字值' }
        ]
      }
    }
  },
  created() {
    this.getUsersList()
  },
  methods: {
    getUsersList() {
      getUsersList(this.defaltQuery).then(res => {
        res.list.forEach(item => {
          if (item.sex === 0) {
            item.sex = '男'
          }
          if (item.sex === 1) {
            item.sex = '女'
          }
          item.createTime = moment(item.createTime).format('YYYY-MM-DD')
        })
        this.tableData = res
      })
    },
    handleSizeChange(pageSize) {
      this.defaltQuery.pageSize = pageSize
      this.getUsersList()
    },
    handleCurrentChange(index) {
      this.defaltQuery.pageNum = index
      this.getUsersList()
    },
    handleUserAdd() {
      this.userAddForm = {
        userName: '',
        password: '',
        name: '',
        age: '',
        sex: null,
        tel: '',
        email: ''
      }
      this.userAddFormFormVisible = true
    },
    confirmUserAdd() {
      this.$refs.addForm.validate(valid => {
        if (valid) {
          userAdd(this.userAddForm).then(res => {
            this.userAddFormFormVisible = false
            this.getUsersList()
          })
            .catch(() => {
              this.userAddFormFormVisible = false
            })
        } else {
          return false
        }
      })
    },
    confirmUserEdit() {
      this.$refs.editForm.validate(valid => {
        console.log(valid)
        if (valid) {
          userAdd(this.userEditForm).then(res => {
            this.userEditFormFormVisible = false
            this.getUsersList()
          })
            .catch(() => {
              this.userEditFormFormVisible = false
            })
        } else {
          return false
        }
      })
    },
    handleRole(index, row) {
      getRolesById({ id: row.id }).then(res => {
        const checkedList = []
        res.forEach(item => {
          if (item.select === true) {
            checkedList.push(item.id)
          }
        })
        this.defaltChecked = checkedList
        this.id = row.id
        this.roleList = res
        this.roleListVisible = true
      })
    },
    confirmRole() {
      const queryList = this.$refs.tree.getCheckedKeys() + ''
      addRoles({ id: this.id, roleIdList: queryList })
        .then(res => {
          this.roleListVisible = false
        })
        .catch(() => {
          this.roleListVisible = false
        })
    },
    // 配置科室
    handleSections(index, row) {
      getAllSection({ id: row.id }).then(res => {
        const checkedList = []
        res.forEach(item => {
          if (item.select === true) {
            checkedList.push(item.id)
          }
        })
        this.sectionChecked = checkedList
        this.id = row.id
        this.sectionList = res
        this.sectionListVisible = true
      })
    },
    confirmSection() {
      const queryList = this.$refs.tree.getCheckedKeys() + ''
      addUserSectionRelation({ id: this.id, sectionsList: queryList })
        .then(res => {
          this.sectionListVisible = false
        })
        .catch(() => {
          this.sectionListVisible = false
        })
    },
    pwdEdit(index, row) {
      this.updatepassword = {
        oldpassword: '',
        newpassword: '',
        surepassword: ''
      }
      this.id = row.id
      this.dialogTitle = '修改密码'
      this.updateFormVisible = true
    },
    updatepsd() {
      const defaultfrom = {
        password: this.updatepassword.oldpassword,
        newPassword: this.updatepassword.newpassword,
        userId: this.id
      }
      if (this.updatepassword.newpassword === this.updatepassword.surepassword && this.updatepassword.newpassword.length > 5) {
        updatePwd(defaultfrom).then(res => {
          this.$message({
            message: '修改成功！',
            type: 'success'
          })
          this.updateFormVisible = false
        })
      } else {
        this.$message.error('密码长度小于六位或者两次输入密码不一致！')
      }
    },
    handleUserEdit(index, row) {
      const { userName, name, age, id, tel, email } = row
      let { sex } = row
      if (sex === '男') {
        sex = 0
      }
      if (sex === '女') {
        sex = 1
      }
      this.userEditForm = { userName, name, age, sex, id, tel, email }
      this.userEditFormFormVisible = true
    },
    handleUserDelete(index, row) {
      this.$confirm('此操作将删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(res => {
        userDelete({ id: row.id }).then(res => {
          this.getUsersList()
        })
      })
    },

    cancelAdd() {
      this.$refs.addForm.resetFields()
      this.userAddFormFormVisible = false
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
}
</style>
