Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1EMTj0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 May 2011 15:39:26 -0400
Received: by wwa36 with SMTP id 36so3208608wwa.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 May 2011 12:39:24 -0700 (PDT)
From: Manuel Lauss <manuel.lauss@googlemail.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2] MIPS: Alchemy: clean up GPIO registers and accessors
Date: Fri, 13 May 2011 21:39:21 +0200
Message-Id: <1305315561-11582-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

remove au_readl/au_writel, remove the predefined GPIO1/2 KSEG1 register
addresses and fix the fallout in all boards and drivers.

Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Please replace the one in mips-queue with this updated version.
Thank you!

V2: - fixed au1550nd.c as well (pb1550/db1550)
    - also fixed the mtx-1 watchdog gpio resource.

 arch/mips/alchemy/devboards/pb1000/board_setup.c |    2 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |    2 +-
 arch/mips/alchemy/mtx-1/platform.c               |    4 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |   27 +--------
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |   71 +++++++++++++++-------
 drivers/mtd/nand/au1550nd.c                      |    3 +-
 drivers/watchdog/mtx-1_wdt.c                     |   21 ++++---
 8 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index 2d85c4b..e64fdcb 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -65,7 +65,7 @@ void __init board_setup(void)
 
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
-	au_writel(0, SYS_PINSTATERD);
+	alchemy_gpio1_input_enable();
 	udelay(100);
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index 83f4621..3b4fa32 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -56,7 +56,7 @@ void __init board_setup(void)
 	sys_clksrc = sys_freqctrl = pin_func = 0;
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
-	au_writel(0, SYS_PINSTATERD);
+	alchemy_gpio1_input_enable();
 	udelay(100);
 
 	/* GPIO201 is input for PCMCIA card detect */
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index cf436ab..3ae984c 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -87,7 +87,7 @@ void __init board_setup(void)
 	au_writel(SYS_PF_NI2, SYS_PINFUNC);
 
 	/* Initialize GPIO */
-	au_writel(0xFFFFFFFF, SYS_TRIOUTCLR);
+	au_writel(~0, KSEG1ADDR(AU1000_SYS_PHYS_ADDR) + SYS_TRIOUTCLR);
 	alchemy_gpio_direction_output(0, 0);	/* Disable M66EN (PCI 66MHz) */
 	alchemy_gpio_direction_output(3, 1);	/* Disable PCI CLKRUN# */
 	alchemy_gpio_direction_output(1, 1);	/* Enable EXT_IO3 */
diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
index 956f946..55628e3 100644
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ b/arch/mips/alchemy/mtx-1/platform.c
@@ -53,8 +53,8 @@ static struct platform_device mtx1_button = {
 
 static struct resource mtx1_wdt_res[] = {
 	[0] = {
-		.start	= 15,
-		.end	= 15,
+		.start	= 215,
+		.end	= 215,
 		.name	= "mtx1-wdt-gpio",
 		.flags	= IORESOURCE_IRQ,
 	}
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 2dfff4f..f260ebe 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -702,7 +702,9 @@ enum soc_au1200_ints {
 #define AU1000_UART1_PHYS_ADDR		0x11200000 /* 0234 */
 #define AU1000_UART2_PHYS_ADDR		0x11300000 /* 0 */
 #define AU1000_UART3_PHYS_ADDR		0x11400000 /* 0123 */
+#define AU1500_GPIO2_PHYS_ADDR		0x11700000 /* 1234 */
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
+#define AU1000_SYS_PHYS_ADDR		0x11900000 /* 01234 */
 #define AU1000_DMA_PHYS_ADDR		0x14002000 /* 012 */
 #define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
 #define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
@@ -717,7 +719,6 @@ enum soc_au1200_ints {
 #define	IRDA_PHYS_ADDR		0x10300000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
-#define	SYS_PHYS_ADDR		0x11900000
 #define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
 #define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
 #define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
@@ -730,8 +731,6 @@ enum soc_au1200_ints {
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
 #define	USBH_PHYS_ADDR		0x10100000
 #define PCI_PHYS_ADDR		0x14005000
-#define GPIO2_PHYS_ADDR		0x11700000
-#define	SYS_PHYS_ADDR		0x11900000
 #define PCI_MEM_PHYS_ADDR	0x400000000ULL
 #define PCI_IO_PHYS_ADDR	0x500000000ULL
 #define PCI_CONFIG0_PHYS_ADDR	0x600000000ULL
@@ -750,8 +749,6 @@ enum soc_au1200_ints {
 #define	IRDA_PHYS_ADDR		0x10300000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
-#define GPIO2_PHYS_ADDR		0x11700000
-#define	SYS_PHYS_ADDR		0x11900000
 #define LCD_PHYS_ADDR		0x15000000
 #define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
 #define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
@@ -765,8 +762,6 @@ enum soc_au1200_ints {
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
 #define	USBH_PHYS_ADDR		0x14020000
 #define PCI_PHYS_ADDR		0x14005000
-#define GPIO2_PHYS_ADDR		0x11700000
-#define	SYS_PHYS_ADDR		0x11900000
 #define PE_PHYS_ADDR		0x14008000
 #define PSC0_PHYS_ADDR		0x11A00000
 #define PSC1_PHYS_ADDR		0x11B00000
@@ -790,8 +785,6 @@ enum soc_au1200_ints {
 #define CIM_PHYS_ADDR		0x14004000
 #define USBM_PHYS_ADDR		0x14020000
 #define	USBH_PHYS_ADDR		0x14020100
-#define GPIO2_PHYS_ADDR		0x11700000
-#define	SYS_PHYS_ADDR		0x11900000
 #define PSC0_PHYS_ADDR	 	0x11A00000
 #define PSC1_PHYS_ADDR	 	0x11B00000
 #define LCD_PHYS_ADDR		0x15000000
@@ -1359,22 +1352,6 @@ enum soc_au1200_ints {
 #define SYS_PINFUNC_S1B 	(1 << 2)
 #endif
 
-#define SYS_TRIOUTRD		0xB1900100
-#define SYS_TRIOUTCLR		0xB1900100
-#define SYS_OUTPUTRD		0xB1900108
-#define SYS_OUTPUTSET		0xB1900108
-#define SYS_OUTPUTCLR		0xB190010C
-#define SYS_PINSTATERD		0xB1900110
-#define SYS_PININPUTEN		0xB1900110
-
-/* GPIO2, Au1500, Au1550 only */
-#define GPIO2_BASE		0xB1700000
-#define GPIO2_DIR		(GPIO2_BASE + 0)
-#define GPIO2_OUTPUT		(GPIO2_BASE + 8)
-#define GPIO2_PINSTATE		(GPIO2_BASE + 0xC)
-#define GPIO2_INTENABLE 	(GPIO2_BASE + 0x10)
-#define GPIO2_ENABLE		(GPIO2_BASE + 0x14)
-
 /* Power Management */
 #define SYS_SCRATCH0		0xB1900018
 #define SYS_SCRATCH1		0xB190001C
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 8f8c1c5..1f41a52 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -24,6 +24,22 @@
 
 #define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
 
+/* GPIO1 registers within SYS_ area */
+#define SYS_TRIOUTRD		0x100
+#define SYS_TRIOUTCLR		0x100
+#define SYS_OUTPUTRD		0x108
+#define SYS_OUTPUTSET		0x108
+#define SYS_OUTPUTCLR		0x10C
+#define SYS_PINSTATERD		0x110
+#define SYS_PININPUTEN		0x110
+
+/* register offsets within GPIO2 block */
+#define GPIO2_DIR		0x00
+#define GPIO2_OUTPUT		0x08
+#define GPIO2_PINSTATE		0x0C
+#define GPIO2_INTENABLE		0x10
+#define GPIO2_ENABLE		0x14
+
 struct gpio;
 
 static inline int au1000_gpio1_to_irq(int gpio)
@@ -201,23 +217,26 @@ static inline int au1200_irq_to_gpio(int irq)
  */
 static inline void alchemy_gpio1_set_value(int gpio, int v)
 {
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
 	unsigned long r = v ? SYS_OUTPUTSET : SYS_OUTPUTCLR;
-	au_writel(mask, r);
-	au_sync();
+	__raw_writel(mask, base + r);
+	wmb();
 }
 
 static inline int alchemy_gpio1_get_value(int gpio)
 {
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
-	return au_readl(SYS_PINSTATERD) & mask;
+	return __raw_readl(base + SYS_PINSTATERD) & mask;
 }
 
 static inline int alchemy_gpio1_direction_input(int gpio)
 {
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
-	au_writel(mask, SYS_TRIOUTCLR);
-	au_sync();
+	__raw_writel(mask, base + SYS_TRIOUTCLR);
+	wmb();
 	return 0;
 }
 
@@ -258,27 +277,31 @@ static inline int alchemy_gpio1_to_irq(int gpio)
  */
 static inline void __alchemy_gpio2_mod_dir(int gpio, int to_out)
 {
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
 	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
-	unsigned long d = au_readl(GPIO2_DIR);
+	unsigned long d = __raw_readl(base + GPIO2_DIR);
+
 	if (to_out)
 		d |= mask;
 	else
 		d &= ~mask;
-	au_writel(d, GPIO2_DIR);
-	au_sync();
+	__raw_writel(d, base + GPIO2_DIR);
+	wmb();
 }
 
 static inline void alchemy_gpio2_set_value(int gpio, int v)
 {
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
 	unsigned long mask;
 	mask = ((v) ? 0x00010001 : 0x00010000) << (gpio - ALCHEMY_GPIO2_BASE);
-	au_writel(mask, GPIO2_OUTPUT);
-	au_sync();
+	__raw_writel(mask, base + GPIO2_OUTPUT);
+	wmb();
 }
 
 static inline int alchemy_gpio2_get_value(int gpio)
 {
-	return au_readl(GPIO2_PINSTATE) & (1 << (gpio - ALCHEMY_GPIO2_BASE));
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
+	return __raw_readl(base + GPIO2_PINSTATE) & (1 << (gpio - ALCHEMY_GPIO2_BASE));
 }
 
 static inline int alchemy_gpio2_direction_input(int gpio)
@@ -330,21 +353,23 @@ static inline int alchemy_gpio2_to_irq(int gpio)
  */
 static inline void alchemy_gpio1_input_enable(void)
 {
-	au_writel(0, SYS_PININPUTEN);	/* the write op is key */
-	au_sync();
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
+	__raw_writel(0, base + SYS_PININPUTEN);	/* the write op is key */
+	wmb();
 }
 
 /* GPIO2 shared interrupts and control */
 
 static inline void __alchemy_gpio2_mod_int(int gpio2, int en)
 {
-	unsigned long r = au_readl(GPIO2_INTENABLE);
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
+	unsigned long r = __raw_readl(base + GPIO2_INTENABLE);
 	if (en)
 		r |= 1 << gpio2;
 	else
 		r &= ~(1 << gpio2);
-	au_writel(r, GPIO2_INTENABLE);
-	au_sync();
+	__raw_writel(r, base + GPIO2_INTENABLE);
+	wmb();
 }
 
 /**
@@ -419,10 +444,11 @@ static inline void alchemy_gpio2_disable_int(int gpio2)
  */
 static inline void alchemy_gpio2_enable(void)
 {
-	au_writel(3, GPIO2_ENABLE);	/* reset, clock enabled */
-	au_sync();
-	au_writel(1, GPIO2_ENABLE);	/* clock enabled */
-	au_sync();
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
+	__raw_writel(3, base + GPIO2_ENABLE);	/* reset, clock enabled */
+	wmb();
+	__raw_writel(1, base + GPIO2_ENABLE);	/* clock enabled */
+	wmb();
 }
 
 /**
@@ -432,8 +458,9 @@ static inline void alchemy_gpio2_enable(void)
  */
 static inline void alchemy_gpio2_disable(void)
 {
-	au_writel(2, GPIO2_ENABLE);	/* reset, clock disabled */
-	au_sync();
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1500_GPIO2_PHYS_ADDR);
+	__raw_writel(2, base + GPIO2_ENABLE);	/* reset, clock disabled */
+	wmb();
 }
 
 /**********************************************************************/
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 3ffe05d..5d513b5 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -470,7 +471,7 @@ static int __init au1xxx_nand_init(void)
 
 #ifdef CONFIG_MIPS_PB1550
 	/* set gpio206 high */
-	au_writel(au_readl(GPIO2_DIR) & ~(1 << 6), GPIO2_DIR);
+	gpio_direction_input(206);
 
 	boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) | ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
 
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 5ec5ac1..1479dc4 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -66,6 +66,7 @@ static struct {
 	int default_ticks;
 	unsigned long inuse;
 	unsigned gpio;
+	int gstate;
 } mtx1_wdt_device;
 
 static void mtx1_wdt_trigger(unsigned long unused)
@@ -75,13 +76,13 @@ static void mtx1_wdt_trigger(unsigned long unused)
 	spin_lock(&mtx1_wdt_device.lock);
 	if (mtx1_wdt_device.running)
 		ticks--;
-	/*
-	 * toggle GPIO2_15
-	 */
-	tmp = au_readl(GPIO2_DIR);
-	tmp = (tmp & ~(1 << mtx1_wdt_device.gpio)) |
-	      ((~tmp) & (1 << mtx1_wdt_device.gpio));
-	au_writel(tmp, GPIO2_DIR);
+
+	/* toggle wdt gpio */
+	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
+	if (mtx1_wdt_device.gstate)
+		gpio_direction_output(mtx1_wdt_device.gpio, 1);
+	else
+		gpio_direction_input(mtx1_wdt_device.gpio);
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
@@ -103,7 +104,8 @@ static void mtx1_wdt_start(void)
 	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
 	if (!mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 1;
-		gpio_set_value(mtx1_wdt_device.gpio, 1);
+		mtx1_wdt_device.gstate = 1;
+		gpio_direction_output(mtx1_wdt_device.gpio, 1);
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
 	}
 	mtx1_wdt_device.running++;
@@ -117,7 +119,8 @@ static int mtx1_wdt_stop(void)
 	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
 	if (mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 0;
-		gpio_set_value(mtx1_wdt_device.gpio, 0);
+		mtx1_wdt_device.gstate = 0;
+		gpio_direction_output(mtx1_wdt_device.gpio, 0);
 	}
 	ticks = mtx1_wdt_device.default_ticks;
 	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
-- 
1.7.5.rc3

