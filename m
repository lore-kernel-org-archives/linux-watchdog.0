Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from one-mail.aptivate.org ([87.106.150.205]:33386 "EHLO
	one-mail.aptivate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186Ab2HJWUc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Aug 2012 18:20:32 -0400
Received: from [197.220.23.213] (helo=lap-x201)
	by one-mail.aptivate.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <chris+linux@aptivate.org>)
	id 1Szx60-0002U5-Pg
	for linux-watchdog@vger.kernel.org; Fri, 10 Aug 2012 22:50:17 +0100
Date: Fri, 10 Aug 2012 23:50:12 +0200 (CAT)
From: Chris Wilson <chris+linux@aptivate.org>
To: linux-watchdog@vger.kernel.org
Subject: [PATCH] ie6xx_wdt: store and show whether system was rebooted by
 watchdog
Message-ID: <alpine.DEB.2.02.1208102347210.5281@lap-x201>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog has a persistent bit which is set when it resets the host, 
and can be reset by the host. The driver previously ignored this bit. It 
was called WDT_TOUT by the driver, but WDT_TIMEOUT in the datasheet, so 
I've renamed it for clarity.

If this bit is set when the driver is probed, I store it in the 
watchdog_device bootstatus field, which can be read by 
ioctl("/dev/watchdog", WDIOC_GETBOOTSTATUS). If debugfs is enabled, the 
recorded value is also printed in the debugfs file 
(/sys/kernel/debug/ie6xx_wdt). I used this to verify that that the bit is 
not set when the system booted normally, but is set when it was rebooted 
by the watchdog.

Signed-off-by: Chris Wilson <chris+github@qwirx.com>
---
  drivers/watchdog/ie6xx_wdt.c |   26 +++++++++++++++++++-------
  1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 8f541b9..16afe49 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -42,7 +42,7 @@
  #define RR0	0x0c
  #define RR1	0x0d
  #define WDT_RELOAD	0x01
-#define WDT_TOUT	0x02
+#define WDT_TIMEOUT	0x02

  #define WDTCR	0x10
  #define WDT_PRE_SEL	0x04
@@ -137,7 +137,7 @@ static int ie6xx_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
  	outl(preload, ie6xx_wdt_data.sch_wdtba + PV2);

  	ie6xx_wdt_unlock_registers();
-	outb(WDT_RELOAD | WDT_TOUT, ie6xx_wdt_data.sch_wdtba + RR1);
+	outb(WDT_RELOAD, ie6xx_wdt_data.sch_wdtba + RR1);

  	spin_unlock(&ie6xx_wdt_data.unlock_sequence);

@@ -208,8 +208,8 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
  		inl(ie6xx_wdt_data.sch_wdtba + DCR));
  	seq_printf(s, "WDTLR = 0x%08x\n",
  		inw(ie6xx_wdt_data.sch_wdtba + WDTLR));
-
-	seq_printf(s, "\n");
+	seq_printf(s, "Rebooted = %s\n",
+		ie6xx_wdt_dev.bootstatus & WDIOF_CARDRESET ? "Yes" : "No");
  	return 0;
  }

@@ -250,12 +250,14 @@ static void ie6xx_wdt_debugfs_exit(void)
  static int __devinit ie6xx_wdt_probe(struct platform_device *pdev)
  {
  	struct resource *res;
-	u8 wdtlr;
+	u8 wdtlr, rr1;
  	int ret;

  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!res)
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get resources\n");
  		return -ENODEV;
+	}

  	if (!request_region(res->start, resource_size(res), pdev->name)) {
  		dev_err(&pdev->dev, "Watchdog region 0x%llx already in use!\n",
@@ -266,6 +268,15 @@ static int __devinit ie6xx_wdt_probe(struct platform_device *pdev)
  	ie6xx_wdt_data.sch_wdtba = res->start;
  	dev_dbg(&pdev->dev, "WDT = 0x%X\n", ie6xx_wdt_data.sch_wdtba);

+	rr1 = inb(ie6xx_wdt_data.sch_wdtba + RR1);
+	if (rr1 & WDT_TIMEOUT) {
+		dev_warn(&pdev->dev, "Previous reboot was caused by the card\n");
+		ie6xx_wdt_dev.bootstatus |= WDIOF_CARDRESET;
+		// reset the flag
+		ie6xx_wdt_unlock_registers();
+		outb(rr1 & ~WDT_TIMEOUT, ie6xx_wdt_data.sch_wdtba + RR1);
+	}
+
  	ie6xx_wdt_dev.timeout = timeout;
  	watchdog_set_nowayout(&ie6xx_wdt_dev, nowayout);

@@ -280,8 +291,9 @@ static int __devinit ie6xx_wdt_probe(struct platform_device *pdev)

  	ret = watchdog_register_device(&ie6xx_wdt_dev);
  	if (ret) {
+		printk(KERN_INFO "ie6xx_wdt_probe: can't register device\n");
  		dev_err(&pdev->dev,
-			"Watchdog timer: cannot register device (err =%d)\n",
+			"Watchdog timer: cannot register device (err=%d)\n",
  									ret);
  		goto misc_register_error;
  	}
-- 
1.7.5.4

