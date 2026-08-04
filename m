Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929F42A7B7
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827119; cv=none; b=tSXuowhTxCI8PfWpoxChG1OMsiNOC14vl2EfUKSTu9JPMm2XbqrM3A+EfCYm+m5V/SmSb6JK4ircocL6q8aHYMS21rTFoihH+RJqHK3X5T1g7TkRqG75DZIdsdVcTm53+m4RQeBTz42gASnWjbwSF3B4lHVhdbFoWQVauqmbAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827119; c=relaxed/simple;
	bh=tgzZiHzQgP/Go00YgV0k5nMYtaCevs9Ym7ijyoX2g7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqDCdyN26PMGGxGPi7Opj5tXMXJE3qzgV7/LPOd9YHBb260lnwEKYgvB6ec0ZILeA28CQR/T1PYNnRbvcA1MpkGSlEIcreLClHmL32mEKfqYGW6SpiXv10ysWrJPgptzm/e9BwJAWETm1/S/xzZkXKqaWkU8nOEpK5womzUrjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtMy5ACh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtMy5ACh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383cb94f742so4277920a91.3
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Aug 2026 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827117; x=1786431917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5phx6faOQXEjIrqjCcZdfK2DfhRyfjtnlSeXUuoCJe0=;
        b=BtMy5AChVdo+8ZJPIy7x1idY3DnuKcbbHoE/uyCux6m8BdX44GN6bzK81DFYIO17U2
         S4DA5KKAyXlFzsTaZPLX0Z4y28KzIkuZd6YjSZHxWnHljm4KyJEarsj/NrrHL7IQtRqE
         X7O6kOa8H2k0c7PQUZbEF48vcJxPHU+Ly/CBh8dIlX66QMaCVy41a0H+1mKgQTUrRErz
         GFr6mTq+NPv2rfz5QT5hEpHJuhnpkQu9udBmlbcRZdPyhsuAqi5pbaErwIP5dwy+oP02
         blxn6ffCqxk7FKkEvgh2R+AIp0PtH7+DLy0fxhSDMl7pmZEaYoY9EBw7ErZrPZzYz7JX
         sVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827117; x=1786431917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5phx6faOQXEjIrqjCcZdfK2DfhRyfjtnlSeXUuoCJe0=;
        b=AfoN85+dYEfRp2Bj4wzVzKb8D48StmGkjphTm7uRp7g8Th2U/B5ixikWrK2e07s4em
         IYs4SMov+9vyIcEOxvOR0w2zVLc294m1mYmtkjmSaXir3Q6KTEr7dds6+lBOYtYVXpn7
         W3DGFgYooY0l7jH0+rdZse24/pSQ/ZpvGlSRTdXPt7t8ptMp/637cAchYsNnDaW1d2Q/
         mcsWX8OHbR/bRyH5wlKWCb2bagUUfw3oLnDPKSl9WvZptpIt6UA5hh14SEnEVhnbmZbN
         DqRTKRPnlUH349PAKTVs63jV4xkB5cebYzBMtKqCttZ1Nx+288tNcnVu6j6K1+p8TGDm
         1buQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDU4ivTXOqeRpSxzqR1pwKdEWNWntE+MExE26BGwGYXeuxylbW769l/gs8FxObPJxGm8UpGpps9OLzxJ8UhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9f24G/ODlp2EH14GtSO6+6nwVz68TDHBbmLCWfO3dwynyPgam
	Ki/w6o62U5lWc+PH7YNt9GdbwIm9aGBYSuANRePvMe7IqNYy9anAK6VU
X-Gm-Gg: AR+sD13EnjN1EpWmey8qnelO6lw484PQ45AfRDV+aJYNjrIElT8gzOk9cC+nwg3otK1
	yaPCS9eFuNJ8ezhoLE1Zh/GpIaFKLpFAyE/Prf7AqLByzlZpnZuvDETn9kR1RXfjnCTuFdkRW4K
	MpDN3AMbL53AiLd59QYVgrlRshpiD1qFb7kXprec6wvIALht/msJQCVB4V8jWJhY9Pl2FOfswlD
	5HFNoQET6Ch1VulN8fdWgQe+/4LOLwpo6Ux+yV4CDrIbSEBLzQhBplfjOJikko8OmbaAvFZApZ9
	n2l3W1mNo7YcLCEjgvQS/zSe7RL2HUX4XnWnV5a0gvOpmFArBjLPH9EjZssaptPJSv7VIr/Se+x
	5k04nrK7Aai+GnjUZUIHerE1CQ4INyAzOpRjYI+hDkovl0cRazDahOG8W85WdePzo+v85Stp8ib
	gF1Yb9AyFiiHmA85yAOzIJkbMStXpuwR2NHrUly9r5+6YDDS2USHyy1QG1YMZBy3GdgGo2lzNtO
	SSqzkkPOKIkiD4jKNgvuaRpz/UHvMQZWFoYJYNQrYawW/8=
