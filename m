Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC93377A81
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188994; cv=none; b=Oh519yyy+fasPQ5o+bLUPeJdiBrpw4C6Cdt8I/ux73ZJW/Kl7SWhDNrVKQ+GfmRNSxgv1O8jRnwHWdso6sv6+3N4Fd/P2ptCrt4uUGIXuk0YwoTR2WcOgZXZDjhPlq5jZK64CJ4kZmpEZA6VOYltqL4cfySjbx5Xf2a8IMLCZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188994; c=relaxed/simple;
	bh=Ihax8ouPm6jYDszAWDnb4X7VuBDRzd+0uEin8+gse3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgwY331jLsz/PVJRbB6SxDdUE+btjJIeOwCeBHEjgnJsJaEu6COiwL0sQ6p5p7PQ7MmQl7L+zL6V78k2wJHT+X3l1IW7ZsUpEy/ciof3HU6BNmuof25dshMH8JnM1aARccasecNgIOxE3BHVFvehEsK8ULRnHkSE81KFGaTBTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMEu8q7b; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMEu8q7b"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b6dad2382so1104348eec.0
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792188992; x=1792793792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PlKRPHckVEX+8lY9jy8A17B4anyFnGx3e97aiFPbmw=;
        b=cMEu8q7bfstO8I8aYBDSUINcxIvRQPXE7auSaVDIaTfBZFo2sVY4UWCUDYnSBphTq/
         XAXmdNg7A6msxD4ZXSAiLQXyVbWbGbpY0Rm3dzeHd4D7KlPQHHnDNkTPo5qog+SWb/zw
         v6O7NZVrGwXyD/ux4ERzOBDl7VQLmV/ijOkRzAjmxB6iRr8cbRXGlNZzI7UwRNhl/yz8
         m+W5MimWI0OrppjhyCnKK6SKzsAAeCNISjzNplQvOx3drmcTcD2HjKaNbkV60UJVJbmY
         AJXGx+w6o/w0HE34rDsPOCOu8X/njnisNINU/7X7nKoIVoK3eC4Wjlbk8rX7vmD6f/tw
         UpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792188992; x=1792793792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PlKRPHckVEX+8lY9jy8A17B4anyFnGx3e97aiFPbmw=;
        b=JOVVOImFU/dFDSeTvYtC4WqBh/OiYicEaEeUx6tMIWAElioKY005NfuFydvDQvHSw3
         BqxGsDdTGwXHWeIAlAdJTbH3KS4mY0ZuuZbYCVyDZwslu4IWOTPSdWf9LrR107s1kqEQ
         sPJ+RW88WBaNBDcusgqUvN4Ei2FWbyMJ9Pl+7vEbbmXDOqnGeM+hOOE08z/CiblhnjYs
         PWIsydWiznoN7sfHZQZXWdKbCG9rZlud1P+8tlz3EWyuA/KKbJGj3KG2G3Ca4rk6zndy
         /U96ERqT3OHyDwpAObo6ha6PlLitTloOjMEYCd6fmYCmLzRb7CJ4iRmivVqhngkeBEzD
         +ELw==
X-Forwarded-Encrypted: i=1; AKwUvBzZwr/0/mDk1MZBJsRa+6pnrePjpow6H9jpFj7oTAXAqMODZrG9aVmBUnKjZttUuyk77Xd7DV7LFwibPshg8w==@vger.kernel.org
X-Gm-Message-State: AFq9FYL1I/cHgELOAPt8KXDy/ZPCO+AjfNlP0T1DqgeGnQ2OW3Knr9c6
	3CevEGtrwFSiBxAyTpRzhv0beApPLr8zPngA3z7b1Hcdlj8B9DccBUU7
X-Gm-Gg: AYBFou0dCzWYdlcjSnS3/APkk6IJ817B5sGh5a/hTi4KfJomgTJqgb/z9oPHiqMcyJ9
	xx1hSvLvmrgKPE7d3V1K76k1v7J6fntuIDnCoRkMKfMysPSEvN7YpyY7AlAuhYINhIggyOCwPrc
	T7Scm7gs8S6hAxE4Cobp79FNsHGQZF+4yDO4rYqLlNc0ceB5CHRJAfXhb1PpMRm1gG8S6bZB5F1
	icL7SG01THZ31lSMZ0NpdbTsmmPxhrAmlx0HDk2y9TCWDk6UsfUxoxZcaGHER7xDq5DKoi2OsKh
	ThRZa31IkL1kIYCB2TCss0HBMG/7CPGjIKjtwztdwagWG9SUH6IlYl1USR/DYQyv40pWkvenl5O
	30Z6rs3zpJNRO51PHmpJUXEQSLfrV0f3vMdOJqkhxJ5ZIw55qE0A59i7G4W9ajz+mb4Xl6X2iWV
	VHif9aUpAScDnSZHe2YY/afLCUgtp0LXVNJuuM0p8vHXANSxcJnhaNXznReZXiirAVYBrppEhtj
	RZQPn+Y
