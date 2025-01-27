-- 由于这只是一个示例配置文件，不要实际加载任何内容，并返回一个空的配置
if true then
  return {}
end

-- `plugins` 目录下的每个配置文件都会被 `lazy.nvim` 自动加载
--
-- 在你的插件文件中，你可以：
-- * 添加额外的插件
-- * 启用/禁用 LazyVim 插件
-- * 覆盖 LazyVim 插件的配置
return {
  -- 添加 gruvbox 配色方案
  { "ellisonleao/gruvbox.nvim" },

  -- 配置 LazyVim 使用 gruvbox 配色方案
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- 修改 trouble.nvim 的配置
  {
    "folke/trouble.nvim",
    -- opts 会与父配置合并
    opts = { use_diagnostic_signs = true },
  },

  -- 禁用 trouble.nvim 插件
  { "folke/trouble.nvim", enabled = false },

  -- 覆盖 nvim-cmp 配置并添加 cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- 修改 telescope.nvim 的配置并添加一个键位映射以浏览插件文件
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- 添加一个键位映射以浏览插件文件
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    -- 修改一些选项
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- 在 lspconfig 中添加 pyright
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright 会通过 mason 自动安装并通过 lspconfig 加载
        pyright = {},
      },
    },
  },

  -- 添加 tsserver 并使用 typescript.nvim 替代 lspconfig 进行配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver 会通过 mason 自动安装并通过 lspconfig 加载
        tsserver = {},
      },
      -- 你可以在这里进行任何额外的 LSP 服务器配置
      -- 如果不想通过 lspconfig 配置此服务器，返回 true
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- 示例：使用 typescript.nvim 进行配置
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- 指定 * 以将此函数用作任何服务器的后备配置
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- 对于 TypeScript，LazyVim 还包括额外的配置以正确设置 lspconfig、treesitter、mason 和 typescript.nvim
  -- 因此，你可以使用以下代码替代上述配置：
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- 添加更多的 treesitter 解析器
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- 由于 `vim.tbl_deep_extend` 只能合并表而不能合并列表，上述代码会覆盖 `ensure_installed` 的值
  -- 如果你想扩展默认配置，可以使用以下代码：
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- 添加 tsx 和 typescript
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- opts 函数也可以用于修改默认配置：
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- 或者你可以返回新的配置以覆盖所有默认值
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[在这里添加你的自定义 lualine 配置]]
      }
    end,
  },

  -- 使用 mini.starter 替代 alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- 添加 jsonls 和 schemastore 包，并为 json、json5 和 jsonc 设置 treesitter
  { import = "lazyvim.plugins.extras.lang.json" },

  -- 添加你希望安装的任何工具
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
