Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 2/3] watchdog: i6300esb: support multiple devices
Date: Mon, 16 Oct 2017 19:25:27 +0100
Message-Id: <20171016182528.3244-2-rrendec@arista.com>
In-Reply-To: <20171016182528.3244-1-rrendec@arista.com>
References: <20171016182528.3244-1-rrendec@arista.com>
List-ID: <linux-watchdog@vger.kernel.org>

Support multiple i6300esb devices simultaneously, by removing the single
device restriction in the original design and leveraging the multiple
device support of the watchdog subsystem.

This patch replaces the global definitions of watchdog device data with
a dynamically allocated structure. This structure is allocated during
device probe, so multiple independent structures can be allocated if
multiple devices are probed.

Signed-off-by: Radu Rendec <rrendec@arista.com>
---
 drivers/watchdog/i6300esb.c | 178 +++++++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 84 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 1df41a09553c..855b4f80ad09 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -23,6 +23,7 @@
  *	Ported driver to kernel 2.6
  *  20171016 Radu Rendec <rrendec@arista.com>
  *	Change driver to use the watchdog subsystem
+ *	Add support for multiple 6300ESB devices
  */
 
 /*
@@ -53,10 +54,10 @@
 #define ESB_LOCK_REG    0x68            /* WDT lock register                 */
 
 /* Memory mapped registers */
-#define ESB_TIMER1_REG (BASEADDR + 0x00)/* Timer1 value after each reset     */
-#define ESB_TIMER2_REG (BASEADDR + 0x04)/* Timer2 value after each reset     */
-#define ESB_GINTSR_REG (BASEADDR + 0x08)/* General Interrupt Status Register */
-#define ESB_RELOAD_REG (BASEADDR + 0x0c)/* Reload register                   */
+#define ESB_TIMER1_REG(w) ((w)->base + 0x00)/* Timer1 value after each reset */
+#define ESB_TIMER2_REG(w) ((w)->base + 0x04)/* Timer2 value after each reset */
+#define ESB_GINTSR_REG(w) ((w)->base + 0x08)/* General Interrupt Status Reg  */
+#define ESB_RELOAD_REG(w) ((w)->base + 0x0c)/* Reload register               */
 
 /* Lock register bits */
 #define ESB_WDT_FUNC    (0x01 << 2)   /* Watchdog functionality            */
@@ -76,12 +77,7 @@
 #define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
 #define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
 
-/* internal variables */
-static void __iomem *BASEADDR;
-static DEFINE_SPINLOCK(esb_lock); /* Guards the hardware */
-static struct pci_dev *esb_pci;
-
-/* We can only use 1 card due to the /dev/watchdog restriction */
+/* Probed devices counter; used only for printing the initial info message */
 static int cards_found;
 
 /* module parameters */
@@ -99,6 +95,16 @@ MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+/* internal variables */
+struct esb_dev {
+	struct watchdog_device wdd;
+	void __iomem *base;
+	spinlock_t lock;
+	struct pci_dev *pdev;
+};
+
+#define to_esb_dev(wptr) container_of(wptr, struct esb_dev, wdd)
+
 /*
  * Some i6300ESB specific functions
  */
@@ -109,39 +115,41 @@ MODULE_PARM_DESC(nowayout,
  * reload register. After this the appropriate registers can be written
  * to once before they need to be unlocked again.
  */
-static inline void esb_unlock_registers(void)
+static inline void esb_unlock_registers(struct esb_dev *edev)
 {
-	writew(ESB_UNLOCK1, ESB_RELOAD_REG);
-	writew(ESB_UNLOCK2, ESB_RELOAD_REG);
+	writew(ESB_UNLOCK1, ESB_RELOAD_REG(edev));
+	writew(ESB_UNLOCK2, ESB_RELOAD_REG(edev));
 }
 
 static int esb_timer_start(struct watchdog_device *wdd)
 {
+	struct esb_dev *edev = to_esb_dev(wdd);
 	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &wdd->status);
 	u8 val;
 
-	spin_lock(&esb_lock);
-	esb_unlock_registers();
-	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+	spin_lock(&edev->lock);
+	esb_unlock_registers(edev);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
 	/* Enable or Enable + Lock? */
 	val = ESB_WDT_ENABLE | (_wdd_nowayout ? ESB_WDT_LOCK : 0x00);
-	pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
-	spin_unlock(&esb_lock);
+	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, val);
+	spin_unlock(&edev->lock);
 	return 0;
 }
 
 static int esb_timer_stop(struct watchdog_device *wdd)
 {
+	struct esb_dev *edev = to_esb_dev(wdd);
 	u8 val;
 
-	spin_lock(&esb_lock);
+	spin_lock(&edev->lock);
 	/* First, reset timers as suggested by the docs */
-	esb_unlock_registers();
-	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+	esb_unlock_registers(edev);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
 	/* Then disable the WDT */
-	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
-	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
-	spin_unlock(&esb_lock);
+	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x0);
+	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val);
+	spin_unlock(&edev->lock);
 
 	/* Returns 0 if the timer was disabled, non-zero otherwise */
 	return val & ESB_WDT_ENABLE;
