import request from '@/utils/request'

export function addFavorite(data) {
  return request({
    url: '/userFavorite/addFavorite',
    method: 'post',
    data
  })
}

export function deleteFavorite(params) {
  return request({
    url: '/userFavorite/deleteFavorite',
    method: 'get',
    params
  })
}

export function getList(params) {
  return request({
    url: '/userFavorite/getList',
    method: 'get',
    params
  })
}
