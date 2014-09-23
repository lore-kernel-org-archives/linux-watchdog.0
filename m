Return-path: <jszhang@marvell.com>
From: Jisheng Zhang <jszhang@marvell.com>
To: <wim@iguana.be>, <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 0/2] watchdog: dw_wdt: one bug fix and restart handler support
Date: Tue, 23 Sep 2014 15:42:10 +0800
Message-ID: <1411458132-5410-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

These patches are intend to improve dw_wdt in the following two aspects:

Firstly, the TOP_INIT, ie bit 4-7 of the WDOG_TIMEOUT_RANGE_REG_OFFSET register
may be zero at reset on some HW, so the timeout period may be very short, thus
we will see immediate system reset after openning the watchdog. Fix this
problem by also initialising the TOP_INIT when setting TOP.

Secondly, the WDT can also be used to reboot the system with the help of
recently introduced restart handler.

Tested on Marvell BG2Q DMP board.

Changes since v1:
  - add some wait to let the reset catch, suggested by Guenter Roeck
  - setting TOP_INIT as well when setting TOP in function dw_wdt_set_top to
    fix the reboot soon issue.

Jisheng Zhang (2):
  watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()
  watchdog: dw_wdt: add restart handler support

 drivers/watchdog/dw_wdt.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

-- 
2.1.0
