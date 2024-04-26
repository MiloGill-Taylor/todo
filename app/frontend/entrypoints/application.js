import { createApp, onMounted } from 'vue'

document.addEventListener('DOMContentLoaded', async () => {
  const entry_element = document.getElementById("app-vue-entry")

  const app = createApp({
    setup() {
      // methods
      function buttonPress () {
        console.log('pressed')
      }
      return {buttonPress}
    }
  })
  app.mount(entry_element)
  }
)
