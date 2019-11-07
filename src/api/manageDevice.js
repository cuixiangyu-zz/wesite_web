import request from '@/utils/request'

export function getAllDevice(params) {
  return request({
    url: '/device/getAllDevice',
    method: 'get',
    params
  })
}

export function addDevice(data) {
  return request({
    url: '/device/add',
    method: 'post',
    data
  })
}

export function updateDevice(data) {
  return request({
    url: '/device/update',
    method: 'post',
    data
  })
}

export function deleteDevice(params) {
  return request({
    url: '/device/delete',
    method: 'post',
    params
  })
}

export function getDetail(params) {
  return request({
    url: '/device/getdetils',
    method: 'get',
    params
  })
}

export function exportExcel(params) {
  return request({
    url: '/device/exportExcel',
    method: 'post',
    params,
    responseType: 'blob'
  })
}
