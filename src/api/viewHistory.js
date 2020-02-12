import request from '@/utils/request'

export function addHistory(data) {
  return request({
    url: '/viewHistory/addHistory',
    method: 'post',
    data
  })
}

export function getHistory(params) {
  return request({
    url: '/viewHistory/getHistory',
    method: 'get',
    params
  })
}

export function getList(params) {
  return request({
    url: '/viewHistory/getList',
    method: 'get',
    params
  })
}

