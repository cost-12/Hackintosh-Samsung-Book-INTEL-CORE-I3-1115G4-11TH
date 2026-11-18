# Status da EFI & Compatibilidade de Hardware

**Samsung Book NP550XDA (`LH43STAR` / `SECCSD`)**  
*macOS Monterey 12.7.6+ (compatível com Big Sur até Tahoe) • OpenCore 1.0.8 • WhateverXe 0.8.2 + WhateverXe-Graphics 0.4.4*

---

## 1. Especificações do Hardware

| Componente | Detalhes do Hardware | Identificador / Device-ID |
| :--- | :--- | :--- |
| **Processador (CPU)** | Intel Core i3-1115G4 (Tiger Lake-U Gen12, 2C/4T, até 4.10 GHz) | Family 6, Model 140, Stepping 1 (`0x806C1`) |
| **Gráficos Integrados (iGPU)** | Intel UHD Graphics (Xe-LP Gen12 GT1, 48 EUs) | `8086:9A78` (Subvendor `144D:C193`) |
| **Painel Interno** | Display LCD eDP 15.6" HD (`1366 × 768 @ 60 Hz`) / Full HD (`1920 × 1080` em outras SKUs) | Conector interno eDP 1.4b |
| **Controlador de Áudio** | Realtek ALC256 (Combo Headphone/Mic + Falantes Internos) | `8086:A0C8` (`layout-id = 11` via `DeviceProperties`) |
| **Rede Cabeada (Ethernet)** | Realtek RTL8111/8168 PCI Express Gigabit Ethernet | `10EC:8168` (`device_type` corrigido) |
| **Rede Sem Fio (Wi-Fi)** | Intel Wireless-AC 9462 / Wi-Fi 6 AX201 (spoof `BCM4360` para macOS 14+) | `8086:02F0` (`PciRoot(0x0)/Pci(0x14,0x3)`) |
| **Bluetooth** | Intel Wireless Bluetooth Controller | USB VID `8087` / PID `0AAA` |
| **Dispositivos de Entrada** | Teclado PS/2 ABNT2 + Trackpad I2C HID Multitoque (polling) | ACPI `TPD0` (`force-polling = 1`) & `PS2K` |
| **Gerenciamento de Bateria** | Bateria Inteligente Samsung Li-Ion + Embedded Controller (EC) | ACPI `H_EC` / `BAT1` |

---

## 2. Matriz de Funcionamento Atual

A tabela a seguir reflete o estado validado após as intervenções, atualizações para o OpenCore `1.0.8` e calibrações aplicadas na EFI:

| Funcionalidade | Status | Driver / Mecanismo Responsável | Observações Técnicas |
| :--- | :---: | :--- | :--- |
| **Boot & Interface UEFI** | ✅ **100% Funcional** | OpenCore `1.0.8` + `UsbMouseDxe.efi` | `config.plist` validado pelo `ocvalidate 1.0.8` com esquema atualizado (`HideVerbose`). |
| **Aceleração Gráfica Metal/OpenGL** | ✅ **100% Funcional** | `WhateverXe.kext` (`v0.8.2`) + `WhateverXe-Graphics` (`v0.4.4`) | Renderização nativa com aceleração 3D, Metal, OpenGL e `AppleIntelTGLCompat` (`v0.8.1`). |
| **Decodificação de Vídeo (VDA)** | ✅ **100% Funcional** | `AppleIntelTGLGraphicsVADriver` | Aceleração em hardware para HEVC e H.264 (Safari, QuickTime, YouTube). |
| **Controle de Brilho Nativo** | ✅ **100% Funcional** | `SSDT-PNLF.aml` (`_UID = 19`, IDs Tiger Lake) | Slider deslizante fluido na Central de Controle e Preferências do Sistema. |
| **Teclas de Brilho (FN + F2 / F3)** | ✅ **100% Funcional** | `SSDT-SMSG.aml` (`_Q63`/`_Q64`) + `BrightnessKeys.kext` | Interceptação dos métodos `_Q63`/`_Q64` (`-> _X63`/`_X64`) na `DSDT` notificando `GFX0.DD1F`. |
| **Teclas de Volume e Mídia (FN)** | ✅ **100% Funcional** | `SSDT-VOLKEYSS.aml` + `VoodooPS2Controller.kext` (`v2.3.7`) | Scancodes em `Breakless PS2` e `Custom ADB Map` (`e020`, `e02e`, `e030`, `e002`, `e006`, `e008`, `e009`, etc.). |
| **Trackpad Multitoque** | ✅ **100% Funcional** | `VoodooI2C.kext` (`v2.8`) + `VoodooI2CHID.kext` | Gestos nativos do macOS via modo polling (`force-polling = 1` em `I2C0`); `SSDT-TPD0.aml` desativada. |
| **Teclado Integrado** | ✅ **100% Funcional** | `VoodooPS2Keyboard.kext` (`v2.3.7`) | Layout ABNT2 e acentuação respondendo com tempo de resposta imediato. |
| **Áudio e Microfone** | ✅ **100% Funcional** | `AppleALC.kext` (`v1.9.8`, `layout-id = 11`) | Codec Realtek ALC256 configurado com troca automática fone/falante. |
| **Wi-Fi Integrado** | ✅ **100% Funcional** | `AirportItlwm` (Big Sur–Ventura) / OCLP (Sonoma+) | Nativo até Ventura; macOS 14+ utiliza `IOSkywalkFamily` + `IO80211FamilyLegacy` + OCLP (`BCM4360`). |
| **Bluetooth Integrado** | ✅ **100% Funcional** | `IntelBluetoothFirmware` (`v2.5.2`) + `IntelBTPatcher` (`v2.5.2`) | Pareamento estável de fones, caixas de som e periféricos BLE (`BlueToolFixup` `v2.7.2` no 12–14). |
| **Rede Cabeada Gigabit** | ✅ **100% Funcional** | `RealtekRTL8111.kext` (`v3.0.0`) | Conexão Ethernet estável em 1000BASE-T. |
| **Leitura de Bateria** | ✅ **100% Funcional** | `SMCBatteryManager.kext` (`v1.3.8`) + `ECEnabler.kext` (`v1.0.6`) | Percentual em tempo real, carregamento e tempo estimado via DSDT nativa (sem `SSDT-BAT.aml`). |
| **Proteção de Carga Baixa** | ℹ️ **Opcional no macOS** | `lowbattery-guard` *(daemon externo à pasta EFI)* | Script/LaunchDaemon recomendado no sistema para desligamento limpo a 3%–4% antes do corte do BMS. |
| **Display Sleep (Apagar Tela)** | ✅ **100% Funcional** | `WhateverXe` (`v0.8.2`) | Desliga a tela por inatividade e reacende sem tela preta (correções de wake da `v0.8.1+`). |
| **Ação ao Fechar a Tampa** | ✅ **Protegido** | `pmset -a disablesleep 1 sleep 0 lidwake 1` | Desliga o display e o backlight de imediato; não trava e não superaquece. |
| **System Sleep / S3 (RAM Sleep)** | ❌ **Não Suportado** | Limitação de Arquitetura Tiger Lake | Sem suporte confiável de retorno S3 sem reinicialização completa do Display 12 via UEFI GOP neste hardware. |
| **Saída Externa HDMI** | ⚠️ **Sob Acompanhamento** | `WhateverXe` Pipeline de Vídeo | Releases `0.7.x–0.8.2` avançaram em USB-C DP Alt Mode e power-wells; HDMI direto no `NP550XDA` segue em validação. |

---

## 3. Detalhamento das Correções e Atualizações na EFI

### 3.1. Gráficos, Aceleração de Vídeo e Atualizações do `WhateverXe` (`0.6.1` -> `0.8.2`)

A solução gráfica utilizada nesta EFI é composta por dois repositórios oficiais mantidos por **b00t0x**:

