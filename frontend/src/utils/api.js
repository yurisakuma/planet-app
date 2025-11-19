const getBaseUrl = () => {
  if (import.meta.env.PROD) {
    return import.meta.env.VITE_API_URL;
  }
  return 'http://localhost:3001/api';
};

export const apiClient = {
  async get(url) {
    const response = await fetch(`${getBaseUrl()}${url}`);
    return response.json();
  },

  async post(url, data) {
    const response = await fetch(`${getBaseUrl()}${url}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    return response.json();
  },
};
