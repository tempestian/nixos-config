# nixos-config

Kendi laptopumun NixOS yapılandırması. nixos-unstable, flake ve Home Manager kullanıyor. Masaüstü niri, kabuk [Tempest Shell](https://github.com/tempestian/tempest-shell) (`Tempest Capsule` & `macTempest`), işlemci AMD, ekran kartı NVIDIA. Tek makine olduğu için tek host var: `nixos`.

## Klasörler

- `flake.nix`: girdiler ve host tanımı
- `vars.nix`: kullanıcı adı, hostname, saat dilimi, locale, klavye düzeni, git kimliği gibi her yerde geçen değerler
- `hosts/`: bu makineye özel kısım (boot, donanım, hangi seçeneklerin açık olduğu)
- `modules/`: sistem tarafı (`desktop.nix`, `audio.nix`, `nvidia.nix`, `network.nix` gibi)
- `home/`: Home Manager tarafı, niri, tempest-shell, kitty, fish, tema, paketler, MangoHud, Flatpak

## Rebuild

Repo yerelde klonluysa:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Klonlamadan, doğrudan GitHub'dan:

```sh
sudo nixos-rebuild switch --flake github:tempestian/nixos-config/tempest-shell#nixos --refresh
```

## Kendi seçeneklerim

`hosts/default.nix` içinde açıp kapatılıyorlar:

- `my.network.ttlFix.enable`: giden paketlerin TTL değerini sabitler (tethering için), varsayılan 65
- `my.network.zapret.enable`: zapret ile DPI engellerini aşar
- `my.cpu.disableBoost`: CPU boost'u kapatır
- `my.desktop.tempestLoginManager`: Tempest Login Manager (greetd + cage). Kapatılırsa farklı bir DM kullanılabilir.

## Masaüstü & Kısayollar

- Niri ayarı `home/niri.nix` içinde, `niri validate` ile derleme sırasında doğrulanıyor
- Tempest Shell ayarları `home/quickshell.nix` içinde (`programs.tempest-shell`), varsayılan düzen `tempest-capsule`
- `Super+Space`: Uygulama başlatıcı (Spotlight / Deepin App Drawer)
- `Super+Tab`: Mission Control / Multitasking genel bakış
- `Super+V`: Pano geçmişi (Maccy / Deepin Cards)
- `Super+Shift+S` / `Super+Shift+R`: Ekran yakalama ve GPU Screen Recorder merkezi
- `Super+,`: Tempest Shell Ayarlar uygulaması
- `Super+Shift+W`: Tempest Capsule <-> macTempest arasında canlı geçiş
- `Super+Alt+L`: Ekranı kilitle
