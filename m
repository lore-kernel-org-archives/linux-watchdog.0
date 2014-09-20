Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36800 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaITRJM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 13:09:12 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so952049wgh.21
        for <linux-watchdog@vger.kernel.org>; Sat, 20 Sep 2014 10:09:10 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v4 0/4] ARM: meson: watchdog driver
Date: Sat, 20 Sep 2014 19:06:48 +0200
Message-Id: <1411232812-11594-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset adds support for the watchdog found on Amlogic MesonX SoCs. The
watchdog is used also to reboot the device.

DTSI and multi_v7_defconfig are updated and proper documentation is added.

No documentation is provided by Amlogic, the code is reverse-engineered by the
code available at http://openlinux.amlogic.com:8000/download/

This patchset depends on:
[1] [PATCH 0/6] ARM: meson: initial support for MesonX SoCs
[2] [PATCH 0/2] ARM: meson: add clocksource support

Changes since v3:
* addressed checkpatch warning

Changes since v2:
* changed compatible to "amlogic,meson6-wdt"
* removed useless code
* code refactored

Changes since v1:
* added restart handler support

Carlo Caione (4):
  ARM: docs: add documentation binding for meson watchdog
  ARM: meson: add watchdog driver
  ARM: DTS: meson: update DTSI to add watchdog node
  ARM: defconfig: update multi_v7_defconfig

 .../devicetree/bindings/watchdog/meson6-wdt.txt    |  13 ++
 arch/arm/boot/dts/meson.dtsi                       |   5 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/meson_wdt.c                       | 236 +++++++++++++++++++++
 6 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
 create mode 100644 drivers/watchdog/meson_wdt.c

-- 
1.9.1

