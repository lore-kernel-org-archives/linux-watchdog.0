Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235F1F5847
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150828; cv=none; b=Uba6X3ahPU8ua0/5nCukRVzZ1vrui6hFc09d17Zb1DmLSGOavNUyzrYupsr3LgnR/UQ3VGHLvbKnbf3RiWKY7YCHEaTGl+QjepcFPEyLZa2+JlX270zYGPWbiOut0To8zaXQRNQ9iNMwP9x66ZejUla2zThBbnwUn6diIZ5USL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150828; c=relaxed/simple;
	bh=lrJ282NK9fi8qqGMccNAIXekUuVRnEMIpVboAyy/jk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqJoU/3OknlhVRo+Fn9evj4tFi7n7dEEdY6YCWAN4niZT9ECDzgSuA3WbDo7zKHBmnlnye0xhc+oUpaSpn5RSZQz0yb+1ZlcIOCud9NKJWViedsuhcd0kZXm+V/OcBV1b8JqYD66sg9kL9G5SCGWFzrn4A3Pf0UfmhBnKHSxoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNqDeZLe; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNqDeZLe"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so1192435a12.0
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779150825; x=1779755625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNs2kxwC7/9yf6VBEm5tsn713iTGlZ3XWuPjzBHMItI=;
        b=nNqDeZLeiapyaHkPHgp7s4nEdKSJZ0smNzD/CX7J3YaRtrQwoXMBiPAacy1ljdKU13
         KAPfIdfun75JHpKMorb/otgOJcUAXGAaP07Yu423k1IIhboFCOyiiqr9kyD3d+ywmTn/
         VtJyVPbPjPLrA0oEVhXnm/YwRmp6J9aWxZd5nzSg6BHl5B+NFqYkcXeyAKmOeshlz1N6
         MtuOGXe5/080tdKW+vtOF3SmJ1KvXwAZioaaBjwfGml403zGMfnLu2ruSA6TFjA3EKml
         Pwr14zmG3+5vYvzIaSSvUudWnEorybtezZqXx5cmYIDaukszTLV5uy9P3lv6tE9Fkiw4
         +aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779150825; x=1779755625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNs2kxwC7/9yf6VBEm5tsn713iTGlZ3XWuPjzBHMItI=;
        b=gZLqf0XVwcodY0CS7vXqrWh1h0uVNwto2JxH8vJQbNFDbZIurLZFTvDE/WJf0c/2LP
         AqFW8J8h3rXhaH3dO0dzY6p2urAMpD+P7qvY3a96MiA7ODh3sgC0L5TbP/8Qs8FyDDCV
         0Irbu2MeF1G8k3YxVud7U0NhSlxjhAUKAbk+Yx4zfnJTailcxq+UXiuBgzMYEcvRfUbw
         5Z8WFVXZSy2vDwJk7e1789YbGNgQkxdH8tIixBrN4oFV+0dLIfZmRUTMIWgvEVjMgf4r
         WSPQo/sSPd6FtjQz8ph++7xmAzSwhFkgQ6SlyxfysWRhqzvLBiLN0zytNP1QJ/n3rJP6
         YjlA==
X-Gm-Message-State: AOJu0YzwKdWuoSeZK5e/ULF7tLMeMUT+v0iQb7wep9+8RGgmgpsi1tkK
	MB4qMbZkxHb99tsFL0wX8BhDOJD1bFUxN8spBg1GNh4iCKmEXq+Q2t5F5Cv8SkHS
