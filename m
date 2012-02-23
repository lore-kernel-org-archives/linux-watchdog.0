From: John Crispin <blogic@openwrt.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH V2 12/14] WDT: MIPS: lantiq: convert watchdog driver to clkdev api
Date: Thu, 23 Feb 2012 17:03:11 +0100
Message-Id: <1330012993-13510-12-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Refrence the IO region clock via its new access function.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/lantiq_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 9c8b10c..fa4866b 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -206,7 +206,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* we do not need to enable the clock as it is always running */
-	clk = clk_get(&pdev->dev, "io");
+	clk = clk_get_io();
 	WARN_ON(!clk);
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
-- 
1.7.7.1
