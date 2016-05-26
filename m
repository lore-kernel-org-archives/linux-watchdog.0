Return-path: <narmstrong@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 0/3] watchdog: Add Amlogic Meson GXBB Watchdog Timer driver
Date: Thu, 26 May 2016 09:51:49 +0200
Message-Id: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
List-ID: <linux-watchdog@vger.kernel.org>

Adds support for the Amlogic Meson GXBB SoC Watchdog Timer.
It differs from the meson6/meson8b HW, so need for a separate driver.
The HW provides a divider capable of having a 1ms timebase thus simplifying
the counter update.
The restart call is not provided even if the HW is capable of triggering a
system reset immediately because of the PSCI firmare having such functionnality.

Neil Armstrong (3):
  watchdog: Add Meson GXBB Watchdog Driver
  dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
  ARM64: dts: amlogic: meson-gxbb: Add watchdog node

 .../bindings/watchdog/meson-gxbb-wdt.txt           |  13 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/meson_gxbb_wdt.c                  | 287 +++++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
 create mode 100644 drivers/watchdog/meson_gxbb_wdt.c

-- 
2.7.0