X-Gm-Gg: Acq92OEJDuVtymzH5KBtJOwH91Q8g/IHxbsDEQD1bT1te3bIbnhIxnLZip1I5j6hlkL
	V/syGsfOT79F19OP1ljwKEaXT9NIwbXl2adRE8zT7b17htnVekyk/9WELhhWNZUXzvqZ6+GjLDX
	dEioBu4m/QTV82XrJOf0h0Sb+pbWEGI+7qXyIpBy9c1Vj7+Dx5PEeRWAu3UJZY/VJkyu6LGuar9
	Cb/u9CA/MLwyt7IBWLnU8GcmYb9AAAKC5Nw79Gyt+pjxVh51jKTd6OKJ5/T9cEi4ADKiMlKvlO6
	GjhQhtNO7K7yW9fcMDbCcAtnDH50kUQYUmfr7gLNyl+/Ohe4WrDJgk5OF9RM+c2qDj4adso9SVU
	rBTmTR5NGLOauYTqARQ4FeUsQD7F8UqI5Wek46/IiGvVrEe8S8EA6OjOgy5HVy6HpaTThA8d8Tv
	4KPMl6ae0y+T6UsntCX239uUGzqKmtWd/e3qmpAi4YdYEky7Dq1v2AkXyRZDVNqzNxiRsyHovMg
	UKpbwqi0m9zvx7PeOKKz9GNzB7dXvNEAhE=
X-Received: by 2002:a17:902:ea03:b0:2bd:9c0a:32c with SMTP id d9443c01a7336-2bd9c0a065cmr131763175ad.19.1779150824706;
        Mon, 18 May 2026 17:33:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm170572785ad.46.2026.05.18.17.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:33:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: ath79: convert to watchdog_device
Date: Mon, 18 May 2026 17:33:26 -0700
Message-ID: <20260519003326.625858-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converts from the legacy miscdevice/file_operations interface to the
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
 drivers/watchdog/ath79_wdt.c | 244 +++++++++++------------------------
 1 file changed, 73 insertions(+), 171 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 409a40b14901..d83957712c02 100644
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
+static inline void ath79_wdt_wr(struct ath79_wdt *wdt, unsigned reg, u32 val)
 {
-	iowrite32(val, wdt_base + reg);
+	iowrite32(val, wdt->base + reg);
 }
 
-static inline u32 ath79_wdt_rr(unsigned reg)
+static inline u32 ath79_wdt_rr(struct ath79_wdt *wdt, unsigned reg)
 {
-	return ioread32(wdt_base + reg);
+	return ioread32(wdt->base + reg);
 }
 
-static inline void ath79_wdt_keepalive(void)
+static inline void ath79_wdt_keepalive(struct ath79_wdt *wdt)
 {
-	ath79_wdt_wr(WDOG_REG_TIMER, wdt_freq * timeout);
+	ath79_wdt_wr(wdt, WDOG_REG_TIMER, wdt->freq * wdt->wdd.timeout);
 	/* flush write */
-	ath79_wdt_rr(WDOG_REG_TIMER);
+	ath79_wdt_rr(wdt, WDOG_REG_TIMER);
 }
 
-static inline void ath79_wdt_enable(void)
+static inline void ath79_wdt_enable(struct ath79_wdt *wdt)
 {
-	ath79_wdt_keepalive();
+	ath79_wdt_keepalive(wdt);
 
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
+	ath79_wdt_keepalive(wdt);
 
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
+	ath79_wdt_keepalive(wdt);
 
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
+	ath79_wdt_enable(wdt);
 
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
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_CARDRESET,
+	.firmware_version = 0,
+	.identity = "ATH79 watchdog",
 };
 
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
-};
-
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
-
-	ctrl = ath79_wdt_rr(WDOG_REG_CTRL);
-	boot_status = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
+	wdt->wdd.max_timeout = U32_MAX / wdt->freq;
 
-	err = misc_register(&ath79_wdt_miscdev);
-	if (err) {
-		dev_err(&pdev->dev,
-			"unable to register misc device, err=%d\n", err);
-		return err;
-	}
+	ctrl = ath79_wdt_rr(wdt, WDOG_REG_CTRL);
+	wdt->wdd.bootstatus = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
 
-	return 0;
-}
+	wdt->wdd.info = &ath79_wdt_info;
+	wdt->wdd.ops = &ath79_wdt_ops;
+	wdt->wdd.min_timeout = 1;
+	wdt->wdd.timeout = WDT_TIMEOUT;
+	watchdog_init_timeout(&wdt->wdd, timeout, &pdev->dev);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
+	watchdog_stop_on_reboot(&wdt->wdd);
 
-static void ath79_wdt_remove(struct platform_device *pdev)
-{
-	misc_deregister(&ath79_wdt_miscdev);
-}
+	watchdog_set_drvdata(&wdt->wdd, wdt);
 
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

