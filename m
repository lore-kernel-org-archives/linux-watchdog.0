Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33195 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbG0Nib (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 09:38:31 -0400
Received: by wicmv11 with SMTP id mv11so139824409wic.0
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2015 06:38:30 -0700 (PDT)
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: [PATCH 5/5] i2c-i801: fixup regarding watchdog timer
Date: Mon, 27 Jul 2015 14:38:12 +0100
Message-Id: <1438004292-16382-6-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Change &array[0] to array since it's the same.

It fixes 80 character limit warning as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c79dbe116ccc..e41005927746 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1173,7 +1173,8 @@ static void i801_add_tco(struct i801_priv *priv)
 	if (!(tco_ctl & TCOCTL_EN))
 		return;
 
-	memset(&tco_res[0], 0, sizeof(tco_res));
+	memset(tco_res, 0, sizeof(tco_res));
+
 	res = &tco_res[ICH_RES_IO_TCO];
 	res->start = tco_base & ~1;
 	res->end = res->start + 32 - 1;
@@ -1226,7 +1227,7 @@ static void i801_add_tco(struct i801_priv *priv)
 	res->flags = IORESOURCE_MEM;
 
 	pdev = platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt", -1,
-						 &tco_res[0], 3, &tco_platform_data,
+						 tco_res, 3, &tco_platform_data,
 						 sizeof(tco_platform_data));
 	if (IS_ERR(pdev)) {
 		dev_warn(&pci_dev->dev, "failed to create iTCO device\n");
-- 
2.1.0

