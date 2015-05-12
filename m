Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/12] mfd: Add support for Clocksource to LPC set
Date: Tue, 12 May 2015 13:58:08 +0100
Message-Id: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

ST's Low Power Controller (LPC) controls three devices; watchdog, RTC
and a Clocksource Timer.  Only one of the devices can be used at any
one time, which is enforced by the Device Driver model.
 
This patchset provides support for the Clocksource driver.  Watchdog
and RTC are already in -next.

Lee Jones (12):
  mfd: dt-bindings: Provide human readable define for Clocksource mode
  clocksource: sti: Provide support for the ST LPC Clocksource IP
  clocksource: sti: Provide 'use timer as sched clock' capability
  clocksource: bindings: Provide bindings for ST's LPC Clocksource
    device
  watchdog: st_wdt: Update IP layout information to include Clocksource
  watchdog: bindings: Supply knowledge of a third supported device -
    clocksource
  rtc: st: Update IP layout information to include Clocksource
  rtc: bindings: Supply knowledge of a third supported device -
    clocksource
  MAINTAINERS: Add the LPC Clocksource to STi maintained driver list
  ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource
  ARM: STi: Enable LPC Clocksource
  ARM: STi: Update platform level menuconfig 'help'

 .../devicetree/bindings/rtc/rtc-st-lpc.txt         |  15 ++-
 .../devicetree/bindings/timer/st,stih407-lpc       |  28 +++++
 .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |  12 +-
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |   2 +-
 arch/arm/mach-sti/Kconfig                          |  10 +-
 drivers/clocksource/Kconfig                        |   9 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/clksrc_st_lpc.c                | 129 +++++++++++++++++++++
 drivers/rtc/rtc-st-lpc.c                           |   2 +-
 drivers/watchdog/st_lpc_wdt.c                      |   2 +-
 include/dt-bindings/mfd/st-lpc.h                   |   1 +
 12 files changed, 194 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stih407-lpc
 create mode 100644 drivers/clocksource/clksrc_st_lpc.c

-- 
1.9.1