X-Received: by 2002:a05:7022:fe0c:b0:14b:1e78:a19f with SMTP id a92af1059eb24-1850c223833mr1912662c88.6.1792188992196;
        Fri, 16 Oct 2026 15:16:32 -0700 (PDT)
Received: from eldorado ([2600:8802:b00:1f84:d294:66ff:fe95:a98e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm10480863c88.6.2026.10.16.15.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:16:30 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	manuel.lauss@gmail.com
Subject: [PATCH 5/5] watchdog: Remove the MTX-1 watchdog driver
Date: Fri, 16 Oct 2026 15:16:17 -0700
Message-ID: <20261016221617.2223004-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016221617.2223004-1-f.fainelli@gmail.com>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTX-1 now uses the generic GPIO watchdog driver with board properties
describing its GPIO and heartbeat constraints. Remove the unused custom
driver and its Kconfig and Makefile entries.

The watchdog core now supplies the character device, keepalive scheduling,
timeout handling and close semantics previously implemented by this driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/watchdog/Kconfig     |   7 -
 drivers/watchdog/Makefile    |   1 -
 drivers/watchdog/mtx-1_wdt.c | 245 -----------------------------------
 3 files changed, 253 deletions(-)
 delete mode 100644 drivers/watchdog/mtx-1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f50709c635e5..c884f86be4e3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1865,13 +1865,6 @@ config JZ4740_WDT
 	help
 	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
 
-config WDT_MTX1
-	tristate "MTX-1 Hardware Watchdog"
-	depends on MIPS_MTX1 || (MIPS && COMPILE_TEST)
-	help
-	  Hardware driver for the MTX-1 boards. This is a watchdog timer that
-	  will reboot the machine after a 100 seconds timer expired.
-
 config SIBYTE_WDOG
 	tristate "Sibyte SoC hardware watchdog"
 	depends on CPU_SB1
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9ac406677aba..19cb25f51624 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -172,7 +172,6 @@ obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
 obj-$(CONFIG_RC32434_WDT) += rc32434_wdt.o
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_JZ4740_WDT) += jz4740_wdt.o
-obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
 obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
deleted file mode 100644
index f75426cfa425..000000000000
--- a/drivers/watchdog/mtx-1_wdt.c
+++ /dev/null
@@ -1,245 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *      Driver for the MTX-1 Watchdog.
- *
- *      (C) Copyright 2005 4G Systems <info@4g-systems.biz>,
- *							All Rights Reserved.
- *                              http://www.4g-systems.biz
- *
- *	(C) Copyright 2007 OpenWrt.org, Florian Fainelli <florian@openwrt.org>
- *      (c) Copyright 2005    4G Systems <info@4g-systems.biz>
- *
- *      Release 0.01.
- *      Author: Michael Stickel  michael.stickel@4g-systems.biz
- *
- *      Release 0.02.
- *	Author: Florian Fainelli florian@openwrt.org
- *		use the Linux watchdog/timer APIs
- *
- *      The Watchdog is configured to reset the MTX-1
- *      if it is not triggered for 100 seconds.
- *      It should not be triggered more often than 1.6 seconds.
- *
- *      A timer triggers the watchdog every 5 seconds, until
- *      it is opened for the first time. After the first open
- *      it MUST be triggered every 2..95 seconds.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/miscdevice.h>
-#include <linux/fs.h>
-#include <linux/ioport.h>
-#include <linux/timer.h>
-#include <linux/completion.h>
-#include <linux/jiffies.h>
-#include <linux/watchdog.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/uaccess.h>
-#include <linux/gpio/consumer.h>
-
-#define MTX1_WDT_INTERVAL	(5 * HZ)
-
-static int ticks = 100 * HZ;
-
-static struct {
-	struct completion stop;
-	spinlock_t lock;
-	int running;
-	struct timer_list timer;
-	int queue;
-	int default_ticks;
-	unsigned long inuse;
-	struct gpio_desc *gpiod;
-	unsigned int gstate;
-} mtx1_wdt_device;
-
-static void mtx1_wdt_trigger(struct timer_list *unused)
-{
-	spin_lock(&mtx1_wdt_device.lock);
-	if (mtx1_wdt_device.running)
-		ticks--;
-
-	/* toggle wdt gpio */
-	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
-	gpiod_set_value(mtx1_wdt_device.gpiod, mtx1_wdt_device.gstate);
-
-	if (mtx1_wdt_device.queue && ticks)
-		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
-	else
-		complete(&mtx1_wdt_device.stop);
-	spin_unlock(&mtx1_wdt_device.lock);
-}
-
-static void mtx1_wdt_reset(void)
-{
-	ticks = mtx1_wdt_device.default_ticks;
-}
-
-
-static void mtx1_wdt_start(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
-	if (!mtx1_wdt_device.queue) {
-		mtx1_wdt_device.queue = 1;
-		mtx1_wdt_device.gstate = 1;
-		gpiod_set_value(mtx1_wdt_device.gpiod, 1);
-		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
-	}
-	mtx1_wdt_device.running++;
-	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
-}
-
-static int mtx1_wdt_stop(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
-	if (mtx1_wdt_device.queue) {
-		mtx1_wdt_device.queue = 0;
-		mtx1_wdt_device.gstate = 0;
-		gpiod_set_value(mtx1_wdt_device.gpiod, 0);
-	}
-	ticks = mtx1_wdt_device.default_ticks;
-	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
-	return 0;
-}
-
-/* Filesystem functions */
-
-static int mtx1_wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &mtx1_wdt_device.inuse))
-		return -EBUSY;
-	return stream_open(inode, file);
-}
-
-
-static int mtx1_wdt_release(struct inode *inode, struct file *file)
-{
-	clear_bit(0, &mtx1_wdt_device.inuse);
-	return 0;
-}
-
-static long mtx1_wdt_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = (int __user *)argp;
-	unsigned int value;
-	static const struct watchdog_info ident = {
-		.options = WDIOF_CARDRESET,
-		.identity = "MTX-1 WDT",
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user(argp, &ident, sizeof(ident)))
-			return -EFAULT;
-		break;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		put_user(0, p);
-		break;
-	case WDIOC_SETOPTIONS:
-		if (get_user(value, p))
-			return -EFAULT;
-		if (value & WDIOS_ENABLECARD)
-			mtx1_wdt_start();
-		else if (value & WDIOS_DISABLECARD)
-			mtx1_wdt_stop();
-		else
-			return -EINVAL;
-		return 0;
-	case WDIOC_KEEPALIVE:
-		mtx1_wdt_reset();
-		break;
-	default:
-		return -ENOTTY;
-	}
-	return 0;
-}
-
-
-static ssize_t mtx1_wdt_write(struct file *file, const char *buf,
-						size_t count, loff_t *ppos)
-{
-	if (!count)
-		return -EIO;
-	mtx1_wdt_reset();
-	return count;
-}
-
-static const struct file_operations mtx1_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.unlocked_ioctl	= mtx1_wdt_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
-	.open		= mtx1_wdt_open,
-	.write		= mtx1_wdt_write,
-	.release	= mtx1_wdt_release,
-};
-
-
-static struct miscdevice mtx1_wdt_misc = {
-	.minor	= WATCHDOG_MINOR,
-	.name	= "watchdog",
-	.fops	= &mtx1_wdt_fops,
-};
-
-
-static int mtx1_wdt_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	mtx1_wdt_device.gpiod = devm_gpiod_get(&pdev->dev,
-					       NULL, GPIOD_OUT_HIGH);
-	if (IS_ERR(mtx1_wdt_device.gpiod)) {
-		dev_err(&pdev->dev, "failed to request gpio");
-		return PTR_ERR(mtx1_wdt_device.gpiod);
-	}
-
-	spin_lock_init(&mtx1_wdt_device.lock);
-	init_completion(&mtx1_wdt_device.stop);
-	mtx1_wdt_device.queue = 0;
-	clear_bit(0, &mtx1_wdt_device.inuse);
-	timer_setup(&mtx1_wdt_device.timer, mtx1_wdt_trigger, 0);
-	mtx1_wdt_device.default_ticks = ticks;
-
-	ret = misc_register(&mtx1_wdt_misc);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register\n");
-		return ret;
-	}
-	mtx1_wdt_start();
-	dev_info(&pdev->dev, "MTX-1 Watchdog driver\n");
-	return 0;
-}
-
-static void mtx1_wdt_remove(struct platform_device *pdev)
-{
-	/* FIXME: do we need to lock this test ? */
-	if (mtx1_wdt_device.queue) {
-		mtx1_wdt_device.queue = 0;
-		wait_for_completion(&mtx1_wdt_device.stop);
-	}
-
-	misc_deregister(&mtx1_wdt_misc);
-}
-
-static struct platform_driver mtx1_wdt_driver = {
-	.probe = mtx1_wdt_probe,
-	.remove = mtx1_wdt_remove,
-	.driver.name = "mtx1-wdt",
-};
-
-module_platform_driver(mtx1_wdt_driver);
-
-MODULE_AUTHOR("Michael Stickel, Florian Fainelli");
-MODULE_DESCRIPTION("Driver for the MTX-1 watchdog");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:mtx1-wdt");
-- 
2.53.0

