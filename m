Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de
Subject: [PATCH 0/6] watchdog: da9062: Improve support
Date: Tue, 17 Oct 2017 17:30:21 +0200
Message-Id: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

This series generally improves the support for the da9062 watchdog. In
default the watchdog would not restart the SoC. We add support for that.
With this series it registers a system restart handler. We also use the
protection delay mechanism from the watchdog core, instead of using our
own routine.

Michael Grzeschik (4):
  watchdog: da9062: Add restart handler support
  watchdog: da9062: Disable and wait before changing timeout
  watchdog: da9062: use protection delay mechanism from core
  watchdog: da9062: add protective delay before stop

Stefan Christ (2):
  mfd: da9062: make register CONFIG_I writable
  watchdog: da9062: reset board on watchdog timeout

 drivers/mfd/da9062-core.c     |  4 +++
 drivers/watchdog/da9062_wdt.c | 64 +++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.11.0
