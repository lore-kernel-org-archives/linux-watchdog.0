Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbbHREs2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:28 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 01/37] mei: wd: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:34 +0530
Message-Id: <6819f228ae7ee2953a07d001a892ec008f319e86.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/misc/mei/wd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/wd.c b/drivers/misc/mei/wd.c
index 2bc0f5089f82..b346638833b0 100644
--- a/drivers/misc/mei/wd.c
+++ b/drivers/misc/mei/wd.c
@@ -364,6 +364,7 @@ int mei_watchdog_register(struct mei_device *dev)
 
 	int ret;
 
+	amt_wd_dev.parent = dev->dev;
 	/* unlock to perserve correct locking order */
 	mutex_unlock(&dev->device_lock);
 	ret = watchdog_register_device(&amt_wd_dev);
-- 
2.4.3

