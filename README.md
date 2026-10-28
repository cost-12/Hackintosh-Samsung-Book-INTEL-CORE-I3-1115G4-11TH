# Samsung Book NP550XDA - OpenCore Hackintosh EFI
**11th Gen Intel Core i3-1115G4 (Tiger Lake Gen12 Xe-LP GT1)**  
*Optimized for macOS Monterey (12.7.6+), Ventura & Big Sur with WhateverXe Graphics Acceleration*

---

[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.8-blue.svg?style=for-the-badge&logo=apple)](https://github.com/acidanthera/OpenCorePkg)
[![EFI Version](https://img.shields.io/badge/EFI%20Version-v0.0.7-green.svg?style=for-the-badge)](https://github.com/)
[![macOS Support](https://img.shields.io/badge/macOS-Monterey%20%7C%20Ventura%20%7C%20Big%20Sur-orange.svg?style=for-the-badge&logo=apple)](https://www.apple.com/macos/)
[![Graphics](https://img.shields.io/badge/Graphics-Intel%20Xe--LP%20(Metal%203)-purple.svg?style=for-the-badge&logo=intel)](https://github.com/b00t0x/WhateverXe)
[![Status](https://img.shields.io/badge/Status-Daily%20Driver-brightgreen.svg?style=for-the-badge)](https://github.com/)

---

<div align="center">
  <img width="1600" height="900" alt="macOS Monterey on Samsung Book NP550XDA" src="https://github.com/user-attachments/assets/16739b43-fcb3-492a-a6c7-4698e2c53817" />
</div>

---

## 📌 About This Project

This repository provides a production-ready, fully customized **OpenCore EFI** for running macOS on the **Samsung Book (`NP550XDA` / Motherboard `LH43STAR` / `SECCSD`)** powered by the **11th Gen Intel Core i3-1115G4 (Tiger Lake-U)**.

Historically, Intel 11th Gen Tiger Lake laptops lacked graphics acceleration on macOS because Apple transitioned directly from 10th Gen Ice Lake to Apple Silicon (M1). Thanks to **WhateverXe 0.6.1** and the `AppleIntelTGLCompat` donor graphics driver, this EFI achieves **full 3D hardware acceleration (Metal 3 & OpenGL)**, video decoding (HEVC/H.264), native display brightness control, functional FN keys, multi-touch trackpad gestures, and rock-solid audio/network connectivity.

> [!NOTE]
> This EFI is built adhering strictly to the Dortania ACPI standards and OpenCore best practices, incorporating tailored SSDTs specifically patched for Samsung's Embedded Controller (`H_EC`).

---

## 💻 System Specifications

| Component | Technical Details | Hardware ID / Model |
| :--- | :--- | :--- |
| **Processor (CPU)** | Intel Core i3-1115G4 (2 Cores, 4 Threads, Base 3.00 GHz, Boost up to 4.10 GHz) | Tiger Lake-U (Family 6, Model 140, Stepping 1) |
| **Integrated GPU (iGPU)** | Intel UHD Graphics (Xe-LP Gen12 GT1, 48 Execution Units) | PCI ID `8086:9A78` (Subvendor `144D:C193`) |
| **Internal Panel** | 15.6" HD Widescreen Display (1920 × 1080 @ 60 Hz) | Embedded DisplayPort (eDP 1.4b) |
| **Chipset** | Intel Tiger Lake-LP PCH-LP | Intel 500 Series Chipset Family |
| **Memory (RAM)** | 12 GB DDR4 3200 MHz (4 GB soldered + 8 GB SODIMM) | Dual-Channel Configuration |
| **Primary Storage** | 256 GB SATA SSD / NVMe M.2 2280 | SATA 6 Gb/s & PCIe 3.0 x4 |
| **Audio Codec** | Realtek ALC256 / ALC897 (Internal Speakers + Combo Headphone/Mic Jack) | Intel Smart Sound Technology (`8086:A0C8`) |
| **Ethernet (LAN)** | Realtek RTL8111/8168 PCI Express Gigabit Controller | `10EC:8168` (10/100/1000 Mbps) |
| **Wireless (Wi-Fi)** | Intel Wireless-AC 9462 / Wi-Fi 6 AX201 (M.2 CNVi / PCIe) | `8086:02F0` (Dual Band 2.4 / 5 GHz) |
| **Bluetooth** | Intel Wireless Bluetooth Controller | USB Bus VID `8087`, PID `0AAA` |
| **Trackpad** | Samsung Precision Touchpad (I2C HID Multitouch) | ACPI `_SB.PC00.I2C0.TPD0` (ELAN0B00 / ATML3000) |
| **Keyboard** | Integrated Notebook Keyboard (ABNT2 Brazilian Layout) | ACPI `_SB.PC00.LPCB.PS2K` |
| **SD Card Reader** | O2 Micro, Inc. OZ711 SD/MMC Controller | PCIe SDHC Reader |
| **BIOS Version** | AMI Aptio Setup Utility | Firmware Revision P23CFB |

---

## 📊 Hardware Working Status

The following matrix reflects real-world hardware verification with OpenCore and WhateverXe 0.6.1:

| Feature | Status | Driver / Mechanism | Technical Details |
| :--- | :---: | :--- | :--- |
| **macOS Boot** | ✅ **Working** | OpenCore 1.0.8 | Clean boot with tailored ACPI tables and sanitized ACPI namespace. |
| **Metal 3 Acceleration** | ✅ **Working** | `WhateverXe.kext` + `AppleIntelTGLCompat` | Native 3D GUI acceleration, smooth animations, WindowServer hardware compositing. |
| **Hardware Video Decode (VDA)** | ✅ **Working** | AppleIntelTGLGraphics VDA Decoder | Full hardware-accelerated HEVC and H.264 video decoding (Safari, QuickTime, YouTube). |
| **Display Brightness Slider** | ✅ **Working** | `SSDT-PNLF.aml` (`_UID = 19`) | Fluid native brightness control in Control Center and System Preferences. |
| **Brightness Keys (Fn + F2 / F3)** | ✅ **Working** | `SSDT-SMSG.aml` + `BrightnessKeys.kext` | Intercepts Samsung Embedded Controller (`H_EC`) events (`_Qxx`) and dispatches native HID notifications. |
| **Volume Keys (Fn + F6 / F7 / F8)** | ✅ **Working** | `SSDT-VOLKEYSS.aml` + `VoodooPS2Controller` | PS/2 scancode translation (Mute: `0x20`, Vol-: `0x2E`, Vol+: `0x30`). |
| **Multi-touch Trackpad** | ✅ **Working** | `VoodooI2C.kext` + `VoodooI2CHID.kext` | Full macOS gesture support (pinch-to-zoom, smart zoom, rotate, 3/4-finger desktop swipe). |
| **Internal Keyboard** | ✅ **Working** | `VoodooPS2Keyboard.kext` | Instant response, correct ABNT2 accent mapping and functional dead keys. |
| **Audio & Microphone** | ✅ **Working** | `AppleALC.kext` (Layout-ID 11 / 7) | Crisp sound via internal stereo speakers and 3.5mm combo jack auto-switching. |
| **Intel Wi-Fi** | ✅ **Working** | `AirportItlwm.kext` (Monterey/Ventura) | Native menu bar Wi-Fi control, connection to 2.4 GHz and 5 GHz WPA2/WPA3 networks. |
| **Intel Bluetooth** | ✅ **Working** | `IntelBluetoothFirmware` + `BlueToolFixup` | Stable pairing with AirPods, wireless mice, game controllers, and audio peripherals. |
| **Gigabit Ethernet** | ✅ **Working** | `RealtekRTL8111.kext` | Wired network stable at full 1000BASE-T speed. |
| **Battery Readout & Status** | ✅ **Working** | `SMCBatteryManager` + `ECEnabler.kext` | Real-time percentage, charging state, cycle count, and remaining discharge time. |
| **Low-Battery Safety Shutdown** | ✅ **Protected** | `lowbattery-guard` daemon | Graceful automatic shutdown at 3%–4% charge, preventing abrupt hardware BMS power cuts. |
| **Display Sleep (Screen Off/On)** | ✅ **Working** | WhateverXe (Alternate Scrambler Reset Hook) | Screen turns off on idle and wakes up instantly with backlight intact upon key/trackpad press. |
| **Lid Close Behavior** | ✅ **Protected** | `pmset -a disablesleep 1 sleep 0 lidwake 1` | Closes lid -> screen & backlight shut off instantly; system does not freeze or overheat. |
| **Full System Sleep / S3** | ❌ **Unsupported** | Tiger Lake Architecture Limitation | Donor Apple drivers lack post-S3 Display 12 re-initialization without UEFI GOP. |
| **External HDMI Output** | ⚠️ **W.I.P.** | WhateverXe TCSS/FIA Multiplexing | Hardware detects connection; HDMI link synchronization in Tiger Lake is under upstream development. |

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

#### What this configuration does:
* **`disablesleep 1`**: Disables full system sleep (S3) globally, bypassing macOS clamshell sleep.
* **`sleep 0`**: Prevents the idle system sleep timer from triggering S3.
* **`lidwake 1`**: Immediately turns the display back on when the lid is reopened.
* **`displaysleep 5 / 10`**: Turns off the display and backlight after 5 minutes on battery (or 10 minutes on AC), saving power without risking system hangs.

Two convenient helper scripts are included in `Utils`:
* **Apply Safe Lid Mode:** `~/Desktop/Utils/ajustar_sleep_tampa.sh`
* **Restore Default macOS Sleep:** `~/Desktop/Utils/restaurar_sleep_padrao.sh`

> [!IMPORTANT]
> **Transport Advisory:**  
> When packing the notebook into a tightly closed bag or sleeve for an extended period, always perform a **proper shutdown** (` > Shut Down...`). Since closing the lid leaves the CPU idling with the screen off, carrying it in an unventilated bag could generate heat.

---

## 🔋 Low Battery Safety Guard

Due to firmware idiosyncrasies in the Samsung Book's `_BST` and `SBIX` ACPI methods, the Embedded Controller does not assert the ACPI critical flag to `SMCBatteryManager` at low capacities. As a consequence, macOS might not trigger the emergency sleep warning before the laptop's physical BMS abruptly cuts power around 2% charge.

To prevent filesystem corruption, this EFI utilizes the lightweight **`lowbattery-guard`** daemon:
* Continuously checks battery capacity via `pmset` / `ioreg`.
* When the remaining charge drops to **3%–4%** on battery power, it initiates a clean, graceful system shutdown (`launchd` shutdown sequence, cleanly unmounting APFS volumes and flushing disk buffers).

---

## 🛠️ ACPI & Kext Architecture

### Tailored ACPI Tables (`/EFI/OC/ACPI`)
* **`SSDT-PNLF.aml`**: Configured with `_UID = 19` for Intel Gen11/Gen12 backlight PWM registers (`0xC8250` / `0xC8254`).
* **`SSDT-VOLKEYSS.aml`**: Samsung Book proprietary scancode mapper for Mute, Volume Down, and Volume Up keys.
* **`SSDT-SMSG.aml`**: Intercepts Embedded Controller query methods (`_Qxx`) for Samsung brightness hotkeys.
* **`SSDT-TPD0.aml`**: Configures GPIO pin interrupts and I2C bus properties for the precision touchpad.
* **`SSDT-GPRW.aml`**: Patches `GPRW` (`0x6D` and `0x0D`) to prevent instant wakeups caused by connected USB devices.
* **`SSDT-PLUG.aml`**: Injects `PluginType = 1` for Intel CPU Power Management (`X86PlatformPlugin`).
* **`SSDT-RTCAWAC.aml`**: Resolves RTC / AWAC timer conflicts with the ACPI 6.2 spec.

### Essential Kexts (`/EFI/OC/Kexts`)
* **Graphics:** `WhateverXe.kext` (v0.6.1) + `AppleIntelTGLCompat.kext` *(WhateverGreen and NootedBlue are disabled)*.
* **Core:** `Lilu.kext` + `VirtualSMC.kext` + `SMCProcessor.kext` + `SMCBatteryManager.kext`.
* **Hardware Interfacing:** `ECEnabler.kext` (allows reading multi-byte EC fields seamlessly).
* **Audio:** `AppleALC.kext` (Realtek ALC256 / ALC897 support).
* **Input Devices:** `VoodooI2C.kext` + `VoodooI2CHID.kext` + `VoodooPS2Controller.kext` + `BrightnessKeys.kext`.
* **Connectivity:** `AirportItlwm.kext` + `IntelBluetoothFirmware.kext` + `BlueToolFixup.kext` + `IntelBTPatcher.kext` + `RealtekRTL8111.kext`.

---

## ⚙️ OpenCore Configuration & Boot Arguments

### Boot Arguments (`boot-args`)
```text
-allow3d -disablegfxfirmware npci=0x2000 keepsyms=1 nvme=-1
```
* **`-allow3d`**: Enables coordinated software/hardware 3D acceleration paths for WhateverXe.
* **`-disablegfxfirmware`**: Prevents loading incompatible Apple proprietary GuC/HuC microcode that causes boot panics on mobile Tiger Lake chips.
* **`npci=0x2000`**: Bypasses PCI enumeration freezes with Tiger Lake host bridge routing.
* **`keepsyms=1`**: Preserves debug symbols during crashes for accurate diagnostic logs.
* **`nvme=-1`**: Prevents secondary NVMe initialization conflicts on setups utilizing primary SATA SSDs.

### SMBIOS Profile
* **Model:** `MacBookAir9,1`
* **Rationale:** Best match for Intel 10th/11th Gen ultra-low-power dual-core and quad-core mobile processors without dedicated GPUs.
* *Note: Generate your own unique `SystemSerialNumber`, `SystemUUID`, and `MLB` using **GenSMBIOS** before signing into Apple ID / iCloud services.*

---

## 💿 macOS Version Compatibility

| Version | Status | Notes |
| :--- | :---: | :--- |
| **macOS 12 Monterey** | 🌟 **Recommended & Verified** | Rock-solid stability with WhateverXe 0.6.1. Full Metal 3 acceleration, native Wi-Fi/Bluetooth and audio. |
| **macOS 13 Ventura** | ✔️ **Supported** | Functional with updated `AirportItlwmVentura.kext`. |
| **macOS 11 Big Sur** | ✔️ **Supported** | Works smoothly with `AirportItlwmBigSur.kext`. |
| **macOS 14 Sonoma / 15 Sequoia** | ⚠️ **Experimental** | Requires OpenCore Legacy Patcher (OCLP) root patches for Broadcom/Intel Wi-Fi and Skywalk networking subsystems. Direct fresh installs may face setup wizard hiccups. |

---

## 📚 References & Community Credits

Sincere appreciation to the Hackintosh community and open-source projects that made this setup possible:

* **[WhateverXe Project](https://github.com/b00t0x/WhateverXe)** by **b00t0x** & contributors for the revolutionary Tiger Lake Gen12 graphics stack.
* **[Acidanthera](https://github.com/acidanthera)** for OpenCorePkg, Lilu, VirtualSMC, AppleALC, VoodooPS2, and BrcmPatchRAM.
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

<div align="center">
  <br />
  <a href="https://discord.universohackintosh.com.br/"><img src="https://img.shields.io/badge/Discord--%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white" alt="Discord" /></a>
  <a href="https://www.youtube.com/@UniversoHackintosh"><img src="https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white" alt="YouTube" /></a>
  <a href="mailto:hackinthc@gmail.com"><img src="https://img.shields.io/badge/Gmail-hackinthc@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Gmail" /></a>
</div>

