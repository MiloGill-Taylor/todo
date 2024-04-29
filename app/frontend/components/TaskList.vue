<script setup>
  import { ref } from 'vue'

  defineProps({
    name: {
      type: String,

      required: true
    },
    tasks: {
      type: Array,

      default: []
    }
  })
</script>

<template>
  <div class="
    inline-block
    border-gray-100
    border
    w-48
    h-80"
  >
    <form>
      <label>

      </label>
    </form>
  </div>
</template>
