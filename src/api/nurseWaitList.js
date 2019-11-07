import request from '@/utils/request'

export function getNotCompleteList(params) {
  return request({
    url: '/nurse/notCompleteList',
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

export function insertQueues(params) {
  return request({
    url: '/doctorCall/patientInsert',
    method: 'post',
    params
  })
}

export function getSignDoctor(data) {
  return request({
    url: '/nurse/getSignDoctor',
    method: 'post',
    data
  })
}
