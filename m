Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41890 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab2KSSnK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Nov 2012 13:43:10 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-watchdog@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 296/493] watchdog: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:05 -0500
Message-Id: <1353349642-3677-296-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Wim Van Sebroeck <wim@iguana.be> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: Rob Herring <rob.herring@calxeda.com> 
Cc: linux-watchdog@vger.kernel.org 
Cc: devicetree-discuss@lists.ozlabs.org 
---
 drivers/watchdog/mixcomwd.c      | 2 +-
 drivers/watchdog/of_xilinx_wdt.c | 2 +-
 drivers/watchdog/orion_wdt.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index 37e4b52..97d62ee 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -73,7 +73,7 @@
 static struct {
 	int ioport;
 	int id;
-} mixcomwd_io_info[] __devinitdata = {
+} mixcomwd_io_info[] = {
 	/* The Mixcom cards */
 	{0x0d90, MIXCOM_ID},
 	{0x0e90, MIXCOM_ID},
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index fd3e5f6..3ddc4e9 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -393,7 +393,7 @@ static int __devexit xwdt_remove(struct platform_device *dev)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id __devinitdata xwdt_of_match[] = {
+static struct of_device_id xwdt_of_match[] = {
 	{ .compatible = "xlnx,xps-timebase-wdt-1.01.a", },
 	{},
 };
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index e6b7bd2..f722635 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -193,7 +193,7 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 	orion_wdt_stop(&orion_wdt);
 }
 
-static const struct of_device_id orion_wdt_of_match_table[] __devinitdata = {
+static const struct of_device_id orion_wdt_of_match_table[] = {
 	{ .compatible = "marvell,orion-wdt", },
 	{},
 };
-- 
1.8.0

