Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B63AFD02
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786909; cv=none; b=aLMaRl58EOkmEJ6JPxvUuRM/GDuqocfD5mEVJKRuwa2HQS2Nvu09561IMZJT2y9oTjDEt2Uk1YyvVEuF79HSWxkUwrk/Xu1s1NFTTQvaK7jWnkLRmulvg3qjzTeJVIEOBj+N/DNv5xNKO1w5Rd0cFUXDg4Sr7MLGGvJX4GWVmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786909; c=relaxed/simple;
	bh=glkag6YepVngxtTaCB6w2w4JLFECULv8W7+KhdLjYhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fM/Hxh0tebPIU5mLR0e4qEya9J0k/NQdjjqWgrnLdR2u1An5+/D8sO0BuA/mDQ3/IKexGDhKjNp5sDZHDBTzKiMFkrDGbH8fUdDtTHnY1S3JQYV5bJQe1CC2P2m9prbEBvaK8AsnF8f61inAHstVWWcXXem3Ax+M9Diqog0BFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLg66mYk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLg66mYk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso3568165ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784786907; x=1785391707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6x2aOBje5frBTxDxT/OoHyn8yJc/gXKzhFg2I8WT5vE=;
        b=PLg66mYkQluFYf9nuK/6fU/vMfv7He+U3+Xo1A+2hfXha8sOfkbHEKpXk6z0v8afgL
         AdLgw18Uq/zIMi+7aG6wmsPGk0uQVnTgravN6nywa64UPxbwhk2G8eATAr5+hGWu/ojj
         h56ZllFvjfzxj+xvrDZqZnBrqyy3MN7SVBdRR4S5t2UoanuEccjDGvRLiGouSCVYk5g3
         i3mJEDP/PBzk8+k3iMWFQw7+FNFuyuQA3WRmiqE1bojEfCqVC5t61kx1Ta4u5+JZ1mgB
         a3UBYFNR2U+8vGD3AfBtoPepIR4BJuD7rwgkhbgsBT887gA2mTa6/IpNoqfYJ72lGVDR
         cDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786907; x=1785391707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6x2aOBje5frBTxDxT/OoHyn8yJc/gXKzhFg2I8WT5vE=;
        b=VBpKZX3tnBkaBUe2OrCLVdvy0uzTiC588oyA8dhmOrrp3t6eC2pSEw4fkH7o92hJ5m
         sCBHWjX9SC9t6wACvkGjiu/oAqa+ch4Am5UYXGzXqDgzS7DYQFooqARJ0wMWSomCnQ7R
         LFvIZ+dBCwMRgkPnF9i2v3SYCKNNx2NAC6+nFf6fjvHuL4S7n95ZQg5L65DHcqGXBpNP
         4VKrUG+M3gKO1Fn6Tr+hymuhQuEGUblt7QoxoSeQrMap8FiiMN7wD1y7OVJKtaUEx1zs
         N7TW7aIvz9JT7bQ2sIxR+RIid7lr9+1hq9qeNogW6nQz8UU4vauCRtGgyfFOAwTnFUVt
         NCzA==
X-Forwarded-Encrypted: i=1; AHgh+Rpyq49tSREMCsvZgk+0buyv847lGVWXILy9OwiaVsiBP87sIFN3hW9sXJyua+slaobTRPUZAWu8SADNxUoOFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/OxspB/3yMiNNuR5UCPM4rvDFR8wuS00kjIO8eV1HbFMzN8+
	3ZGMtyzRqFlwYPTc/6iW+X86OAIoRS0BCceoTQmH9+g3Hj7OG4+B7chS
X-Gm-Gg: AR+sD12tW3qcv5paMhoynVMowQJT/xWGIGR5p8fYFY8hnIMN4WtM9v1v5gMLzjEE0ZW
	ge3LP6+zk56Y59g6kwzDoXS+CfIlDZsX+lA4TDIHEmJeRvg1FNBS3MzhIz7pq5UdpBar7JwmGZN
	rA/DAbL0LzNyTXFz38pDSRnk3Fr0hhN7Fw1GObpL/qZpEbdxmU5DFYFzEeRtvtTay3ZdC/P3MEC
	+HXQFeVvNPu0d8gTsDDRfcPX/uI0rD27hiB6NCCEabcZw8JVBwgDBbOfxYiIqci57gvF0GvY19e
	XjQHLPrR5Kr7sPAIiOrpHiRgOpiQiJbDEhQPDHbBzErZ7RxMQ3TgPwMArGznLVon6ZMzD654prM
	/Kn0EZegboLV4DWhO36cemJm73wYRw47abf1i9K2bx+qjOVMVBlI5V8F6mYTEOkVMhF6jrnVcid
	+nignxtS5M7+Cy1Z4nCPjhsgESsvnmfq5o3KquzFtuvidcvhVoPcOU9L6r/h3H
