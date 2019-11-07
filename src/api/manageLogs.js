import request from '@/utils/request' // 复用request.js里面的后台地址

export function getLogList(params) {
  return request({
    url: '/sysLog/getList',
    method: 'get',
    params
  })
}
