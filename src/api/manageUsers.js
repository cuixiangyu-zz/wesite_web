import request from '@/utils/request'

export function getUsersList(params) {
  return request({
    url: '/admin/getUserList',
    method: 'get',
    params
  })
}

export function userAdd(params) {
  return request({
    url: '/admin/userAdd',
    method: 'post',
    params
  })
}

export function getRolesById(params) {
  return request({
    url: '/admin/toGetUserRole',
    method: 'get',
    params
  })
}

export function addRoles(params) {
  return request({
    url: '/admin/toGrantUserRole',
    method: 'get',
    params
  })
}

export function userDelete(params) {
  return request({
    url: '/admin/deleteUser',
    method: 'post',
    params
  })
}

export function getAllSection(params) {
  return request({
    url: '/admin/toGetUserSections',
    method: 'get',
    params
  })
}

export function addUserSectionRelation(params) {
  return request({
    url: '/admin/toGrantUserSections',
    method: 'post',
    params
  })
}

export function updatePwd(params) {
  return request({
    url: '/admin/updatePwd',
    method: 'post',
    params
  })
}
