Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <541ABD07.5090407@elproma.com.pl>
Date: Thu, 18 Sep 2014 13:07:51 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: watchdog's pm support preffered implementation
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net> <54196BE2.2010800@elproma.com.pl>
In-Reply-To: <54196BE2.2010800@elproma.com.pl>
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

I work under suspend/resume PM support for stmp3xxx driver.
I checked other drivers:
grep suspend watchdog/* | grep static
watchdog/at32ap700x_wdt.c:static int at32_wdt_suspend(struct 
platform_device *pdev, pm_message_t message)
watchdog/at91rm9200_wdt.c:static int at91wdt_suspend(struct 
platform_device *pdev, pm_message_t message)
watchdog/bfin_wdt.c:static int bfin_wdt_suspend(struct platform_device 
*pdev, pm_message_t state)
watchdog/coh901327_wdt.c:static int coh901327_suspend(struct 
platform_device *pdev, pm_message_t state)
watchdog/dw_wdt.c:static int dw_wdt_suspend(struct device *dev)
watchdog/dw_wdt.c:static SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, 
dw_wdt_suspend, dw_wdt_resume);
watchdog/kempld_wdt.c:static int kempld_wdt_suspend(struct 
platform_device *pdev,
watchdog/ks8695_wdt.c:static int ks8695wdt_suspend(struct 
platform_device *pdev, pm_message_t message)
watchdog/omap_wdt.c:static int omap_wdt_suspend(struct platform_device 
*pdev, pm_message_t state)
watchdog/s3c2410_wdt.c:static int s3c2410wdt_suspend(struct device *dev)
watchdog/s3c2410_wdt.c:static SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops, 
s3c2410wdt_suspend,
watchdog/sirfsoc_wdt.c:static int sirfsoc_wdt_suspend(struct device *dev)
watchdog/sp805_wdt.c:static int __maybe_unused sp805_wdt_suspend(struct 
device *dev)
watchdog/sp805_wdt.c:static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, 
sp805_wdt_suspend,
watchdog/stmp3xxx_rtc_wdt.c:static int stmp3xxx_wdt_suspend(struct 
platform_device *pdev,
watchdog/twl4030_wdt.c:static int twl4030_wdt_suspend(struct 
platform_device *pdev, pm_message_t state)
watchdog/ux500_wdt.c:static int ux500_wdt_suspend(struct platform_device 
*pdev,
watchdog/xen_wdt.c:static int xen_wdt_suspend(struct platform_device 
*dev, pm_message_t state)

Most of them use suspend() with struct platform_device and CONFIG_PM.
Only sp805, sirfsoc, s3c2410, dw drivers use suspend() with struct device
and SIMPLE_DEV_PM_OPS.
Which implementation is preffered today?

best regards
Janusz

P.S. Patch on the moment:
Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
  drivers/watchdog/stmp3xxx_rtc_wdt.c | 41 +++++++++++++++++++++++
  1 file changed, 41 insertions(+)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c 
b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 3546f03..12060ab 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -74,6 +74,7 @@ static int stmp3xxx_wdt_probe(struct platform_device 
*pdev)
  {
         int ret;

+       platform_set_drvdata(pdev, &stmp3xxx_wdd);
         watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);

         stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, 
STMP3XXX_MAX_TIMEOUT);
@@ -95,12 +96,52 @@ static int stmp3xxx_wdt_remove(struct 
platform_device *pdev)
         return 0;
  }

+#ifdef CONFIG_PM
+/* There is no conflict with rtc/rtc-stmp3xxx.c parent
+ * because modified registers in PM functions are different */
+static int stmp3xxx_wdt_suspend(struct platform_device *pdev,
+                                       pm_message_t state)
+{
+       struct watchdog_device *wdd = platform_get_drvdata(pdev);
+
+       /* Is keep-on/ping timer suspended before?
+        * or additional driver-specific flag must be added
+        *  to block watchdog ping in the timer?
+        * or disable WATCHDOG_KEEP_ON before wdt_stop
+        *  and restore it in resume? */
+       if (watchdog_active(wdd)) {
+               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
+               return wdt_stop(wdd);
+       }
+       /* should we use pm_runtime like omap_wdt.c does? */
+
+       return 0;
+}
+
+static int stmp3xxx_wdt_resume(struct platform_device *pdev)
+{
+       struct watchdog_device *wdd = platform_get_drvdata(pdev);
+
+       if (watchdog_active(wdd)) {
+               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
+               return wdt_start(wdd);
+       }
+
+       return 0;
+}
+#else
+#define stmp3xxx_wdt_suspend   NULL
+#define stmp3xxx_wdt_resume    NULL
+#endif
+
  static struct platform_driver stmp3xxx_wdt_driver = {
         .driver = {
                 .name = "stmp3xxx_rtc_wdt",
         },
         .probe = stmp3xxx_wdt_probe,
         .remove = stmp3xxx_wdt_remove,
+       .suspend = stmp3xxx_wdt_suspend,
+       .resume = stmp3xxx_wdt_resume,
  };
  module_platform_driver(stmp3xxx_wdt_driver);
