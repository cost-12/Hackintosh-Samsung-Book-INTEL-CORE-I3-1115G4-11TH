# Hackintosh-Samsung-Book-INTEL-CORE-I3-1115G4-11TH
BASE EFI GABRIEL LUCHINA
- Opencore version: 1.0.8
    - Release date Opencore: 27/09/2026
- EFI version: 0.0.7
    - Release date EFI: 28/10/2026
_________________________________________________

<img width="1600" height="900" alt="MacOS-Info" src="https://github.com/user-attachments/assets/16739b43-fcb3-492a-a6c7-4698e2c53817" />

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
| HDMI Output         | ❗️ Limited                                   |

________________________________________________

## 2. Matriz de Funcionamento Atual

A tabela a seguir reflete o estado validado após as intervenções e calibrações aplicadas na EFI:

| Funcionalidade | Status | Driver / Mecanismo Responsável | Observações Técnicas |
| :--- | :---: | :--- | :--- |
| **Aceleração Gráfica Metal** | ✅ **100% Funcional** | WhateverXe.kext + AppleIntelTGLCompat | Renderização nativa com aceleração 3D, Metal 3, OpenGL e OpenCL. |
| **Decodificação de Vídeo (VDA)** | ✅ **100% Funcional** | AppleIntelTGLGraphics / VDA Decoder | Aceleração em hardware para HEVC e H.264 (Safari, QuickTime, YouTube). |
| **Controle de Brilho Nativo** | ✅ **100% Funcional** | SSDT-PNLF.aml (`_UID = 19`) | Slider deslizante fluido na Central de Controle e Preferências do Sistema. |
| **Teclas de Brilho (FN + F2 / F3)** | ✅ **100% Funcional** | SSDT-SMSG.aml + BrightnessKeys.kext | Interceptação de eventos ACPI do EC Samsung sincronizados com a UI. |
| **Teclas de Volume (FN + F6..F8)** | ✅ **100% Funcional** | SSDT-VOLKEYSS.aml + VoodooPS2Controller.kext | Scancodes PS/2 mapeados (Mute: `0x20`, Vol-: `0x2E`, Vol+: `0x30`). |
| **Trackpad Multitoque** | ✅ **100% Funcional** | VoodooI2C.kext + VoodooI2CHID.kext | Gestos nativos do macOS (pinça, zoom, rotação, troca de mesas com 3/4 dedos). |
| **Teclado Integrado** | ✅ **100% Funcional** | VoodooPS2Keyboard.kext | Layout e acentuação respondendo com tempo de resposta imediato. |
| **Áudio e Microfone** | ✅ **100% Funcional** | AppleALC.kext | Codec Realtek ALC256 configurado com troca automática fone/falante. |
| **Wi-Fi Integrado** | ✅ **100% Funcional** | AirportItlwmMonterey.kext | Integração nativa na barra de menus, redes 2.4/5 GHz e WPA2/WPA3. |
| **Bluetooth Integrado** | ✅ **100% Funcional** | IntelBluetoothFirmware + BlueToolFixup.kext | Pareamento estável de fones, caixas de som e periféricos BLE. |
| **Rede Cabeada Gigabit** | ✅ **100% Funcional** | RealtekRTL8111.kext | Conexão Ethernet estável em 1000BASE-T. |
| **Leitura de Bateria** | ✅ **100% Funcional** | SMCBatteryManager.kext + ECEnabler.kext | Percentual em tempo real, status de carregamento e tempo estimado. |
| **Proteção de Carga Baixa** | ✅ **Protegido** | lowbattery-guard | Desligamento limpo a 3%–4% de bateria antes do corte abrupto do BMS. |
| **Display Sleep (Apagar Tela)** | ✅ **100% Funcional** | WhateverXe (Alternate Scrambler Reset Hook) | Desliga a tela por inatividade e reacende instantaneamente sem tela preta. |
| **Ação ao Fechar a Tampa** | ✅ **Protegido** | `pmset -a disablesleep 1 sleep 0 lidwake 1` | Desliga o display e o backlight de imediato; não trava e não superaquece. |
| **System Sleep / S3 (RAM Sleep)** | ❌ **Não Suportado** | Limitação de Arquitetura Tiger Lake | Drivers doadores da Apple não possuem sequenciador Display 12 pós-S3 sem GOP. |
| **Saída Externa HDMI** | ⚠️ **Sob Acompanhamento** | WhateverXe TCSS/FIA Multiplexing | Hardware detecta a porta, porém o pipeline HDMI em Tiger Lake está em refinamento upstream. |

