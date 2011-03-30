From: John Crispin <blogic@openwrt.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH V5 05/10] MIPS: lantiq: add watchdog support
Date: Wed, 30 Mar 2011 09:27:51 +0200
Message-Id: <1301470076-17279-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

This patch adds the driver for the watchdog found inside the Lantiq SoC family.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-mips@linux-mips.org
Cc: linux-watchdog@vger.kernel.org

---

Changes in V2
* add comments to explain register access
* cleanup resource allocation
* cleanup clock handling
* whitespace fixes

Changes in V3
* whitespace
* change __iomem void to void __iomem
* typo fixes
* comment style
* fix exit path in init function

Changes in V4
* fixes register offsets (we use a smaller memory window)
* typo in the comments
* add __init to probe function

 drivers/watchdog/Kconfig      |    6 +
 drivers/watchdog/Makefile     |    1 +
 drivers/watchdog/lantiq_wdt.c |  217 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/lantiq_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b69d714..cee7738 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -990,6 +990,12 @@ config BCM63XX_WDT
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called bcm63xx_wdt.
 
+config LANTIQ_WDT
+	tristate "Lantiq SoC watchdog"
+	depends on LANTIQ
+	help
+	  Hardware driver for the Lantiq SoC Watchdog Timer.
+
 # PARISC Architecture
 
 # POWERPC Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d520bf9..0d84e48 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
+obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 
 # PARISC Architecture
 
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
new file mode 100644
index 0000000..0a78dfb
--- /dev/null
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -0,0 +1,217 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Based on EP93xx wdt driver
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <lantiq.h>
+
+/* Section 3.4 of the datasheet
+ * The password sequence protects the WDT control register from unintended
+ * write actions, which might cause malfunction of the WDT.
+ *
+ * essentially the following two magic passwords need to be written to allow
+ * io access to the wdt core
+ */
+#define LTQ_WDT_PW1		0x00BE0000
+#define LTQ_WDT_PW2		0x00DC0000
+
+#define LTQ_WDT_CR		0x0	/* watchdog control register */
+#define LTQ_WDT_SR		0x8	/* watchdog status register */
+
+#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
+#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
+#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
+						/* divider to 0x40000 */
+#define LTQ_WDT_DIVIDER		0x40000
+#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+static int ltq_wdt_ok_to_close;
+#endif
+
+static int ltq_wdt_timeout = 30;
+static void __iomem *ltq_wdt_membase;
+static unsigned long ltq_io_region_clk_rate;
+
+static void
+ltq_wdt_enable(unsigned int timeout)
+{
+	timeout = ((timeout * (ltq_io_region_clk_rate / LTQ_WDT_DIVIDER))
+		+ 0x1000);
+	if (timeout > LTQ_MAX_TIMEOUT)
+		timeout = LTQ_MAX_TIMEOUT;
+
+	/* write the first password magic */
+	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	/* write the second magic plus the configuration and new timeout */
+	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
+		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
+}
+
+static void
+ltq_wdt_disable(void)
+{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	ltq_wdt_ok_to_close = 0;
+#endif
+	/* write the first password magic */
+	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	/* write the second password magic with no config
+	 * this turns the watchdog off
+	 */
+	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
+}
+
+static ssize_t
+ltq_wdt_write(struct file *file, const char __user *data,
+		size_t len, loff_t *ppos)
+{
+	size_t i;
+
+	if (!len)
+		return 0;
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	for (i = 0; i != len; i++) {
+		char c;
+
+		if (get_user(c, data + i))
+			return -EFAULT;
+		if (c == 'V')
+			ltq_wdt_ok_to_close = 1;
+	}
+#endif
+	ltq_wdt_enable(ltq_wdt_timeout);
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "ltq_wdt",
+};
+
+static long
+ltq_wdt_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOTTY;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
+				sizeof(ident)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(ltq_wdt_timeout, (int __user *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(ltq_wdt_timeout, (int __user *)arg);
+		if (!ret)
+			ltq_wdt_enable(ltq_wdt_timeout);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ltq_wdt_enable(ltq_wdt_timeout);
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+static int
+ltq_wdt_open(struct inode *inode, struct file *file)
+{
+	ltq_wdt_enable(ltq_wdt_timeout);
+	return nonseekable_open(inode, file);
+}
+
+static int
+ltq_wdt_release(struct inode *inode, struct file *file)
+{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (ltq_wdt_ok_to_close)
+		ltq_wdt_disable();
+	else
+#endif
+		pr_err("ltq_wdt: watchdog closed without warning\n");
+	return 0;
+}
+
+static const struct file_operations ltq_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.write		= ltq_wdt_write,
+	.unlocked_ioctl	= ltq_wdt_ioctl,
+	.open		= ltq_wdt_open,
+	.release	= ltq_wdt_release,
+	.llseek		= no_llseek,
+};
+
+static struct miscdevice ltq_wdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &ltq_wdt_fops,
+};
+
+static int __init
+ltq_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct clk *clk;
+
+	if (!res) {
+		dev_err(&pdev->dev, "cannot obtain I/O memory region");
+		return -ENOENT;
+	}
+	res = devm_request_mem_region(&pdev->dev, res->start,
+		resource_size(res), dev_name(&pdev->dev));
+	if (!res) {
+		dev_err(&pdev->dev, "cannot request I/O memory region");
+		return -EBUSY;
+	}
+	ltq_wdt_membase = devm_ioremap_nocache(&pdev->dev, res->start,
+		resource_size(res));
+	if (!ltq_wdt_membase) {
+		dev_err(&pdev->dev, "cannot remap I/O memory region\n");
+		return -ENOMEM;
+	}
+	/* we do not need to enable the clock as it is always running */
+	clk = clk_get(&pdev->dev, "io");
+	BUG_ON(!clk);
+	ltq_io_region_clk_rate = clk_get_rate(clk);
+	clk_put(clk);
+	return misc_register(&ltq_wdt_miscdev);
+}
+
+static struct platform_driver ltq_wdt_driver = {
+	.driver = {
+		.name = "ltq_wdt",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init
+init_ltq_wdt(void)
+{
+	return platform_driver_probe(&ltq_wdt_driver, ltq_wdt_probe);
+}
+
+module_init(init_ltq_wdt);
+
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("Lantiq SoC Watchdog");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.2.3