X-Received: by 2002:a17:90b:48c7:b0:381:26f:8f05 with SMTP id 98e67ed59e1d1-38fbc3ff29dmr10769007a91.3.1785827116930;
        Tue, 04 Aug 2026 00:05:16 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfd8ff8sm859815a91.4.2026.08.04.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:05:16 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v3 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver support
Date: Tue,  4 Aug 2026 15:03:50 +0800
Message-Id: <20260804070351.1846165-3-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804070351.1846165-1-zychennvt@gmail.com>
References: <20260804070351.1846165-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver support for the Watchdog Timer (WDT) integrated in
Nuvoton MA35D1 SoC. This driver provides standard watchdog functionality,
including timeout configuration, ping, and system reset support via
the watchdog framework.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 drivers/watchdog/Kconfig      |  10 +
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/ma35d1_wdt.c | 363 ++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)
 create mode 100644 drivers/watchdog/ma35d1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..e9b32f8cb9b5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -720,6 +720,16 @@ config STMP3XXX_RTC_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmp3xxx_rtc_wdt.
 
+config MA35D1_WDT
+	tristate "Nuvoton MA35D1 Watchdog Timer"
+	depends on ARCH_MA35 || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  for the Nuvoton MA35D1 series microprocessor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called ma35d1_wdt.
+
 config TS4800_WATCHDOG
 	tristate "TS-4800 Watchdog"
 	depends on HAS_IOMEM && OF
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index bc1d52220f22..a7889eb48c7f 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
 obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
 obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
 obj-$(CONFIG_GUNYAH_WATCHDOG) += gunyah_wdt.o
