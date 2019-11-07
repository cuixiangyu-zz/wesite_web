import request from '@/utils/request'

export function getNoDoctorList(params) {
  return request({
    url: '/nurse/notDoctorList',
    method: 'post',
    params
  })
}

export function batchEdit(data) {
  return request({
    url: '/nurse/batchEdit',
    method: 'post',
    data
  })
}

export function getSignDoctor(data) {
  return request({
    url: '/nurse/getSignDoctor',
    method: 'post',
    data
  })
}
