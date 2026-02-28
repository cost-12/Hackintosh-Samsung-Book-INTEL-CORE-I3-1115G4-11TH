# Hackintosh-Samsung-Book-INTEL-CORE-I3-1115G4-11TH
BASE EFI GABRIEL LUCHINA
- Opencore version: 1.0.6
    - Release date Opencore: 03/11/2025
- EFI version: 0.0.5
    - Release date EFI: 25/02/2026
_________________________________________________

![Captura de Tela 2024-05-03 às 22 27 36](https://github.com/cost-12/Hackintosh-Samsung-Book-INTEL-CORE-I3-1115G4-11TH/assets/124941175/a9a25b24-b0f2-4273-ac02-963d56e7c684)
_________________________________________________
📌 About This Project

This repository provides a base EFI for running macOS on the Samsung Book (11th Gen Intel Tiger Lake) laptop using OpenCore.
This project is aimed at beginners and intermediate Hackintosh users who want a clean starting point, following Dortania standards.

⚠️ Important:
This EFI is a work in progress. Certain components—especially the Intel UHD G4 iGPU—are not fully functional on macOS due to lack of official drivers. Expect limitations.
_________________________________________________
## System Specifications

| Component             | Details                                                           |
| --------------------- | ----------------------------------------------------------------- |
| **CPU**               | Intel 11th Gen Tiger Lake i3-1115G4 (up to 4.1 GHz)               |
| **Chipset**           | Intel Tiger Lake-LP                                               |
| **iGPU**              | Intel UHD Graphics G4 (Iris Xe architecture, partially supported) |
| **Memory**            | 12 GB DDR4 3200 MHz                                               |
| **Storage**           | SSD SATA 256GB                                                    |
| **SD/MMC**            | O2 Micro, Inc. OZ711                                              |
| **Audio**             | Realtek ALC897                                                    |
| **Wi-Fi / Bluetooth** | Intel Wi-Fi 6 AX201 / 9462                                        |
| **Touchpad**          | Samsung I2C Precision TouchPad (ATML3000 / ELAN0B00)              |
| **BIOS**              | AMI Aptio Setup Utility (Version P23CFB)                          |

_______________________________________________
## Current Working Status

| Feature             | Status                                       |
| ------------------- | -------------------------------------------- |
| Booting macOS       | ✔️ Stable                                    |
| Keyboard / Trackpad | ✔️ Fn keys and I2C trackpad are working      |
| Audio (ALC897)      | ✔️ Functional                                |
| USB                 | ✔️ Mapped / Stable                           |
| Storage             | ⚠️ Note: Some NVMe drives may have problems  |
| Wi-Fi / Bluetooth   | ✔️ Via AirportItlwm / IntelBluetoothFirmware |
| Power Management    | ✔️ CPU PM with SSDT-PLUG & SMCBatteryManager |
| Sleep / Wake        | ✔️ Partial (improving)                       |
| Battery Readout     | ✔️ Working                                   |
| HDMI Output         | ❗️ Limited Note: No graphics acceleration    |

________________________________________________
📝 To activate the graphics drivers, modifications are required using [RU.efi](https://ruexe.blogspot.com/), specifically CFG Lock, and DVMT Pre-allocated. More information can be found here: 
- https://olarila.com/topic/40092-how-to-fixing-your-dvmt-pre-allocated-for-the-perfect-hackintosh/
- https://github.com/cost-12/Hackintosh-Samsung-Book-INTEL-CORE-I3-1115G4-11TH/issues/1#issuecomment-3391430613

❌ Known Issues / Not Working
🔸 Intel UHD G4 / Iris Xe — GPU Acceleration

Currently QE/CI hardware acceleration is unavailable because Apple never released Kexts for Gen12 Xe architecture. Only useful for programming tasks; for that purpose, it will have acceptable performance (I3 users).

Consequences:
- The keyboard does not have brightness control.
- Laggy animations
- Poor performance in Mission Control
- No HEVC/H.264 hardware encoding
- Reduced battery life

Community work is ongoing to develop experimental drivers.

Discussion Thread:
- https://www.insanelymac.com/forum/topic/358305-iris-xe-igpu-on-tiger-lake/
- https://github.com/pawan295/Appleinteltgldriver.kext
_______________________________________________

🛠️ Installation Notes

| Version        | Status                                        |
| -------------- | --------------------------------------------- |
| macOS Ventura  | ✔️ Recommended                                |
| macOS Sonoma   | ⚠️ Works but heavier without GPU acceleration |
| New Versions   | ⚠️ Bootable, but performance issues           |

📝 Note: Starting with the Sonoma versions, installing directly through them may result in loss of iCloud features and possible intermittent error messages. I recommend installing Catalina first, making the necessary modifications, and then updating to Ventura through official channels.

### SMBIOS Used:

- MacBookAir9,1 (stable on iGPU-only laptops)
- MacBookPro16,2 (Note: Display corrections are needed)

📝 Note: Modifying the SMBIOS also necessitates modifying the USBMap, in addition to CPUFriend profiles.

### Required Tools:

- GenSMBIOS
- ProperTree
- USB mapping tool
- DarwinDumper
- TinkerTool
- FixEDID
- KDK Apple
_______________________________________________
📚 References & Credits
- https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html
- https://dortania.github.io/Getting-Started-With-ACPI/
- https://github.com/luchina-gabriel
- https://olarila.com/
- https://github.com/lshbluesky/Samsung-NT750XDA-KF59U-Hackintosh
- https://github.com/joevt/WhateverGreen
- https://github.com/pawan295/Appleinteltgldriver.kext/releases
- https://github.com/becoolio
- https://www.insanelymac.com/forum/profile/53253-jalavoui/
_______________________________________________
💬 Community & Support

Feel free to:

- Submit PRs
- Report issues
- Share DSDTs, patches or new findings
- Any help is appreciated!

# [![Discord](https://img.shields.io/badge/Discord--%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)](mailto:https://discord.universohackintosh.com.br/)
# [![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](mailto:https://www.youtube.com/@UniversoHackintosh)
# [![Gmail](https://img.shields.io/badge/Gmail-hackinthc@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:hackinthc@gmail.com)
