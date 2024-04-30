<script setup>
  import Task from './Task.vue'
  import { ref } from 'vue'

  const props = defineProps({
    name: {
      type: String,

      required: true
    },
    tasks: {
      type: Array,

      default: []
    }
  })

  const localTasks = ref(props.tasks);

  function deleteTask(taskID) {
    localTasks.value = localTasks.value.filter(task => task.id != taskID)
  }
</script>

<template>
  <div class="
    inline-block
    border-gray-100
    border
    w-64
    h-80
    shadow-lg
    rounded-lg
    overflow-hidden"
  >
    <h1> {{ name }}</h1>

    <Task v-for="task in localTasks"
      :task="task"
      :key="task.id"
      @deleteTask="deleteTask"
      />
  </div>
</template>
