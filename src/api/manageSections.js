import request from '@/utils/request'

export function getSectionsList(params) {
  return request({
    url: '/sections/findList',
    method: 'post',
    params
  })
}

export function getSectionsPage(params) {
  return request({
    url: '/sections/findPage',
    method: 'post',
    params
  })
}

export function getSectionsBydoctorId(params) {
  return request({
    url: '/sections/findListByDoctorId',
    method: 'post',
    params
  })
}

export function exportExcel(params) {
  return request({
    url: '/sections/exportExcel',
    method: 'post',
    params,
    responseType: 'blob'
  })
}
