<template>
  <div>
    <h2>Cari File MIDI</h2>
    <input v-model="query" placeholder="Cari file..." class="input" />
    <button @click="searchMidi">Cari</button>

    <ul class="list">
      <li v-for="(file, index) in results" :key="index" class="list-item">
        {{ file }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      query: '',
      results: [] // Will hold list of file names from response.files
    };
  },
  methods: {
    async searchMidi() {
      try {
        const response = await axios.get(`${import.meta.env.VITE_API_BASE_URL}/api/files/search`, {
          params: { q: this.query }
        });
        // Assign the files from response to results
        this.results = response.data.files;
      } catch (error) {
        console.error("Gagal mencari file:", error);
      }
    }
  }
};
</script>

<style scoped>
.input {
  padding: 0.5em;
  border: 1px solid #000; /* Black border */
  border-radius: 4px;
  margin-bottom: 1rem;
  width: 100%;
  background-color: #fff; /* White background */
}

.list {
  list-style: none;
  padding: 0;
}

.list-item {
  padding: 0.5em 0;
  border-bottom: 1px solid #ccc;
  color: #000; /* Set text color to black */
}

.list-item:last-child {
  border-bottom: none;
}
</style>
