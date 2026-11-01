// @ts-check
import { defineConfig } from "astro/config";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  site: "https://aquashoremarine.com",
  vite: {
    plugins: [tailwindcss()],
  },
  output: "static",
});
