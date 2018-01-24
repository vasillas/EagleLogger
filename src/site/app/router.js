import Vue from 'vue'
import Router from 'vue-router'

import AboutPage from '../../components/About/AboutPage.vue'
import AuthActivationPage from '../../components/Auth/AuthActivationPage.vue'
import HomePage from '../../components/Home/HomePage.vue'
import RouterView from '../../components/Misc/RouterView.vue'
import NetPage from '../../components/Nets/NetPage.vue'
import NetPageControls from '../../components/Nets/NetPageControls.vue'
import NetsListPage from '../../components/Nets/NetsListPage.vue'
import NetTypesListPage from '../../components/NetTypes/NetTypesListPage.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      components: {
        page: HomePage
      }
    }, {
      path: '/about',
      components: { page: AboutPage }
    }, {
      path: '/activate',
      components: { page: AuthActivationPage },
      props: true,
      children: [
        { path: ':userId', components: { page: AuthActivationPage } },
        { path: ':userId/:code', components: { page: AuthActivationPage } }
      ]
    }, {
      path: '/nets',
      components: { page: NetsListPage }
    }, {
      path: '/nets/:id',
      components: { page: NetPage, controls: NetPageControls }
    }, {
      path: '/net-types',
      components: { page: NetTypesListPage }
    }
  ],
  mode: 'history'
})
