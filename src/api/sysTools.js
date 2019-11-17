import request from "@/utils/request"

export function selectfile(params) {
  return request({
    url: '/video/selectfile',
    method: 'get',
    params
  })
}

export function updatefile(data) {
  return request({
    url: '/video/updatefile',
    method: 'post',
    data
  })
}
