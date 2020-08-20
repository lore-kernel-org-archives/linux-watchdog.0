Return-Path: <SRS0=tKlH=B6=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75994C433DF
	for <linux-watchdog@archiver.kernel.org>; Thu, 20 Aug 2020 02:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C99C207DA
	for <linux-watchdog@archiver.kernel.org>; Thu, 20 Aug 2020 02:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHTClC (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:41:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTClC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Aug 2020 22:41:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D0FA6B74D5D34CE20B31;
        Thu, 20 Aug 2020 10:40:58 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 10:40:52 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <linux-watchdog@vger.kernel.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>, <guohanjun@huawei.com>,
        <lizefan@huawei.com>
Subject: [PATCH] watchdog: Add interface to config timeout and pretimeout in sysfs
Date:   Thu, 20 Aug 2020 02:38:58 +0000
Message-ID: <20200820023858.10873-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Those interfaces exist already in sysfs of watchdog driver core, but
they are readonly. This patch add write hook so we can config timeout
and pretimeout by writing those files.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/watchdog/watchdog_dev.c | 48 +++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 10b2090f3e5e..bb8ddc71d4ea 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -485,7 +485,29 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "%u\n", wdd->timeout);
 }
-static DEVICE_ATTR_RO(timeout);
+
+static ssize_t timeout_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	unsigned int val;
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&wd_data->lock);
+	ret = watchdog_set_timeout(wdd, val);
+	mutex_unlock(&wd_data->lock);
+
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(timeout);
 
 static ssize_t pretimeout_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -494,7 +516,29 @@ static ssize_t pretimeout_show(struct device *dev,
 
 	return sprintf(buf, "%u\n", wdd->pretimeout);
 }
-static DEVICE_ATTR_RO(pretimeout);
+
+static ssize_t pretimeout_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	unsigned int val;
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&wd_data->lock);
+	ret = watchdog_set_pretimeout(wdd, val);
+	mutex_unlock(&wd_data->lock);
+
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(pretimeout);
 
 static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
-- 
2.25.0

