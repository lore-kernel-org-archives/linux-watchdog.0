Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Oct 2017 16:20:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: lpc18xx_wdt: Convert timers to use timer_setup()
Message-ID: <20171016232007.GA100300@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/lpc18xx_wdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 3b8bb59adf02..b4221f43cd94 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -78,10 +78,10 @@ static int lpc18xx_wdt_feed(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static void lpc18xx_wdt_timer_feed(unsigned long data)
+static void lpc18xx_wdt_timer_feed(struct timer_list *t)
 {
-	struct watchdog_device *wdt_dev = (struct watchdog_device *)data;
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = from_timer(lpc18xx_wdt, t, timer);
+	struct watchdog_device *wdt_dev = &lpc18xx_wdt->wdt_dev;
 
 	lpc18xx_wdt_feed(wdt_dev);
 
@@ -96,7 +96,9 @@ static void lpc18xx_wdt_timer_feed(unsigned long data)
  */
 static int lpc18xx_wdt_stop(struct watchdog_device *wdt_dev)
 {
-	lpc18xx_wdt_timer_feed((unsigned long)wdt_dev);
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+
+	lpc18xx_wdt_timer_feed(&lpc18xx_wdt->timer);
 
 	return 0;
 }
@@ -267,8 +269,7 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 
 	__lpc18xx_wdt_set_timeout(lpc18xx_wdt);
 
-	setup_timer(&lpc18xx_wdt->timer, lpc18xx_wdt_timer_feed,
-		    (unsigned long)&lpc18xx_wdt->wdt_dev);
+	timer_setup(&lpc18xx_wdt->timer, lpc18xx_wdt_timer_feed, 0);
 
 	watchdog_set_nowayout(&lpc18xx_wdt->wdt_dev, nowayout);
 	watchdog_set_restart_priority(&lpc18xx_wdt->wdt_dev, 128);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
