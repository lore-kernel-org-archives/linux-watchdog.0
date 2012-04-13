Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12650 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758026Ab2DMJQ4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Apr 2012 05:16:56 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3D9GuFL019165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Apr 2012 05:16:56 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] sch56xx-watchdog: Remove unnecessary checks for register changes
Date: Fri, 13 Apr 2012 11:19:07 +0200
Message-Id: <1334308750-2859-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1334308750-2859-1-git-send-email-hdegoede@redhat.com>
References: <1334308750-2859-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since the watchdog core keeps track of the watchdog's active state, start/stop
will never get called when no changes are necessary. So we can remove the
check for the output_enable register changing before writing it (which is
an expensive operation).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch56xx-common.c |   41 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index c7de81a..29020f2 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -334,18 +334,14 @@ static int watchdog_start(struct watchdog_device *wddev)
 	if (ret)
 		goto leave;
 
-	/* 2. Enable output (if not already enabled) */
-	if (!(data->watchdog_output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)) {
-		val = data->watchdog_output_enable |
-		      SCH56XX_WDOG_OUTPUT_ENABLE;
-		ret = sch56xx_write_virtual_reg(data->addr,
-						SCH56XX_REG_WDOG_OUTPUT_ENABLE,
-						val);
-		if (ret)
-			goto leave;
+	/* 2. Enable output */
+	val = data->watchdog_output_enable | SCH56XX_WDOG_OUTPUT_ENABLE;
+	ret = sch56xx_write_virtual_reg(data->addr,
+					SCH56XX_REG_WDOG_OUTPUT_ENABLE, val);
+	if (ret)
+		goto leave;
 
-		data->watchdog_output_enable = val;
-	}
+	data->watchdog_output_enable = val;
 
 	/* 3. Clear the watchdog event bit if set */
 	val = inb(data->addr + 9);
@@ -377,21 +373,16 @@ static int watchdog_stop(struct watchdog_device *wddev)
 	int ret = 0;
 	u8 val;
 
-	if (data->watchdog_output_enable & SCH56XX_WDOG_OUTPUT_ENABLE) {
-		val = data->watchdog_output_enable &
-		      ~SCH56XX_WDOG_OUTPUT_ENABLE;
-		mutex_lock(data->io_lock);
-		ret = sch56xx_write_virtual_reg(data->addr,
-						SCH56XX_REG_WDOG_OUTPUT_ENABLE,
-						val);
-		mutex_unlock(data->io_lock);
-		if (ret)
-			return ret;
-
-		data->watchdog_output_enable = val;
-	}
+	val = data->watchdog_output_enable & ~SCH56XX_WDOG_OUTPUT_ENABLE;
+	mutex_lock(data->io_lock);
+	ret = sch56xx_write_virtual_reg(data->addr,
+					SCH56XX_REG_WDOG_OUTPUT_ENABLE, val);
+	mutex_unlock(data->io_lock);
+	if (ret)
+		return ret;
 
-	return ret;
+	data->watchdog_output_enable = val;
+	return 0;
 }
 
 static const struct watchdog_ops watchdog_ops = {
-- 
1.7.9.3

