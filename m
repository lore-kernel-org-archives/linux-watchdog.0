Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: kernel@pengutronix.de,
	Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/4] watchdog: omap: several cleanups
Date: Mon, 27 Apr 2015 11:22:57 +0200
Message-Id: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

this is v2 of the series I sent on Friday. The changes to the patches
are documented in the respective mails. Thanks to Felipe Balbi and
Guenter Roeck for the feedback. I added Reviewed-by tags for Guenter who
didn't even saw these patches up to now (but who gave a carte blanche).
I assume that's ok and as intended, Guenter?

Best regards
Uwe

Uwe Kleine-König (4):
  watchdog: omap: clearify device tree documentation
  watchdog: omap: use watchdog_init_timeout instead of open coding it
  watchdog: omap: put struct watchdog_device into driver data
  watchdog: omap: simplify assignment of bootstatus

 .../devicetree/bindings/watchdog/omap-wdt.txt      |  9 +--
 drivers/watchdog/omap_wdt.c                        | 66 +++++++++-------------
 2 files changed, 32 insertions(+), 43 deletions(-)

-- 
2.1.4
