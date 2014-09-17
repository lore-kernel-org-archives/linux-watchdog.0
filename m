Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35832 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaIQUMW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Sep 2014 16:12:22 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so1945421wgh.10
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Sep 2014 13:12:21 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 0/4] ARM: meson: watchdog driver
Date: Wed, 17 Sep 2014 22:12:02 +0200
Message-Id: <1410984726-18944-1-git-send-email-carlo@caione.org>
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

Changes since v1:
* added restart handler support

[1] http://www.spinics.net/lists/arm-kernel/msg362521.html
[2] http://www.spinics.net/lists/arm-kernel/msg362483.html

Carlo Caione (4):
  ARM: docs: add documentation binding for meson watchdog
  ARM: meson: add watchdog driver
  ARM: DTS: meson: update DTSI to add watchdog node
  ARM: defconfig: update multi_v7_defconfig

 .../devicetree/bindings/watchdog/meson-wdt.txt     |  13 ++
 arch/arm/boot/dts/meson.dtsi                       |   5 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/meson_wdt.c                       | 237 +++++++++++++++++++++
 6 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 create mode 100644 drivers/watchdog/meson_wdt.c

-- 
1.9.1

