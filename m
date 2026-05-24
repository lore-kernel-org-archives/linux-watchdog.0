Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BC24A05D
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779587465; cv=none; b=MpL2VnyA2vZOWZWptDYRERX1Dl2kFLBoG1QN2bjz7SyXf7ef0UZg2ZueFxRbaZx9nntsxTZHA7v61cp/uddSTuvbB/KdP5tFY2zQGC15UUkCGEY38N9T0gLWm2ViW1w/bCmAijdrVQAqHv1DQYDVCMDZH8ttjQu8WQ5WMMw62X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779587465; c=relaxed/simple;
	bh=XI2dc+Chseaxjg8ImWfSsqZEqEDJH3xY6KvTIbs6LlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVAO8NpVQiWxYbJ3VuPYhsOKC8N6rr/3Y/0sRs3dysfI07MQaU2sGJdZ+MHjiDZBEgezNzk9DSOH+XPUi+Top0HIGbjQL88MI1bdk37cL/CXkp3ON2+Dy32sILkLmqpvwzwp089yKh0XUKxwUwTqjad9Z+cpqTcH073GmQZWS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbl3arSt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbl3arSt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b45cb89f7eso57734455ad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779587463; x=1780192263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW3JxozN5mFE+zYYPNILylQXRtOhbOi/GdQCwJhUliM=;
        b=pbl3arStrWXl27ZRp6bm3b0BH7NRz/rzkvXWp87+Ht480p5MhBlT0VIvKTp+HILnCA
         v88D1vFgq8fjz2zjquwOdgF76rxBhz0JsVhUJI5fADZgWHX9D662AC+grkMX6lxm0JHm
         a7y/9xWC5BxiVh8ZmiCA5WszKWVfgBMWK2OghP6KtZbRpqDIVsXCcIdW+xWkDHKJvPtz
         zvMdkB/nwnek+8tRgNzM6c90TXGhKWm1xOvxk63RBvWyus0hR820ZtCklZ3sxtKUAbOA
         T9eNVl5qJG0lsVTt+/oGu50QzTMHdaqPZzEpXdfR+QaurP8eHsQ50Mh8Lem6yeIN6e0b
         31GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779587463; x=1780192263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pW3JxozN5mFE+zYYPNILylQXRtOhbOi/GdQCwJhUliM=;
        b=G7n0IpEB+siWMQr099f2Atky3RFIMsy2jSQCTtLOSjN18ROvpx9xOeHVPsq23Db3Bc
         F1JeyDnvbwher3MbBRo3uMBz4gAjfK3b9HoJjp9iXdo1nmfwSR+ugSnlqfwQwUdeo7yD
         UFfTonAY/jHPQ3JwO1ZsOOkfonlkY9yn8JlbMa0bCH+yCklwGwiuoUfEDYwJ5Id41CSF
         FanoAfTFSKNxLMzUn/RZppQGp+Rn3SFhMwy4e7PoATE03UHz3myDzRXGyGaSyNgxi2BF
         iBabDg7hXn3kl4y9Oii4i9FFuhAgaLHerZ/kpuDx4tJRB5RsT+IR4EvFDV648MGOSoNf
         A3tg==
X-Gm-Message-State: AOJu0Yzwm11xjUxhDabTg+jyLr/gQJCFYpCXonoqmi8sQ4HUHuwBX3Ki
	0RbN+KE023D47vftaghzY9bkU2mPIAfz/2aPSY7rVsoFoZd7SdbB9MfzGp1SBQ==
