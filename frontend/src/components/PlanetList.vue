<template>
  <v-container>
    <v-card class="mx-auto" max-width="1200">
      <v-card-title class="d-flex align-center">
        <v-icon class="mr-2">mdi-planet</v-icon>
        Planet Catalog
        <v-spacer></v-spacer>
        <v-btn to="/add" color="primary" prepend-icon="mdi-plus"> Add Planet </v-btn>
      </v-card-title>

      <v-card-text>
        <!-- Filters -->
        <v-row class="mb-6">
          <v-col cols="12" md="4">
            <v-text-field
              v-model="filters.search"
              label="Search planets or stars"
              clearable
              prepend-icon="mdi-magnify"
              @update:model-value="fetchPlanets"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="2">
            <v-text-field
              v-model="filters.minMass"
              label="Min mass (Earth)"
              type="number"
              clearable
              @update:model-value="fetchPlanets"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="2">
            <v-text-field
              v-model="filters.maxMass"
              label="Max mass (Earth)"
              type="number"
              clearable
              @update:model-value="fetchPlanets"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="2">
            <v-select
              v-model="filters.planetType"
              :items="planetTypes"
              label="Planet Type"
              clearable
              @update:model-value="fetchPlanets"
            ></v-select>
          </v-col>
          <v-col cols="12" md="2" class="d-flex align-center">
            <v-btn @click="resetFilters" variant="outlined" color="secondary">
              Reset
            </v-btn>
          </v-col>
        </v-row>

        <!-- Planets Table -->
        <v-data-table
          :headers="headers"
          :items="planets"
          :loading="loading"
          class="elevation-1"
        >
          <template v-slot:item.tipo_planeta="{ item }">
            <v-chip :color="getPlanetTypeColor(item.tipo_planeta)" dark>
              {{ item.tipo_planeta }}
            </v-chip>
          </template>

          <template v-slot:item.massa_terra="{ item }">
            {{ formatNumber(item.massa_terra, ' M⊕') }}
          </template>

          <template v-slot:item.raio_km="{ item }">
            {{ formatNumber(item.raio_km, ' km') }}
          </template>

          <template v-slot:item.gravidade_m_s2="{ item }">
            {{ formatNumber(item.gravidade_m_s2, ' m/s²') }}
          </template>

          <template v-slot:item.distancia_anos_luz="{ item }">
            {{ formatDistance(item.distancia_anos_luz) }}
          </template>

          <template v-slot:loading>
            <v-skeleton-loader type="table-row@10"></v-skeleton-loader>
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { apiClient } from '../utils/api.js'

const planets = ref([]);
const loading = ref(false);

const filters = ref({
  search: '',
  minMass: '',
  maxMass: '',
  planetType: '',
});

const planetTypes = [
  { title: 'All', value: 'all' },
  { title: 'Gasoso', value: 'gasoso' },
  { title: 'Rochoso', value: 'rochoso' },
];

const headers = [
  { title: 'Name', key: 'nome', sortable: true },
  { title: 'Type', key: 'tipo_planeta', sortable: true },
  { title: 'Mass (Earth)', key: 'massa_terra', sortable: true },
  { title: 'Radius (km)', key: 'raio_km', sortable: true },
  { title: 'Gravity (m/s²)', key: 'gravidade_m_s2', sortable: true },
  { title: 'Distance (ly)', key: 'distancia_anos_luz', sortable: true },
  { title: 'Star', key: 'estrela_nome', sortable: true },
  { title: 'Galaxy', key: 'galaxia_nome', sortable: true },
];

function formatNumber(value, suffix = '') {
  if (value === null || value === undefined || value === '') return 'N/A';

  const num = typeof value === 'string' ? parseFloat(value) : value;
  if (isNaN(num)) return 'N/A';

  return num.toFixed(2) + suffix;
}

function formatDistance(value) {
  if (value === null || value === undefined || value === '') return 'N/A';

  const num = typeof value === 'string' ? parseFloat(value) : value;
  if (isNaN(num)) return 'N/A';

  if (num === 0) return '0 ly (Solar System)';
  return num.toFixed(2) + ' ly';
}

function getPlanetTypeColor(type) {
  const colors = {
    Gasoso: 'orange',
    Rochoso: 'green',
    Anão: 'blue',
    Desconhecido: 'grey',
  };
  return colors[type] || 'grey';
}

async function fetchPlanets() {
  loading.value = true
  try {
    const params = new URLSearchParams()
    if (filters.value.search) params.append('search', filters.value.search)
    if (filters.value.minMass) params.append('minMass', filters.value.minMass)
    if (filters.value.maxMass) params.append('maxMass', filters.value.maxMass)
    if (filters.value.planetType) params.append('planetType', filters.value.planetType)
    
    planets.value = await apiClient.get(`/planets?${params}`)
  } catch (error) {
    console.error('Error fetching planets:', error)
  } finally {
    loading.value = false
  }
}

function resetFilters() {
  filters.value = {
    search: '',
    minMass: '',
    maxMass: '',
    planetType: '',
  };
  fetchPlanets();
}

onMounted(() => {
  fetchPlanets();
});
</script>
