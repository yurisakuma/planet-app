<template>
  <v-container>
    <v-card class="mx-auto" max-width="800">
      <v-card-title class="d-flex align-center">
        <v-icon class="mr-2">mdi-plus-circle</v-icon>
        Add New Planet
        <v-spacer></v-spacer>
        <v-btn to="/" variant="text" prepend-icon="mdi-arrow-left"> Back to List </v-btn>
      </v-card-title>

      <v-card-text>
        <v-form @submit.prevent="submitForm">
          <v-row>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="form.nome"
                label="Planet Name"
                required
                :rules="[(v) => !!v || 'Name is required']"
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="6">
              <v-select
                v-model="form.id_orbita_estrela"
                :items="orbits"
                item-title="display"
                item-value="id_orbita_estrela"
                label="Orbit Around Star"
                required
                :rules="[(v) => !!v || 'Orbit is required']"
              ></v-select>
            </v-col>

            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.massa_terra"
                label="Mass (Earth masses)"
                type="number"
                step="0.01"
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.raio_km"
                label="Radius (km)"
                type="number"
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.gravidade_m_s2"
                label="Gravity (m/s²)"
                type="number"
                step="0.01"
              ></v-text-field>
            </v-col>

            <v-col cols="12">
              <v-text-field
                v-model="form.distancia_anos_luz"
                label="Distance (light years)"
                type="number"
                step="0.01"
              ></v-text-field>
            </v-col>

            <v-col cols="12">
              <v-select
                v-model="form.tipo_planeta"
                :items="planetTypes"
                label="Planet Type"
                @update:model-value="resetTypeFields"
              ></v-select>
            </v-col>

            <template v-if="form.tipo_planeta === 'gasoso'">
              <v-col cols="12" md="6">
                <v-text-field
                  v-model="form.temperatura_atmosfera"
                  label="Atmosphere Temperature (°C)"
                  type="number"
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="6">
                <v-text-field
                  v-model="form.velocidade_ventos"
                  label="Wind Speed (km/h)"
                  type="number"
                ></v-text-field>
              </v-col>
            </template>

            <template v-if="form.tipo_planeta === 'rochoso'">
              <v-col cols="12" md="6">
                <v-text-field v-model="form.topografia" label="Topography"></v-text-field>
              </v-col>
              <v-col cols="12" md="6">
                <v-text-field v-model="form.vulcanismo" label="Volcanism"></v-text-field>
              </v-col>
              <v-col cols="12" md="6">
                <v-text-field
                  v-model="form.temperatura_superficie"
                  label="Surface Temperature (°C)"
                  type="number"
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="6">
                <v-checkbox
                  v-model="form.presencia_agua_liquida"
                  label="Liquid Water Present"
                ></v-checkbox>
              </v-col>
              <v-col cols="12" md="6">
                <v-text-field
                  v-model="form.campo_magnetico"
                  label="Magnetic Field (μT)"
                  type="number"
                  step="0.01"
                ></v-text-field>
              </v-col>
            </template>
          </v-row>

          <v-btn
            type="submit"
            color="primary"
            size="large"
            :loading="loading"
            :disabled="!isFormValid"
            block
          >
            Add Planet
          </v-btn>
        </v-form>
      </v-card-text>
    </v-card>

    <v-snackbar v-model="snackbar.show" :color="snackbar.color" timeout="3000">
      {{ snackbar.message }}
    </v-snackbar>
  </v-container>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { apiClient } from '../utils/api.js'

const router = useRouter();
const loading = ref(false);
const orbits = ref([]);

const snackbar = ref({
  show: false,
  message: '',
  color: 'success',
});

const form = ref({
  nome: '',
  massa_terra: '',
  raio_km: '',
  gravidade_m_s2: '',
  distancia_anos_luz: '',
  id_orbita_estrela: '',
  tipo_planeta: '',
  temperatura_atmosfera: '',
  velocidade_ventos: '',
  topografia: '',
  vulcanismo: '',
  temperatura_superficie: '',
  presencia_agua_liquida: false,
  campo_magnetico: '',
});

const planetTypes = [
  { title: 'Select planet type', value: '' },
  { title: 'Gasoso', value: 'gasoso' },
  { title: 'Rochoso', value: 'rochoso' },
];

const isFormValid = computed(() => {
  return form.value.nome && form.value.id_orbita_estrela;
});

function resetTypeFields() {
  form.value.temperatura_atmosfera = '';
  form.value.velocidade_ventos = '';
  form.value.topografia = '';
  form.value.vulcanismo = '';
  form.value.temperatura_superficie = '';
  form.value.presencia_agua_liquida = false;
  form.value.campo_magnetico = '';
}

async function fetchOrbits() {
  try {
    const data = await apiClient.get('/orbits')
    orbits.value = data.map((orbit) => ({
      ...orbit,
      display: `${orbit.estrela_nome} (${(orbit.raio_km / 149600000).toFixed(2)} AU)`,
    }))
  } catch (error) {
    console.error('Error fetching orbits:', error)
    snackbar.value = {
      show: true,
      message: 'Failed to load orbits. Please try again.',
      color: 'error'
    }
  }
}

async function submitForm() {
  loading.value = true;
  try {
    const response = await apiClient.post('/planets', form.value);

    if (response.ok) {
      snackbar.value = {
        show: true,
        message: 'Planet added successfully!',
        color: 'success',
      };

      Object.keys(form.value).forEach((key) => {
        if (typeof form.value[key] === 'boolean') {
          form.value[key] = false;
        } else {
          form.value[key] = '';
        }
      });

      setTimeout(() => {
        router.push('/');
      }, 1500);
    } else {
      throw new Error('Failed to add planet');
    }
  } catch (error) {
    console.error('Error adding planet:', error);
    snackbar.value = {
      show: true,
      message: 'Error adding planet. Please try again.',
      color: 'error',
    };
  } finally {
    loading.value = false;
  }
}

onMounted(() => {
  fetchOrbits();
});
</script>
