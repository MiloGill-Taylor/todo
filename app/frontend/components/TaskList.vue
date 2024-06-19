<script setup>
  import Task from './Task.vue'
  import { ref, computed } from 'vue'
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
  const hideCompleted = ref(false)

  // Functions
  async function deleteTask(taskID) {
    localTasks.value = localTasks.value.filter(task => task.id != taskID)

    const response = await fetch(`/tasks/${taskID}`, {
      method: 'DELETE',
      headers: { 'X-CSRF-Token' : getCsrfToken() }
    })

    if (!response.ok) { } // TODO: handle errors
  }

  async function updateTask(task) {
    if (!task.id) { return null }

    const response = await fetch(`/tasks/${task.id}`, {
      method: 'PATCH',
      headers: { 'X-CSRF-Token' : getCsrfToken() },
      body: JSON.stringify(task)
    })

    if (!response.ok) { } // TODO: hanlde erros

    const index = localTasks.value.findIndex(localTask => localTask.id === task.id)

    localTasks.value[index] = task
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

  const completedTasks = computed(() => {
    return localTasks.value.filter((task) => task.status === 'complete')
  });

  const incompleteTasks = computed(() => {
    return localTasks.value.filter((task) => task.status != 'complete')
  });

  const toggleCompletedText = computed(() => {
    return hideCompleted.value ? "Show completed ": "Hide completed"
  });
</script>

<template>
  <div class="
    grid
    grid-cols-3
    border-gray-100
    border
    w-64
    shadow-lg
    rounded-lg
    overflow-hidden"
  >
    <h1 class="col-span-2"> {{ name }}</h1>

    <Task v-for="task in incompleteTasks"
      :task="task"
      :key="task.id"
      class="col-start-1"
      @deleteTask="deleteTask"
      @updateTask="updateTask"
    />

    <button
      class="
        col-start-1
        col-span-1
        flex
        justify-between
        mt-1.5
        text-sm"
      @click="hideCompleted = !hideCompleted"
    >
      <svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path v-if="hideCompleted" d="M9 18l6-6-6-6" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          <path v-else d="M6 9l6 6 6-6" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      {{ toggleCompletedText }}
    </button>


    <button
      class="
        col-start-2
        col-span-1
        flex
        justify-center
        mt-1.5"
      @click="createTask"
    >
    <svg
      width="30px"
      height="30px"
      viewBox="0 0 16 16"
      xmlns="http://www.w3.org/2000/svg"
      fill="#000000"
      class="bi bi-plus-circle-dotted"
    >
      <path d="M8 0c-.176 0-.35.006-.523.017l.064.998a7.117 7.117 0 0 1 .918 0l.064-.998A8.113 8.113 0 0 0 8 0zM6.44.152c-.346.069-.684.16-1.012.27l.321.948c.287-.098.582-.177.884-.237L6.44.153zm4.132.271a7.946 7.946 0 0 0-1.011-.27l-.194.98c.302.06.597.14.884.237l.321-.947zm1.873.925a8 8 0 0 0-.906-.524l-.443.896c.275.136.54.29.793.459l.556-.831zM4.46.824c-.314.155-.616.33-.905.524l.556.83a7.07 7.07 0 0 1 .793-.458L4.46.824zM2.725 1.985c-.262.23-.51.478-.74.74l.752.66c.202-.23.418-.446.648-.648l-.66-.752zm11.29.74a8.058 8.058 0 0 0-.74-.74l-.66.752c.23.202.447.418.648.648l.752-.66zm1.161 1.735a7.98 7.98 0 0 0-.524-.905l-.83.556c.169.253.322.518.458.793l.896-.443zM1.348 3.555c-.194.289-.37.591-.524.906l.896.443c.136-.275.29-.54.459-.793l-.831-.556zM.423 5.428a7.945 7.945 0 0 0-.27 1.011l.98.194c.06-.302.14-.597.237-.884l-.947-.321zM15.848 6.44a7.943 7.943 0 0 0-.27-1.012l-.948.321c.098.287.177.582.237.884l.98-.194zM.017 7.477a8.113 8.113 0 0 0 0 1.046l.998-.064a7.117 7.117 0 0 1 0-.918l-.998-.064zM16 8a8.1 8.1 0 0 0-.017-.523l-.998.064a7.11 7.11 0 0 1 0 .918l.998.064A8.1 8.1 0 0 0 16 8zM.152 9.56c.069.346.16.684.27 1.012l.948-.321a6.944 6.944 0 0 1-.237-.884l-.98.194zm15.425 1.012c.112-.328.202-.666.27-1.011l-.98-.194c-.06.302-.14.597-.237.884l.947.321zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a6.999 6.999 0 0 1-.458-.793l-.896.443zm13.828.905c.194-.289.37-.591.524-.906l-.896-.443c-.136.275-.29.54-.459.793l.831.556zm-12.667.83c.23.262.478.51.74.74l.66-.752a7.047 7.047 0 0 1-.648-.648l-.752.66zm11.29.74c.262-.23.51-.478.74-.74l-.752-.66c-.201.23-.418.447-.648.648l.66.752zm-1.735 1.161c.314-.155.616-.33.905-.524l-.556-.83a7.07 7.07 0 0 1-.793.458l.443.896zm-7.985-.524c.289.194.591.37.906.524l.443-.896a6.998 6.998 0 0 1-.793-.459l-.556.831zm1.873.925c.328.112.666.202 1.011.27l.194-.98a6.953 6.953 0 0 1-.884-.237l-.321.947zm4.132.271a7.944 7.944 0 0 0 1.012-.27l-.321-.948a6.954 6.954 0 0 1-.884.237l.194.98zm-2.083.135a8.1 8.1 0 0 0 1.046 0l-.064-.998a7.11 7.11 0 0 1-.918 0l-.064.998zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/>
    </svg>
    </button>

    <Task v-if="!hideCompleted"
      v-for="task in completedTasks"
      :task="task"
      :key="task.id"
      class="col-start-1"
      @deleteTask="deleteTask"
      @updateTask="updateTask"
    />
  </div>
</template>
