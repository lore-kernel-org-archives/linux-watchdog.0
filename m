Return-path: <prvs=997fd3939=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric
 Anholt <eric@anholt.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	<linux-watchdog@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] watchdog: bcm2835_wdt: constify _ops and _info structures
Date: Fri, 15 Jul 2016 10:15:21 +0200
Message-ID: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

These are never modified, so might as well be const.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/bcm2835_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 2e6164c..733e402 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -96,7 +96,7 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
 }
 
-static struct watchdog_ops bcm2835_wdt_ops = {
+static const struct watchdog_ops bcm2835_wdt_ops = {
 	.owner =	THIS_MODULE,
 	.start =	bcm2835_wdt_start,
 	.stop =		bcm2835_wdt_stop,
@@ -104,7 +104,7 @@ static struct watchdog_ops bcm2835_wdt_ops = {
 	.get_timeleft =	bcm2835_wdt_get_timeleft,
 };
 
-static struct watchdog_info bcm2835_wdt_info = {
+static const struct watchdog_info bcm2835_wdt_info = {
 	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
 			WDIOF_KEEPALIVEPING,
 	.identity =	"Broadcom BCM2835 Watchdog timer",
-- 
2.5.0
