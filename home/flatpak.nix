{
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [
      "org.vinegarhq.Sober"
      "net.retrodeck.retrodeck"
      "io.itch.itch"
    ];
  };
}
