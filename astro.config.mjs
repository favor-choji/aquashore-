// @ts-check
import { defineConfig } from "astro/config";
import netlify from "@astrojs/netlify";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  site: "https://aquashoremarine.com",
  adapter: netlify({
    devFeatures: false,
  }),
  vite: {
    plugins: [tailwindcss()],
  },
  output: "static",
});
