# Samsung Book NP550XDA - OpenCore Hackintosh EFI

**11th Gen Intel Core i3-1115G4 (Tiger Lake Gen12 Xe-LP GT1)**  
*Optimized for macOS Monterey (12.7.6+), Ventura & Big Sur (with Sonoma/Sequoia/Tahoe support via WhateverXe-Graphics & OCLP)*

---

[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.8-blue.svg?style=for-the-badge&logo=apple)](https://github.com/acidanthera/OpenCorePkg)
[![EFI Version](https://img.shields.io/badge/EFI%20Version-v0.0.7-green.svg?style=for-the-badge)](https://github.com/)
[![macOS Support](https://img.shields.io/badge/macOS-Big%20Sur%20--%20Tahoe-orange.svg?style=for-the-badge&logo=apple)](https://www.apple.com/macos/)
[![Graphics](https://img.shields.io/badge/WhateverXe-v0.8.2%20(Metal%203)-purple.svg?style=for-the-badge&logo=intel)](https://github.com/b00t0x/WhateverXe)
[![Status](https://img.shields.io/badge/Status-Daily%20Driver-brightgreen.svg?style=for-the-badge)](https://github.com/)

---

![macOS Monterey on Samsung Book NP550XDA](https://github.com/user-attachments/assets/16739b43-fcb3-492a-a6c7-4698e2c53817)

---

## 📌 About This Project

This repository provides a production-ready, fully customized **OpenCore 1.0.8 EFI** for running macOS on the **Samsung Book (`NP550XDA` / Motherboard `LH43STAR` / `SECCSD`)** powered by the **11th Gen Intel Core i3-1115G4 (Tiger Lake-U)**.

Historically, Intel 11th Gen Tiger Lake laptops lacked graphics acceleration on macOS because Apple transitioned directly from 10th Gen Ice Lake to Apple Silicon (M1). Thanks to **[WhateverXe](https://github.com/b00t0x/WhateverXe) (`v0.8.2`)** and its companion **[WhateverXe-Graphics](https://github.com/b00t0x/WhateverXe-Graphics)** package (providing `AppleIntelTGLCompat` and signed donor graphics drivers), this EFI achieves **full 3D hardware acceleration (Metal & OpenGL)**, video decoding (HEVC/H.264), native display brightness control, functional FN keys, multi-touch trackpad gestures, and rock-solid audio/network connectivity.

> [!NOTE]
> This EFI adheres strictly to Dortania ACPI standards and OpenCore best practices, incorporating curated SSDTs tailored for Samsung's Embedded Controller (`H_EC`) and omitting redundant ACPI dumps from `config.plist` to keep the namespace clean.

---

## 💻 System Specifications

| Component | Technical Details | Hardware ID / Model |
| :--- | :--- | :--- |
| **Processor (CPU)** | Intel Core i3-1115G4 (2 Cores, 4 Threads, Base 3.00 GHz, Boost up to 4.10 GHz) | Tiger Lake-U (Family 6, Model 140, Stepping 1) |
| **Integrated GPU (iGPU)** | Intel UHD Graphics (Xe-LP Gen12 GT1, 48 Execution Units) | PCI ID `8086:9A78` (Subvendor `144D:C193`) |
| **Internal Panel** | 15.6" HD (`1366 × 768`) / Full HD (`1920 × 1080`) @ 60 Hz *(varies by NP550XDA SKU)* | Embedded DisplayPort (eDP 1.4b) |
| **Chipset** | Intel Tiger Lake-LP PCH-LP | Intel 500 Series Chipset Family |
| **Memory (RAM)** | 12 GB DDR4 3200 MHz (4 GB soldered + 8 GB SODIMM) | Dual-Channel Configuration |
| **Primary Storage** | SATA SSD / NVMe M.2 2280 | SATA 6 Gb/s & PCIe 3.0 x4 |
| **Audio Codec** | Realtek ALC256 (Internal Speakers + 3.5mm Combo Headphone/Mic Jack) | Intel Smart Sound (`8086:A0C8`, `layout-id = 11`) |
| **Ethernet (LAN)** | Realtek RTL8111/8168 PCI Express Gigabit Controller | `10EC:8168` (10/100/1000 Mbps) |
| **Wireless (Wi-Fi)** | Intel Wireless-AC 9462 / Wi-Fi 6 AX201 (CNVi, `BCM4360` spoof for macOS 14+) | `8086:02F0` (`PciRoot(0x0)/Pci(0x14,0x3)`) |
| **Bluetooth** | Intel Wireless Bluetooth Controller | USB Bus VID `8087`, PID `0AAA` |
| **Trackpad** | Samsung Precision Touchpad (I2C HID Multitouch, polling mode) | ACPI `_SB.PC00.I2C0.TPD0` (`force-polling = 1`) |
| **Keyboard** | Integrated Notebook Keyboard (ABNT2 Brazilian Layout) | ACPI `_SB.PC00.LPCB.PS2K` |
| **SD Card Reader** | O2 Micro, Inc. OZ711 SD/MMC Controller | PCIe SDHC Reader (`EmeraldSDHC.kext`) |
| **BIOS Version** | AMI Aptio Setup Utility | Firmware Revision P23CFB |

---

## 📊 Hardware Working Status

The following matrix reflects real-world hardware verification with **OpenCore 1.0.8** and **WhateverXe 0.8.2** (paired with **WhateverXe-Graphics 0.4.4**):

| Feature | Status | Driver / Mechanism | Technical Details |
| :--- | :---: | :--- | :--- |
| **macOS Boot** | ✅ **Working** | OpenCore 1.0.8 | Clean boot with curated ACPI tables, `UsbMouseDxe.efi`, and sanitized ACPI namespace. |
| **Metal & OpenGL Acceleration** | ✅ **Working** | `WhateverXe.kext` (`v0.8.2`) + `WhateverXe-Graphics` | Native 3D GUI acceleration, smooth animations, and WindowServer hardware compositing. |
| **Hardware Video Decode (VDA)** | ✅ **Working** | `AppleIntelTGLGraphicsVADriver` | Hardware-accelerated HEVC and H.264 video decoding (Safari, QuickTime, YouTube). |
| **Display Brightness Slider** | ✅ **Working** | `SSDT-PNLF.aml` (`_UID = 19`, Tiger Lake IDs) | Fluid native brightness slider in Control Center and System Settings/Preferences. |
| **Brightness Keys (Fn + F2 / F3)** | ✅ **Working** | `SSDT-SMSG.aml` (`_Q63`/`_Q64`) + `BrightnessKeys.kext` | Intercepts Samsung EC queries (`_Q63`/`_Q64` -> `_X63`/`_X64`) and notifies `_SB.PC00.GFX0.DD1F`. |
| **Volume & Media Keys (Fn)** | ✅ **Working** | `SSDT-VOLKEYSS.aml` + `VoodooPS2Controller.kext` | PS/2 scancodes & custom ADB map (`e020`, `e02e`, `e030`, `e002`, `e006`, `e008`, `e009`, etc.). |
| **Multi-touch Trackpad** | ✅ **Working** | `VoodooI2C.kext` + `VoodooI2CHID.kext` | Full macOS gestures (pinch-to-zoom, smart zoom, rotate, 3/4-finger desktop swipe) via I2C polling. |
| **Internal Keyboard** | ✅ **Working** | `VoodooPS2Keyboard.kext` (`v2.3.7`) | Instant response, correct ABNT2 accent mapping, and functional dead keys. |
| **Audio & Microphone** | ✅ **Working** | `AppleALC.kext` (`v1.9.8`, `layout-id = 11`) | Stereo internal speakers and 3.5mm combo jack auto-switching. |
| **Intel Wi-Fi** | ✅ **Working** | `AirportItlwm` (Big Sur–Ventura) / OCLP (Sonoma+) | Native Wi-Fi up to Ventura; Sonoma+ uses `IOSkywalkFamily` + `IO80211FamilyLegacy` + OCLP (`BCM4360` spoof). |
| **Intel Bluetooth** | ✅ **Working** | `IntelBluetoothFirmware` (`v2.5.2`) + `IntelBTPatcher` | Stable pairing with AirPods, wireless mice, and BLE peripherals (`BlueToolFixup` for 12–14). |
| **Gigabit Ethernet** | ✅ **Working** | `RealtekRTL8111.kext` (`v3.0.0`) | Wired network stable at 1000BASE-T speed. |
| **Battery Readout & Status** | ✅ **Working** | `SMCBatteryManager` (`v1.3.8`) + `ECEnabler.kext` | Real-time percentage, charging state, cycle count, and remaining time (via native DSDT + ECEnabler). |
| **Low-Battery Safety Shutdown** | ℹ️ **Optional OS Setup** | External `lowbattery-guard` LaunchDaemon *(not in EFI)* | Recommended macOS user-space daemon to trigger clean shutdown at 3%–4% before BMS power cut. |
| **Display Sleep (Screen Off/On)** | ✅ **Working** | `WhateverXe` (`v0.8.2`) | Screen turns off on idle/lid close and wakes cleanly with backlight intact (wake notification fixes in 0.8.1+). |
| **Lid Close Behavior** | ✅ **Protected** | `pmset -a disablesleep 1 sleep 0 lidwake 1` | Closes lid -> display & backlight turn off immediately; avoids broken S3 wake and overheating. |
| **Full System Sleep / S3** | ❌ **Unsupported** | Tiger Lake Architecture Limitation | Donor Apple drivers lack post-S3 Display 12 re-initialization without UEFI GOP on this hardware. |
| **External HDMI Output** | ⚠️ **W.I.P. / Testing** | `WhateverXe` Display Pipeline | Upstream `0.7.x–0.8.2` improved USB-C DP Alt Mode & display power-wells; direct HDMI on `NP550XDA` remains under validation. |

---

## ⚡ Power Management & Lid Behavior

### The Sleep Architecture on Tiger Lake

On Intel 11th Gen platforms running macOS, there is a fundamental distinction between **Display Sleep** and **System Sleep (S3)**:

1. **Display Sleep (Supported & Working):**  
   WhateverXe intercepts DisplayPort/eDP link training (`wrapTGLTrainingPattern`) to synchronize the *Alternate Scrambler Reset* with the Samsung LCD panel. When the screen turns off due to inactivity, touching the trackpad or keyboard wakes the screen immediately with full brightness.
2. **System Sleep / S3 (Unsupported by Design):**  
   During a cold boot, the UEFI GOP (Graphics Output Protocol) initializes the Tiger Lake Display 12 engine (Power Wells, DBUF slices, and FIA multiplexers). Upon waking from S3 Suspend-to-RAM, the UEFI GOP **does not run**. Because Apple's donor drivers (version 16.0.0) lack Tiger Lake Gen12 power state sequencers, waking from S3 causes a black screen or kernel panic.

### 🛡️ Recommended Power Management Setup

To ensure the laptop **only turns off the screen** upon closing the lid (preventing broken S3 sleep and preventing heat buildup), execute this configuration in Terminal:

```bash
sudo pmset -a disablesleep 1 sleep 0 lidwake 1 && sudo pmset -b displaysleep 5 && sudo pmset -c displaysleep 10
```

#### What this configuration does

* **`disablesleep 1`**: Disables full system sleep (S3) globally, bypassing macOS clamshell sleep.
* **`sleep 0`**: Prevents the idle system sleep timer from triggering S3.
* **`lidwake 1`**: Immediately turns the display back on when the lid is reopened.
* **`displaysleep 5 / 10`**: Turns off the display and backlight after 5 minutes on battery (or 10 minutes on AC), saving power without risking system hangs.

Two helper scripts are included in [`Utils/`](./Utils):

* **Apply Safe Lid Mode:** `./Utils/ajustar_sleep_tampa.sh`
* **Restore Default macOS Sleep:** `./Utils/restaurar_sleep_padrao.sh`

> [!IMPORTANT]
> **Transport Advisory:**  
> When packing the notebook into a tightly closed bag or sleeve for an extended period, always perform a **proper shutdown** (` > Shut Down...`). Since closing the lid leaves the CPU idling with the screen off, carrying it in an unventilated bag could generate heat.

---

## 🔋 Low Battery Safety Guard *(Optional macOS Setup)*

Due to firmware idiosyncrasies in the Samsung Book's `_BST` and `SBIX` ACPI methods, the Embedded Controller may not assert the ACPI critical flag to `SMCBatteryManager` at very low capacities. As a consequence, macOS might not trigger an emergency shutdown before the laptop's physical BMS abruptly cuts power around 2%–3% charge.

To prevent filesystem corruption, it is recommended to run a lightweight user-space daemon (`lowbattery-guard` via `launchd`, external to the `/EFI` folder) that:

* Periodically polls battery capacity via `pmset` / `ioreg`.
* Initiates a clean, graceful shutdown when remaining charge drops to **3%–4%** on battery power.

---

## 🎨 WhateverXe Graphics Architecture & Updates (`v0.8.2`)

Intel Xe-LP graphics acceleration relies on two companion open-source projects by **b00t0x**:

1. **[b00t0x/WhateverXe](https://github.com/b00t0x/WhateverXe)** — The OpenCore/Lilu kernel plugin (`EFI/OC/Kexts/WhateverXe.kext`, currently **`v0.8.2`**).
2. **[b00t0x/WhateverXe-Graphics](https://github.com/b00t0x/WhateverXe-Graphics)** — The macOS system installer (`WhateverXe-Graphics.pkg`, verified with **`v0.4.4`**) that installs `AppleIntelTGLCompat.kext` (`v0.8.1`), `AppleIntelTGLGraphics*`, and `XeMetalCompiler.bundle` into `/Library/Extensions` and `/Library/GPUBundles`, rebuilding the Auxiliary Kernel Collection (AuxKC) without modifying the Sealed System Volume (SSV).

> [!WARNING]
>
> * **Keep both components matched:** Upstream requires updating **`WhateverXe.kext`** and **`WhateverXe-Graphics`** together from their official GitHub releases.
> * **Do not mix graphic injectors:** **`WhateverGreen.kext`** and **`DisplayMergeNub.kext`** are disabled in `config.plist` and must **never** run alongside `WhateverXe.kext`.
> * **Use the bundled `AMFIPass.kext` (`v1.4.1` Mod):** Required for loading `WhateverXe-Graphics` payloads under `csr-active-config = 03080000` without disabling AMFI globally (`amfi=0x80`).

### Notable Upstream Evolution (`v0.6.1` -> `v0.8.2`)

* **`v0.6.x` -> `v0.7.0`**: Expanded eDP panel matching for Tiger Lake / Alder Lake / Raptor Lake, broadened USB-C DP Alt Mode support, added experimental MIPI DSI display support, improved compatibility with macOS Sequoia and Tahoe, and introduced `AutoPkg-Assets.pkg` to enable graphics acceleration during the macOS installer / OOBE stage.
* **`v0.8.0`**: Refined display initialization stability, single-channel memory init paths, expanded PCI device ID matching, and resolved USB-C display power-off hangs.
* **`v0.8.1`**: Fixed missing/duplicate display wake notifications across sleep/wake cycles, fixed graphics memory mapping at buffer boundaries, preserved firmware display output when only one graphics component is installed, and added experimental 10-bit MIPI DSI framebuffer support.
* **`v0.8.2`**: Fixed a regression introduced in `v0.8.1` that could leave displays completely black immediately after macOS boot.

---

## 🛠️ ACPI & Kext Architecture

### Curated ACPI Tables (`/EFI/OC/ACPI`)

24 curated tables are active in `EFI/OC/config.plist` (while 29 legacy/raw dumps such as `DSDT.aml`, `SSDT-BAT.aml`, `SSDT-TPD0.aml`, `ssdt_data.aml`, and `ssdt*.aml` are disabled in `config.plist` to keep the namespace clean and avoid `AE_ALREADY_EXISTS` collisions):

* **`SSDT-PNLF.aml`**: Configured with `_UID = 19` and updated with Intel Tiger Lake Xe-LP device IDs (including `0x9A78`) for native backlight PWM control (`0xC8250` / `0xC8254`).
* **`SSDT-SMSG.aml`**: Rewritten to intercept Samsung Embedded Controller queries **`_Q63` and `_Q64`** (via DSDT renames `_Q63 -> _X63` and `_Q64 -> _X64` in `config.plist`) and notify `_SB.PC00.GFX0.DD1F` for brightness hotkeys (`Fn + F2 / F3`).
* **`SSDT-VOLKEYSS.aml`**: Samsung Book scancode mapper for Mute, Volume Down, and Volume Up keys (`Fn + F6 / F7 / F8`).
* **`SSDT-USBX.aml`**: Simplified to inject `USBX` USB power properties without duplicating the `H_EC` device.
* **`SSDT-GPRW.aml`**: Paired with the refined `GPRW(2)` -> `XPRW(2)` ACPI patch to prevent instant wakeups caused by USB controllers.
* **`SSDT-PLUG.aml`**, **`SSDT-EC.aml`**, **`SSDT-RTCAWAC.aml`**, **`SSDT-XOSI.aml`**, **`SSDT-SBUS-MCHC.aml`**, **`SSDT-PMC.aml`**, **`SSDT-ALS0.aml`**, **`DMAR.aml`**: Core Dortania/Tiger Lake platform enablement tables.

### Essential Kexts (`/EFI/OC/Kexts`)

* **Graphics:** `WhateverXe.kext` (`v0.8.2`) + `WhateverXe-Graphics` (`v0.4.4`, providing `AppleIntelTGLCompat.kext` `v0.8.1` in `/Library/Extensions`) *(WhateverGreen, NootedBlue, and DisplayMergeNub are disabled)*.
* **Core & Sensors:** `Lilu.kext` (`v1.7.2`), `VirtualSMC.kext` (`v1.3.8`), `SMCProcessor.kext` (`v1.3.8`), `SMCBatteryManager.kext` (`v1.3.8`), `SMCSuperIO.kext` (`v1.3.2`), `SMCLightSensor.kext` (`v1.3.2`), `ForgedInvariant.kext` (`v1.5.0`).
* **Power & Battery:** `ECEnabler.kext` (`v1.0.6`), `CPUFriend.kext` (`v1.3.0`) + `CPUFriendDataProvider.kext` (`v1.0.1`, tuned to `800 MHz` LFM and EPP `0x20`), `HWPEnabler.kext` (`v1.2`), `HibernationFixup.kext` (`v1.5.4`).
* **AMFI / Root Patch Support:** `AMFIPass.kext` (`v1.4.1` Mod, `MinKernel = 20.0.0`, `MaxKernel = 25.99.99`).
* **Audio:** `AppleALC.kext` (`v1.9.8`, `layout-id = 11` injected via `DeviceProperties`).
* **Input Devices:** `VoodooI2C.kext` (`v2.8`) + `VoodooI2CHID.kext` (`v1.0`) with `force-polling = 1` on `I2C0`, `VoodooPS2Controller.kext` (`v2.3.7` with extended Samsung `Breakless PS2` and `Custom ADB Map` entries), `BrightnessKeys.kext`.
* **Connectivity:** `AirportItlwm` (`BigSur`, `Monterey`, `Ventura` — `Sonoma` disabled), `AirportBrcmFixup.kext` (`v2.2.1`) + `IOSkywalkFamily.kext` + `IO80211FamilyLegacy.kext` (`MinKernel = 23.0.0` for OCLP Sonoma+), `IntelBluetoothFirmware` / `IntelBTPatcher` / `IntelBluetoothInjector` (`v2.5.2`), `BlueToolFixup.kext` (`v2.7.2`), `RealtekRTL8111.kext` (`v3.0.0`).

---

## ⚙️ OpenCore Configuration & Boot Arguments

### Boot Arguments (`boot-args`)

```text
-allow3d -disablegfxfirmware npci=0x2000 keepsyms=1 nvme=-1
```

* **`-allow3d`**: Enables 3D hardware acceleration paths required by `WhateverXe`.
* **`-disablegfxfirmware`**: Prevents loading incompatible Apple GuC/HuC firmware that causes boot panics on mobile Tiger Lake chips.
* **`npci=0x2000`**: Bypasses PCI enumeration freezes with Tiger Lake host bridge routing.
* **`keepsyms=1`**: Preserves debug symbols during crashes for diagnostic logs.
* **`nvme=-1`**: Prevents secondary NVMe initialization conflicts on setups utilizing primary SATA SSDs.

### SIP, SecureBoot & DeviceProperties

* **`csr-active-config`:** `03080000` (`0x803`) with `SecureBootModel = Disabled` (required for `WhateverXe-Graphics` AuxKC loading).
* **`PciRoot(0x0)/Pci(0x2,0x0)`:** Sanitized to standard identification (`AAPL,slot-name`, `device_type`, `hda-gfx`, `model: Intel UHD Graphics`) without Ice Lake/Comet Lake `device-id` or framebuffer spoofs.
* **UEFI Drivers:** OpenCore `1.0.8` drivers (`HideVerbose = false` schema) including `UsbMouseDxe.efi`, `OpenRuntime.efi`, `OpenCanopy.efi`, `OpenLinuxBoot.efi`, `Ext4Dxe.efi`, `btrfs_x64.efi`, `ExFatDxe.efi`, `apfs_aligned.efi`, and `HfsPlus.efi`.

### SMBIOS Profile

* **Model:** `MacBookAir9,1`
* **Rationale:** Best match for Intel 10th/11th Gen ultra-low-power dual-core and quad-core mobile processors without dedicated GPUs.
* *Note: Generate your own unique `SystemSerialNumber`, `SystemUUID`, and `MLB` using **GenSMBIOS** before signing into Apple ID / iCloud services.*

---

## 💿 macOS Version Compatibility

| Version | Status | Notes |
| :--- | :---: | :--- |
| **macOS 12 Monterey** | 🌟 **Recommended & Verified** | Rock-solid daily-driver stability with `WhateverXe 0.8.2` + `WhateverXe-Graphics 0.4.4` (`12.7.6+`). Native `AirportItlwmMonterey.kext`, Bluetooth, and audio. |
| **macOS 13 Ventura** | ✔️ **Supported** | Functional with `AirportItlwmVentura.kext` and `WhateverXe-Graphics` (`13.7.8+`). |
| **macOS 11 Big Sur** | ✔️ **Supported** | Supported with `AirportItlwmBigSur.kext` and `WhateverXe-Graphics` (`11.7.11+`). |
| **macOS 14 Sonoma / 15 Sequoia / 26 Tahoe** | ⚠️ **Experimental / OCLP** | Supported upstream by `WhateverXe 0.8.2` and `WhateverXe-Graphics 0.4.4` (`14.8.9+`, `15.8+`, `26.7+`); requires OpenCore Legacy Patcher (`OCLP`) root patches for Wi-Fi (`BCM4360` spoof + Skywalk/IO80211FamilyLegacy). |

> [!TIP]
> For a detailed Portuguese technical report of every fix and hardware status on this machine, check [`Utils/Docs/STATUS_EFI_SAMSUNG_NP550XDA.md`](./Utils/Docs/STATUS_EFI_SAMSUNG_NP550XDA.md).

---

## 📚 References & Community Credits

Sincere appreciation to the Hackintosh community and open-source projects that made this setup possible:

* **[WhateverXe](https://github.com/b00t0x/WhateverXe)** & **[WhateverXe-Graphics](https://github.com/b00t0x/WhateverXe-Graphics)** by **b00t0x** & contributors for the Tiger Lake / Xe-LP Gen12 graphics stack (download matching `WhateverXe` + `WhateverXe-Graphics` `.pkg` releases directly from GitHub).
* **[OpenCore Legacy Patcher (OCLP)](https://github.com/dortania/OpenCore-Legacy-Patcher)** by Dortania for Sonoma+ Wi-Fi/legacy root-patching support.
* **[Acidanthera](https://github.com/acidanthera)** for OpenCorePkg (`1.0.8`), Lilu, VirtualSMC, AppleALC, VoodooPS2, and BrcmPatchRAM.
* **[OpenIntelWireless](https://github.com/OpenIntelWireless)** for `AirportItlwm` and `IntelBluetoothFirmware`.
* **[VoodooI2C Team](https://github.com/VoodooI2C/VoodooI2C)** for the multi-touch I2C engine.
* **[Gabriel Luchina](https://github.com/luchina-gabriel)** for the foundational Samsung Book base EFI.
* **[Dortania Guides](https://dortania.github.io/OpenCore-Install-Guide/)** for the definitive OpenCore installation documentation.
* **Community Research & Discussions:**
  * [InsanelyMac Tiger Lake Iris Xe Discussion Thread](https://www.insanelymac.com/forum/topic/358305-iris-xe-igpu-on-tiger-lake/)
  * [Samsung NT750XDA Research by lshbluesky](https://github.com/lshbluesky/Samsung-NT750XDA-KF59U-Hackintosh)

---

## 💬 Community & Support

Contributions, issue reports, and diagnostic dumps are always welcome! Feel free to:

* Submit Pull Requests with ACPI or stability optimizations.
* Open an Issue with diagnostic `pmset`, `ioreg`, or OpenCore logs.
* Share your test findings with external display configurations.

[![Discord](https://img.shields.io/badge/Discord--%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.universohackintosh.com.br/)
[![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://www.youtube.com/@UniversoHackintosh)
[![Gmail](https://img.shields.io/badge/Gmail-hackinthc@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:hackinthc@gmail.com)
