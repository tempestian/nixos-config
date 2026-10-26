# nixos-config

Kendi laptopumun NixOS yapılandırması. `nixos-unstable`, flake ve Home Manager kullanıyor. Masaüstü ortamı **Wayland** üzerinde çalışan **Niri** kompozitörü ve **Tempest Shell** (Quickshell). İşlemci AMD, ekran kartı NVIDIA. Tek makine olduğu için tek host var: `nixos`.

## Masaüstü Mimarisi: Tempest Shell & Niri

GNOME masaüstü ortamı kaldırılarak yerine akıcı, GPU hızlandırmalı ve dinamik çift paradigmaya (**Tempest Capsule** & **macTempest**) sahip **Tempest Shell** entegre edilmiştir.

- **Kompozitör**: [Niri](https://github.com/YaLTeR/niri) (Scrollable-tiling Wayland compositor)
- **Kabuk (Shell)**: [Tempest Shell](https://github.com/tempestian/tempest-shell) (Quickshell tabanlı modern masaüstü arayüzü)
- **Giriş Yöneticisi**: SDDM (Wayland oturumu)
- **Renk & Tema**: Matugen (Material You duvar kağıdı renk motoru)
- **Ekran Kaydı**: GPU Screen Recorder (NVENC sıfır gecikme)

---

## Klasörler

- `flake.nix`: Girdiler (`nixpkgs`, `home-manager`, `tempest-shell`, `eden`, vb.) ve host tanımı
- `vars.nix`: Kullanıcı adı (`bayram`), hostname, saat dilimi, locale, git kimliği
- `hosts/`: Bu makineye özel kısım (boot, donanım, network/CPU seçenekleri)
- `modules/`: Sistem tarafı:
  - `desktop.nix`: SDDM, Niri oturumu, GPU Screen Recorder, GVfs, Dconf ve masaüstü temel uygulamaları
  - `nvidia.nix`: NVIDIA tescilli sürücüleri ve PRIME offload ayarları
  - `network.nix`: DNSCrypt, zapret DPI engeli aşma, TTL ayarları
  - `gaming.nix`: Steam, Gamemode ve oyun optimizasyonları
- `home/`: Home Manager kullanıcı yapılandırması:
  - `niri.nix`: Niri kompozitör pencere kuralları, layout ve kısayol eşlemeleri
  - `tempest-shell.nix`: Tempest Shell etkinleştirme, ön ayarlar ve ayar yönetimi
  - `packages.nix`: Kullanıcı uygulamaları (Firefox, Discord, Telegram, Spotify, Nautilus, vb.)
  - `theme/`: GTK teması, imleç ve renk tercihleri

---

## Klavye Kısayolları (Keybindings)

### ⚡ Tempest Shell Kısayolları
| Kısayol | Eylem |
| :--- | :--- |
| `Mod + Space` | **Uygulama Başlatıcı**: Spotlight veya DDE Akrilik Çekmece |
| `Mod + V` | **Pano Yöneticisi**: Renk önizlemeli Wayland pano geçmişi |
| `Mod + Shift + S` / `Ctrl + Shift + S` | **Ekran Alıntısı & Kayıt Hub'ı**: Bölge, Pencere, Tam Ekran & GPU Video Kaydı |
| `Mod + Tab` | **Mission Control / Çoklu Görev**: Açık pencereler ve çalışma alanları |
| `Mod + Alt + L` | **Kilit Ekranı**: Liquid Glass Sonoma / DDE kilit ekranı |
| `Mod + ,` (Virgül) | **Ayarlar GUI**: Tempest Shell görsel ve davranışsal ayarlar paneli |
| `Mod + Shift + W` | **Düzen Değiştir**: Tempest Capsule ve macTempest arasında anında geçiş |
| `Ctrl + Alt + T` | **Matugen**: Duvar kağıdından otomatik Material You renk paleti üretir |

### 🪟 Uygulama Kısayolları
| Kısayol | Eylem |
| :--- | :--- |
| `Mod + Return` veya `Mod + T` | **Terminal** (Kitty) |
| `Super + E` | **Dosya Yöneticisi** (Nautilus) |
| `Super + W` | **Web Tarayıcısı** (Firefox) |

### 🧭 Pencere ve Gezinme Kısayolları (Niri)
| Kısayol | Eylem |
| :--- | :--- |
| `Mod + Q` | Odaktaki pencereyi kapat |
| `Mod + D` | Sütunu genişlet / daralt (Maximize Column) |
| `Mod + F` | Tam ekran yap (Fullscreen) |
| `Mod + A` | Yüzen pencere modunu aç/kapat (Toggle Floating) |
| `Mod + Shift + Space` | Yüzen ve döşemeli pencereler arasında odağı değiştir |
| `Mod + Sol / Sağ / Yukarı / Aşağı` | Sütunlar ve pencereler arasında gezin (`H/J/K/L` de geçerlidir) |
| `Mod + Shift + Sol / Sağ / Yukarı / Aşağı` | Sütun veya pencereyi taşı |
| `Mod + 1 .. 9` | İlgili çalışma alanına (Workspace) geç |
| `Mod + Shift + 1 .. 9` | Pencereyi ilgili çalışma alanına taşı |
| `Mod + R` | Önceden tanımlı sütun genişliğini değiştir (%33, %50, %66) |
| `Mod + Eksi (-)` / `Mod + Artı (=)` | Sütun genişliğini %10 daralt / genişlet |
| `Print` / `Alt + Print` / `Ctrl + Print` | Tam ekran veya pencere görüntüsü al |
| `Ses Tuşları` | Sesi aç, kıs veya sessize al (`wpctl`) |
| `Parlaklık Tuşları` | Ekran parlaklığını ayarla (`brightnessctl`) |
| `Medya Tuşları` | Şarkıyı oynat / duraklat / sonraki / önceki (`playerctl`) |

---

## Rebuild ve Uygulama

Sistemi güncellemek veya yapılandırmayı uygulamak için:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Sistemi değiştirmeden önce test etmek için derleme:

```sh
nixos-rebuild build --flake .#nixos
```

Doğrudan GitHub üzerindeki `gnome` dalından çekip uygulamak için:

```sh
sudo nixos-rebuild switch --flake github:tempestian/nixos-config/gnome#nixos --refresh
```
