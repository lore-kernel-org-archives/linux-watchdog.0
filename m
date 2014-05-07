Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16901 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbaEGImX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 May 2014 04:42:23 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700ILY46M8I30@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 07 May 2014 17:42:22 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Michal Simek' <michal.simek@xilinx.com>
Subject: [PATCH] watchdog: xilinx: Make of_device_id array const
Date: Wed, 07 May 2014 17:42:22 +0900
Message-id: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/of_xilinx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 57ccae8..1e6e28d 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -225,7 +225,7 @@ static int xwdt_remove(struct platform_device *pdev)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id xwdt_of_match[] = {
+static const struct of_device_id xwdt_of_match[] = {
 	{ .compatible = "xlnx,xps-timebase-wdt-1.00.a", },
 	{ .compatible = "xlnx,xps-timebase-wdt-1.01.a", },
 	{},
-- 
1.7.10.4


