Return-Path: <andre.draszik@gmail.com>
Return-path: <andre.draszik@gmail.com>
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/2] watchdog: mt7621: set WDOG_HW_RUNNING bit when appropriate
Date: Fri, 12 Jan 2018 09:44:53 +0000
Message-Id: <20180112094454.5518-1-git@andred.net>
In-Reply-To: <20180110121323.17657-1-git@andred.net>
References: <20180110121323.17657-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

If the watchdog hardware is enabled/running during boot, e.g.
due to a boot loader configuring it, we must tell the
watchdog framework about this fact so that it can ping the
watchdog until userspace opens the device and takes over
control.

Do so using the WDOG_HW_RUNNING flag that exists for exactly
that use-case.

Given the watchdog driver core doesn't know what timeout was
originally set by whoever started the watchdog (boot loader),
we make sure to update the timeout in the hardware according
to what the watchdog core thinks it is.

Signed-off-by: André Draszik <git@andred.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: John Crispin <john@phrozen.org>

---
Changes in v2:
- fix typo and proper multi-line comment
- update commit message to be clearer
---
 drivers/watchdog/mt7621_wdt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index db38f8017218..eec57e5e1eae 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -105,6 +105,11 @@ static int mt7621_wdt_bootcause(void)
 	return 0;
 }
 
+static int mt7621_wdt_is_running(struct watchdog_device *w)
+{
+	return !!(rt_wdt_r32(TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
+}
+
 static const struct watchdog_info mt7621_wdt_info = {
 	.identity = "Mediatek Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
@@ -144,6 +149,20 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
 			      &pdev->dev);
 	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
+	if (mt7621_wdt_is_running(&mt7621_wdt_dev)) {
+		/*
+		 * Make sure to apply timeout from watchdog core, taking
+		 * the prescaler of this driver here into account (the
+		 * boot loader might be using a different prescaler).
+		 *
+		 * To avoid spurious resets because of different scaling,
+		 * we first disable the watchdog, set the new prescaler
+		 * and timeout, and then re-enable the watchdog.
+		 */
+		mt7621_wdt_stop(&mt7621_wdt_dev);
+		mt7621_wdt_start(&mt7621_wdt_dev);
+		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
+	}
 
 	ret = watchdog_register_device(&mt7621_wdt_dev);
 
-- 
2.15.1
