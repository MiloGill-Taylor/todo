import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue({

      template: {
        compilerOptions: {
          isCustomElement: tag => tag.startsWith('app-')
        }
      }
    })
  ],
  resolve: {
    alias: {
      vue: 'vue/dist/vue.esm-bundler.js'
    }
  }
})
