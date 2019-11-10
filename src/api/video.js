import request from '@/utils/request'

export function getPageList(data) {
  return request({
    url: '/video/getPageList',
    method: 'post',
    data
  })
}
