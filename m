Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60212 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1C3Nsj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2011 09:48:39 -0400
Received: by wwa36 with SMTP id 36so1510416wwa.1
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Mar 2011 06:48:38 -0700 (PDT)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: grant.likely@secretlab.ca, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] mpc8xxx_wdt: fix build
Date: Wed, 30 Mar 2011 15:48:22 +0200
Message-Id: <1301492902-12343-1-git-send-email-jacmet@sunsite.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since 1c48a5c93da6313 (dt: Eliminate of_platform_{,un}register_driver)
mpc8xxx_wdt no longer builds as it tries to refer to a 'match' variable
rather than ofdev->dev.of_match that it checks just before.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/watchdog/mpc8xxx_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 6709d72..528bceb 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -195,7 +195,7 @@ static int __devinit mpc8xxx_wdt_probe(struct platform_device *ofdev)
 
 	if (!ofdev->dev.of_match)
 		return -EINVAL;
-	wdt_type = match->data;
+	wdt_type = ofdev->dev.of_match->data;
 
 	if (!freq || freq == -1)
 		return -EINVAL;
-- 
1.7.2.3

