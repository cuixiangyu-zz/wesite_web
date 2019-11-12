import request from '@/utils/request'

export function getPageList(data) {
  return request({
    url: '/video/getPageList',
    method: 'post',
    data
  })
}
export function sysTools(params) {
  return request({
    url: '/video/sysTools',
    method: 'get',
    params
  })
}
