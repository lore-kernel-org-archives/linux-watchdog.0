Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32979 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbICLGL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 07:06:11 -0400
Date: Thu, 3 Sep 2015 13:06:09 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/3] watchdog: mach-moxart: Fix module autoload for OF
 platform driver
Message-ID: <20150903110609.GA17390@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/watchdog/moxart_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 2789da2..60b0605 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -168,6 +168,7 @@ static const struct of_device_id moxart_watchdog_match[] = {
 	{ .compatible = "moxa,moxart-watchdog" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, moxart_watchdog_match);
 
 static struct platform_driver moxart_wdt_driver = {
 	.probe      = moxart_wdt_probe,
-- 
2.4.6

