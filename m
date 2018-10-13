Return-Path: <khoroshilov@ispras.ru>
Return-path: <khoroshilov@ispras.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org
Subject: [PATCH] watchdog: ts4800: release syscon device node in ts4800_wdt_probe()
Date: Sat, 13 Oct 2018 23:51:03 +0300
Message-Id: <1539463863-21867-1-git-send-email-khoroshilov@ispras.ru>
List-ID: <linux-watchdog@vger.kernel.org>

Put syscon device node when it is not needed anymore.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/watchdog/ts4800_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 2b8de8602b67..89843b16b04a 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -135,6 +135,7 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	/* set regmap and offset to know where to write */
 	wdt->feed_offset = reg;
 	wdt->regmap = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
 	if (IS_ERR(wdt->regmap)) {
 		dev_err(&pdev->dev, "cannot get parent's regmap\n");
 		return PTR_ERR(wdt->regmap);
-- 
2.7.4
