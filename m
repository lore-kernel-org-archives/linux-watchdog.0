Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34156 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700AbcAGWux (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jan 2016 17:50:53 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v4 3/7] watchdog: mei_wdt: add status debugfs entry
Date: Fri,  8 Jan 2016 00:49:23 +0200
Message-Id: <1452206967-1144-4-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
References: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add entry for displaying current watchdog internal state

cat <debugfs>/mei_wdt/state
IDLE|START|RUNNING|STOPPING

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: new in the series
V3: rebase 
V4: cleanup the code 
 drivers/watchdog/mei_wdt.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 32e3e1d55ef3..e7e3f144f2b0 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/debugfs.h>
 #include <linux/watchdog.h>
 
 #include <linux/uuid.h>
@@ -54,6 +55,24 @@ enum mei_wdt_state {
 	MEI_WDT_STOPPING,
 };
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static const char *mei_wdt_state_str(enum mei_wdt_state state)
+{
+	switch (state) {
+	case MEI_WDT_IDLE:
+		return "IDLE";
+	case MEI_WDT_START:
+		return "START";
+	case MEI_WDT_RUNNING:
+		return "RUNNING";
+	case MEI_WDT_STOPPING:
+		return "STOPPING";
+	default:
+		return "unknown";
+	}
+}
+#endif /* CONFIG_DEBUG_FS */
+
 /**
  * struct mei_wdt - mei watchdog driver
  * @wdd: watchdog device
@@ -61,6 +80,8 @@ enum mei_wdt_state {
  * @cldev: mei watchdog client device
  * @state: watchdog internal state
  * @timeout: watchdog current timeout
+ *
+ * @dbgfs_dir: debugfs dir entry
  */
 struct mei_wdt {
 	struct watchdog_device wdd;
@@ -68,6 +89,10 @@ struct mei_wdt {
 	struct mei_cl_device *cldev;
 	enum mei_wdt_state state;
 	u16 timeout;
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *dbgfs_dir;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 /*
@@ -310,6 +335,63 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
+				    size_t cnt, loff_t *ppos)
+{
+	struct mei_wdt *wdt = file->private_data;
+	const size_t bufsz = 32;
+	char buf[bufsz];
+	ssize_t pos;
+
+	pos = scnprintf(buf, bufsz, "state: %s\n",
+			 mei_wdt_state_str(wdt->state));
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, pos);
+}
+
+static const struct file_operations dbgfs_fops_state = {
+	.open = simple_open,
+	.read = mei_dbgfs_read_state,
+	.llseek = generic_file_llseek,
+};
+
+static void dbgfs_unregister(struct mei_wdt *wdt)
+{
+	debugfs_remove_recursive(wdt->dbgfs_dir);
+	wdt->dbgfs_dir = NULL;
+}
+
+static int dbgfs_register(struct mei_wdt *wdt)
+{
+	struct dentry *dir, *f;
+
+	dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (!dir)
+		return -ENOMEM;
+
+	wdt->dbgfs_dir = dir;
+	f = debugfs_create_file("state", S_IRUSR, dir, wdt, &dbgfs_fops_state);
+	if (!f)
+		goto err;
+
+	return 0;
+err:
+	dbgfs_unregister(wdt);
+	return -ENODEV;
+}
+
+#else
+
+static inline void dbgfs_unregister(struct mei_wdt *wdt) {}
+
+static inline int dbgfs_register(struct mei_wdt *wdt)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static int mei_wdt_probe(struct mei_cl_device *cldev,
 			 const struct mei_cl_device_id *id)
 {
@@ -337,6 +419,9 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 	if (ret)
 		goto err_disable;
 
+	if (dbgfs_register(wdt))
+		dev_warn(&cldev->dev, "cannot register debugfs\n");
+
 	return 0;
 
 err_disable:
@@ -356,6 +441,8 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 
 	mei_cldev_disable(cldev);
 
+	dbgfs_unregister(wdt);
+
 	kfree(wdt);
 
 	return 0;
-- 
2.4.3

