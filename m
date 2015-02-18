Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:49498 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbBRLtW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 06:49:22 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so1571791wiv.2
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Feb 2015 03:49:21 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v3 0/8] mfd: watchdog: rtc: New driver for ST's LPC IP
Date: Wed, 18 Feb 2015 11:49:06 +0000
Message-Id: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ST's Low Power Controller (LPC) controls two devices; watchdog and RTC.
Only one of the devices can be used at any one time, which is enforced
by the correlating MFD driver.
  
This driver set provides everything you need to choose one (and only
one) of the LPC devices to run per I/P block, of which there are two
on the enabled STiH407 h/w.

Version 3:
 - Move Regmap pointer into core device data structure
 - Remove error message from devm_ioremap_resource
  
Version 2:
 - Only calculate keepalive once in probe()
 - Check for a 0 clk_rate
 - Set limits using predefined attributes from watchdog_device
 - CONFIG_PM => CONFIG_SLEEP
 - Call st_wdog_setup() on resume
 - Remove MFD driver -- instead rely on driver probing mechanism
   which continues attempting to bind to different drivers until
   one does not return -ENODEV

Lee Jones (8):
  ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
  ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
  ARM: STi: DT: STiH407: Add Device Tree node for the LPC
  watchdog: bindings: Provide ST bindings for ST's LPC Watchdog device
  watchdog: st_wdt: Add new driver for ST's LPC Watchdog
  rtc: bindings: Provide ST bindings for ST's LPC RTC device
  rtc: st: add new driver for ST's LPC RTC
  MAINTAINERS: Add Watchdog and RTC files to STI's maintainer entry

 .../devicetree/bindings/rtc/rtc-st-lpc.txt         |  25 ++
 .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |  38 +++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/stih407-family.dtsi              |  20 ++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 drivers/rtc/Kconfig                                |  12 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-st-lpc.c                           | 354 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  13 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/st_lpc_wdt.c                      | 333 +++++++++++++++++++
 11 files changed, 801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
 create mode 100644 drivers/rtc/rtc-st-lpc.c
 create mode 100644 drivers/watchdog/st_lpc_wdt.c

-- 
1.9.1

