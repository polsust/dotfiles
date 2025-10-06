return {
  {
    enabled = false,
    lazy = true,
    "kyazdani42/nvim-web-devicons",
    opts = {
      override_by_extension = {
        ts = {
          icon = "",
          color = "#519aba",
          name = "Typescript",
        },
      },
      override_by_filename = {
        ["tsconfig.json"] = {
          icon = "",
          color = "#519aba",
          name = "Tsconfig",
        },
      },
    },
  },
}
