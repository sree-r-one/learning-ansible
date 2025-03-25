import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  define: {
    "process.env": {}, // Prevents Vite build errors
  },
  server: {
    host: true, // This allows Vite to listen on 0.0.0.0 inside Docker
    port: 5173, // Default dev port, must match docker-compose
  },
  test: {
    globals: true,
    environment: "jsdom",
    setupFiles: "./tests/setup.ts",
    coverage: {
      provider: "v8",
      reporter: ["text", "json", "html"],
      exclude: [
        "node_modules/",
        "tests/setup.ts",
        "src/config/**",
        "src/routes/**",
        "src/pages/static/**",
        "src/posts/static/**",
      ],
    },
  },
});
