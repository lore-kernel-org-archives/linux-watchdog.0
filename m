Return-path: <krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] watchdog: s3c2410: Minor code cleanup
Date: Mon, 13 Mar 2017 21:07:26 +0200
Message-Id: <20170313190726.2988-4-krzk@kernel.org>
In-Reply-To: <20170313190726.2988-1-krzk@kernel.org>
References: <20170313190726.2988-1-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Cleanup the code from minor readability issues (no functional changes):
1. Fix checkpatch: ERROR: Do not include the paragraph about writing to
   the Free Software Foundation's mailing address.
2. Fix checkpatch: WARNING: quoted string split across lines
3. Fix chechpatch: WARNING: Prefer 'unsigned int' to bare use of
   'unsigned'
4. Use 'dev' consistently in probe function instead of mixing dev with
   &pdev->dev.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/s3c2410_wdt.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 0532dc93e600..adaa43543f0a 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -1,5 +1,4 @@
-/* linux/drivers/char/watchdog/s3c2410_wdt.c
- *
+/*
  * Copyright (c) 2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
@@ -17,11 +16,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+ */
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -95,8 +90,7 @@ MODULE_PARM_DESC(tmr_atboot,
 			__MODULE_STRING(S3C2410_WATCHDOG_ATBOOT));
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
-			"0 to reboot (default 0)");
+MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");
 
 /**
  * struct s3c2410_wdt_variant - Per-variant config data
@@ -311,7 +305,8 @@ static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
 	return readl(wdt->reg_base + S3C2410_WTCON) & S3C2410_WTCON_ENABLE;
 }
 
-static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeout)
+static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd,
+				    unsigned int timeout)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
 	unsigned long freq = clk_get_rate(wdt->clock);
@@ -525,7 +520,7 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 
 static int s3c2410wdt_probe(struct platform_device *pdev)
 {
-	struct device *dev;
+	struct device *dev = &pdev->dev;
 	struct s3c2410_wdt *wdt;
 	struct resource *wdt_mem;
 	struct resource *wdt_irq;
@@ -533,13 +528,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	int started = 0;
 	int ret;
 
-	dev = &pdev->dev;
-
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt->dev = &pdev->dev;
+	wdt->dev = dev;
 	spin_lock_init(&wdt->lock);
 	wdt->wdt_device = s3c2410_wdd;
 
@@ -595,7 +588,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	/* see if we can actually set the requested timer margin, and if
 	 * not, try the default value */
 
-	watchdog_init_timeout(&wdt->wdt_device, tmr_margin, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdt_device, tmr_margin, dev);
 	ret = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
 					wdt->wdt_device.timeout);
 	if (ret) {
@@ -604,11 +597,10 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 		if (started == 0)
 			dev_info(dev,
-			   "tmr_margin value out of range, default %d used\n",
-			       S3C2410_WATCHDOG_DEFAULT_TIME);
+				 "tmr_margin value out of range, default %d used\n",
+				 S3C2410_WATCHDOG_DEFAULT_TIME);
 		else
-			dev_info(dev, "default timer value is out of range, "
-							"cannot start\n");
+			dev_info(dev, "default timer value is out of range, cannot start\n");
 	}
 
 	ret = devm_request_irq(dev, wdt_irq->start, s3c2410wdt_irq, 0,
@@ -622,7 +614,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	watchdog_set_restart_priority(&wdt->wdt_device, 128);
 
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
-	wdt->wdt_device.parent = &pdev->dev;
+	wdt->wdt_device.parent = dev;
 
 	ret = watchdog_register_device(&wdt->wdt_device);
 	if (ret) {
@@ -757,7 +749,6 @@ static struct platform_driver s3c2410wdt_driver = {
 
 module_platform_driver(s3c2410wdt_driver);
 
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
-	      "Dimitry Andric <dimitry.andric@tomtom.com>");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, Dimitry Andric <dimitry.andric@tomtom.com>");
 MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
 MODULE_LICENSE("GPL");
-- 
2.9.3
