<template>
  <div>
    <h2>Daftar File MIDI</h2>
    <!-- Refresh button to load the latest data -->
    <button class="refresh" @click="fetchMidiFiles">Refresh</button>
    <table class="midi-table">
      <thead>
        <tr>
          <th>Nama File</th>
          <th>Aksi</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(midi, index) in midis" :key="index">
          <td>{{ midi.name }}</td>
          <td>
            <button class="delete-button" @click="deleteMidi(midi.name)">Hapus</button>
            <button class="download-button" @click="downloadMidi(midi.name)">Unduh</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      midis: []
    };
  },
  mounted() {
    this.fetchMidiFiles();
  },
  methods: {
    async fetchMidiFiles() {
      try {
        const response = await axios.get(`${import.meta.env.VITE_API_BASE_URL}/api/files`);
        console.log("Fetched files:", response.data);
        if (response.data && response.data.files) {
          this.midis = response.data.files.map(file => ({ name: file }));
        } else {
          console.error("Unexpected response structure:", response.data);
        }
      } catch (error) {
        console.error("Gagal mengambil daftar file:", error);
      }
    },
    async deleteMidi(fileName) {
      try {
        await axios.delete(`${import.meta.env.VITE_API_BASE_URL}/api/files`, {
          params: { filename: fileName }
        });
        this.fetchMidiFiles();
      } catch (error) {
        console.error("Gagal menghapus file:", error);
      }
    },
    async downloadMidi(fileName) {
      window.location.href = `${import.meta.env.VITE_API_BASE_URL}/api/files/download?filename=${encodeURIComponent(fileName)}`;
    }
  }
};
</script>

<style scoped>
.delete-button {
  background-color: red;
  color: white;
}
</style>
