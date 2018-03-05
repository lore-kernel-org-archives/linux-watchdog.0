Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms@verge.net.au>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v8 2/3] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Mon,  5 Mar 2018 15:30:25 +0000
Message-Id: <1520263826-1937-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1520263826-1937-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520263826-1937-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

Due to commits:
* "ARM: shmobile: Add watchdog support",
* "ARM: shmobile: rcar-gen2: Add watchdog support", and
* "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
we now have everything we needed for the watchdog to work on Gen2 and
RZ/G1.

However, on early revisions of some R-Car Gen2 SoCs, and depending on SMP
configuration, the system may fail to restart on watchdog time-out, and
lock up instead.

Specifically:
  - On R-Car H2 ES1.0 and M2-W ES1.0, watchdog restart fails unless
    only the first CPU core is in use (using e.g. the "maxcpus=1" kernel
    commandline option).
  - On R-Car V2H ES1.1, watchdog restart fails unless SMP is disabled
    completely (using CONFIG_SMP=n during build configuration, or using
    the "nosmp" or "maxcpus=0" kernel commandline options).

This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
Gen2 and RZ/G1, but also prevents the system from using the watchdog
driver in cases where the system would fail to restart by blacklisting
the affected SoCs, using the minimum known working revisions (ES2.0 on R-Car
H2, and ES3.0 on M2-W), and taking the actual SMP software configuration
into account.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
[Geert: blacklisting logic]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v7->v8:
* folded patch "watchdog: renesas_wdt: Blacklist early R-Car Gen2 SoCs" from
  Geert into this patch.

Since Simon only reviewed Geert's patch, and Wolfram and Guenter only reviewed
earlier versions of this patch, I am not including their "Reviewed-by" as they
may disagree with the final result.

Thanks,
Fab

 drivers/watchdog/renesas_wdt.c | 49 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 024d54e..0dede5b 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -16,6 +16,8 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/smp.h>
+#include <linux/sys_soc.h>
 #include <linux/watchdog.h>
 
 #define RWTCNT		0
@@ -121,6 +123,44 @@ static const struct watchdog_ops rwdt_ops = {
 	.get_timeleft = rwdt_get_timeleft,
 };
 
+#if defined(CONFIG_ARCH_RCAR_GEN2) && defined(CONFIG_SMP)
+/*
+ * Watchdog-reset integration is broken on early revisions of R-Car Gen2 SoCs
+ */
+static const struct soc_device_attribute rwdt_quirks_match[] = {
+	{
+		.soc_id = "r8a7790",
+		.revision = "ES1.*",
+		.data = (void *)1,	/* needs single CPU */
+	}, {
+		.soc_id = "r8a7791",
+		.revision = "ES[12].*",
+		.data = (void *)1,	/* needs single CPU */
+	}, {
+		.soc_id = "r8a7792",
+		.revision = "*",
+		.data = (void *)0,	/* needs SMP disabled */
+	},
+	{ /* sentinel */ }
+};
+
+static bool rwdt_blacklisted(struct device *dev)
+{
+	const struct soc_device_attribute *attr;
+
+	attr = soc_device_match(rwdt_quirks_match);
+	if (attr && setup_max_cpus > (uintptr_t)attr->data) {
+		dev_info(dev, "Watchdog blacklisted on %s %s\n", attr->soc_id,
+			 attr->revision);
+		return true;
+	}
+
+	return false;
+}
+#else /* !CONFIG_ARCH_RCAR_GEN2 || !CONFIG_SMP */
+static inline bool rwdt_blacklisted(struct device *dev) { return false; }
+#endif /* !CONFIG_ARCH_RCAR_GEN2 || !CONFIG_SMP */
+
 static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
@@ -129,6 +169,9 @@ static int rwdt_probe(struct platform_device *pdev)
 	unsigned long clks_per_sec;
 	int ret, i;
 
+	if (rwdt_blacklisted(&pdev->dev))
+		return -ENODEV;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -228,12 +271,8 @@ static int __maybe_unused rwdt_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
 
-/*
- * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
- * to work there, one also needs a RESET (RST) driver which does not exist yet
- * due to HW issues. This needs to be solved before adding compatibles here.
- */
 static const struct of_device_id rwdt_ids[] = {
+	{ .compatible = "renesas,rcar-gen2-wdt", },
 	{ .compatible = "renesas,rcar-gen3-wdt", },
 	{ /* sentinel */ }
 };
-- 
2.7.4
