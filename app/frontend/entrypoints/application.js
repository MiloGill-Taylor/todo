import { createApp } from 'vue'
import TaskList from '../components/TaskList.vue'

document.addEventListener('DOMContentLoaded', async () => {
  const entry_element = document.getElementById("app-vue-entry")

  const app = createApp({
    components: {
      TaskList
    },
    setup() {
      const tasks = [
        { name: "task name", description: "task description", status: "unstarted", id: 1 },
        { name: "task name", description: "task 2", status: "unstarted", id: 2 }
      ]

      return {
        TaskList,
        tasks
      }
    }
  })
  app.mount(entry_element)
  }
)
