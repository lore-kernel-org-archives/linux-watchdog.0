Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:44796 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbBYNwl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 08:52:41 -0500
Received: by wesk11 with SMTP id k11so3698331wes.11
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 05:52:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Cc: lee.jones@linaro.org, kernel@stlinux.com
Subject: [PATCH v4 0/9] mfd: watchdog: rtc: New driver for ST's LPC IP
Date: Wed, 25 Feb 2015 13:52:20 +0000
Message-Id: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ST's Low Power Controller (LPC) controls two devices; watchdog and RTC.
Only one of the devices can be used at any one time, which is enforced
by the correlating MFD driver.
  
This driver set provides everything you need to choose one (and only
one) of the LPC devices to run per I/P block, of which there are two
on the enabled STiH407 h/w.

Version 4:
 - Use {readl,writel}_relaxed() calls
 - Add Guenter's Reviewed-by
 - Rebased onto v4.0-rc1
  
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

Lee Jones (9):
  mfd: dt-bindings: Provide human readable defines for LPC mode choosing
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
 include/dt-bindings/mfd/st-lpc.h                   |  15 +
 12 files changed, 816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
 create mode 100644 drivers/rtc/rtc-st-lpc.c
 create mode 100644 drivers/watchdog/st_lpc_wdt.c
 create mode 100644 include/dt-bindings/mfd/st-lpc.h

-- 
1.9.1

