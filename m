Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45868 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756827AbdJKCby (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 22:31:54 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: linux@roeck-us.net, wim@iguana.be,
        gregory.clement@free-electrons.com, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/3] watchdog: orion: fix typo
Date: Wed, 11 Oct 2017 15:29:56 +1300
Message-Id: <20171011022958.31268-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Correct typo in comment "insterted" -> "inserted".

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 83af7d6cc37c..ea676d233e1e 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -576,7 +576,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	/*
 	 * Let's make sure the watchdog is fully stopped, unless it's
 	 * explicitly enabled. This may be the case if the module was
-	 * removed and re-insterted, or if the bootloader explicitly
+	 * removed and re-inserted, or if the bootloader explicitly
 	 * set a running watchdog before booting the kernel.
 	 */
 	if (!orion_wdt_enabled(&dev->wdt))
-- 
2.14.2

