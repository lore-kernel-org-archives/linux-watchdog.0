Return-path: <jpitti@cisco.com>
From: Julius Hemanth Pitti <jpitti@cisco.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: xe-kernel@external.cisco.com, jpitti@mvista.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] watchdog: iTCO_wdt: Introduce panic_on_timeout module param
Date: Tue,  6 Dec 2016 04:18:15 +0530
Message-Id: <20161205224815.23335-1-jpitti@cisco.com>
List-ID: <linux-watchdog@vger.kernel.org>

Currently iTCO_wdt silently resets the board when timeout
occurs.

This patch introduces new "panic_on_timeout" module param,
which when set allows the iTCO_wdt to call panic when
watchdog timeout occurs, this help to boot to crash
kernel and collect core dump for further analysis.

Cc: xe-kernel@external.cisco.com
Cc: jpitti@mvista.com
Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
---
 drivers/watchdog/iTCO_wdt.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 06fcb6c..23ddcf4 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -66,6 +66,7 @@
 #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For inb/outb/... */
+#include <linux/nmi.h>
 #include <linux/platform_data/itco_wdt.h>
 
 #include "iTCO_vendor.h"
@@ -76,6 +77,24 @@
 /* SMI Control and Enable Register */
 #define SMI_EN		(iTCO_wdt_private.smi_res->start)
 
+static int panic_on_timeout;
+module_param(panic_on_timeout, int, 0);
+MODULE_PARM_DESC(panic_on_timeout,
+		 "Panic on NMI instead of Reset (1 = panic), default=0.");
+
+/* NMI2SMI_EN is bit 9 of TCO1_CNT register
+ * Read/Write
+ * 0 = Normal NMI functionality.
+ * 1 = Forces all NMIs to instead cause SMIs
+ *     This depends on NMI_EN and GBL_SMI_EN bits.
+ */
+#define NMI2SMI_EN	(1 << 9)
+
+/* NMI_NOW is bit 8 of TCO1_CNT register.
+ * Read/'Write to Clear'
+ */
+#define NMI_NOW		(1 << 8)
+
 #define TCO_RLD		(TCOBASE + 0x00) /* TCO Timer Reload and Curr. Value */
 #define TCOv1_TMR	(TCOBASE + 0x01) /* TCOv1 Timer Initial Value	*/
 #define TCO_DAT_IN	(TCOBASE + 0x02) /* TCO Data In Register	*/
@@ -236,6 +255,15 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 	val &= 0xf7ff;
 	outw(val, TCO1_CNT);
 	val = inw(TCO1_CNT);
+
+	if (panic_on_timeout) {
+		/* Make sure NMIs are allowed to fire */
+		if (NMI2SMI_EN & val) {
+			val &= ~(NMI2SMI_EN);
+			outw(val, TCO1_CNT);
+			pr_info("NMIs are no longer routed to SMIs\n");
+		}
+	}
 	spin_unlock(&iTCO_wdt_private.io_lock);
 
 	if (val & 0x0800)
@@ -422,6 +450,26 @@ static void iTCO_wdt_cleanup(void)
 	iTCO_wdt_private.gcs_pmc = NULL;
 }
 
+/*
+ * iTCO_wdt_timeout_handler: Handler for watchdog timeout NMI event.
+ */
+int iTCO_wdt_timeout_handler(unsigned int ulReason, struct pt_regs *regs)
+{
+	unsigned long val32 = inw(TCO1_CNT);
+
+	if (val32 & NMI_NOW) {
+		/* Clear NMI - Bit 8 within TCO1_CNT is write to clear */
+		outw(val32, TCO1_CNT);
+
+		/* Crash the system */
+		nmi_panic(regs, "iTCO_wdt: Watchdog timeout");
+
+		/* Never returns */
+		return NMI_HANDLED;
+	}
+	return NMI_DONE;
+}
+
 static int iTCO_wdt_probe(struct platform_device *dev)
 {
 	int ret = -ENODEV;
@@ -552,11 +600,21 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 		goto unreg_tco;
 	}
 
+	if (panic_on_timeout) {
+		ret = register_nmi_handler(NMI_UNKNOWN, iTCO_wdt_timeout_handler, 0, "iTCO_wdt");
+		if (ret != 0) {
+			pr_err("cannot register NMI Handler for iTCO_wdt watchdog (err=%d)\n", ret);
+			goto unreg_wd;
+		}
+	}
+
 	pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
 		heartbeat, nowayout);
 
 	return 0;
 
+unreg_wd:
+	watchdog_unregister_device(&iTCO_wdt_watchdog_dev);
 unreg_tco:
 	release_region(iTCO_wdt_private.tco_res->start,
 			resource_size(iTCO_wdt_private.tco_res));
@@ -581,6 +639,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 
 static int iTCO_wdt_remove(struct platform_device *dev)
 {
+	if (panic_on_timeout)
+		unregister_nmi_handler(NMI_UNKNOWN, "iTCO_wdt");
+
 	if (iTCO_wdt_private.tco_res || iTCO_wdt_private.smi_res)
 		iTCO_wdt_cleanup();
 
-- 
2.10.1
