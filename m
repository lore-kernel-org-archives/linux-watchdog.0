Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net
Cc: lee.jones@linaro.org,
	kernel@stlinux.com
Subject: [PATCH v4 0/4] watchdog: Introduce new driver to support ST's Watchdog
Date: Thu, 23 Oct 2014 16:18:40 +0100
Message-Id: <1414077524-6469-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Wim,
  
Basic driver to support ST's LPC Watchdog device.

Kind regards,
Lee
  
v3 => v4:
 - Fixed undefined 'clk' error (caused my rushing)
 - Fixed up Mark's DT Doc comments

v2 => v3:
 - Don't stop Watchdog during .remove()
 - Remove superflous {EN,DIS}ABLE defines
 - Add missing clk_disable_unprepare()
  
v1 => v2:
 - Fixed reset enable masks
 - Fixed DT documentation

Lee Jones (4):
  ARM: STi: DT: STiH407: Add Device Tree node for LPC Watchdog
  ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
  watchdog: st_wdt: Provide binding documentation for ST's LPC Watchdog
    driver
  watchdog: st_wdt: Add new driver for ST's LPC Watchdog

 .../devicetree/bindings/watchdog/st-lpc-wdt.txt    |  31 ++
 arch/arm/boot/dts/stih407.dtsi                     |  10 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/watchdog/Kconfig                           |  16 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/st_wdt.c                          | 317 +++++++++++++++++++++
 6 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt
 create mode 100644 drivers/watchdog/st_wdt.c

-- 
1.9.1
