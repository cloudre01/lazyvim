return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        ["docker-compose.local.yaml"] = {
          icon = "󰡨",
          color = "#458ee6",
          cterm_color = "68",
          name = "DockerComposeLocal",
        },
        [".env.local"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "EnvLocal",
        },
      },
    },
  },
}
