import { defineConfig, loadEnv } from 'vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');

  return {
    plugins: [vue()],
    server: {
      port: 3000,
    },
    define: {
      __VITE_API_URL__: JSON.stringify(env.VITE_API_URL),
    },
  };
});
