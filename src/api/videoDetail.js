import request from '@/utils/request'

export function getDetil(params) {
  return request({
    url: '/video/getDetil',
    method: 'get',
    params
  })
}
