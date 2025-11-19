const getBaseUrl = () => {
  if (
    window.location.hostname === 'localhost' ||
    window.location.hostname === '127.0.0.1'
  ) {
    return 'http://localhost:3001/api';
  } else {
    return 'https://planet-app-yppo.onrender.com/api';
  }
};

export const apiClient = {
  async get(url) {
    const fullUrl = `${getBaseUrl()}${url}`;
    console.log('Making GET request to:', fullUrl);
    const response = await fetch(fullUrl);
    return response.json();
  },

  async post(url, data) {
    const fullUrl = `${getBaseUrl()}${url}`;
    console.log('Making POST request to:', fullUrl);
    const response = await fetch(fullUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    return response.json();
  },
};
