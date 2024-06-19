<script setup>
  import { computed, ref, watch } from 'vue'

  // Props
const props = defineProps({
    task: {
      type: Object,

      required: true
    }
  })

  // Refs
  const name = ref(props.task.name)
  const description = ref(props.task.description);
  const status = ref(props.task.status);

  // Emits
  const emit = defineEmits(['deleteTask', 'updateTask'])

  // computed
  const statusCss = computed(() => {
    let baseCss = `inline-block
      w-4
      h-4
      justify-self-center
      self-center
      rounded-full `

    if (status.value === "unstarted") {
      return baseCss
    } else if (status.value === "in_progress") {
      return baseCss + "bg-yellow-400"
    } else {
      return baseCss + "bg-green-600"
    }
  })

  const buttons = computed(() => {
    let baseCss = 'text-white text-sm font-bold mb-1 mx-2 rounded'
    if (status.value === "unstarted") {
      return [
        { class: baseCss + ' bg-yellow-400', text: 'Start'},
        { class: baseCss + ' bg-green-500', text: 'Done' },
        { class: baseCss + ' bg-red-300', text: 'Delete'}
      ]
    } else if (status.value === "in_progress") {
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

  // methods
  function buttonClick(button) {
    switch(button.text){
      case 'Start':
        status.value = 'in_progress'
        break;
      case 'Done':
      case 'Complete':
        status.value = 'complete'
        break;
      case 'Unstart':
        status.value = 'unstarted'
        break;
      case 'Delete':
        emit('deleteTask', props.task.id)
        break;
    }
  }

  function getTask() {
    return { id: props.task.id, name: name.value, status: status.value, description: description.value }
  }

  // watchers

  watch(name, () => emit('updateTask', getTask()))
  watch(description, () => emit('updateTask', getTask()))
  watch(status, () => emit('updateTask', getTask()))
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

    <textarea
      type="textarea"
      placeholder="Task"
      class="
        col-span-3
        border-0
        h-8
        p-1
        font-medium
        focus:ring-0
        resize-none"
      v-model="name"
    />
    <div :class="statusCss"></div>

    <textarea
      placeholder="Enter description"
      class="
        col-span-3
        text-sm
        h-8
        border-0
        p-1
        mb-1
        focus:ring-0
        resize-none"
        v-model="description"
    />

    <button v-for="button in buttons" :class="button.class" @click="buttonClick(button)">{{ button.text }}</button>
  </div>
</template>
