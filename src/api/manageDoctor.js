import request from '@/utils/request'

export function getDoctorList(params) {
  return request({
    url: '/doctor/findList',
    method: 'post',
    params
  })
}

export function updateDoctor(data) {
  return request({
    url: '/doctor/update',
    method: 'post',
    data
  })
}

export function exportExcel(params) {
  return request({
    url: '/doctor/exportExcel',
    method: 'post',
    params,
    responseType: 'blob'
  })
}
