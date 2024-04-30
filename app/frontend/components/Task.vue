<script setup>
  import { computed } from 'vue'
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
    },
    id: {
      type: Number,

      required: true
    }
  })

  // Emits

  const emit = defineEmits(['updateTaskName', 'updateTaskDescription', 'updateTaskStatus'])

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

  const buttons = computed(() => {
    let baseCss = 'text-white text-sm font-bold mb-1 mx-2 rounded'
    if (props.status === "unstarted") {
      return [
        { class: baseCss + ' bg-yellow-400', text: 'Start'},
        { class: baseCss + ' bg-green-500', text: 'Done' },
        { class: baseCss + ' bg-red-300', text: 'Delete'}
      ]
    } else if (props.status === "in_progress") {
      return [
        { class: baseCss + ' bg-red-500', text: 'Unstart'},
        { class: baseCss + ' bg-green-500', text: 'Complete' },
        { class: baseCss + ' bg-red-300', text: 'Delete'}
      ]
    } else {
      return [
        { class: baseCss + ' bg-red-300 col-start-3', text: 'Delete'}
      ]
    }
  })

  const taskName = computed({
    get() {
      return props.name
    },
    set(newName){
      emit('updateTaskName', newName, props.id);
    }
  })

  const taskDescription = computed({
    get() {
      return props.description
    },
    set(newDescription){
      emit('updateDescription', newDescription, props.id);
    }
  })

  const taskStatus= computed({
    get() {
      return props.status
    },
    set(newStatus){
      emit('updateTaskStatus', newStatus, props.id);
    }
  })

  // methods

  function buttonClick(button) {
    switch(button.text){
      case 'Start':
        taskStatus.value = 'in_progress'
        break;
      case 'Done':
      case 'Complete':
        taskStatus.value = 'completed'
        break;
      case 'Unstart':
        taskStatus.value = 'unstarted'
        break;
      case 'Delete':
        // To implement
        break;
    }
  }
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
      v-model="taskName"
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

    <button v-for="button in buttons" :class="button.class" @click="buttonClick(button)">{{ button.text }}</button>
  </div>
</template>
