<script setup>
  import { ref, computed } from 'vue'
  // props
  const props = defineProps({
    name: {
      type: String,

      required: true
    },
    description: {
      type: String,

      required: false
    },
    status: {
      type: String,

      required: true
    }
  })

  // computed
  const statusCss = computed(() => {
    let baseCss = `inline-block
      w-4
      h-4
      justify-self-center
      self-center
      rounded-full `

    if (props.status === "unstarted") {
      return baseCss
    } else if (props.status === "in_progress") {
      return baseCss + "bg-yellow-400"
    } else {
      return baseCss + "bg-green-600"
    }
  })
</script>

<template>
  <div class="
    grid
    grid-cols-3
    border-gray-200
    border
    w-64
    shadow-lg
    rounded-lg
    overflow-hidden"
  >

  <input
    type="text"
    placeholder="Name"
    class="
      col-span-2
      border-0
      py-0
      px-1
      font-medium
      focus:ring-0"
    value="name"
  />
  <div :class="statusCss"></div>

  <input
    type="text"
    placeholder="Enter description"
    class="
      col-span-3
      text-sm
      border-0
      py-0
      px-1
      focus:ring-0"
  />

  <div v-if="status === 'unstarted'" class="col-span-3 grid grid-cols-3">
    <button class="
      bg-yellow-400
      text-white
        text-sm
        font-bold
        mb-1
        mx-4
        rounded"
    >Start</button>
    <button class="
      bg-green-500
      text-white
        text-sm
        font-bold
        mb-1
        mx-4
        rounded"
    >Done</button>
    <button class="
      bg-red-300
      text-white
        text-sm
        font-bold
        mb-1
        mx-2
        rounded"
    >Delete</button>
  </div>
  <div v-else-if="status ==='in_progress'" class="col-span-3 grid grid-cols-3">
    <button class="
        bg-red-500
      text-white
        text-sm
        font-bold
        mb-1
        mx-2
        rounded"
    >Unstart</button>
    <button class="
        bg-green-500
      text-white
        text-sm
        font-bold
        mb-1
        mx-2
        rounded"
    >Complete</button>
    <button class="
      bg-red-300
      text-white
        text-sm
        font-bold
        mb-1
        mx-2
        rounded"
    >Delete</button>
  </div>
  <div v-else class="col-span-3 grid grid-cols-3">
    <button class="
        col-start-3
        bg-red-300
      text-white
        text-sm
        font-bold
        mb-1
        mx-2
        rounded">Delete</button>
  </div>
  </div>
</template>

<style>

</style>
