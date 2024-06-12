return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        -- exact = {
        ["docker-compose.local.yaml"] = {
          icon = "󰡨",
          color = "#458ee6",
          cterm_color = "68",
          name = "DockerComposeLocal",
        },
        [".env.sample"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "EnvSample",
        },
        [".env.local"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "EnvLocal",
        },
      },
      -- regex = {
      --   [".env..*"] = {
      --     icon = "",
      --     color = "#faf743",
      --     cterm_color = "227",
      --     name = "EnvFile",
      --   },
      -- },
      -- },
    },
  },
}
