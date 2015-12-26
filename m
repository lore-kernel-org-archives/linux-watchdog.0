Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/6] watchdog: diag288: Stop re-using watchdog core internal flags
Date: Fri, 25 Dec 2015 16:01:41 -0800
Message-Id: <1451088105-1722-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
References: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

A watchdog driver should not use watchdog subsystem internal flags.
Use a driver variable and flag instead to maintain the watchdog state
and to determine if a suspend operation is possible or not.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/watchdog/diag288_wdt.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 3db9d0e0673d..861d3d3133f8 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -106,6 +106,10 @@ static int __diag288_lpar(unsigned int func, unsigned int timeout,
 	return __diag288(func, timeout, action, 0);
 }
 
+static unsigned long wdt_status;
+
+#define DIAG_WDOG_BUSY	0
+
 static int wdt_start(struct watchdog_device *dev)
 {
 	char *ebc_cmd;
@@ -113,12 +117,17 @@ static int wdt_start(struct watchdog_device *dev)
 	int ret;
 	unsigned int func;
 
+	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status))
+		return -EBUSY;
+
 	ret = -ENODEV;
 
 	if (MACHINE_IS_VM) {
 		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
-		if (!ebc_cmd)
+		if (!ebc_cmd) {
+			clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 			return -ENOMEM;
+		}
 		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
 		ASCEBC(ebc_cmd, MAX_CMDLEN);
 		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
@@ -135,6 +144,7 @@ static int wdt_start(struct watchdog_device *dev)
 
 	if (ret) {
 		pr_err("The watchdog cannot be activated\n");
+		clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 		return ret;
 	}
 	return 0;
@@ -146,6 +156,9 @@ static int wdt_stop(struct watchdog_device *dev)
 
 	diag_stat_inc(DIAG_STAT_X288);
 	ret = __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
+
+	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
+
 	return ret;
 }
 
@@ -220,17 +233,10 @@ static struct watchdog_device wdt_dev = {
  * It makes no sense to go into suspend while the watchdog is running.
  * Depending on the memory size, the watchdog might trigger, while we
  * are still saving the memory.
- * We reuse the open flag to ensure that suspend and watchdog open are
- * exclusive operations
  */
 static int wdt_suspend(void)
 {
-	if (test_and_set_bit(WDOG_DEV_OPEN, &wdt_dev.status)) {
-		pr_err("Linux cannot be suspended while the watchdog is in use\n");
-		return notifier_from_errno(-EBUSY);
-	}
-	if (test_bit(WDOG_ACTIVE, &wdt_dev.status)) {
-		clear_bit(WDOG_DEV_OPEN, &wdt_dev.status);
+	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status)) {
 		pr_err("Linux cannot be suspended while the watchdog is in use\n");
 		return notifier_from_errno(-EBUSY);
 	}
@@ -239,7 +245,7 @@ static int wdt_suspend(void)
 
 static int wdt_resume(void)
 {
-	clear_bit(WDOG_DEV_OPEN, &wdt_dev.status);
+	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 	return NOTIFY_DONE;
 }
 
-- 
2.1.4
