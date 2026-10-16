# nixos-config

Kendi laptopumun NixOS yapılandırması. nixos-unstable, flake ve Home Manager kullanıyor. Masaüstü GNOME (Yaru temalı), işlemci AMD, ekran kartı NVIDIA. Tek makine olduğu için tek host var: `nixos`.

## Klasörler

- `flake.nix`: girdiler ve host tanımı
- `vars.nix`: kullanıcı adı, hostname, saat dilimi, locale, git kimliği gibi her yerde geçen değerler
- `hosts/`: bu makineye özel kısım (boot, donanım, hangi seçeneklerin açık olduğu)
- `modules/`: sistem tarafı, her dosya tek bir iş yapıyor (`nvidia.nix`, `network.nix`, `gaming.nix` gibi)
- `home/`: Home Manager tarafı, kullanıcı paketleri, GNOME ayarları, tema, MangoHud, Flatpak

## Rebuild

Repo yerelde klonluysa:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Klonlamadan, doğrudan GitHub'dan:

```sh
sudo nixos-rebuild switch --flake github:tempestian/nixos-config/gnome#nixos --refresh
```

Değişiklik denemeden önce `switch` yerine `build` yazmak yeterli, sistemi değiştirmeden derler.

## Kendi seçeneklerim

`hosts/default.nix` içinde açıp kapatılıyorlar:

- `my.network.ttlFix.enable`: giden paketlerin TTL değerini sabitler (tethering için), değer `my.network.ttlFix.ttl` ile ayarlanır, varsayılan 65
- `my.network.zapret.enable`: zapret ile DPI engellerini aşar
- `my.cpu.disableBoost`: CPU boost'u kapatır

## Tema rengi

GNOME'un vurgu rengi `home/theme/accent` dosyasındaki tek kelimeden geliyor: `blue`, `purple`, `sage`, `red` ya da `orange`. Kelimeyi değiştirip rebuild etmek yeterli. Yanlış bir şey yazarsan rebuild hangi değerlerin geçerli olduğunu söyleyerek hata verir.

## Başka bir makineye kurarken

`hosts/hardware-configuration.nix` bu laptopa ait. Yeni makinede kendi donanım dosyanı üretip üzerine yazman gerekiyor:

```sh
nixos-generate-config --show-hardware-config > hosts/hardware-configuration.nix
```

Kullanıcı adı ve hostname'i `vars.nix` içinden değiştirebilirsin.

## Branch'ler

`gnome` güncel olan, varsayılan branch. `test-inir` eskiden denediğim iNiR/Niri kurulumu, artık bu düzende değil.