* **[`b00t0x/WhateverXe`](https://github.com/b00t0x/WhateverXe)**: Plugin Lilu carregado pelo OpenCore (`EFI/OC/Kexts/WhateverXe.kext`, atualmente na versão **`0.8.2`**).
* **[`b00t0x/WhateverXe-Graphics`](https://github.com/b00t0x/WhateverXe-Graphics)**: Instalador `.pkg` executado dentro do macOS (validado com **`v0.4.4`**), responsável por instalar `AppleIntelTGLCompat.kext` (`v0.8.1`) e os bundles/drivers doadores (`16.0.32`) em `/Library/Extensions` e `/Library/GPUBundles`, reconstruindo o *Auxiliary Kernel Collection* (AuxKC) sem quebrar o snapshot selado do sistema (SSV).

> [!IMPORTANT]
>
> * **Mantenha ambos em versões compatíveis:** o projeto upstream exige que `WhateverXe.kext` e o pacote `WhateverXe-Graphics` sejam atualizados em conjunto a partir dos releases oficiais no GitHub.
> * **Nunca ative `WhateverGreen.kext` junto:** `WhateverGreen.kext`, `NootedBlue.kext` e `DisplayMergeNub.kext` foram desativados no `config.plist`.
> * **Requisitos obrigatórios no `config.plist`:** `AMFIPass.kext` (`1.4.1` Mod, com `MinKernel = 20.0.0`), `csr-active-config = 03080000` (`0x803`) e `SecureBootModel = Disabled` (dispensa flags amplas como `amfi=0x80`).

#### Principais novidades das atualizações do `WhateverXe` (`0.6.1` -> `0.8.2`)

* **`v0.6.x` -> `v0.7.0`**: Ampliação de compatibilidade eDP para Tiger Lake / Alder Lake / Raptor Lake, expansão de suporte a USB-C DisplayPort Alt Mode, suporte experimental a painéis MIPI DSI, ajustes para macOS Sequoia e Tahoe e introdução do `AutoPkg-Assets.pkg` para aceleração gráfica já no instalador / OOBE.
* **`v0.8.0`**: Melhorias de estabilidade na inicialização em configurações single-channel, ampliação de correspondência de Device IDs e correção de travamentos ao desligar monitores USB-C.
* **`v0.8.1`**: Correção de notificações de sleep/wake ausentes ou duplicadas no display, correção de mapeamento de memória gráfica nas fronteiras de buffer, preservação da saída de vídeo do firmware quando apenas um dos componentes gráficos está instalado e suporte experimental a framebuffer 10-bit para painéis MIPI DSI compatíveis.
* **`v0.8.2`**: Correção crítica de regressão introduzida na `v0.8.1` que podia deixar a tela totalmente preta logo após a inicialização do macOS.

#### Ajustes aplicados na EFI para o `WhateverXe 0.8.2`

* **Higienização do `DeviceProperties` (`PciRoot(0x0)/Pci(0x2,0x0)`)**:
  * Removidas todas as injeções legadas de `device-id` (spoofs de Ice Lake), `AAPL,ig-platform-id`, `framebuffer-*`, `AAPL00,override-no-connect` e `igfxfw`, mantendo apenas identificação limpa (`AAPL,slot-name`, `device_type`, `hda-gfx: onboard-1`, `model: Intel UHD Graphics`).
* **Argumentos de Inicialização (`boot-args`)**:

  ```text
  -allow3d -disablegfxfirmware npci=0x2000 keepsyms=1 nvme=-1
  ```

  * `-allow3d`: Habilita a aceleração 3D exigida pelo stack do WhateverXe.
  * `-disablegfxfirmware`: Evita que o driver tente carregar firmwares GuC/HuC incompatíveis em CPUs Tiger Lake móveis.

---

### 3.2. OpenCore `1.0.8`, Kexts e `DeviceProperties`

* **OpenCore `1.0.8`**: Atualização de `BOOTx64.efi`, `OpenCore.efi`, drivers UEFI, tools (`CleanNvram.efi`, `ResetSystem.efi`), `ocvalidate`, `macrecovery` (com `macrecovery.bat`) e adição da chave `HideVerbose = false` em `UEFI -> Drivers` mais o driver `UsbMouseDxe.efi`.
* **Atualização de Kexts**:
  * `AppleALC.kext`: `1.9.7` -> `1.9.8` (`layout-id = 11` em `PciRoot(0x0)/Pci(0x1F,0x3)`).
  * `VirtualSMC.kext` (`1.3.7` -> `1.3.8`), `SMCProcessor.kext` (`1.3.2` -> `1.3.8`), `SMCBatteryManager.kext` (`1.3.7` -> `1.3.8`).
  * `AirportBrcmFixup.kext` (`2.2.0` -> `2.2.1`).
  * `IntelBluetoothFirmware.kext` (`2.5.0` -> `2.5.2`), `IntelBTPatcher.kext` (`2.5.0` -> `2.5.2`), `IntelBluetoothInjector.kext` (`2.4.0` -> `2.5.2`).
  * `AMFIPass.kext` (`1.4.1` Mod atualizado, com `MinKernel` alterado de `23.0.0` para `20.0.0`).
* **Correções em `DeviceProperties`**:
  * Adicionados metadados do controlador xHCI em `PciRoot(0x0)/Pci(0x14,0x0)` e removida entrada vazia `PciRoot(0x0)/Pci(0x14,0x0)/Pci(0x0,0x0)`.
  * Comentado `device-id` (`#device-id`) do MEI (`PciRoot(0x0)/Pci(0x16,0x0)`).
  * Corrigido `device_type` da Ethernet Realtek (`PciRoot(0x0)/Pci(0x1D,0x0)/Pci(0x0,0x0)`) de `Non-Volatile memory controller` para `Ethernet controller`.

---

### 3.3. Iluminação, Teclado, ACPI e Energia

* **Higienização do Namespace ACPI (`config.plist`)**:
  * Desabilitadas **29 tabelas redundantes ou dumps brutos** (`DSDT.aml`, `SSDT-BAT.aml`, `SSDT-TPD0.aml`, `ssdt_data.aml`, `SSDT-NVME_OFF.aml`, `SSDT-FPDT.aml`, `SSDT-LPIT.aml`, `facp.aml`, `mcfg.aml`, `nhlt.aml` e dumps `ssdt*.aml`), evitando conflitos `AE_ALREADY_EXISTS` no boot e mantendo ativas apenas as 24 tabelas essenciais.
  * `ACPI -> Quirks`: `NormalizeHeaders` e `RebaseRegions` alterados para `false`, e patch `GPRW` -> `XPRW` refinado para `GPRW\x02` -> `XPRW\x02`.
* **Tabela ACPI `SSDT-PNLF.aml`**:
  * Atualizada com os Device IDs Intel Tiger Lake Xe-LP (incluindo `0x9A78`) e `_UID = 19` para controle PWM nativo de brilho (`0xC8250` e `0xC8254`).
* **Tabela ACPI `SSDT-SMSG.aml` & Patches `DSDT`**:
  * Reescrita (substituindo `_Q71`/`_Q72`) para interceptar as notificações `_Q63` e `_Q64` do `H_EC` (com os renames `[FNBL] _Q63 -> _X63` e `_Q64 -> _X64` filtrados para `DSDT` ativos no `config.plist`) e notificar `_SB.PC00.GFX0.DD1F` ao pressionar `FN + F2 / F3`.
* **Tabela ACPI `SSDT-USBX.aml`**:
  * Simplificada para isolar as propriedades de energia `USBX` sem duplicar o dispositivo `H_EC`.
* **Teclado (`VoodooPS2Keyboard.kext`)**:
  * Adicionados novos códigos em `Breakless PS2` (`e002`, `e003`, `e004`, `e006`, `e008`, `e009`, `e033`, `e077`, `e079`) e `Custom ADB Map` (`e002=70`, `e006=80`, `e008=71`, `e009=6b`), além dos códigos de volume (`e020`, `e02e`, `e030`).
* **Gerenciamento de CPU e Bateria (`CPUFriendDataProvider.kext` & `ECEnabler.kext`)**:
  * `CPUFriendDataProvider.kext` calibrado com LFM reduzido de `900 MHz` para `800 MHz` (`0x08`) e `epp` ajustado para `0x20` (com `ssdt_data.aml` sincronizada, embora desativada em favor da kext).
  * Leitura da bateria via DSDT nativa do firmware + `ECEnabler.kext` + `SMCBatteryManager.kext` (com `SSDT-BAT.aml` desativada para evitar duplicidade de `BAT1`).
  * Como proteção adicional contra cortes abruptos do BMS em 2%–3%, recomenda-se configurar no macOS um guardião externo (`lowbattery-guard` via `launchd`) para desligamento seguro em **3%–4%** de bateria.

---

### 3.4. Gerenciamento de Energia e Comportamento da Tampa (Lid)

* **Prevenção do Sono Quebrado (S3)**:
  * O gerenciamento de energia deve ser configurado para desligar o display de imediato ao fechar a tampa, sem permitir que o kernel entre em S3:

    ```bash
    sudo pmset -a disablesleep 1 sleep 0 lidwake 1
    sudo pmset -b displaysleep 5
    sudo pmset -c displaysleep 10
    ```

* **Scripts Utilitários no Repositório**:
  * `Utils/ajustar_sleep_tampa.sh`: Aplica o modo seguro para a tampa.
  * `Utils/restaurar_sleep_padrao.sh`: Restaura o comportamento padrão do macOS caso futuras versões do `WhateverXe` passem a suportar S3 nesta plataforma.

---

## 4. Recomendações de Uso e Manutenção

1. **Transporte do Notebook**:
   * Ao guardar o notebook dentro de mochilas, capas de neoprene ou bolsas fechadas, **desligue o computador** (` > Desligar...`). Como o sistema permanece acordado com a tela desligada ao fechar a tampa, transportá-lo ligado em ambientes sem circulação de ar pode gerar aquecimento indesejado.
2. **Atualizações do WhateverXe & WhateverXe-Graphics**:
   * Acompanhe os releases oficiais em [`b00t0x/WhateverXe`](https://github.com/b00t0x/WhateverXe/releases) e [`b00t0x/WhateverXe-Graphics`](https://github.com/b00t0x/WhateverXe-Graphics/releases). Sempre baixe e instale ambos os pacotes correspondentes juntos (o `.pkg` não é armazenado neste repositório devido ao tamanho).
3. **Estrutura de Arquivos da EFI**:
   * Sempre mantenha uma cópia de segurança funcional da pasta `/Volumes/EFI/EFI` em um pendrive de boot para contingências antes de atualizar o macOS ou modificar patches.
