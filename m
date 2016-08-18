Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-clk@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-spi@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
Date: Thu, 18 Aug 2016 19:34:26 +0200
Message-Id: <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
List-ID: <linux-watchdog@vger.kernel.org>

While the custom minimal TXx9 clock implementation doesn't need or use
clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
they are mandatory when using the Common Clock Framework.

Hence add them, to prepare for the advent of CCF.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested on RBTX4927.
---
 drivers/watchdog/txx9wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index c2da880292bc2f32..6f7a9deb27d05d25 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -112,7 +112,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 		txx9_imclk = NULL;
 		goto exit;
 	}
-	ret = clk_enable(txx9_imclk);
+	ret = clk_prepare_enable(txx9_imclk);
 	if (ret) {
 		clk_put(txx9_imclk);
 		txx9_imclk = NULL;
@@ -144,7 +144,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	return 0;
 exit:
 	if (txx9_imclk) {
-		clk_disable(txx9_imclk);
+		clk_disable_unprepare(txx9_imclk);
 		clk_put(txx9_imclk);
 	}
 	return ret;
@@ -153,7 +153,7 @@ exit:
 static int __exit txx9wdt_remove(struct platform_device *dev)
 {
 	watchdog_unregister_device(&txx9wdt);
-	clk_disable(txx9_imclk);
+	clk_disable_unprepare(txx9_imclk);
 	clk_put(txx9_imclk);
 	return 0;
 }
-- 
1.9.1
