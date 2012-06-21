Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52343 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab2FUGpq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jun 2012 02:45:46 -0400
Received: by wibhn6 with SMTP id hn6so284491wib.1
        for <linux-watchdog@vger.kernel.org>; Wed, 20 Jun 2012 23:45:45 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linux-watchdog@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Subject: [PATCH] watchdog: xilinx: Read clock frequency directly from DT node
Date: Thu, 21 Jun 2012 08:45:40 +0200
Message-Id: <1340261140-10166-1-git-send-email-monstr@monstr.eu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do not use clock-frequency property from parent node.
Use it from watchdog node.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 drivers/watchdog/of_xilinx_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 55d2f66..294fb4e 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -297,7 +297,7 @@ static int __devinit xwdt_probe(struct platform_device *pdev)
 
 	no_timeout = 0;
 
-	pfreq = (u32 *)of_get_property(pdev->dev.of_node->parent,
+	pfreq = (u32 *)of_get_property(pdev->dev.of_node,
 					"clock-frequency", NULL);
 
 	if (pfreq == NULL) {
-- 
1.7.0.4

