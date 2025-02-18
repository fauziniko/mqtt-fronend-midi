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
            <button @click="deleteMidi(midi.name)">Hapus</button>
            <button @click="downloadMidi(midi.name)">Unduh</button>
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
        // If response contains a "files" array, map each filename to an object with a name property.
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
        // Refresh the list after deletion
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
.midi-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
}

.midi-table th,
.midi-table td {
  border: 1px solid #ccc;
  padding: 0.5em;
  text-align: left;
}

.midi-table th {
  background-color: #fff;
  color: #000; /* Ensure header text is black */
}

.midi-table tr:nth-child(even) {
  background-color: #f9f9f9;
}

button {
  border-radius: 8px;
  border: 1px solid transparent;
  padding: 0.4em 0.8em;
  font-size: 0.9em;
  font-weight: 500;
  font-family: inherit;
  background-color: #1a1a1a;
  color: white;
  cursor: pointer;
  transition: background-color 0.25s;
  margin-right: 0.5em;
}

button:hover {
  background-color: #333;
}

/* Style the refresh button (if different styling is desired) */
button.refresh {
  background-color: #007bff;
  margin-bottom: 1rem;
}
</style>