X-Received: by 2002:a17:902:cf42:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2cfa7091618mr23349475ad.25.1784786907130;
        Wed, 22 Jul 2026 23:08:27 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f390dd2sm26071285ad.79.2026.07.22.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:08:26 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver support
Date: Thu, 23 Jul 2026 14:07:53 +0800
Message-Id: <20260723060755.1596858-3-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723060755.1596858-1-zychennvt@gmail.com>
References: <20260723060755.1596858-1-zychennvt@gmail.com>
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
 drivers/watchdog/Kconfig      |  11 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/ma35d1_wdt.c | 357 ++++++++++++++++++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 drivers/watchdog/ma35d1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..28d8d3d12c27 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -720,6 +720,17 @@ config STMP3XXX_RTC_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmp3xxx_rtc_wdt.
 
+config MA35D1_WDT
+	tristate "Nuvoton MA35D1 Watchdog Timer"
+	depends on ARCH_MA35 || COMPILE_TEST
+	select WATCHDOG_CORE
+	select MFD_SYSCON
+	help
+	  Say Y here to include support for the watchdog timer
+	  for the Nuvoton MA35D1 series microprosser.
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
index 000000000000..bd52847bb09b
--- /dev/null
+++ b/drivers/watchdog/ma35d1_wdt.c
@@ -0,0 +1,357 @@
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
+	struct device *dev;
+	spinlock_t lock;
+	void __iomem *wdt_base;
+	struct clk *clk;
+	unsigned long clk_rate;
+	u32 irq;
+};
+
+static int ma35d1_wdt_wait_sync(struct ma35d1_wdt_dev *ma35d1_wdt)
+{
+	unsigned int val;
+
+	return readl_relaxed_poll_timeout_atomic(ma35d1_wdt->wdt_base +
+							 REG_WDT_CTL,
+						 val, !(val & SYNC), 10, 125);
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
+
+	unsigned int val;
+	int ret;
+
+	guard(spinlock_irqsave)
+		(&ma35d1_wdt->lock);
+	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	val &= ~WDTEN;
+	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
+	if (ret) {
+		dev_err(ma35d1_wdt->dev, "Wait for WDTEN SYNC timeout!\n");
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
+	target_ticks = (unsigned long)timeout * ma35d1_wdt->clk_rate;
+
+	for (i = 0; i < ARRAY_SIZE(toutsel_shifts); i++) {
+		if ((1UL << toutsel_shifts[i]) >= target_ticks)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(toutsel_shifts))
+		i = ARRAY_SIZE(toutsel_shifts) - 1;
+
+	scoped_guard(spinlock_irqsave, &ma35d1_wdt->lock) {
+		val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
+		val &= ~TOUTSEL;
+		val |= FIELD_PREP(TOUTSEL, i);
+		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
+	}
+
+	/* To avoid truncation errors (0 seconds) during division. */
+	wdt_dev->timeout = (1UL << toutsel_shifts[i]) / ma35d1_wdt->clk_rate;
+	if (wdt_dev->timeout == 0)
+		wdt_dev->timeout = 1;
+
+	dev_dbg(ma35d1_wdt->dev, "wdt_dev->timeout = %d\n", wdt_dev->timeout);
+
+	return 0;
+}
+
+static int ma35d1_wdt_start(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+
+	struct ma35d1_wdt_dev *ma35d1_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = ma35d1_wdt->wdt_base;
+	int ret;
+
+	ret = ma35d1_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	if (ret < 0)
+		return ret;
+
+	guard(spinlock_irqsave)
+		(&ma35d1_wdt->lock);
+	val = readl_relaxed(wdt_base + REG_WDT_CTL);
+	val |= (WDTEN | RSTEN);
+
+	writel_relaxed(val, wdt_base + REG_WDT_CTL);
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
+	guard(spinlock)
+		(&ma35d1_wdt->lock);
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
+	watchdog_set_drvdata(&ma35d1_wdt->wdt_dev, ma35d1_wdt);
+	watchdog_set_nowayout(&ma35d1_wdt->wdt_dev, nowayout);
+	watchdog_init_timeout(&ma35d1_wdt->wdt_dev, timeout, &pdev->dev);
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
+		ret = dev_pm_set_wake_irq(dev, ma35d1_wdt->irq);
+		if (ret)
+			return ret;
+	}
+
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
+	if (watchdog_active(&ma35d1_wdt->wdt_dev)) {
+		u32 val;
+		int ret;
+
+		guard(spinlock_irqsave)
+			(&ma35d1_wdt->lock);
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
+			dev_err(ma35d1_wdt->dev,
+				"Wait for WDTEN SYNC timeout!\n");
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
+	if (watchdog_active(&ma35d1_wdt->wdt_dev)) {
+		u32 val;
+		int ret;
+
+		guard(spinlock_irqsave)
+			(&ma35d1_wdt->lock);
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
+			dev_err(ma35d1_wdt->dev,
+				"Wait for WDTEN SYNC timeout!\n");
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

