Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43043 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbbLUXTO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 18:19:14 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v3 7/8] watchdog: mei_wdt: add activation debugfs entry
Date: Tue, 22 Dec 2015 01:18:00 +0200
Message-Id: <1450739881-3923-8-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
References: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add entry for displaying whether the device has activated or
deactivated watchdog fw application.

cat <debugfs>/mei_wdt/activation
activated | deactivated

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series

 drivers/watchdog/mei_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 3cd80aa75db1..88511ef68b67 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -548,6 +548,28 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
+static ssize_t mei_dbgfs_read_activation(struct file *file, char __user *ubuf,
+					size_t cnt, loff_t *ppos)
+{
+	struct mei_wdt *wdt = file->private_data;
+	const size_t bufsz = 32;
+	char buf[bufsz];
+	ssize_t pos = 0;
+
+	mutex_lock(&wdt->reg_lock);
+	pos += scnprintf(buf + pos, bufsz - pos, "event: %s\n",
+			 wdt->mwd ? "activated" : "deactivated");
+	mutex_unlock(&wdt->reg_lock);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, pos);
+}
+
+static const struct file_operations dbgfs_fops_activation = {
+	.open    = simple_open,
+	.read    = mei_dbgfs_read_activation,
+	.llseek  = generic_file_llseek,
+};
+
 static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
 				    size_t cnt, loff_t *ppos)
 {
@@ -589,6 +611,11 @@ static int dbgfs_register(struct mei_wdt *wdt)
 	if (!f)
 		goto err;
 
+	f = debugfs_create_file("activation",  S_IRUSR,
+				dir, wdt, &dbgfs_fops_activation);
+	if (!f)
+		goto err;
+
 	return 0;
 err:
 	dbgfs_unregister(wdt);
-- 
2.4.3

