<template>
  <div class="container">
    <h1>🎵 MIDI Manager 🎵</h1>
    <div class="card">
      <UploadMidi />
    </div>
    <div class="card">
      <SearchMidi />
    </div>
    <div class="card">
      <MidiList />
    </div>
  </div>
</template>

<script>
import UploadMidi from '../components/UploadMidi.vue';
import SearchMidi from '../components/SearchMidi.vue';
import MidiList from '../components/MidiList.vue';

export default {
  components: {
    UploadMidi,
    SearchMidi,
    MidiList
  }
};
</script>
