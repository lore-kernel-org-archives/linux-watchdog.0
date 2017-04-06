Return-path: <yannick.fertre@st.com>
From: Yannick Fertre <yannick.fertre@st.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob
 Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre
	<yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe
 Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/5] STM32 Independent watchdog
Date: Thu, 6 Apr 2017 14:19:23 +0200
Message-ID: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Version 5:
- Update bindings (add field timeout-sec)
- Update driver (rework start, rework settings & remove max_timeout)

Version 4:
- Update bindings (iwdg > watchdog)
- Update typo
- Update commit header
- remove gerrit tags
- Update driver (remove unnecessary tests) a add watchdog_init_timeout

Version 3:
- Update typo into  bindings file
- Reorder node in devicetree (ordering by address)
- Remove unnecessary lines in commits

Version 2:
- Add commit messages

Version 1:
- Initial commit

The purpose of this set of patches is to add a new watchdog driver for
stm32f429.
This driver was developed and tested on evaluation board stm32429i.

Yannick Fertre (5):
  dt-bindings: watchdog: Document STM32 IWDG bindings
  drivers: watchdog: Add STM32 IWDG driver
  ARM: dts: stm32: Add watchdog support for STM32F429 SoC
  ARM: dts: stm32: Add watchdog support for STM32F429 eval board
  ARM: configs: stm32: Add watchdog support in STM32 defconfig

 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  19 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   5 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   9 +-
 arch/arm/configs/stm32_defconfig                   |   1 +
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stm32_iwdg.c                      | 253 +++++++++++++++++++++
 7 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
 create mode 100644 drivers/watchdog/stm32_iwdg.c

-- 
1.9.1
