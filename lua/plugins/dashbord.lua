return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local logo = [[
                                          _                                                        
                                         (  )                                               _ .--. 
          _ .                         ( `  ) . )                                           ( `    )   
        (  _ )_                      (_, _(  ,_)_)                                      .-'      `--,   
      (_  _(_ ,)                                                                        (_   )__  __ _)`- 
  ___    ___ ___  ___  ________            ___    ___ ________  ___  ___           ___    ___ ___     
 |\  \  /  /|\  \|\  \|\   ___  \         |\  \  /  /|\   __  \|\  \|\  \         |\  \  /  /|\  \    
 \ \  \/  / | \  \\\  \ \  \\ \  \        \ \  \/  / | \  \|\  \ \  \\\  \        \ \  \/  / | \  \   
  \ \    / / \ \  \\\  \ \  \\ \  \        \ \    / / \ \  \\\  \ \  \\\  \        \ \    / / \ \  \  
   \/   / /   \ \  \\\  \ \  \\ \  \        \/   / /   \ \  \\\  \ \  \\\  \        \/   / /   \ \  \ 
 __/   / /     \ \_______\ \__\\ \__\     __/   / /     \ \_______\ \_______\     __/   / /     \ \__\
|\____/ /       \|_______|\|__| \|__|    |\___ / /       \|_______|\|_______|    |\____/ /       \|__|
\|____|/                                 \|____|/                                \|____|/             
  __________________________________________________________________________________________________
---------------------------------------------------------------------------------------@云有依--------
      ]]

      logo = string.rep("\n", 1) .. logo .. "\n\n"

      -- 定义白色和粉色高亮组
      vim.api.nvim_set_hl(0, "DashboardLogoWhite", { fg = "#FFFFFF" }) -- 白色
      vim.api.nvim_set_hl(0, "DashboardLogoPink", { fg = "#FF69B4" }) -- 粉色 (#FF69B4 是粉色的十六进制代码)

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
            { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
            { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
            { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      -- 调整菜单项的格式
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- 手动为 header 设置高亮组
      vim.schedule(function()
        local header_lines = vim.split(logo, "\n")
        for i = 1, #header_lines do
          if i <= 6 or i >= 16 then
            -- 前 7 行设置为白色
            vim.api.nvim_buf_add_highlight(0, -1, "DashboardLogoWhite", i - 1, 0, -1)
          else
            -- 其余行设置为粉色
            vim.api.nvim_buf_add_highlight(0, -1, "DashboardLogoPink", i - 1, 0, -1)
          end
        end
      end)

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },
}