X-Gm-Gg: Acq92OGARu7cgB3DHhwdI485mcfkWBwrURIBqBZDBRLojBiqZ40iUtqOeXbLtzD6l23
	Dr943YRZmd8fZO0TsFFQIUOheN2q8JFTz212S6O5BkALTs/0BrtjEah1r0rLfBoEKXohUX+zK2b
	+0QZMBy3ibKyp81ew59uGgVj1J1VJCHijUbBymNVGxjmckO8dC3LSrdlf68Jvvn3p6lhF2HXg41
	AecgSZRqsdwVWWBPL/yb5hWW+rFxiOCN8899Qi4Zc0tTEkicc6wqATSKEfKOQz64/gErqT8e/vW
	by36uI6jNabwp+Bn3x6UdfDcFLY7H6mzPRyLMldlniuF/0d73jLZGiCUFSuSXs6KfZDeWKMBsn0
	nQvbq5w9j2B6h9jr2syulLuxcTJKvIZUTrqhxQeGc6duCM52q2TzUtImxWBKcq2+Eh09zmTtoaD
	uUcMR1oeYd3sUddzZfIVJR77fVZ+lo7nuqoEI9ipVOamn0b3b0ylQYNSlO1/FiQZ7pQBAXtIeH5
	nBnyEiedKqzVD/EW/jptCSw1LyREjaKdQxYq7I/i52osQ==
X-Received: by 2002:a17:902:e5cc:b0:2bd:a5e:4c66 with SMTP id d9443c01a7336-2beb035ba35mr104736275ad.14.1779587462959;
        Sat, 23 May 2026 18:51:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm54822965ad.58.2026.05.23.18.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 18:51:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/2] watchdog: ath79: convert to watchdog_device
Date: Sat, 23 May 2026 18:50:42 -0700
Message-ID: <20260524015042.175271-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524015042.175271-1-rosenp@gmail.com>
References: <20260524015042.175271-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy miscdevice/file_operations interface to the
watchdog_device framework, simplifying the driver and properly handling
EPROBE_DEFER.

Use wdd->timeout in all callbacks instead of a global, fix get_timeleft()
to return seconds instead of raw clock ticks, store max_timeout in the
watchdog_device struct, wire up nowayout via watchdog_set_nowayout(), pass
the module parameter to watchdog_init_timeout(), add .owner to
watchdog_ops, and remove the leftover file-ops state (wdt_flags and the
busy/expect-close bits).

Tested on an Archer C7v2. sysupgrade watchdog handoff works fine.

Assisted-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/ath79_wdt.c | 246 +++++++++++------------------------
 1 file changed, 74 insertions(+), 172 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 409a40b14901..90c7e2578018 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -15,13 +15,10 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

-#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
@@ -31,7 +28,6 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/uaccess.h>

 #define DRIVER_NAME	"ath79-wdt"

@@ -57,37 +53,32 @@ module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
 			  "(default=" __MODULE_STRING(WDT_TIMEOUT) "s)");

-static unsigned long wdt_flags;
-
-#define WDT_FLAGS_BUSY		0
-#define WDT_FLAGS_EXPECT_CLOSE	1
-
-static struct clk *wdt_clk;
-static unsigned long wdt_freq;
-static int boot_status;
-static int max_timeout;
-static void __iomem *wdt_base;
+struct ath79_wdt {
+	void __iomem *base;
+	unsigned long freq;
+	struct watchdog_device wdd;
+};

-static inline void ath79_wdt_wr(unsigned reg, u32 val)
+static inline void ath79_wdt_wr(struct ath79_wdt *wdt, unsigned int reg, u32 val)
 {
-	iowrite32(val, wdt_base + reg);
+	iowrite32(val, wdt->base + reg);
 }

-static inline u32 ath79_wdt_rr(unsigned reg)
+static inline u32 ath79_wdt_rr(struct ath79_wdt *wdt, unsigned int reg)
 {
-	return ioread32(wdt_base + reg);
+	return ioread32(wdt->base + reg);
 }

-static inline void ath79_wdt_keepalive(void)
+static inline void ath79_wdt_keepalive(struct ath79_wdt *wdt, unsigned int timeout)
 {
-	ath79_wdt_wr(WDOG_REG_TIMER, wdt_freq * timeout);
+	ath79_wdt_wr(wdt, WDOG_REG_TIMER, wdt->freq * timeout);
 	/* flush write */
-	ath79_wdt_rr(WDOG_REG_TIMER);
+	ath79_wdt_rr(wdt, WDOG_REG_TIMER);
 }

