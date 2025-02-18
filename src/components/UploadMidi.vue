<template>
    <div>
      <h2>Upload File MIDI</h2>
      <input type="file" @change="handleFileUpload" class="input" />
      <button @click="uploadFile">Upload</button>
      <p v-if="message">{{ message }}</p>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        file: null,
        message: ''
      };
    },
    methods: {
      handleFileUpload(event) {
        this.file = event.target.files[0];
      },
      async uploadFile() {
        if (!this.file) {
          this.message = 'Pilih file MIDI terlebih dahulu!';
          return;
        }
        
        const formData = new FormData();
        formData.append('file', this.file);
  
        try {
          const response = await axios.post(`${import.meta.env.VITE_API_BASE_URL}/api/files/upload`, formData, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          });
          if (response.status === 200) {
            this.message = 'File berhasil diunggah!';
          } else {
            this.message = 'Gagal mengunggah file!';
          }
        } catch (error) {
          this.message = 'Gagal mengunggah file!';
          console.error(error);
        }
      }
    }
  };
  </script>
