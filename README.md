# nixos-config

Kendi laptopumun NixOS yapılandırması. `nixos-unstable`, flake ve Home Manager kullanıyor. Masaüstü Niri pencere yöneticisi, kabuk (bar, başlatıcı, denetim merkezi, bildirimler, kilit ekranı, OSD ve widget'lar) [iNiR](https://github.com/tempestian/iNiR) (`fix-nix-support` dalı), işlemci AMD, ekran kartı NVIDIA. Tek makine olduğu için tek host var: `nixos`.

## Klasör Yapısı

- `flake.nix`: Girdiler ve host tanımı
- `vars.nix`: Kullanıcı adı, hostname, saat dilimi, locale, klavye düzeni ve git kimliği gibi genel değişkenler
- `hosts/`: Makineye özel boot, donanım yapılandırması ve aktif servis seçenekleri
- `modules/`: Sistem düzeyindeki modüller (`desktop.nix`, `audio.nix`, `nvidia.nix`, `network.nix`, `gaming.nix`, `renpy.nix` vb.)
- `home/`: Home Manager yapılandırmaları (Niri, iNiR, Kitty, Fish, temalandırma, Flatpak, MangoHud, paketler)

## Rebuild

Repo yerelde klonluysa:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Klonlamadan, doğrudan GitHub üzerinden:

```sh
sudo nixos-rebuild switch --flake github:tempestian/nixos-config#nixos --refresh
```

Değişiklik denemeden önce `switch` yerine `build` yazmak yeterlidir, sistemi değiştirmeden derlemeyi test eder. Bir sorun olursa açılışta GRUB/systemd-boot menüsünden önceki nesil seçilebilir veya `sudo nixos-rebuild switch --rollback` çalıştırılabilir.

## Özel Seçenekler

`hosts/default.nix` içinden açılıp kapatılabilir:

- `my.network.ttlFix.enable`: Giden paketlerin TTL değerini sabitler (tethering için), değer `my.network.ttlFix.ttl` ile ayarlanır, varsayılan 65
- `my.network.zapret.enable`: zapret ile DPI engellerini aşar
- `my.cpu.disableBoost`: CPU boost'u kapatır (ısı ve pil tasarrufu için)

## Masaüstü ve Kabuk

- Niri pencere yöneticisi yapılandırması `home/niri.nix` içinde tanımlıdır.
- iNiR kabuk ayarları `home/quickshell.nix` içinde (`programs.inir`) yer alır.
- Terminal Kitty (`Super+Enter`), kabuk Fish.
- Temel kısayollar: `Super+D` uygulama başlatıcı, `Super+A` kontrol merkezi, `Super+N` bildirimler, `Super+V` pano geçmişi, `Super+Alt+L` kilit ekranı, `Super+G` masaüstü araçları/kaydedici overlay'i.

## Tema

Renkler duvar kâğıdından Matugen ile dinamik üretilir. Duvar kâğıdı değiştiğinde Kitty, GTK 3/4, Qt (qt5ct/qt6ct), btop ve Fish renkleri otomatik senkronize edilir. İlk kurulumda `home/theme/accent` dosyasındaki renk tonu (`blue`, `purple`, `sage`, `red`, `orange`) baz alınır.

## Başka Bir Makineye Kurulum

`hosts/hardware-configuration.nix` bu laptop donanımına aittir. Yeni makinede kendi donanım dosyanızı üretip üzerine yazmanız gerekir:

```sh
nixos-generate-config --show-hardware-config > hosts/hardware-configuration.nix
```

Kullanıcı adı, hostname ve klavye düzenini `vars.nix` içerisinden değiştirebilirsiniz.

## Dallar (Branches)

- `main`: Güncel, varsayılan ana dal. Niri + iNiR masaüstü ortamını içerir.
