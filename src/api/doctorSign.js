import request from '@/utils/request'

export function getClinicList(params) {
  return request({
    url: '/doctorSign/getClinicBySectionId',
    method: 'get',
    params
  })
}
export function doctorSignn(params) {
  return request({
    url: '/doctorSign/doctorSignin',
    method: 'get',
    params
  })
}
export function backSign(params) {
  return request({
    url: '/doctorSign/doctorSignOut',
    method: 'post',
    params
  })
}

export function getNotSignDoctorBySectionId(params) {
  return request({
    url: '/doctorSign/getNotSignDoctorBySectionId',
    method: 'get',
    params
  })
}
