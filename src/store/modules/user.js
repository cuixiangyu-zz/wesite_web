import { login, logout, getName } from '@/api/user'
import { getToken, removeToken, setToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const state = {
  token: getToken(),
  name: '',
  avatar: '',
  hasLogin: false
}

const mutations = {
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password } = userInfo
    const formData = new FormData()
    formData.append('userName', username)
    formData.append('password', password)
    return new Promise((resolve, reject) => {
      login(formData)
        .then(response => {
          commit('SET_TOKEN', response.token)
          setToken(response.token)
          resolve()
        })
        .catch(error => {
          reject(error)
        })
    })
  },
  getName({ commit, state }) {
    return new Promise((resolve, reject) => {
      getName()
        .then(res => {
          commit('SET_NAME', res.userName)
          resolve(res)
        })
        .catch(error => {
          reject(error)
        })
    })
  },
  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout()
        .then(() => {
          commit('SET_TOKEN', '')
          // commit('SET_LOGIN', false)
          removeToken()
          console.log(2)
          resetRouter()
          console.log(3)
          resolve()
        })
        .catch(error => {
          reject(error)
        })
    })
  },

  // remove token
  resetToken({ commit }) {
    return new Promise(resolve => {
      commit('SET_TOKEN', '')
      removeToken()
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
