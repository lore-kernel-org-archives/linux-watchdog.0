Return-path: <tomas.winkler@intel.com>
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/7] watchdog: mei_wdt: add status debugfs entry
Date: Thu, 17 Dec 2015 16:49:37 +0200
Message-Id: <1450363780-30008-5-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add entry for dumping current watchdog internal state

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/mei_wdt.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 3c97deb70d90..a3f1c1613c32 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/watchdog.h>
+#include <linux/debugfs.h>
 
 #include <linux/uuid.h>
 #include <linux/mei_cl_bus.h>
@@ -54,6 +55,19 @@ enum mei_wdt_state {
 	MEI_WDT_STOPPING,
 };
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static const char *mei_wdt_state_str(enum mei_wdt_state state)
+{
+	switch (state) {
+	case MEI_WDT_IDLE: return "IDLE";
+	case MEI_WDT_START: return "START";
+	case MEI_WDT_RUNNING: return "RUNNING";
+	case MEI_WDT_STOPPING: return "STOPPING";
+	default: return "unknown";
+	}
+}
+#endif /* CONFIG_DEBUG_FS */
+
 /**
  * struct mei_wdt - mei watchdog driver
  * @wdd: watchdog device
@@ -62,6 +76,8 @@ enum mei_wdt_state {
  * @state: watchdog internal state
  * @cldev: mei watchdog client device
  * @timeout: watchdog current timeout
+ *
+ * @dbgfs_dir: debugfs dir entry
  */
 struct mei_wdt {
 	struct watchdog_device wdd;
@@ -70,6 +86,10 @@ struct mei_wdt {
 	struct mei_cl_device *cldev;
 	enum mei_wdt_state state;
 	u16 timeout;
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *dbgfs_dir;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 /*
@@ -296,6 +316,66 @@ static void mei_wdt_ops_unref(struct watchdog_device *wdd)
 	kref_put(&wdt->refcnt, mei_wdt_release);
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
+				    size_t cnt, loff_t *ppos)
+{
+	struct mei_wdt *wdt = file->private_data;
+	const size_t bufsz = 32;
+	char buf[32];
+	ssize_t pos = 0;
+
+	pos += scnprintf(buf + pos, bufsz - pos, "state: %s\n",
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
+static void dbgfs_deregister(struct mei_wdt *wdt)
+{
+	if (!wdt->dbgfs_dir)
+		return;
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
+	dbgfs_deregister(wdt);
+	return -ENODEV;
+}
+
+#else
+
+static inline void dbgfs_deregister(struct mei_wdt *wdt) {}
+
+static inline int dbgfs_register(struct mei_wdt *wdt)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+
+
 static const struct watchdog_ops wd_ops = {
 	.owner       = THIS_MODULE,
 	.start       = mei_wdt_ops_start,
@@ -348,6 +428,8 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 	if (ret)
 		goto err_disable;
 
+	dbgfs_register(wdt);
+
 	return 0;
 
 err_disable:
@@ -367,6 +449,8 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 
 	kref_put(&wdt->refcnt, mei_wdt_release);
 
+	dbgfs_deregister(wdt);
+
 	mei_cldev_disable(cldev);
 
 	return 0;
-- 
2.4.3
