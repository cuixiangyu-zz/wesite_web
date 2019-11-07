import request from '@/utils/request'

export function getClinicList(params) {
  return request({
    url: '/clinic/findList',
    method: 'post',
    params
  })
}

export function addClinic(data) {
  return request({
    url: '/clinic/save',
    method: 'post',
    data
  })
}

export function updateClinic(data) {
  return request({
    url: '/clinic/update',
    method: 'post',
    data
  })
}

export function deleteClinic(params) {
  return request({
    url: '/clinic/delete',
    method: 'post',
    params
  })
}

export function getClinicDevice(params) {
  return request({
    url: '/clinic/getClinicDevice',
    method: 'get',
    params
  })
}

export function setClinicDevice(data) {
  return request({
    url: '/clinic/setClinicDevice',
    method: 'post',
    data
  })
}

export function exportExcel(params) {
  return request({
    url: '/clinic/exportExcel',
    method: 'post',
    params,
    responseType: 'blob'
  })
}
