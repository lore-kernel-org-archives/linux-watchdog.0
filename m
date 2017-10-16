Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:43816 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbdJPU45 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Oct 2017 16:56:57 -0400
Received: by mail-lf0-f51.google.com with SMTP id a16so18494392lfk.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Oct 2017 13:56:57 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5 v2] watchdog: ftwdt010: Add restart support
Date: Mon, 16 Oct 2017 22:54:27 +0200
Message-Id: <20171016205427.4297-5-linus.walleij@linaro.org>
In-Reply-To: <20171016205427.4297-1-linus.walleij@linaro.org>
References: <20171016205427.4297-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This enables the Faraday FTWDT010 to restart the system,
if need be. Set the restart priority for the watchdog to
128.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased, no changes.
---
 drivers/watchdog/ftwdt010_wdt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index 21c3ac7f557a..0be7c2db642d 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -56,6 +56,22 @@ struct ftwdt010_wdt *to_ftwdt010_wdt(struct watchdog_device *wdd)
 	return container_of(wdd, struct ftwdt010_wdt, wdd);
 }
 
+static int ftwdt010_wdt_restart(struct watchdog_device *wdd,
+				unsigned long action, void *data)
+{
+	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
+	u32 enable;
+
+	writel(1, gwdt->base + FTWDT010_WDLOAD);
+	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
+	enable = WDCR_SYS_RST | WDCR_ENABLE;
+	if (gwdt->use_extclk)
+		enable |= WDCR_EXTCLK;
+	writel(enable, gwdt->base + FTWDT010_WDCR);
+
+	return 0;
+}
+
 static int ftwdt010_wdt_start(struct watchdog_device *wdd)
 {
 	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
@@ -118,6 +134,7 @@ static const struct watchdog_ops ftwdt010_wdt_ops = {
 	.stop		= ftwdt010_wdt_stop,
 	.ping		= ftwdt010_wdt_ping,
 	.set_timeout	= ftwdt010_wdt_set_timeout,
+	.restart	= ftwdt010_wdt_restart,
 	.owner		= THIS_MODULE,
 };
 
@@ -190,6 +207,7 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
 	 */
 	gwdt->wdd.timeout = 13U;
 	watchdog_init_timeout(&gwdt->wdd, 0, dev);
+	watchdog_set_restart_priority(&gwdt->wdd, 128);
 
 	reg = readw(gwdt->base + FTWDT010_WDCR);
 	if (reg & WDCR_ENABLE) {
-- 
2.13.6

