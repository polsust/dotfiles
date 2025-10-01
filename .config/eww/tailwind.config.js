/** @type {import('tailwindcss').Config} */
module.exports = {
  mode: "aot",
  content: ["./src/*.yuck"],
  safelist: [],
  theme: {},
  corePlugins: {
    preflight: false,
    container: false,
    backgroundOpacity: false, // <- disable bg opacity
    textOpacity: false, // <- disable text opacity
  },
  variants: { extend: {} },
};
