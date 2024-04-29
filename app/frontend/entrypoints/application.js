import { createApp, ref } from 'vue'
import TaskList from '../components/TaskList.vue'
import Task from '../components/Task.vue'

document.addEventListener('DOMContentLoaded', async () => {
  const entry_element = document.getElementById("app-vue-entry")

  let task = {
    name: "Name",
    description: "description",
    status: "unstarted"
  }

  const app = createApp({
    components: {
      TaskList,
      Task
    },
    setup() {
      // ref

      return {
        buttonPress,
        TaskList,
        Task,
        createNewList
      }
    }
  })
  app.mount(entry_element)
  }
)
