import request from '@/utils/request'

export function getDetil(params) {
  return request({
    url: '/video/getDetile',
    method: 'get',
    params
  })
}
export function changelevel(params) {
  return request({
    url: '/video/changelevel',
    method: 'get',
    params
  })
}

export function saveViewHistory(data) {
  return request({
    url: '/video/saveViewHistory',
    method: 'post',
    data
  })
}

export function getWatchList(params) {
  return request({
    url: '/video/getWatchList',
    method: 'get',
    params
  })
}

export function suggestVideo(params) {
  return request({
    url: '/video/suggestVideo',
    method: 'get',
    params
  })
}
