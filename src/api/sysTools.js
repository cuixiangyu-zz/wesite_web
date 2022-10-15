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

export function reName(data) {
  return request({
    url: '/video/reName',
    method: 'post',
    data
  })
}

export function selectFileForComic(params) {
  return request({
    url: '/picture/getComicName',
    method: 'get',
    params
  })
}

export function selectFileForAmerican(params) {
  return request({
    url: '/video/selectFileForAmerican',
    method: 'get',
    params
  })
}

export function moveFileFunc(params) {
  return request({
    url: '/video/moveFile',
    method: 'get',
    params
  })
}

export function selectFileForJapan(params) {
  return request({
    url: '/video/selectfile',
    method: 'get',
    params
  })
}

export function selectFileForAnimate(params) {
  return request({
    url: '/video/selectFileForAnimate',
    method: 'get',
    params
  })
}

export function selectFileForPornHub(params) {
  return request({
    url: '/video/selectFileForPornHub',
    method: 'get',
    params
  })
}

export function refreshCover(params) {
  return request({
    url: '/sysUtil/refreshCover',
    method: 'get',
    params
  })
}

export function updatePicsFromLocal(data) {
  return request({
    url: '/picture/updatefile',
    method: 'post',
    data
  })
}

export function updateType(params) {
  return request({
    url: '/type/updateType',
    method: 'get',
    params
  })
}


export function savePornVideo(params) {
  return request({
    url: '/util/savePornVideo',
    method: 'get',
    params
  })
}

export function checkVideo(params) {
  return request({
    url: '/util/checkVideo',
    method: 'get',
    params
  })
}
