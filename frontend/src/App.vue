<template>
  <v-app>
    <v-app-bar color="deep-purple" dark>
      <v-toolbar-title>🌌 Planet Explorer</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn to="/" icon>
        <v-icon>mdi-star</v-icon>
      </v-btn>
      <v-btn to="/add" icon>
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script setup>
</script>