---

### 3. Gerenciamento de Energia e Comportamento da Tampa (Lid)
* **Prevenção do Sono Quebrado (S3)**:
  * Na arquitetura Tiger Lake sob WhateverXe, o retorno de sono S3 profundo resulta em tela preta devido à ausência de GOP no despertar.
  * O gerenciamento de energia foi configurado para desligar o display de imediato ao fechar a tampa, sem permitir que o kernel entre em S3:
    ```bash
    sudo pmset -a disablesleep 1 sleep 0 lidwake 1
    sudo pmset -b displaysleep 5
    sudo pmset -c displaysleep 10
    ```
* **Scripts Utilitários Gerados**:
  * `ajustar_sleep_tampa.sh`: Aplica o modo seguro para a tampa.
  * `restaurar_sleep_padrao.sh`: Restaura o comportamento padrão do macOS caso o WhateverXe receba suporte a S3 no futuro.

---

## 4. Recomendações de Uso e Manutenção

1. **Transporte do Notebook**:
   * Ao guardar o notebook dentro de mochilas, capas de neoprene ou bolsas fechadas, **desligue o computador** (` > Desligar...`). Como o sistema permanece acordado com a tela desligada ao fechar a tampa, transportá-lo ligado em ambientes sem circulação de ar pode gerar aquecimento indesejado.
2. **Atualizações do WhateverXe**:
   * O projeto WhateverXe continua em evolução ativa pelos desenvolvedores upstream. Quando novas versões estáveis forem lançadas com melhorias no roteamento HDMI ou no sequenciamento de sono S3, basta atualizar a kext `WhateverXe.kext` mantendo o restante da base ACPI intacto.
3. **Estrutura de Arquivos da EFI**:
   * Sempre mantenha uma cópia de segurança funcional da pasta `/Volumes/EFI/EFI` em um pendrive de boot para contingências antes de atualizar o macOS ou modificar kexts.
  
---

Community work is ongoing to develop experimental drivers.

Discussion Thread:
- https://www.insanelymac.com/forum/topic/358305-iris-xe-igpu-on-tiger-lake/
- https://github.com/pawan295/Appleinteltgldriver.kext
- https://github.com/m4j2rpf766-crypto/IntelIGPU-Tahoe
- https://github.com/JulioNectar/Hackintosh-XPS13Plus-IrisXe-Tahoe
- https://github.com/sgiammori/NootedGreen
_______________________________________________

🛠️ Installation Notes

| Version        | Status                                        |
| -------------- | --------------------------------------------- |
| macOS Big Sur  | 📌 OK                                         |
| macOS Monterey | 📌 It was tested                              |
| macOS Ventura  | ✔️ Recommended                                |
| macOS Sonoma   | ⚠️ It has not been tested                     |
| New Versions   | ⚠️ Some features may not work                 |

📝 Note: Starting with the Sonoma versions, installing directly through them may result in loss of iCloud features and possible intermittent error messages. I recommend installing Catalina first, making the necessary modifications, and then updating to Ventura through official channels.

### SMBIOS Used:

- MacBookAir9,1 (stable on iGPU-only laptops)

📝 Note: Modifying the SMBIOS also necessitates modifying the USBMap, in addition to CPUFriend profiles.

### Required Tools:

- GenSMBIOS
- ProperTree
- USB mapping tool

_______________________________________________
📚 References & Credits
- https://github.com/b00t0x/WhateverXe-Graphics
- https://github.com/b00t0x/WhateverXe
- https://github.com/lshbluesky/IntelBluetoothFirmware
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

[![Discord](https://img.shields.io/badge/Discord--%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.universohackintosh.com.br/)
[![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://www.youtube.com/@UniversoHackintosh)
[![Gmail](https://img.shields.io/badge/Gmail-hackinthc@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:hackinthc@gmail.com)
