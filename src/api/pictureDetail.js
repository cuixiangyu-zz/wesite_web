import request from '@/utils/request'

export function getDetil(params) {
  return request({
    url: '/picture/getDetil',
    method: 'get',
    params
  })
}
