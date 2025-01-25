return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "float", -- 终端打开的方向（float、horizontal、vertical）
    open_mapping = [[<c-\>]], -- 打开终端的快捷键
    start_in_insert = true, -- 打开终端时进入插入模式
    close_on_exit = true, -- 退出终端时关闭窗口
    -- 关键配置：设置终端在当前文件的目录中打开
    on_open = function(term)
      vim.cmd("lcd " .. vim.fn.expand("%:p:h"))
    end,
  },
}
