Return-Path: <jg1.han@samsung.com>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Guenter Roeck' <linux@roeck-us.net>,
 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 0/8] watchdog: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:46:43 +0900
Message-id: <000101cf26f5$06c21760$14464620$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
List-ID: <linux-watchdog@vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

Jingoo Han (8):
      watchdog: at32ap700x: Remove unnecessary OOM messages
      watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
      watchdog: bcm2835: Remove unnecessary OOM messages
      watchdog: da9052: Remove unnecessary OOM messages
      watchdog: da9055: Remove unnecessary OOM messages
      watchdog: pcwd_usb: Remove unnecessary OOM messages
      watchdog: sp805_wdt: Remove unnecessary OOM messages
      watchdog: ts72xx_wdt: Remove unnecessary OOM messages
      watchdog: wm831x: Remove unnecessary OOM messages

---
 drivers/watchdog/at32ap700x_wdt.c |    4 +---
 drivers/watchdog/bcm2835_wdt.c    |    4 +---
 drivers/watchdog/da9052_wdt.c     |    1 -
 drivers/watchdog/da9055_wdt.c     |    4 +---
 drivers/watchdog/pcwd_usb.c       |    4 +---
 drivers/watchdog/sp805_wdt.c      |    1 -
 drivers/watchdog/ts72xx_wdt.c     |    6 ++----
 drivers/watchdog/wm831x_wdt.c     |    1 -
 8 files changed, 6 insertions(+), 19 deletions(-)
