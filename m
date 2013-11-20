Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13109 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab3KTWei (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 Nov 2013 17:34:38 -0500
From: Bibek Basu <bbasu@nvidia.com>
To: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<lee.jones@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Bibek Basu <bbasu@nvidia.com>
Subject: [PATCH 1/2] mfd: as3722: add watchdog support
Date: Thu, 21 Nov 2013 04:03:29 +0530
Message-ID: <1384986810-10952-1-git-send-email-bbasu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog device support for as3722

Signed-off-by: Bibek Basu <bbasu@nvidia.com>
---
 drivers/mfd/as3722.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index f161f2e..cfbdeda 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -74,6 +74,9 @@ static struct mfd_cell as3722_devs[] = {
 	{
 		.name = "as3722-power-off",
 	},
+	{
+		.name = "as3722-wdt",
+	},
 };
 
 static const struct regmap_irq as3722_irqs[] = {
-- 
1.8.1.5

