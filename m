Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>,
	Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
Date: Sat, 12 Aug 2017 20:43:07 +0200
Message-Id: <20170812184318.10144-1-linus.walleij@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

The MOXA ART and Aspeed watchdogs are clearly based on the
Faraday Technology FTWDT010 IP block.

This series consolidates the drivers into one by extending
the Gemini driver to be as generic as possible, renaming it
to ftwdt010_wdt and merging the two other drivers into it.

As similar approach was used for the FTTMR010 driver in the
past.

The series ends with two patches that will be applied to
the ARM SoC tree to fix up the PCLK annotations, but these
are not needed to make the consolidation, patches 1-9 can
be applied directly to the watchdog tree to perform the
consolidation.

Obviously I would like the MOXA ART and Aspeed maintainers
to test the series to see that it still works as expected for
them afterwards.

The patch series is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
Branch ftwdt010

Linus Walleij (11):
  watchdog: gemini/ftwdt010: rename DT bindings
  watchdog: gemini/ftwdt010: rename driver and symbols
  watchdog: ftwdt010: Make interrupt optional
  watchdog: ftwdt010: Add clock support
  watchdog: ftwdt010: Add restart support
  watchdog: ftwdt010: Extend DT bindings to derivatives
  watchdog: ftwdt010: Delete surplus bindings
  watchdog: ftwdt010/moxart: Merge MOXA ART into FTWDT010
  watchdog: ftwdt010/aspeed: Merge Aspeed into FTWDT010
  ARM: dts: fix PCLK name on Gemini and MOXA ART
  ARM: dts: Add PCLK to the Aspeed watchdogs

 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  16 -
 .../bindings/watchdog/cortina,gemin-watchdog.txt   |  17 --
 .../bindings/watchdog/cortina,gemini-watchdog.txt  |  17 --
 .../bindings/watchdog/faraday,ftwdt010.txt         |  34 +++
 .../bindings/watchdog/moxa,moxart-watchdog.txt     |  15 -
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   7 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  12 +-
 arch/arm/boot/dts/gemini.dtsi                      |   3 +-
 arch/arm/boot/dts/moxart.dtsi                      |   3 +-
 drivers/watchdog/Kconfig                           |  39 +--
 drivers/watchdog/Makefile                          |   4 +-
 drivers/watchdog/aspeed_wdt.c                      | 200 ------------
 drivers/watchdog/ftwdt010_wdt.c                    | 338 +++++++++++++++++++++
 drivers/watchdog/gemini_wdt.c                      | 229 --------------
 drivers/watchdog/moxart_wdt.c                      | 178 -----------
 15 files changed, 401 insertions(+), 711 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt
 delete mode 100644 drivers/watchdog/aspeed_wdt.c
 create mode 100644 drivers/watchdog/ftwdt010_wdt.c
 delete mode 100644 drivers/watchdog/gemini_wdt.c
 delete mode 100644 drivers/watchdog/moxart_wdt.c

-- 
2.13.4
