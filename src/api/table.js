import request from '@/utils/request'

export function getList(params) {
  return request({
    url: '/admin/prepayBySTH',
    method: 'post',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    params
  })
}
