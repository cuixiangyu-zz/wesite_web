import request from '@/utils/request'

export function getRole(params) {
  return request({
    url: '/admin/getRoleList',
    method: 'get',
    params
  })
}

export function roleAdd(params) {
  return request({
    url: '/admin/saveRoleMessage',
    method: 'post',
    params
  })
}

export function roleDelete(params) {
  return request({
    url: '/admin/roleDelete',
    method: 'get',
    params
  })
}

export function getPermission(params) {
  return request({
    url: '/admin/getRoleMenu',
    method: 'get',
    params
  })
}

export function handlePremission(params) {
  return request({
    url: '/admin/toAuthorize',
    method: 'post',
    params
  })
}

export function checkRoleExists(params) {
  return request({
    url: '/admin/checkRoleExists',
    method: 'get',
    params
  })
}
