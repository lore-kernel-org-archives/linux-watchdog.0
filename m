Return-path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH -next] watchdog: wdat_wdt: Fix warning for using 0 as NULL
Date: Wed, 28 Sep 2016 14:44:55 +0000
Message-Id: <1475073895-10369-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warnings:

drivers/watchdog/wdat_wdt.c:210:66: warning: Using plain integer as NULL pointer
drivers/watchdog/wdat_wdt.c:235:66: warning: Using plain integer as NULL pointer

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/watchdog/wdat_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 6b64645..7ab923f 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -207,7 +207,7 @@ static int wdat_wdt_enable_reboot(struct wdat_wdt *wdat)
 	 * recommeded to make it configurable through hardware register. We
 	 * enable reboot now if it is configrable, just in case.
 	 */
-	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_REBOOT, 0, 0);
+	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_REBOOT, 0, NULL);
 	if (ret && ret != -EOPNOTSUPP) {
 		dev_err(&wdat->pdev->dev,
 			"Failed to enable reboot when watchdog triggers\n");
@@ -232,7 +232,7 @@ static void wdat_wdt_boot_status(struct wdat_wdt *wdat)
 		wdat->wdd.bootstatus = WDIOF_CARDRESET;
 
 	/* Clear the boot status in case BIOS did not do it */
-	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_STATUS, 0, 0);
+	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_STATUS, 0, NULL);
 	if (ret && ret != -EOPNOTSUPP)
 		dev_err(&wdat->pdev->dev, "Failed to clear boot status\n");
 }
