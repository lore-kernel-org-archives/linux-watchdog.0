Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.scalarmail.ca ([98.158.95.75]:3642 "EHLO
	ironport-01.sms.scalar.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751713Ab1LSQcZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Dec 2011 11:32:25 -0500
From: Nick Bowler <nbowler@elliptictech.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: sp805: Fix section mismatch in ID table.
Date: Mon, 19 Dec 2011 11:22:36 -0500
Message-Id: <1324311756-15815-1-git-send-email-nbowler@elliptictech.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The AMBA ID table is marked as __initdata, yet it is referenced by the
driver struct which is not.  This causes a (somewhat unhelpful) section
mismatch warning:

  WARNING: drivers/watchdog/sp805_wdt.o(.data+0x4c): Section mismatch in
           reference from the variable sp805_wdt_driver to the (unknown
           reference) .init.data:(unknown)

Fix this by removing the annotation.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
 drivers/watchdog/sp805_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index cc2cfbe..bfaf9bb 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -351,7 +351,7 @@ static int __devexit sp805_wdt_remove(struct amba_device *adev)
 	return 0;
 }
 
-static struct amba_id sp805_wdt_ids[] __initdata = {
+static struct amba_id sp805_wdt_ids[] = {
 	{
 		.id	= 0x00141805,
 		.mask	= 0x00ffffff,
-- 
1.7.3.4


