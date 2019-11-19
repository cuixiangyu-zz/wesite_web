import request from '@/utils/request'

export function getPageList(data) {
  return request({
    url: '/actor/getPageList',
    method: 'post',
    data
  })
}
export function findAll(params) {
  return request({
    url: '/actor/findAll',
    method: 'get',
    params
  })
}
