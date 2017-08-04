Return-Path: <monstr@monstr.eu>
Return-path: <monstr@monstr.eu>
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/2] watchdog: cadence_wdt: Show information when driver is probed
Date: Fri,  4 Aug 2017 09:39:17 +0200
Message-Id: <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
In-Reply-To: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
In-Reply-To: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
List-ID: <linux-watchdog@vger.kernel.org>

Showing message that driver is loaded is common across drivers.
This change also fixes checkpatch (--strict) warning
"Alignment should match open parenthesis".

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/watchdog/cadence_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index dadd3b0c2d49..064cf7b6c1c5 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -368,7 +368,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, wdt);
 
-	dev_dbg(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
+	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
 		 wdt->regs, cdns_wdt_device->timeout,
 		 nowayout ? ", nowayout" : "");
 
-- 
1.9.1
