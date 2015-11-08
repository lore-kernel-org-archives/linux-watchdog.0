Return-path: <carlo.caione@gmail.com>
Sender: Carlo Caione <carlo.caione@gmail.com>
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net,
	wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	drake@endlessm.com,
	jerry.cao@amlogic.com,
	victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH v3 0/4] watchdog: meson: Add meson8b watchdog
Date: Sun,  8 Nov 2015 13:18:53 +0100
Message-Id: <1446985137-25498-1-git-send-email-carlo@caione.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Carlo Caione <carlo@endlessm.com>

Patchset to add support for the watchdog found on the Amlogic meson8b SoCs.
DTS and documentation are also updated.

Changelog:
   - V1 -> V2:
     * Do not calculate mask at runtime
     * Fix few style problems
     * Remove useless typecase

   - V2 -> V3:
     * Changed description for [PATCH 1/4]
     * Default timeout is not set as min(default, max)

Carlo Caione (4):
  watchdog: meson: Enable meson SoC specific data
  watchdog: meson: Add meson8b SoC specific data
  Documentation: watchdog: Add new bindings for meson8b
  ARM: dts: meson8b: Add watchdog node

 .../devicetree/bindings/watchdog/meson-wdt.txt     | 13 +++++
 .../devicetree/bindings/watchdog/meson6-wdt.txt    | 13 -----
 arch/arm/boot/dts/meson8b.dtsi                     |  6 ++
 drivers/watchdog/meson_wdt.c                       | 65 ++++++++++++++++------
 4 files changed, 67 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

-- 
1.9.1
