import request from '@/utils/request'

export function getPageList(data) {
  return request({
    url: '/picture/getPageList',
    method: 'post',
    data
  })
}
