{
  programs.mangohud = {
    enable = true;
    settings = {
      position = "top-center";
      font_size = 24;
      background_alpha = 0.4;
      round_corners = 6;
      no_display = false;
      fps = true;
      cpu_stats = true;
      cpu_temp = true;
      gpu_stats = true;
      gpu_temp = true;
      frametime = false;
      frame_timing = false;
      ram = false;
      vram = false;
      engine_version = false;
      vulkan_driver = false;
      wine = false;
      toggle_hud = "Shift_R+F12";
    };
  };
}
