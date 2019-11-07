import request from '@/utils/request'

export function getCompleteList(params) {
  return request({
    url: '/nurse/completeList',
    method: 'post',
    params
  })
}

export function changetoWaitList(data) {
  return request({
    url: '/nurse/changetoWaitList',
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
