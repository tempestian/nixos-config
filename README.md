# nixos-config

Kendi laptopumun NixOS yapılandırması. nixos-unstable, flake ve Home Manager kullanıyor. Masaüstü niri, kabuk (bar, başlatıcı, denetim merkezi, bildirimler, kilit ekranı) [qs-niri](https://github.com/dpentx/qs-niri) (`oneui8-adapt` branch'i), işlemci AMD, ekran kartı NVIDIA. Tek makine olduğu için tek host var: `nixos`.

## Klasörler

- `flake.nix`: girdiler ve host tanımı
- `vars.nix`: kullanıcı adı, hostname, saat dilimi, locale, klavye düzeni, git kimliği gibi her yerde geçen değerler
- `hosts/`: bu makineye özel kısım (boot, donanım, hangi seçeneklerin açık olduğu)
- `modules/`: sistem tarafı, her dosya tek bir iş yapıyor (`desktop.nix`, `audio.nix`, `nvidia.nix`, `network.nix` gibi)
- `home/`: Home Manager tarafı, niri, qs-niri, kitty, fish, tema, paketler, MangoHud, Flatpak

## Rebuild

Repo yerelde klonluysa:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Klonlamadan, doğrudan GitHub'dan:

```sh
sudo nixos-rebuild switch --flake github:tempestian/nixos-config/gnome#nixos --refresh
```

Değişiklik denemeden önce `switch` yerine `build` yazmak yeterli, sistemi değiştirmeden derler. Bir şey bozulursa açılışta önceki nesli seçmek ya da `sudo nixos-rebuild switch --rollback` yeterli.

## Kendi seçeneklerim

`hosts/default.nix` içinde açıp kapatılıyorlar:

- `my.network.ttlFix.enable`: giden paketlerin TTL değerini sabitler (tethering için), değer `my.network.ttlFix.ttl` ile ayarlanır, varsayılan 65
- `my.network.zapret.enable`: zapret ile DPI engellerini aşar
- `my.cpu.disableBoost`: CPU boost'u kapatır
- `my.desktop.oneUiGreeter`: qs-niri'nin One UI giriş ekranı. Kapatınca tuigreet gelir. Giriş ekranı gerçek donanımda test edilmemiş, açılışta sorun olursa `false` yapıp rebuild et (Ctrl+Alt+F3 ile TTY'den girilebilir)

## Masaüstü

- niri ayarı `home/niri.nix` içinde, `niri validate` ile derleme sırasında doğrulanıyor
- qs-niri ayarları `home/quickshell.nix` içinde (`programs.qs-niri`), profil `bloated`
- Terminal kitty (`Super+Enter`), kabuk fish, dosya yöneticisi qs-niri'nin kendi yöneticisi (`Super+E`)
- Kısayollar: `Super+D` başlatıcı, `Super+A` denetim merkezi, `Super+N` bildirimler, `Super+V` pano geçmişi, `Super+Alt+L` kilit, `Super+Shift+/` tüm kısayol listesi

## Tema

Renkler duvar kağıdından matugen ile üretiliyor. Kabukta duvar kağıdı değişince kitty, GTK 3/4, Qt (qt5ct/qt6ct), btop ve fish renkleri de aynı anda güncelleniyor (şablonlar `home/theme/matugen.nix` içinde). İlk açılışta `home/theme/accent` rengiyle üretilen varsayılan bir duvar kağıdı kullanılıyor ve tema ondan çıkarılıyor.

`home/theme/accent` dosyasındaki tek kelime varsayılan duvar kağıdının ve niri odak halkasının rengini belirler: `blue`, `purple`, `sage`, `red` ya da `orange`. Yanlış bir şey yazarsan rebuild hangi değerlerin geçerli olduğunu söyleyerek hata verir.

## Başka bir makineye kurarken

`hosts/hardware-configuration.nix` bu laptopa ait. Yeni makinede kendi donanım dosyanı üretip üzerine yazman gerekiyor:

```sh
nixos-generate-config --show-hardware-config > hosts/hardware-configuration.nix
```

Kullanıcı adı, hostname ve klavye düzenini `vars.nix` içinden değiştirebilirsin.

## Branch'ler

`gnome` güncel olan, varsayılan branch (adı eskiden kaldı, içinde artık GNOME yok). `test-inir` eskiden denediğim iNiR/Niri kurulumu, artık bu düzende değil.
