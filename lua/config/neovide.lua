-- ~/.config/nvim/lua/config/neovide.lua

-- 检查是否在 Neovide 中运行
if vim.g.neovide then
  -- 设置缩放比例
  vim.g.neovide_scale_factor = 1.0 -- 默认缩放比例

  -- 启用光标特效
  vim.g.neovide_cursor_vfx_mode = "pixiedust" -- 光标特效模式
  vim.g.neovide_cursor_vfx_opacity = 400.0 -- 特效透明度
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2 -- 粒子生命周期
  vim.g.neovide_cursor_vfx_particle_density = 10.0 -- 粒子密度
  -- 设置粒子速度
  vim.g.neovide_cursor_vfx_particle_speed = 10.0 -- 默认值为 10.0

  -- 控制粒子形状的弯曲程度
  vim.g.neovide_cursor_vfx_particle_curl = 1.0
  -- vim.g.neovide_transparency = 0.8 -- 窗口透明度
  vim.g.neovide_refresh_rate = 120 -- 设置刷新率为 120Hz
  vim.g.neovide_refresh_rate_idle = 5

  -- 设置内边距
  vim.g.neovide_padding_top = 2
  vim.g.neovide_padding_bottom = 4
  vim.g.neovide_padding_left = 4
  vim.g.neovide_padding_right = 4

  -- 设置文本伽马值和对比度
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.1

  -- 设置行间距
  vim.opt.linespace = 2

  --光标动画长度
  vim.g.neovide_position_animation_length = 0.11
  --光标拖尾
  vim.g.neovide_cursor_animation_length = 0.05
  --光标轨迹
  vim.g.neovide_cursor_trail_size = 0.7
  --全屏
  vim.g.neovide_fullscreen = true

  --抗锯齿
  vim.g.neovide_cursor_antialiasing = true

  --记住以前窗口的大小
  vim.g.neovide_remember_window_size = true
end
