import { createRouter, createWebHistory } from 'vue-router'
import PlanetList from '../components/PlanetList.vue'
import AddPlanet from '../components/AddPlanet.vue'

const routes = [
  { path: '/', component: PlanetList },
  { path: '/add', component: AddPlanet }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router