Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36175 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbbICLGx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 07:06:53 -0400
Date: Thu, 3 Sep 2015 13:06:50 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Johannes Thumshirn <morbidrsa@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/3] watchdog: mena21_wdt: Fix module autoload for OF
 platform driver
Message-ID: <20150903110650.GA17441@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/watchdog/mena21_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index d193a5e..f2861e4 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -252,6 +252,7 @@ static const struct of_device_id a21_wdt_ids[] = {
 	{ .compatible = "men,a021-wdt" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, a21_wdt_ids);
 
 static struct platform_driver a21_wdt_driver = {
 	.probe = a21_wdt_probe,
-- 
2.4.6

