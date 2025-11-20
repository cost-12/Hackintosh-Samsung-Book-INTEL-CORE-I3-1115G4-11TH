# Hackintosh-Samsung-Book-INTEL-CORE-I3-1115G4-11TH
BASE EFI GABRIEL LUCHINA
Opencore version: 1.0.6
Release date: 20/11/2025

![Captura de Tela 2024-05-03 às 22 27 36](https://github.com/cost-12/Hackintosh-Samsung-Book-INTEL-CORE-I3-1115G4-11TH/assets/124941175/a9a25b24-b0f2-4273-ac02-963d56e7c684)
_________________________________________________
📌 About This Project

This repository provides a base EFI for running macOS on the Samsung Book (11th Gen Intel Tiger Lake) laptop using OpenCore.
This project is aimed at beginners and intermediate Hackintosh users who want a clean starting point, following Dortania standards.

⚠️ Important:
This EFI is a work in progress. Certain components—especially the Intel UHD G4 iGPU—are not fully functional on macOS due to lack of official drivers. Expect limitations.

For support, questions or contributions:
📧 hackinthc@gmail.com
_________________________________________________
## System Specifications

| Component             | Details                                                           |
| --------------------- | ----------------------------------------------------------------- |
| **CPU**               | Intel 11th Gen Tiger Lake i3-1115G4 (up to 4.1 GHz)               |
| **Chipset**           | Intel Tiger Lake-LP                                               |
| **iGPU**              | Intel UHD Graphics G4 (Iris Xe architecture, partially supported) |
| **Memory**            | 12 GB DDR4 3200 MHz                                               |
| **Audio**             | Realtek ALC897                                                    |
| **Wi-Fi / Bluetooth** | Intel Wi-Fi 6 AX201 / 9462                                        |
| **Touchpad**          | Samsung I2C Precision TouchPad (ATML3000 / ELAN0B00)              |
| **BIOS**              | AMI Aptio Setup Utility (Version P21CFB)                          |

_______________________________________________
## Current Working Status

| Feature             | Status                                       |
| ------------------- | -------------------------------------------- |
| Booting macOS       | ✔️ Stable                                    |
| Keyboard / Trackpad | ✔️ I2C supported with VoodooI2C              |
| Audio (ALC897)      | ✔️ Functional                                |
| USB                 | ✔️ Mapped / Stable                           |
| Wi-Fi / Bluetooth   | ✔️ Via AirportItlwm / IntelBluetoothFirmware |
| Power Management    | ✔️ CPU PM with SSDT-PLUG & SMCBatteryManager |
| Sleep / Wake        | ✔️ Partial (improving)                       |
| Battery Readout     | ✔️ Working                                   |
| HDMI Output         | ✔️ Working (limited)                         |

________________________________________________
❌ Known Issues / Not Working
🔸 Intel UHD G4 / Iris Xe — GPU Acceleration

Currently QE/CI hardware acceleration is unavailable because Apple never released Kexts for Gen12 Xe architecture.

Consequences:

Laggy animations

Poor performance in Mission Control

No HEVC/H.264 hardware encoding

Reduced battery life

Community work is ongoing to develop experimental drivers.

Discussion Thread:
https://www.insanelymac.com/forum/topic/358305-iris-xe-igpu-on-tiger-lake/
_______________________________________________

🛠️ Installation Notes

| Version        | Status                                        |
| -------------- | --------------------------------------------- |
| macOS Ventura  | ✔️ Recommended                                |
| macOS Sonoma   | ⚠️ Works but heavier without GPU acceleration |
| macOS Sequoia  | ⚠️ Bootable, but performance issues           |


- SMBIOS Used:

MacBookAir9,1 (stable on iGPU-only laptops)

- Required Tools:

GenSMBIOS
ProperTree
USB mapping tool (included)
_______________________________________________
📚 References & Credits
- https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html
- https://dortania.github.io/Getting-Started-With-ACPI/
- https://github.com/luchina-gabriel/BASE-EFI-INTEL-DESKTOP-11THGEN-ROCKET-LAKE
- https://olarila.com/
- https://github.com/lshbluesky/Samsung-NT750XDA-KF59U-Hackintosh
- https://github.com/joevt/WhateverGreen
_______________________________________________
💬 Community & Support

Feel free to:

- Submit PRs
- Report issues
- Share DSDTs, patches or new findings
- Any help is appreciated!

# Discord

https://discord.universohackintosh.com.br/

# Recommended YouTube Channel

https://www.youtube.com/@UniversoHackintosh
