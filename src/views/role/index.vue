<template>
  <div v-if="tableData" class="main">
    <!-- 查询角色表单 -->
    <el-form :inline="true">
      <el-form-item label="角色名">
        <el-input v-model="defaltQuery.roleName" clearable placeholder="请输入角色名" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getRoleLists">查询</el-button>
      </el-form-item>
      <el-form-item style="margin-left: 50px;">
        <el-button type="primary" @click="roleAdd">新建角色</el-button>
      </el-form-item>
    </el-form>
    <!-- 角色表格 -->
    <el-table :data="tableData.list" style="width: 100%" border>
      <el-table-column label="角色名称" prop="roleName" />
      <el-table-column label="角色描述" prop="description" />
      <el-table-column label="创建时间" prop="createTime" />
      <!-- <el-table-column label="角色ID" prop="roleId" /> -->
      <el-table-column label="备注" prop="remark" />
      <el-table-column label="操作" min-width="300">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="primary"
            @click="handlePermission(scope.$index, scope.row)"
          >分配权限</el-button>
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑角色</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除角色</el-button>
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

    <!-- 编辑角色弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="roleEditFormFormVisible" width="30%">
      <el-form ref="roleForm" :rules="formRules" :model="roleEditForm">
        <el-form-item v-if="dialogTitle==='编辑角色'" hidden="true" label="id" label-width="100px">
          <el-input v-model="roleEditForm.id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="角色名" label-width="100px" prop="roleName">
          <el-input
            v-model="roleEditForm.roleName"
            autocomplete="off"
            placeholder="请输入角色名称"
            clearable
          />
        </el-form-item>
        <el-form-item label="角色描述" label-width="100px" prop="description">
          <el-input
            v-model="roleEditForm.description"
            autocomplete="off"
            placeholder="请输入角色描述"
            clearable
          />
        </el-form-item>
        <el-form-item label="备注" label-width="100px" prop="remark">
          <el-input v-model="roleEditForm.remark" autocomplete="off" placeholder="请输入备注" clearable />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :disabled="btnLoad" @click="confirmEdit">保 存</el-button>
        <el-button @click="roleEditFormFormVisible = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 分配权限弹窗 -->
    <el-dialog title="分配权限" :visible.sync="permissionListVisible" width="30%">
      <el-tree
        ref="tree"
        :data="permissionList"
        :default-checked-keys="defaltChecked"
        show-checkbox
        node-key="id"
      />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmPermission">保 存</el-button>
        <el-button @click="permissionListVisible = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
function getDefaltChecked(list) {
  const array = []
  handleList(list)
  function handleList(list) {
    list.forEach(item => {
      if (!item.children) {
        if (item.select) {
          array.push(item.id)
        }
      } else {
        handleList(item.children)
      }
    })
  }
  return array
}

import Moment from 'moment'
import {
  getRole,
  roleAdd,
  roleDelete,
  getPermission,
  handlePremission
} from '@/api/role'
export default {
  data() {
    return {
      tableData: null,
      formRules: {
        roleName: { required: true, message: '请输入角色名称', trigger: 'blur' }
      },
      roleEditFormFormVisible: false,
      permissionListVisible: false,
      defaltQuery: {
        roleName: null,
        pageSize: 10,
        pageNum: 1
      },
      roleEditForm: {
        roleName: '',
        description: '',
        id: '',
        remark: ''
      },
      permissionList: null,
      btnLoad: false,
      id: null,
      defaltChecked: [5],
      dialogTitle: ''
    }
  },
  created() {
    this.getRoleLists()
  },
  methods: {
    getRoleLists() {
      getRole(this.defaltQuery).then(res => {
        res.list.forEach(item => {
          if (item.createTime) {
            item.createTime = Moment(item.createTime).format('YYYY-MM-DD')
          } else {
            item.createTime = '无'
          }
        })
        this.tableData = res
      })
    },
    handleSizeChange(pageSize) {
      this.defaltQuery.pageSize = pageSize
      this.getRoleLists()
    },
    handleCurrentChange(index) {
      this.defaltQuery.pageNum = index
      this.getRoleLists()
    },
    handlePermission(index, row) {
      this.id = row.id
      getPermission({ id: row.id }).then(res => {
        this.defaltChecked = getDefaltChecked(res)
        this.permissionList = res
        this.permissionListVisible = true
      })
    },
    handleEdit(index, row) {
      const { roleName, description, id, available, remark } = row
      this.roleEditForm = { roleName, description, id, available, remark }
      this.dialogTitle = '编辑角色'
      this.roleEditFormFormVisible = true
    },
    handleDelete(index, row) {
      this.$confirm('此操作将删除该角色, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        roleDelete({ id: row.id }).then(res => {
          this.$message({
            message: '删除成功!',
            type: 'success'
          })
          this.getRoleLists()
        })
      })
    },
    confirmEdit() {
      this.$refs.roleForm.validate(valid => {
        if (valid) {
          this.btnLoad = true
          roleAdd(this.roleEditForm)
            .then(res => {
              this.$message({
                message: '操作成功！',
                type: 'success'
              })
              this.btnLoad = false
              this.roleEditFormFormVisible = false
              this.getRoleLists()
            })
            .catch(err => {
              console.log(err)
              this.btnLoad = false
              // this.roleEditFormFormVisible = false
            })
        } else {
          return false
        }
      })
    },
    roleAdd() {
      this.roleEditForm = {
        roleName: '',
        description: '',
        id: '',
        available: ''
      }
      this.dialogTitle = '新建角色'
      this.roleEditFormFormVisible = true
    },
    confirmPermission() {
      const nodeList = this.$refs.tree.getCheckedNodes(false, true)
      const queryList = []
      nodeList.forEach(item => {
        queryList.push(item.id)
      })
      handlePremission({
        id: this.id,
        menuIdList: queryList + ''
      }).then(res => {
        this.permissionListVisible = false
      })
    }
  }
}
</script>
<style lang="scss" scoped>
.main {
  padding: 20px;
  height: 100%;
}
</style>
