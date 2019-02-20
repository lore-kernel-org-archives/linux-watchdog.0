Return-Path: <SRS0=fu0w=Q3=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D7C43381
	for <linux-watchdog@archiver.kernel.org>; Wed, 20 Feb 2019 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE8A21773
	for <linux-watchdog@archiver.kernel.org>; Wed, 20 Feb 2019 09:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBTJeh (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:34:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:38972 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbfBTJeh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 20 Feb 2019 04:34:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from michaelsh@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 20 Feb 2019 11:34:32 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x1K9YRMe014345;
        Wed, 20 Feb 2019 11:34:29 +0200
From:   michaelsh@mellanox.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v4 1/3] platform_data/mlxreg:   additions for Mellanox watchdog driver.
Date:   Wed, 20 Feb 2019 09:34:22 +0000
Message-Id: <20190220093424.5374-2-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220093424.5374-1-michaelsh@mellanox.com>
References: <20190220093424.5374-1-michaelsh@mellanox.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

There are two new fields added to mlxreg core structure:
features - supported features of device and
identity - device identity name.
Add new defines for watchdog features.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>

---
v1->v2
Change feature name MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START
to MLXREG_CORE_WD_FEATURE_NOWAYOUT
---
v2->v3
1. Move enum enum mlxreg_wdt_type from mlx_wdt driver to common mlxreg.h
2. Add version field to mlxreg_core_platform_data struct.
---
 include/linux/platform_data/mlxreg.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index 19f5cb618c55..31f7c25a44da 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -35,6 +35,19 @@
 #define __LINUX_PLATFORM_DATA_MLXREG_H
 
 #define MLXREG_CORE_LABEL_MAX_SIZE	32
+#define MLXREG_CORE_WD_FEATURE_NOWAYOUT		BIT(0)
+#define MLXREG_CORE_WD_FEATURE_START_AT_BOOT	BIT(1)
+
+/**
+ * enum mlxreg_wdt_type - type of HW watchdog
+ *
+ * TYPE1 HW watchdog implementation exist in old systems.
+ * All new systems have TYPE2 HW watchdog.
+ */
+enum mlxreg_wdt_type {
+	MLX_WDT_TYPE1,
+	MLX_WDT_TYPE2,
+};
 
 /**
  * struct mlxreg_hotplug_device - I2C device data:
@@ -110,11 +123,17 @@ struct mlxreg_core_item {
  * @led_data: led private data;
  * @regmap: register map of parent device;
  * @counter: number of led instances;
+ * @features: supported features of device;
+ * @version: implementation version;
+ * @identity: device identity name;
  */
 struct mlxreg_core_platform_data {
 	struct mlxreg_core_data *data;
 	void *regmap;
 	int counter;
+	u32 features;
+	u32 version;
+	char identity[MLXREG_CORE_LABEL_MAX_SIZE];
 };
 
 /**
-- 
2.11.0

