Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36758 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbbICLHY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 07:07:24 -0400
Date: Thu, 3 Sep 2015 13:07:22 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/3] watchdog: gef_wdt: Fix module autoload for OF platform
 driver
Message-ID: <20150903110722.GA17450@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/watchdog/gef_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index cc1bdfc..006e234 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -303,6 +303,7 @@ static const struct of_device_id gef_wdt_ids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, gef_wdt_ids);
 
 static struct platform_driver gef_wdt_driver = {
 	.driver = {
-- 
2.4.6

