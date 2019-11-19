import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
/* Layout */
import Layout from '@/layout'
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },

  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  {
    path: '/',
    component: Layout,
    redirect: '/index',
    children: [
      {
        path: 'index',
        name: 'Index',
        component: () => import('@/views/index/index'),
        meta: { title: '首页', icon: 'dashboard' }
      }
    ]
  },
  {
    path: '/picture',
    component: Layout,
    redirect: '/picture/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/picture/index'),
        name: '图片',
        meta: { title: '图片' }
      }
    ]
  },
  {
    path: '/picture_detail',
    component: Layout,
    redirect: '/picture_detail/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/picture_detail/index'),
        name: '图片详情',
        meta: { title: '图片详情' }
      }
    ]
  },
  {
    path: '/video',
    component: Layout,
    redirect: '/video/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/video/index'),
        name: '影片',
        meta: { title: '影片' }
      }
    ]
  },
  {
    path: '/video_detail',
    component: Layout,
    redirect: '/video_detail/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/video_detail/index'),
        name: '影片详情',
        meta: { title: '影片详情' }
      }
    ]
  },
  {
    path: '/sys_tools',
    component: Layout,
    redirect: '/sys_tools/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/sys_tools/index'),
        name: '工具',
        meta: { title: '工具' }
      }
    ]
  },
  {
    path: '/actor',
    component: Layout,
    redirect: '/actor/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/actor/index'),
        name: '演员',
        meta: { title: '演员' }
      }
    ]
  }
  // {
  //   path: '/clinic',
  //   component: Layout,
  //   redirect: '/clinic/index',
  //   children: [
  //     {
  //       path: 'index',
  //       component: () => import('@/views/manage-clinic/index'),
  //       name: 'Clinic',
  //       meta: { title: '诊室管理' }
  //     }
  //   ]
  // }
  // {
  //   path: '/record',
  //   component: Layout,
  //   redirect: '/record/table',
  //   name: 'record',
  //   meta: { title: '业务记录', icon: 'example' },
  //   children: [
  //     {
  //       path: 'table',
  //       name: 'Table',
  //       component: () => import('@/views/table/index'),
  //       meta: { title: '预交金记录', icon: 'table' }
  //     },
  //     {
  //       path: 'tree',
  //       name: 'Tree',
  //       component: () => import('@/views/tree/index'),
  //       meta: { title: '挂号费记录', icon: 'tree' }
  //     }, {
  //       path: 'payment',
  //       name: 'Payment',
  //       component: () => import('@/views/payment/index'),
  //       meta: { title: '缴费记录', icon: 'tree' }
  //     }
  //   ]
  // },

  // // 404 page must be placed at the end !!!
  // { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () =>
  new Router({
    // mode: 'history', // require service support
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes
  })

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
