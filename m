Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41352 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbcAGWuz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jan 2016 17:50:55 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v4 6/7] watchdog: mei_wdt: add activation debugfs entry
Date: Fri,  8 Jan 2016 00:49:26 +0200
Message-Id: <1452206967-1144-7-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
References: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add entry for displaying whether the device has activated or
deactivated watchdog fw application.

cat <debugfs>/mei_wdt/activation
activated | deactivated

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series
V4: Rebase the code over patchset : "watchdog: Replace driver based refcounting"
 drivers/watchdog/mei_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 85b27fc5d4ec..fe683e582566 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -493,6 +493,28 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
+static ssize_t mei_dbgfs_read_activation(struct file *file, char __user *ubuf,
+					size_t cnt, loff_t *ppos)
+{
+	struct mei_wdt *wdt = file->private_data;
+	const size_t bufsz = 32;
+	char buf[bufsz];
+	ssize_t pos;
+
+	mutex_lock(&wdt->reg_lock);
+	pos = scnprintf(buf, bufsz, "%s\n",
+		__mei_wdt_is_registered(wdt) ? "activated" : "deactivated");
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
@@ -532,6 +554,11 @@ static int dbgfs_register(struct mei_wdt *wdt)
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