@@ -149,20 +157,23 @@ static int esb_timer_stop(struct watchdog_device *wdd)
 
 static int esb_timer_keepalive(struct watchdog_device *wdd)
 {
-	spin_lock(&esb_lock);
-	esb_unlock_registers();
-	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+	struct esb_dev *edev = to_esb_dev(wdd);
+
+	spin_lock(&edev->lock);
+	esb_unlock_registers(edev);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
 	/* FIXME: Do we need to flush anything here? */
-	spin_unlock(&esb_lock);
+	spin_unlock(&edev->lock);
 	return 0;
 }
 
 static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
 		unsigned int time)
 {
+	struct esb_dev *edev = to_esb_dev(wdd);
 	u32 val;
 
-	spin_lock(&esb_lock);
+	spin_lock(&edev->lock);
 
 	/* We shift by 9, so if we are passed a value of 1 sec,
 	 * val will be 1 << 9 = 512, then write that to two
@@ -171,21 +182,21 @@ static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
 	val = time << 9;
 
 	/* Write timer 1 */
-	esb_unlock_registers();
-	writel(val, ESB_TIMER1_REG);
+	esb_unlock_registers(edev);
+	writel(val, ESB_TIMER1_REG(edev));
 
 	/* Write timer 2 */
-	esb_unlock_registers();
-	writel(val, ESB_TIMER2_REG);
+	esb_unlock_registers(edev);
+	writel(val, ESB_TIMER2_REG(edev));
 
 	/* Reload */
-	esb_unlock_registers();
-	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
+	esb_unlock_registers(edev);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
 
 	/* FIXME: Do we need to flush everything out? */
 
 	/* Done */
-	spin_unlock(&esb_lock);
+	spin_unlock(&edev->lock);
 	return 0;
 }
 
@@ -206,14 +217,6 @@ static const struct watchdog_ops esb_ops = {
 	.ping = esb_timer_keepalive,
 };
 
-static struct watchdog_device esb_dev = {
-	.info = &esb_info,
-	.ops = &esb_ops,
-	.min_timeout = 1,
-	.max_timeout = 2 * 0x03ff,
-	.timeout = WATCHDOG_HEARTBEAT,
-};
-
 /*
  * Data for PCI driver interface
  */
@@ -227,38 +230,38 @@ MODULE_DEVICE_TABLE(pci, esb_pci_tbl);
  *      Init & exit routines
  */
 
-static unsigned char esb_getdevice(struct pci_dev *pdev)
+static unsigned char esb_getdevice(struct esb_dev *edev)
 {
-	if (pci_enable_device(pdev)) {
+	if (pci_enable_device(edev->pdev)) {
 		pr_err("failed to enable device\n");
 		goto err_devput;
 	}
 
-	if (pci_request_region(pdev, 0, ESB_MODULE_NAME)) {
+	if (pci_request_region(edev->pdev, 0, ESB_MODULE_NAME)) {
 		pr_err("failed to request region\n");
 		goto err_disable;
 	}
 
-	BASEADDR = pci_ioremap_bar(pdev, 0);
-	if (BASEADDR == NULL) {
+	edev->base = pci_ioremap_bar(edev->pdev, 0);
+	if (edev->base == NULL) {
 		/* Something's wrong here, BASEADDR has to be set */
 		pr_err("failed to get BASEADDR\n");
 		goto err_release;
 	}
 
 	/* Done */
-	esb_pci = pdev;
+	dev_set_drvdata(&edev->pdev->dev, edev);
 	return 1;
 
 err_release:
-	pci_release_region(pdev, 0);
+	pci_release_region(edev->pdev, 0);
 err_disable:
-	pci_disable_device(pdev);
+	pci_disable_device(edev->pdev);
 err_devput:
 	return 0;
 }
 
-static void esb_initdevice(void)
+static void esb_initdevice(struct esb_dev *edev)
 {
 	u8 val1;
 	u16 val2;
@@ -275,33 +278,34 @@ static void esb_initdevice(void)
 	 * any interrupts as there is not much we can do with it
 	 * right now.
 	 */
-	pci_write_config_word(esb_pci, ESB_CONFIG_REG, 0x0003);
+	pci_write_config_word(edev->pdev, ESB_CONFIG_REG, 0x0003);
 
 	/* Check that the WDT isn't already locked */
-	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val1);
+	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val1);
 	if (val1 & ESB_WDT_LOCK)
 		pr_warn("nowayout already set\n");
 
 	/* Set the timer to watchdog mode and disable it for now */
-	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x00);
+	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
 
 	/* Check if the watchdog was previously triggered */
-	esb_unlock_registers();
-	val2 = readw(ESB_RELOAD_REG);
+	esb_unlock_registers(edev);
+	val2 = readw(ESB_RELOAD_REG(edev));
 	if (val2 & ESB_WDT_TIMEOUT)
-		esb_dev.bootstatus = WDIOF_CARDRESET;
+		edev->wdd.bootstatus = WDIOF_CARDRESET;
 
 	/* Reset WDT_TIMEOUT flag and timers */
-	esb_unlock_registers();
-	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG);
+	esb_unlock_registers(edev);
+	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG(edev));
 
 	/* And set the correct timeout value */
