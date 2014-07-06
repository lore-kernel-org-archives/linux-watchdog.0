Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-samsung-soc@vger.kernel.org, Tomasz Figa <t.figa@samsung.com>, Mike Turquette <mturquette@linaro.org>
Subject: [RFC PATCH 1/3] watchdog: s3c2410: add restart notifier
Date: Sun, 06 Jul 2014 20:42:50 +0200
Message-ID: <10183342.ZfePbPvRx9@diego>
In-Reply-To: <1531376.ijR0PPyvmJ@diego>
References: <1531376.ijR0PPyvmJ@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On a lot of Samsung systems the watchdog is responsible for restarting the
system and until now this code was contained in plat-samsung/watchdog-reset.c .

With the introduction of the restart notifiers, this code can now move into
driver itself, removing the need for arch-specific code.

Tested on a S3C2442 based GTA02
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/watchdog/s3c2410_wdt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 7c6ccd0..3f89912 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -41,6 +41,7 @@
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 #define S3C2410_WTCON		0x00
 #define S3C2410_WTDAT		0x04
@@ -438,6 +439,31 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
 }
 #endif
 
+static struct s3c2410_wdt *s3c2410wdt_restart_ctx;
+static int s3c2410wdt_restart_notify(struct notifier_block *this,
+				     unsigned long mode, void *cmd)
+{
+	void __iomem *wdt_base = s3c2410wdt_restart_ctx->reg_base;
+
+	/* disable watchdog, to be safe  */
+	writel(0, wdt_base + S3C2410_WTCON);
+
+	/* put initial values into count and data */
+	writel(0x80, wdt_base + S3C2410_WTCNT);
+	writel(0x80, wdt_base + S3C2410_WTDAT);
+
+	/* set the watchdog to go and reset... */
+	writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
+		S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
+		wdt_base + S3C2410_WTCON);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block s3c2410wdt_restart_notifier = {
+	.notifier_call = s3c2410wdt_restart_notify,
+};
+
 static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 {
 	unsigned int rst_stat;
@@ -592,6 +618,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 
+	s3c2410wdt_restart_ctx = wdt;
+	ret = register_restart_notifier(&s3c2410wdt_restart_notifier);
+	if (ret)
+		pr_err("cannot register restart notifier, %d\n", ret);
+
 	/* print out a statement of readiness */
 
 	wtcon = readl(wdt->reg_base + S3C2410_WTCON);
@@ -621,6 +652,8 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 	int ret;
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	unregister_restart_notifier(&s3c2410wdt_restart_notifier);
+
 	ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
 	if (ret < 0)
 		return ret;
-- 
1.9.0
