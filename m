Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39251 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbcFGRi6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 13:38:58 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] watchdog: add pretimeout read-only device attribute to sysfs
Date: Tue, 7 Jun 2016 20:38:44 +0300
Message-ID: <1465321127-19522-4-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The change allows for WDIOF_PRETIMEOUT capable watchdog devices to get
a configured pretimeout value over sysfs, the correspondent device
attribute name is "pretimeout".

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v2 to v3:
* none, new change

Changes from v1 to v2:
* none, new change

 drivers/watchdog/watchdog_dev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 42ab86d..87bbae7 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -443,6 +443,15 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(state);
 
+static ssize_t pretimeout_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", wdd->pretimeout);
+}
+static DEVICE_ATTR_RO(pretimeout);
+
 static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 				int n)
 {
@@ -454,6 +463,9 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 		mode = 0;
 	else if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
 		mode = 0;
+	else if (attr == &dev_attr_pretimeout.attr &&
+		 !(wdd->info->options & WDIOF_PRETIMEOUT))
+		mode = 0;
 
 	return mode;
 }
@@ -465,6 +477,7 @@ static struct attribute *wdt_attrs[] = {
 	&dev_attr_bootstatus.attr,
 	&dev_attr_status.attr,
 	&dev_attr_nowayout.attr,
+	&dev_attr_pretimeout.attr,
 	NULL,
 };
 
-- 
2.5.0

