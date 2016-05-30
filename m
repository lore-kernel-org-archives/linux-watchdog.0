Return-path: <narmstrong@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 0/3] watchdog: Add Amlogic Meson GXBB Watchdog Timer driver
Date: Mon, 30 May 2016 15:29:05 +0200
Message-Id: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
List-ID: <linux-watchdog@vger.kernel.org>

Adds support for the Amlogic Meson GXBB SoC Watchdog Timer.
It differs from the meson6/meson8b HW, so need for a separate driver.
The HW provides a divider capable of having a 1ms timebase thus simplifying
the counter update.
The restart call is not provided even if the HW is capable of triggering a
system reset immediately because of the PSCI firmare having such functionnality.
The watchdog is not expected to be running at boot time since there is a separate
system-level watchdog running from the SCPI co-processor, but this case would be
handle in a next driver update.

Changes since RFC version at http://lkml.kernel.org/r/1464249112-13658-1-git-send-email-narmstrong@baylibre.com :
- Remove status callback, will re-introduce it later to managed the already-running use case
- Fix registers defines indentation
- Fix space between operators
- Make all callbacks static functions
- Fix bindings with missing clocks attribute
- Do not stop/start watchdog on a timeout setup
- Fix probe device configuration

Neil Armstrong (3):
  watchdog: Add Meson GXBB Watchdog Driver
  dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
  ARM64: dts: amlogic: meson-gxbb: Add watchdog node

 .../bindings/watchdog/meson-gxbb-wdt.txt           |  16 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/meson_gxbb_wdt.c                  | 277 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
 create mode 100644 drivers/watchdog/meson_gxbb_wdt.c

-- 
2.7.0
