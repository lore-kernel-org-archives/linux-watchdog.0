Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:55941 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932889AbcGENYv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:51 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [RFC 5/6] mfd: da9063: save i2c_client for later use
Date: Tue, 5 Jul 2016 15:22:22 +0200
Message-Id: <1467724943-13416-6-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Save i2c_client for later use in watchdog restart handler. The regmap
interface cannot be used there.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/mfd/da9063-i2c.c        | 1 +
 include/linux/mfd/da9063/core.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 6f3a7c0..c0f53d2 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -224,6 +224,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, da9063);
 	da9063->dev = &i2c->dev;
 	da9063->chip_irq = i2c->irq;
+	da9063->i2c = i2c;
 
 	if (da9063->variant_code == PMIC_DA9063_AD) {
 		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 79f4d82..1d1ae5d 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -83,6 +83,7 @@ struct da9063 {
 
 	/* Control interface */
 	struct regmap	*regmap;
+	struct i2c_client *i2c;
 
 	/* Interrupts */
 	int		chip_irq;
-- 
1.9.1