-static inline void ath79_wdt_enable(void)
+static inline void ath79_wdt_enable(struct ath79_wdt *wdt, unsigned int timeout)
 {
-	ath79_wdt_keepalive();
+	ath79_wdt_keepalive(wdt, timeout);

 	/*
 	 * Updating the TIMER register requires a few microseconds
@@ -97,202 +88,115 @@ static inline void ath79_wdt_enable(void)
 	 */
 	udelay(2);

-	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
+	ath79_wdt_wr(wdt, WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
 	/* flush write */
-	ath79_wdt_rr(WDOG_REG_CTRL);
+	ath79_wdt_rr(wdt, WDOG_REG_CTRL);
 }

-static inline void ath79_wdt_disable(void)
+static inline void ath79_wdt_disable(struct ath79_wdt *wdt)
 {
-	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
+	ath79_wdt_wr(wdt, WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
 	/* flush write */
-	ath79_wdt_rr(WDOG_REG_CTRL);
+	ath79_wdt_rr(wdt, WDOG_REG_CTRL);
 }

-static int ath79_wdt_set_timeout(int val)
+static int ath79_wdt_ping(struct watchdog_device *wdd)
 {
-	if (val < 1 || val > max_timeout)
-		return -EINVAL;
+	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);

-	timeout = val;
-	ath79_wdt_keepalive();
+	ath79_wdt_keepalive(wdt, wdd->timeout);

 	return 0;
 }

-static int ath79_wdt_open(struct inode *inode, struct file *file)
+static int ath79_wdt_set_timeout(struct watchdog_device *wdd, unsigned int val)
 {
-	if (test_and_set_bit(WDT_FLAGS_BUSY, &wdt_flags))
-		return -EBUSY;
+	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);

-	clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
-	ath79_wdt_enable();
+	wdd->timeout = val;
+	ath79_wdt_keepalive(wdt, val);

-	return stream_open(inode, file);
+	return 0;
 }

-static int ath79_wdt_release(struct inode *inode, struct file *file)
+static int ath79_wdt_start(struct watchdog_device *wdd)
 {
-	if (test_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags))
-		ath79_wdt_disable();
-	else {
-		pr_crit("device closed unexpectedly, watchdog timer will not stop!\n");
-		ath79_wdt_keepalive();
-	}
+	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);

-	clear_bit(WDT_FLAGS_BUSY, &wdt_flags);
-	clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
+	ath79_wdt_enable(wdt, wdd->timeout);

 	return 0;
 }

-static ssize_t ath79_wdt_write(struct file *file, const char *data,
-				size_t len, loff_t *ppos)
+static unsigned int ath79_wdt_get_timeleft(struct watchdog_device *wdd)
 {
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
+	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);

-			for (i = 0; i != len; i++) {
-				char c;
-
-				if (get_user(c, data + i))
-					return -EFAULT;
+	return ath79_wdt_rr(wdt, WDOG_REG_TIMER) / wdt->freq;
+}

-				if (c == 'V')
-					set_bit(WDT_FLAGS_EXPECT_CLOSE,
-						&wdt_flags);
-			}
-		}
+static int ath79_wdt_stop(struct watchdog_device *wdd)
+{
+	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);

-		ath79_wdt_keepalive();
-	}
+	ath79_wdt_disable(wdt);

-	return len;
+	return 0;
 }

 static const struct watchdog_info ath79_wdt_info = {
-	.options		= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-				  WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
-	.firmware_version	= 0,
-	.identity		= "ATH79 watchdog",
-};
-
-static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int err;
-	int t;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		err = copy_to_user(argp, &ath79_wdt_info,
-				   sizeof(ath79_wdt_info)) ? -EFAULT : 0;
-		break;
-
-	case WDIOC_GETSTATUS:
-		err = put_user(0, p);
-		break;
-
-	case WDIOC_GETBOOTSTATUS:
-		err = put_user(boot_status, p);
-		break;
-
-	case WDIOC_KEEPALIVE:
-		ath79_wdt_keepalive();
-		err = 0;
-		break;
-
-	case WDIOC_SETTIMEOUT:
-		err = get_user(t, p);
-		if (err)
-			break;
-
-		err = ath79_wdt_set_timeout(t);
-		if (err)
-			break;
-		fallthrough;
-
-	case WDIOC_GETTIMEOUT:
-		err = put_user(timeout, p);
-		break;
-
-	default:
-		err = -ENOTTY;
-		break;
-	}
-
-	return err;
-}
-
-static const struct file_operations ath79_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.write		= ath79_wdt_write,
-	.unlocked_ioctl	= ath79_wdt_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
-	.open		= ath79_wdt_open,
-	.release	= ath79_wdt_release,
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
+	.firmware_version = 0,
+	.identity = "ATH79 watchdog",
 };

