return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        -- Docker compose files
        ["docker-compose.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["docker-compose.override.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["docker-compose.dev.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["docker-compose.prod.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["docker-compose.test.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["docker-compose.local.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        -- -- Prettier files
        [".prettierrc.json"] = { glyph = "", hl = "MiniIconsRed" },
        [".prettierignore"] = { glyph = "", hl = "MiniIconsRed" },
        -- -- ESLint files
        [".eslintrc.json"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintignore"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["eslint.config.cjs"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["eslint.config.mjs"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
      },
      extension = {
        ["test.ts"] = { glyph = "", hl = "MiniIconsBlue" },
        ["spec.ts"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
  },
}
