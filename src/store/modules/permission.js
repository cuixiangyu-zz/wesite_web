import { getRoutes } from '@/api/user'
import { constantRoutes } from '@/router'
import Layout from '@/layout'

const routesMap = {
  Layout: Layout,
  sysLogManage: () => import('@/views/table/index'),
  roleManage: () => import('@/views/role/index'),
  userManage: () => import('@/views/manage-users'),
  devManager: () => import('@/views/manage-device'),
  conManager: () => import('@/views/manage-clinic'),
  logManage: () => import('@/views/manage-logs'),
  doneList: () => import('@/views/nurse_doneList'),
  waitList: () => import('@/views/nurse_waitList'),
  noDoctorList: () => import('@/views/nurse_noDoctorList'),
  doctorSign: () => import('@/views/nurse_doctorSign'),
  docManager: () => import('@/views/manage-doctor/index'),
  depManager: () => import('@/views/manage-sections/index')
}

function handleRoutes(list) {
  list.forEach(item => {
    item.component = routesMap[item.component]
    if (item.children && item.children !== null) {
      item.redirect = item.children[0].path
      handleRoutes(item.children)
    } else {
      delete item.children
    }
  })
}

const state = {
  routes: []
}

const mutations = {
  SET_ROUTES: (state, routes) => {
    state.routes = constantRoutes.concat(routes)
  },
  RESET_ROUTES: state => {
    state.routes = []
  }
}

const actions = {
  generateRoutes({ commit }, username) {
    return new Promise((resolve, reject) => {
      getRoutes()
        .then(res => {
          handleRoutes(res)
          res.forEach(item => {
            item.path = '/' + item.path
          })
          commit('SET_ROUTES', res)
          res.push({ path: '*', redirect: '/404', hidden: true })
          resolve(res)
        })
        .catch(error => {
          reject(error)
        })
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
