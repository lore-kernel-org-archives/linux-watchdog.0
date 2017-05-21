Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55441 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756404AbdEUWCW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 21 May 2017 18:02:22 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        rtc-linux@googlegroups.com
Subject: [PATCH 0/3] mfd: move include files out of include/linux/i2c
Date: Mon, 22 May 2017 00:02:07 +0200
Message-Id: <20170521220212.1404-1-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, for the mfd subsystem to include/linux/mfd. Because of twl.h,
this touches quite some subsystems, but I still think it is worth it.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (3):
  mfd: dm355evm_msp: move header file out of I2C realm
  mfd: tps65010: move header file out of I2C realm
  mfd: twl: move header file out of I2C realm

 arch/arm/mach-omap1/board-h2-mmc.c        | 2 +-
 arch/arm/mach-omap1/board-h2.c            | 2 +-
 arch/arm/mach-omap1/board-h3-mmc.c        | 2 +-
 arch/arm/mach-omap1/board-h3.c            | 2 +-
 arch/arm/mach-omap1/board-osk.c           | 2 +-
 arch/arm/mach-omap2/common.h              | 2 +-
 arch/arm/mach-omap2/omap_twl.c            | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c   | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c       | 2 +-
 drivers/gpio/gpio-twl4030.c               | 2 +-
 drivers/iio/adc/twl4030-madc.c            | 2 +-
 drivers/iio/adc/twl6030-gpadc.c           | 2 +-
 drivers/input/keyboard/twl4030_keypad.c   | 2 +-
 drivers/input/misc/dm355evm_keys.c        | 2 +-
 drivers/input/misc/twl4030-pwrbutton.c    | 2 +-
 drivers/input/misc/twl4030-vibra.c        | 2 +-
 drivers/mfd/dm355evm_msp.c                | 2 +-
 drivers/mfd/tps65010.c                    | 2 +-
 drivers/mfd/twl-core.c                    | 6 +++---
 drivers/mfd/twl4030-audio.c               | 2 +-
 drivers/mfd/twl4030-irq.c                 | 2 +-
 drivers/mfd/twl4030-power.c               | 2 +-
 drivers/mfd/twl6030-irq.c                 | 2 +-
 drivers/phy/phy-twl4030-usb.c             | 2 +-
 drivers/power/supply/twl4030_charger.c    | 2 +-
 drivers/pwm/pwm-twl-led.c                 | 2 +-
 drivers/pwm/pwm-twl.c                     | 2 +-
 drivers/regulator/twl-regulator.c         | 2 +-
 drivers/regulator/twl6030-regulator.c     | 2 +-
 drivers/rtc/rtc-dm355evm.c                | 2 +-
 drivers/rtc/rtc-twl.c                     | 2 +-
 drivers/usb/host/ohci-omap.c              | 2 +-
 drivers/usb/phy/phy-isp1301-omap.c        | 2 +-
 drivers/usb/phy/phy-twl6030-usb.c         | 2 +-
 drivers/video/backlight/pandora_bl.c      | 2 +-
 drivers/video/fbdev/omap/lcd_h3.c         | 2 +-
 drivers/watchdog/twl4030_wdt.c            | 2 +-
 include/linux/{i2c => mfd}/dm355evm_msp.h | 0
 include/linux/{i2c => mfd}/tps65010.h     | 2 +-
 include/linux/{i2c => mfd}/twl.h          | 0
 sound/soc/codecs/twl4030.c                | 2 +-
 41 files changed, 41 insertions(+), 41 deletions(-)
 rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)
 rename include/linux/{i2c => mfd}/tps65010.h (99%)
 rename include/linux/{i2c => mfd}/twl.h (100%)

-- 
2.11.0