-static struct miscdevice ath79_wdt_miscdev = {
-	.minor = WATCHDOG_MINOR,
-	.name = "watchdog",
-	.fops = &ath79_wdt_fops,
+static const struct watchdog_ops ath79_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ath79_wdt_start,
+	.stop = ath79_wdt_stop,
+	.ping = ath79_wdt_ping,
+	.set_timeout = ath79_wdt_set_timeout,
+	.get_timeleft = ath79_wdt_get_timeleft,
 };

 static int ath79_wdt_probe(struct platform_device *pdev)
 {
+	struct ath79_wdt *wdt;
+	struct clk *wdt_clk;
 	u32 ctrl;
-	int err;

-	if (wdt_base)
-		return -EBUSY;
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;

-	wdt_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(wdt_base))
-		return PTR_ERR(wdt_base);
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);

 	wdt_clk = devm_clk_get_enabled(&pdev->dev, "wdt");
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);

-	wdt_freq = clk_get_rate(wdt_clk);
-	if (!wdt_freq)
+	wdt->freq = clk_get_rate(wdt_clk);
+	if (!wdt->freq)
 		return -EINVAL;

-	max_timeout = (0xfffffffful / wdt_freq);
-	if (timeout < 1 || timeout > max_timeout) {
-		timeout = max_timeout;
-		dev_info(&pdev->dev,
-			"timeout value must be 0 < timeout < %d, using %d\n",
-			max_timeout, timeout);
-	}
+	ctrl = ath79_wdt_rr(wdt, WDOG_REG_CTRL);
+	wdt->wdd.bootstatus = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;

-	ctrl = ath79_wdt_rr(WDOG_REG_CTRL);
-	boot_status = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
+	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.info = &ath79_wdt_info;
+	wdt->wdd.ops = &ath79_wdt_ops;
+	wdt->wdd.min_timeout = 1;
+	wdt->wdd.timeout = WDT_TIMEOUT;
+	wdt->wdd.max_timeout = U32_MAX / wdt->freq;
+	watchdog_init_timeout(&wdt->wdd, timeout, &pdev->dev);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
+	watchdog_stop_on_reboot(&wdt->wdd);

-	err = misc_register(&ath79_wdt_miscdev);
-	if (err) {
-		dev_err(&pdev->dev,
-			"unable to register misc device, err=%d\n", err);
-		return err;
-	}
+	watchdog_set_drvdata(&wdt->wdd, wdt);

-	return 0;
-}
-
-static void ath79_wdt_remove(struct platform_device *pdev)
-{
-	misc_deregister(&ath79_wdt_miscdev);
-}
-
-static void ath79_wdt_shutdown(struct platform_device *pdev)
-{
-	ath79_wdt_disable();
+	return devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 }

 static const struct of_device_id ath79_wdt_match[] = {
@@ -303,8 +207,6 @@ MODULE_DEVICE_TABLE(of, ath79_wdt_match);

 static struct platform_driver ath79_wdt_driver = {
 	.probe		= ath79_wdt_probe,
-	.remove		= ath79_wdt_remove,
-	.shutdown	= ath79_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = ath79_wdt_match,
@@ -314,7 +216,7 @@ static struct platform_driver ath79_wdt_driver = {
 module_platform_driver(ath79_wdt_driver);

 MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X hardware watchdog driver");
-MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
-MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRIVER_NAME);
--
2.54.0