-	esb_timer_set_heartbeat(&esb_dev, esb_dev.timeout);
+	esb_timer_set_heartbeat(&edev->wdd, edev->wdd.timeout);
 }
 
 static int esb_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
+	struct esb_dev *edev;
 	int ret;
 
 	cards_found++;
@@ -309,13 +313,14 @@ static int esb_probe(struct pci_dev *pdev,
 		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
 			ESB_VERSION);
 
-	if (cards_found > 1) {
-		pr_err("This driver only supports 1 device\n");
-		return -ENODEV;
-	}
+	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		return -ENOMEM;
 
 	/* Check whether or not the hardware watchdog is there */
-	if (!esb_getdevice(pdev) || esb_pci == NULL)
+	spin_lock_init(&edev->lock);
+	edev->pdev = pdev;
+	if (!esb_getdevice(edev))
 		return -ENODEV;
 
 	/* Check that the heartbeat value is within it's range;
@@ -327,47 +332,52 @@ static int esb_probe(struct pci_dev *pdev,
 	}
 
 	/* Initialize the watchdog and make sure it does not run */
-	watchdog_init_timeout(&esb_dev, heartbeat, NULL);
-	watchdog_set_nowayout(&esb_dev, nowayout);
-	esb_initdevice();
+	edev->wdd.info = &esb_info;
+	edev->wdd.ops = &esb_ops;
+	edev->wdd.min_timeout = 1;
+	edev->wdd.max_timeout = 2 * 0x03ff;
+	watchdog_init_timeout(&edev->wdd, heartbeat, NULL);
+	watchdog_set_nowayout(&edev->wdd, nowayout);
+	esb_initdevice(edev);
 
 	/* Register the watchdog so that userspace has access to it */
-	ret = watchdog_register_device(&esb_dev);
+	ret = watchdog_register_device(&edev->wdd);
 	if (ret != 0) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
 		goto err_unmap;
 	}
 	pr_info("initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
-		BASEADDR, esb_dev.timeout, nowayout);
+		edev->base, edev->wdd.timeout, nowayout);
 	return 0;
 
 err_unmap:
-	iounmap(BASEADDR);
-	pci_release_region(esb_pci, 0);
-	pci_disable_device(esb_pci);
-	esb_pci = NULL;
+	iounmap(edev->base);
+	pci_release_region(edev->pdev, 0);
+	pci_disable_device(edev->pdev);
 	return ret;
 }
 
 static void esb_remove(struct pci_dev *pdev)
 {
-	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &esb_dev.status);
+	struct esb_dev *edev = dev_get_drvdata(&pdev->dev);
+	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &edev->wdd.status);
 
 	/* Stop the timer before we leave */
 	if (!_wdd_nowayout)
-		esb_timer_stop(&esb_dev);
+		esb_timer_stop(&edev->wdd);
 
 	/* Deregister */
-	watchdog_unregister_device(&esb_dev);
-	iounmap(BASEADDR);
-	pci_release_region(esb_pci, 0);
-	pci_disable_device(esb_pci);
-	esb_pci = NULL;
+	watchdog_unregister_device(&edev->wdd);
+	iounmap(edev->base);
+	pci_release_region(edev->pdev, 0);
+	pci_disable_device(edev->pdev);
 }
 
 static void esb_shutdown(struct pci_dev *pdev)
 {
-	esb_timer_stop(&esb_dev);
+	struct esb_dev *edev = dev_get_drvdata(&pdev->dev);
+
+	esb_timer_stop(&edev->wdd);
 }
 
 static struct pci_driver esb_driver = {
-- 
2.13.6
