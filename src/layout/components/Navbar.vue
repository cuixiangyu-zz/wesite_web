<template>
  <div class="navbar">
    <hamburger
      :is-active="sidebar.opened"
      class="hamburger-container"
      @toggleClick="toggleSideBar"
    />

    <breadcrumb class="breadcrumb-container" />

    <div class="right-menu">
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <!-- <img :src="avatar+'?imageView2/1/w/80/h/80'" class="user-avatar"> -->
          <img src="@/assets/avatar.png" class="user-avatar">
          <!-- <svg-icon class="user-avatar" icon-class="avatar" /> -->
          <i class="el-icon-caret-bottom" />
        </div>
        <el-dropdown-menu slot="dropdown" style="margin-top: -5px" class="user-dropdown">
          <el-dropdown-item divided>
            <span style="display:block;" @click="logout">退出</span>
          </el-dropdown-item>
          <el-dropdown-item divided>
            <span style="display:block;" @click="roleAdd">修改密码</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
    <!-- 弹框 -->
    <el-dialog
      :title="dialogTitle"
      :visible.sync="FormVisible"
      width="30%"
      :modal-append-to-body="false"
      :before-close="closeDialog"
    >
      <el-form ref="roleForm" :model="updatepassword">
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
          <el-input
            v-model="updatepassword.surepassword"
            type="password"
            autocomplete="off"
            placeholder="请再次输入密码"
            clearable
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :plain="true" @click="updatepsd">保 存</el-button>
        <el-button @click="close">关 闭</el-button>
      </div>
    </el-dialog>
    <!-- 弹框 -->
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/Breadcrumb'
import Hamburger from '@/components/Hamburger'
import { updatePswd } from '@/api/user'
export default {
  components: {
    Breadcrumb,
    Hamburger
  },
  data() {
    return {
      updatepassword: {
        oldpassword: '',
        newpassword: '',
        surepassword: ''
      },
      FormVisible: false,
      dialogTitle: ''
    }
  },
  computed: {
    ...mapGetters(['sidebar', 'avatar'])
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch('app/toggleSideBar')
    },
    async logout() {
      await this.$store.dispatch('tagsView/delAllViews')
      await this.$store.dispatch('user/logout')
      this.$store.commit('permission/RESET_ROUTES')
      this.$router.push(`/login?redirect=${this.$route.fullPath}`)
    },
    roleAdd() {
      this.updatepassword = {
        oldpassword: '',
        newpassword: '',
        surepassword: ''
      }
      this.dialogTitle = '修改密码'
      this.FormVisible = true
    },
    updatepsd() {
      const defaultfrom = {
        password: this.updatepassword.oldpassword,
        newPassword: this.updatepassword.newpassword
      }
      if (
        this.updatepassword.newpassword === this.updatepassword.surepassword &&
        this.updatepassword.newpassword.length > 5
      ) {
        updatePswd(defaultfrom).then(res => {})
      } else {
        this.$message.error('密码长度小于六位或者两次输入密码不一致！')
      }
    },
    close() {
      this.FormVisible = false
      this.updatepassword = {
        oldpassword: '',
        newpassword: '',
        surepassword: ''
      }
    },
    closeDialog() {
      this.FormVisible = false
      this.updatepassword = {
        oldpassword: '',
        newpassword: '',
        surepassword: ''
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background 0.3s;
    -webkit-tap-highlight-color: transparent;

    &:hover {
      background: rgba(0, 0, 0, 0.025);
    }
  }

  .breadcrumb-container {
    float: left;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;

      &.hover-effect {
        cursor: pointer;
        transition: background 0.3s;

        &:hover {
          background: rgba(0, 0, 0, 0.025);
        }
      }
    }

    .avatar-container {
      margin-right: 30px;
      .avatar-wrapper {
        margin-top: 5px;
        position: relative;
        .user-avatar {
          cursor: pointer;
          width: 40px;
          // height: 40px;
          line-height: 40px;
          border-radius: 10px;
        }

        .el-icon-caret-bottom {
          cursor: pointer;
          position: absolute;
          right: -20px;
          top: 25px;
          font-size: 12px;
        }
      }
    }
  }
}
</style>
