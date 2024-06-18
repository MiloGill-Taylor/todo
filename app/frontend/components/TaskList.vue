<script setup>
  import Task from './Task.vue'
  import { ref, watch } from 'vue'
  import getCsrfToken from '../src/get_csrf_token'

  // Props
  const props = defineProps({
    name: {
      type: String,

      required: true
    },
    id: {
      type: String,

      required: true
    },
    tasks: {
      type: Array,

      default: []
    }
  })

  // Refs
  const localTasks = ref(props.tasks.map((task) => JSON.parse(task)));

  // Functions
  async function deleteTask(taskID) {
    localTasks.value = localTasks.value.filter(task => task.id != taskID)

    const response = await fetch(`/tasks/${taskID}`, {
      method: 'DELETE',
      headers: { 'X-CSRF-Token' : getCsrfToken() }
    })

    if (!response.ok) { } // TODO: handle errors
  }

  async function createTask(){
    const response = await fetch('/tasks', {
      method: 'POST',
      headers: { 'X-CSRF-Token' : getCsrfToken() },
      body: JSON.stringify({ list_id: props.id }),
    })

    if (response.ok){
      const body = await response.json()

      const newTask = { id: body.id, name: undefined, status: 'unstarted' }

      localTasks.value.push(newTask)
    } else {
      //TODO: handle errors
    }
  }

</script>

<template>
  <div class="
    inline-block
    border-gray-100
    border
    w-64
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

    <button @click="createTask">New Task</button>
  </div>
</template>
