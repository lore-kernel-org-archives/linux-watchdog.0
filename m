Return-Path: <SRS0=QDKL=QN=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA76CC169C4
	for <linux-watchdog@archiver.kernel.org>; Wed,  6 Feb 2019 16:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACC92186A
	for <linux-watchdog@archiver.kernel.org>; Wed,  6 Feb 2019 16:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfBFQuo (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:50:44 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47683 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbfBFQun (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Feb 2019 11:50:43 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from michaelsh@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Feb 2019 18:50:41 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x16GodZv005390;
        Wed, 6 Feb 2019 18:50:40 +0200
From:   michaelsh@mellanox.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 1/3] platform_data/mlxreg:   addittions for mellanox watchdog driver.
Date:   Wed,  6 Feb 2019 16:50:35 +0000
Message-Id: <20190206165037.4346-2-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190206165037.4346-1-michaelsh@mellanox.com>
References: <20190206165037.4346-1-michaelsh@mellanox.com>
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
 include/linux/platform_data/mlxreg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index 19f5cb618c55..e6bb0e2d6efc 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -35,6 +35,8 @@
 #define __LINUX_PLATFORM_DATA_MLXREG_H
 
 #define MLXREG_CORE_LABEL_MAX_SIZE	32
+#define MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START	BIT(0)
+#define MLXREG_CORE_WD_FEATURE_START_AT_BOOT		BIT(1)
 
 /**
  * struct mlxreg_hotplug_device - I2C device data:
@@ -110,11 +112,15 @@ struct mlxreg_core_item {
  * @led_data: led private data;
  * @regmap: register map of parent device;
  * @counter: number of led instances;
+ * @features: supported features of device;
+ * @identity: device identity name;
  */
 struct mlxreg_core_platform_data {
 	struct mlxreg_core_data *data;
 	void *regmap;
 	int counter;
+	u32 features;
+	char identity[MLXREG_CORE_LABEL_MAX_SIZE];
 };
 
 /**
-- 
2.11.0

