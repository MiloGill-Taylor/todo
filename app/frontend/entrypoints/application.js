import { createApp } from 'vue'
import TaskList from '../components/TaskList.vue'

document.addEventListener('DOMContentLoaded', async () => {
  const entry_element = document.getElementById("app-vue-entry")

  const app = createApp({
    components: {
      TaskList
    },
    setup() {
      return {
        TaskList,
      }
    }
  })
  app.mount(entry_element)
  }
)
