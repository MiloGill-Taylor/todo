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

  function updateTaskName(newName, id) {
    updateTaskProperty('name', newName, id)
  }

  function updateTaskDescription(newDescription, id) {
    updateTaskProperty('description', newDescription, id)
  }

  function updateTaskStatus(newStatus, id) {
    updateTaskProperty('status', newStatus, id)
  }

  function updateTaskProperty(property, newValue, id) {
    localTasks.value.forEach((task, index, tasks) => {
      if (task.id === id) {
        tasks[index][property] = newValue
      }
    })
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
      :name="task.name"
      :description="task.description"
      :status="task.status"
      :id="task.id"
      @updateTaskName="updateTaskName"
      @updateTaskDescription="updateTaskDescription"
      @updateTaskStatus="updateTaskStatus"
      />
  </div>
</template>