+obj-$(CONFIG_MA35D1_WDT) += ma35d1_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/watchdog/ma35d1_wdt.c b/drivers/watchdog/ma35d1_wdt.c
new file mode 100644
index 000000000000..119d58f338bf
--- /dev/null
+++ b/drivers/watchdog/ma35d1_wdt.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Nuvoton technology corporation.
+ *
+ * Author: Zi-Yu Chen <zychennvt@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/property.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define DRV_NAME		"ma35d1-wdt"
+
+#define REG_WDT_CTL		0x00
+#define REG_WDT_RSTCNT	0x08
+
+#define TOUTSEL			GENMASK(11, 8)
+#define WDTEN			BIT(7)
+#define INTEN			BIT(6)
+#define WKF				BIT(5)
+#define WKEN			BIT(4)
+#define IF				BIT(3)
+#define RSTF			BIT(2)
+#define RSTEN			BIT(1)
+#define SYNC			BIT(30)
+
+#define WDT_DEFAULT_TIMEOUT		32
+#define RESET_COUNTER			0x00005AA5
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static unsigned int timeout;
+
+struct ma35d1_wdt_dev {
+	struct watchdog_device wdt_dev;
+	spinlock_t lock;
+	void __iomem *wdt_base;
+	struct clk *clk;
+	unsigned long clk_rate;
+	int irq;
+};
+
+static int ma35d1_wdt_wait_sync(struct ma35d1_wdt_dev *ma35d1_wdt)
+{
+	unsigned int val;
+
+	return readl_relaxed_poll_timeout_atomic(ma35d1_wdt->wdt_base +
+							 REG_WDT_CTL, val, !(val & SYNC), 10, 125);
+}
+
+/**
+ * ma35d1_wdt_stop - Stop the watchdog.
+ *
+ * @wdt_dev: watchdog device
+ *
+ * Read the contents of the CTL register, clear the WDTEN bit
+ * in the register and set the access key for successful write.
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+static int ma35d1_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned int val;
+	int ret;
+
+	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
+	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	val &= ~WDTEN;
+	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
+	if (ret) {
+		dev_err(wdt_dev->parent, "Wait for WDTEN SYNC timeout!\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int ma35d1_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = watchdog_get_drvdata(wdt_dev);
+
+	writel_relaxed(RESET_COUNTER, ma35d1_wdt->wdt_base + REG_WDT_RSTCNT);
+
+	return 0;
+}
+
+static int ma35d1_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				  unsigned int timeout)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned long target_ticks;
+	unsigned int val, i;
+	static const uint8_t toutsel_shifts[] = { 4,  6,  8,  10, 12,
+						  14, 16, 18, 20 };
+
+	if (timeout < (ma35d1_wdt->wdt_dev.max_hw_heartbeat_ms / 1000)) {
+		target_ticks = (unsigned long)timeout * ma35d1_wdt->clk_rate;
+
+		for (i = 0; i < ARRAY_SIZE(toutsel_shifts); i++) {
+			if ((1UL << toutsel_shifts[i]) >= target_ticks)
+				break;
+		}
+		/* To avoid truncation errors (0 seconds) during division. */
+		wdt_dev->timeout =
+			(1UL << toutsel_shifts[i]) / ma35d1_wdt->clk_rate;
+		if (wdt_dev->timeout == 0)
+			wdt_dev->timeout = 1;
+
+	} else {
+		i = ARRAY_SIZE(toutsel_shifts) - 1;
+		wdt_dev->timeout = timeout;
+	}
+
+	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
+	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	val &= ~TOUTSEL;
+	val |= FIELD_PREP(TOUTSEL, i);
+	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+
+	ma35d1_wdt_ping(wdt_dev);
+	return 0;
+}
+
+static int ma35d1_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = ma35d1_wdt->wdt_base;
+	unsigned int val;
+	int ret;
+
+	ret = ma35d1_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	if (ret < 0)
+		return ret;
+
+	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
+	val = readl_relaxed(wdt_base + REG_WDT_CTL);
+	val |= (WDTEN | RSTEN);
+
+	writel_relaxed(val, wdt_base + REG_WDT_CTL);
+	ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
+	if (ret) {
+		dev_err(wdt_dev->parent, "Wait for WDTEN SYNC timeout!\n");
+		return ret;
+	}
+
+	writel_relaxed(RESET_COUNTER, wdt_base + REG_WDT_RSTCNT);
+
+	return 0;
+}
+
+static const struct watchdog_info ma35d1_wdt_info = {
+	.identity = DRV_NAME,
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
+		   WDIOF_CARDRESET,
+};
+
+static const struct watchdog_ops ma35d1_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ma35d1_wdt_start,
+	.stop = ma35d1_wdt_stop,
+	.ping = ma35d1_wdt_ping,
+	.set_timeout = ma35d1_wdt_set_timeout,
+};
+
+static irqreturn_t ma35d1_wdt_isr(int irq, void *dev_id)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = dev_id;
+	unsigned int val;
+
+	/* Clear the flag if set */
+	guard(spinlock)(&ma35d1_wdt->lock);
+	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+
+	return IRQ_HANDLED;
+}
+
+static int ma35d1_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ma35d1_wdt_dev *ma35d1_wdt;
+	unsigned long clk_rate, val;
+	int ret;
+
+	ma35d1_wdt = devm_kzalloc(dev, sizeof(*ma35d1_wdt), GFP_KERNEL);
+	if (!ma35d1_wdt)
+		return -ENOMEM;
+
+	spin_lock_init(&ma35d1_wdt->lock);
+	platform_set_drvdata(pdev, ma35d1_wdt);
+
+	ma35d1_wdt->wdt_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ma35d1_wdt->wdt_base))
+		return PTR_ERR(ma35d1_wdt->wdt_base);
+
+	ma35d1_wdt->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(ma35d1_wdt->clk))
+		return dev_err_probe(dev, PTR_ERR(ma35d1_wdt->clk),
+				     "Can't get Watchdog clock\n");
+
+	clk_rate = clk_get_rate(ma35d1_wdt->clk);
+	if (!clk_rate)
+		return -EINVAL;
+	ma35d1_wdt->clk_rate = clk_rate;
+
+	ma35d1_wdt->irq = platform_get_irq(pdev, 0);
+	if (ma35d1_wdt->irq < 0)
+		return dev_err_probe(dev, ma35d1_wdt->irq,
+				     "failed to get irq\n");
+
+	ma35d1_wdt->wdt_dev.info = &ma35d1_wdt_info;
+	ma35d1_wdt->wdt_dev.ops = &ma35d1_wdt_ops;
+	ma35d1_wdt->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
+	ma35d1_wdt->wdt_dev.min_timeout = 1;
+	ma35d1_wdt->wdt_dev.max_hw_heartbeat_ms = (1U << 20) * 1000 / clk_rate;
+	ma35d1_wdt->wdt_dev.parent = dev;
+
+	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	if (val & RSTF) {
+		ma35d1_wdt->wdt_dev.bootstatus = WDIOF_CARDRESET;
+		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	}
+
+	if (val & WDTEN)
+		set_bit(WDOG_HW_RUNNING, &ma35d1_wdt->wdt_dev.status);
+
+	watchdog_set_drvdata(&ma35d1_wdt->wdt_dev, ma35d1_wdt);
+	watchdog_set_nowayout(&ma35d1_wdt->wdt_dev, nowayout);
+	watchdog_init_timeout(&ma35d1_wdt->wdt_dev, timeout, &pdev->dev);
+
+	ma35d1_wdt_set_timeout(&ma35d1_wdt->wdt_dev,
+			       ma35d1_wdt->wdt_dev.timeout);
+
+	ret = devm_request_irq(dev, ma35d1_wdt->irq, ma35d1_wdt_isr, 0,
+			       dev_name(dev), ma35d1_wdt);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot claim IRQ %d\n",
+				     ma35d1_wdt->irq);
+
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return ret;
+
+		ret = devm_pm_set_wake_irq(dev, ma35d1_wdt->irq);
+		if (ret)
+			return ret;
+	}
+
+	watchdog_stop_on_reboot(&ma35d1_wdt->wdt_dev);
+	watchdog_stop_on_unregister(&ma35d1_wdt->wdt_dev);
+	ret = devm_watchdog_register_device(dev, &ma35d1_wdt->wdt_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ma35d1_wdt_suspend(struct device *dev)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&ma35d1_wdt->wdt_dev) ||
+	    watchdog_hw_running(&ma35d1_wdt->wdt_dev)) {
+		u32 val;
+		int ret;
+
+		guard(spinlock_irqsave)(&ma35d1_wdt->lock);
+		val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+
+		if (device_may_wakeup(dev)) {
+			val &= ~RSTEN;
+			val |= (INTEN | WKEN);
+		} else {
+			val &= ~(WDTEN | RSTEN);
+		}
+		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+		ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
+		if (ret) {
+			dev_err(dev, "Wait for WDTEN SYNC timeout!\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ma35d1_wdt_resume(struct device *dev)
+{
+	struct ma35d1_wdt_dev *ma35d1_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&ma35d1_wdt->wdt_dev) ||
+	    watchdog_hw_running(&ma35d1_wdt->wdt_dev)) {
+		u32 val;
+		int ret;
+
+		guard(spinlock_irqsave)(&ma35d1_wdt->lock);
+		val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+
+		if (device_may_wakeup(dev)) {
+			val |= RSTEN;
+			val &= ~(INTEN | WKEN);
+		} else {
+			val |= (WDTEN | RSTEN);
+		}
+		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+		writel_relaxed(RESET_COUNTER,
+			       ma35d1_wdt->wdt_base + REG_WDT_RSTCNT);
+		ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
+		if (ret) {
+			dev_err(dev, "Wait for WDTEN SYNC timeout!\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ma35d1_wdt_pm_ops, ma35d1_wdt_suspend,
+				ma35d1_wdt_resume);
+
+static const struct of_device_id ma35d1_wdt_dt_ids[] = {
+	{ .compatible = "nuvoton,ma35d1-wdt" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ma35d1_wdt_dt_ids);
+
+static struct platform_driver ma35d1_wdt_driver = {
+	.probe		= ma35d1_wdt_probe,
+	.driver		= {
+		.name	= DRV_NAME,
+		.pm	= pm_ptr(&ma35d1_wdt_pm_ops),
+		.of_match_table = ma35d1_wdt_dt_ids,
+	},
+};
+
+module_platform_driver(ma35d1_wdt_driver);
+
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(
+	nowayout,
+	"Watchdog cannot be stopped once started (default=" __MODULE_STRING(
+		WATCHDOG_NOWAYOUT) ")");
+
+MODULE_AUTHOR("Zi-Yu Chen <zychennvt@gmail.com>");
+MODULE_DESCRIPTION("Nuvoton MA35D1 Watchdog Timer Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

