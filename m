Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35634 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbbKGLEX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Nov 2015 06:04:23 -0500
Received: by wmll128 with SMTP id l128so50969857wml.0
        for <linux-watchdog@vger.kernel.org>; Sat, 07 Nov 2015 03:04:22 -0800 (PST)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH v2 0/4] watchdog: meson: Add meson8b watchdog
Date: Sat,  7 Nov 2015 12:02:15 +0100
Message-Id: <1446894139-6802-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

Patchset to add support for the watchdog found on the Amlogic meson8b SoCs.
DTS and documentation are also updated.

Changelog:
   - V1 -> V2:
     * Do not calculate mask at runtime
     * Fix few style problems
     * Remove useless typecase

Carlo Caione (4):
  watchdog: meson: Enable meson SoC specific data
  watchdog: meson: Add meson8b SoC specific data
  Documentation: watchdog: Add new bindings for meson8b
  ARM: dts: meson8b: Add watchdog node

 .../devicetree/bindings/watchdog/meson-wdt.txt     | 13 +++++
 .../devicetree/bindings/watchdog/meson6-wdt.txt    | 13 -----
 arch/arm/boot/dts/meson8b.dtsi                     |  6 +++
 drivers/watchdog/meson_wdt.c                       | 63 ++++++++++++++++------
 4 files changed, 65 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

-- 
1.9.1

