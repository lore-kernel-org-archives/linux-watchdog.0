Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from leibniz.telenet-ops.be ([195.130.137.77]:42635 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbcHSCEa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 18 Aug 2016 22:04:30 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by leibniz.telenet-ops.be (Postfix) with ESMTP id 3sFYBq6tPFzMqvLr
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Aug 2016 19:34:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] spi: spi-txx9: Add missing clock (un)prepare calls for CCF
Date: Thu, 18 Aug 2016 19:34:25 +0200
Message-Id: <1471541667-30689-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

While the custom minimal TXx9 clock implementation doesn't need or use
clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
they are mandatory when using the Common Clock Framework.

Hence add them, to prepare for the advent of CCF.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested due to lack of hardware.
---
 drivers/spi/spi-txx9.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 7492ea346b43ed5b..51759d3fd45f6b06 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -346,7 +346,7 @@ static int txx9spi_probe(struct platform_device *dev)
 		c->clk = NULL;
 		goto exit;
 	}
-	ret = clk_enable(c->clk);
+	ret = clk_prepare_enable(c->clk);
 	if (ret) {
 		c->clk = NULL;
 		goto exit;
@@ -395,7 +395,7 @@ static int txx9spi_probe(struct platform_device *dev)
 exit_busy:
 	ret = -EBUSY;
 exit:
-	clk_disable(c->clk);
+	clk_disable_unprepare(c->clk);
 	spi_master_put(master);
 	return ret;
 }
@@ -406,7 +406,7 @@ static int txx9spi_remove(struct platform_device *dev)
 	struct txx9spi *c = spi_master_get_devdata(master);
 
 	flush_work(&c->work);
-	clk_disable(c->clk);
+	clk_disable_unprepare(c->clk);
 	return 0;
 }
 
-- 
1.9.1

