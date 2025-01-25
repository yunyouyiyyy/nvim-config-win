local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.o.shell = "pwsh"
require("lazy").setup({
  spec = {
    -- 添加 LazyVim 并导入其插件
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- 导入你的自定义插件
    { import = "plugins" },
  },
  defaults = {
    -- 默认情况下，只有 LazyVim 插件会被延迟加载。你的自定义插件会在启动时加载。
    -- 如果你知道自己在做什么，可以将此设置为 `true`，以默认延迟加载所有自定义插件。
    lazy = false,
    -- 建议暂时保持 version=false，因为许多支持版本控制的插件可能有过时的版本，可能会破坏你的 Neovim 安装。
    version = false, -- 始终使用最新的 git commit
    -- version = "*", -- 尝试安装支持 semver 的插件的最新稳定版本
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- 定期检查插件更新
    notify = false, -- 更新时不通知
  }, -- 自动检查插件更新
  performance = {
    rtp = {
      -- 禁用一些 rtp 插件
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
