return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    -- Uncomment a picker that you want to use, snacks.nvim might be additionally
    -- useful to show previews and failing snapshots.

    -- You must select at least one:
    -- "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "folke/snacks.nvim", -- (optional) to show previews

    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  },
  keys = {
    { "<leader>xcp", "<cmd>XcodebuildPicker<cr>", desc = "Show Xcodebuild Actions" },
    { "<leader>xcf", "<cmd>XcodebuildProjectManager<cr>", desc = "Show Project Manager Actions" },

    { "<leader>xcb", "<cmd>XcodebuildBuild<cr>", desc = "Build Project" },
    { "<leader>xcB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build For Testing" },
    { "<leader>xcr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run Project" },

    { "<leader>xct", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
    { "<leader>xct", "<cmd>XcodebuildTestSelected<cr>", mode = "v", desc = "Run Selected Tests" },
    { "<leader>xcT", "<cmd>XcodebuildTestClass<cr>", desc = "Run Current Test Class" },
    { "<leader>xc.", "<cmd>XcodebuildTestRepeat<cr>", desc = "Repeat Last Test Run" },

    { "<leader>xcl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Xcodebuild Logs" },
    { "<leader>xcc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Toggle Code Coverage" },
    { "<leader>xcC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", desc = "Show Code Coverage Report" },
    { "<leader>xce", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Toggle Test Explorer" },
    { "<leader>xcs", "<cmd>XcodebuildFailingSnapshots<cr>", desc = "Show Failing Snapshots" },

    { "<leader>xcpp", "<cmd>XcodebuildPreviewGenerateAndShow<cr>", desc = "Generate Preview" },
    { "<leader>xc<cr>", "<cmd>XcodebuildPreviewToggle<cr>", desc = "Toggle Preview" },

    { "<leader>xcd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
    { "<leader>xcq", "<cmd>Telescope quickfix<cr>", desc = "Show QuickFix List" },

    { "<leader>xcx", "<cmd>XcodebuildQuickfixLine<cr>", desc = "Quickfix Line" },
    { "<leader>xca", "<cmd>XcodebuildCodeActions<cr>", desc = "Show Code Actions" },
  },
  config = function()
    require("xcodebuild").setup({
      -- put some options here or leave it empty to use default settings
    })
  end,
}
