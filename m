Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483719;
	b=ZnVmrT6eEeLJN4y2wpbQnysOUQ/Esm5vGgZObArLFIuiYxw+UvFd7yMC6sAbEgLxI8hR
	 rTX8/70/Q9LIOv5pwfBdeftNUNPMILuU5Yl7c9qJz3AF94b9MwVsynnkhUAqxpuzg3rL7
	 NNNv26YlkMMAQQvdYVd5K2SOH4o8chXcxjz39d+FXFf9Pei5btM1/rkvxXD35bQA6ZDGi
	 kqp9gj1E5YIM9ZkV4HSMIHxPtTvBLim40FHaLa3ry+yuLbva4tx7j0S79p7JicjiRLIEa
	 TbLB+knzT8G9/UDlWcW3iCTMX8HCNwe/3ykTQGieTj8DapuvrfU37VPQA1rXxsn7myA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fh0x5VQQJAWMGfm2v5ASdgMgkGoChGrLjbjXEFbyGzQ=;
	b=YbHLLCrBEiPLVwFCo5jX0q3zrTMg0CyEADrXzgSgxubkx79kTFr1YV5s3uDs0jvMy3Ot
	 f4ytphk7bP4yMukRk7kVcAsPzViFOW9RZbKMzX/1H4GqscabKFb+WXlFY1hb8hSrnkLX3
	 mrUTJJg4uGy5GTl75MANInNi9lrpRhY1mmv3nuOOE60NamSp0GnKq08qNC+VDZApJOYv0
	 61EHPh1TMCpJhag9m4k9tKweXj0TqoOh/Ze+8Mh6S8A6KDyR1kQ2SGsZ6zgokDmOHJ9Ac
	 LkVuA4cPB4TlUfl9PNVJHzvdHFmIPqT+vjCSM3BKLKWsXgI+PtIplEiNUHjLmM0eKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=olXbCxTn;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9E606A32C
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 01:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA9E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=olXbCxTn
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2f59de176so3119964b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 17:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483717; x=1796088517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fh0x5VQQJAWMGfm2v5ASdgMgkGoChGrLjbjXEFbyGzQ=;
        b=olXbCxTn1RDLkyz937SafHWBqMmoo/fGOy6wXqNzAazQuj4bc2tiu4ErWt1mNcUSq+
         2oBHTvIl5WAuvE4awPGa9LsL8WVHkhal4MKXgt/hJ67Pa3huLpbQy2+J7GJobcljfr2M
         nMqMbHVwh5WAVutkcA8axYYS+bfxZHGhIxxhheQ1W9I00Pd2a2EFSvLPUlbz0EldSatA
         sm1Wx1u5Zqa0+7J4q00ey6DEe9o9hcc0IQ9XFdIQmKlfr8o+Cdlaxs32HjLym2UODKVJ
         Vedk6VpJM1Z6CFF6ccbGjH/e/zBKqG16B/gdD8t+21puJaUtvgof21L50kw1BZ9ZWhXP
         3AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483717; x=1796088517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fh0x5VQQJAWMGfm2v5ASdgMgkGoChGrLjbjXEFbyGzQ=;
        b=pyrnjFi+b7k01Wqq1Vtnnuz5X18h5k3YcAaHJnVHilDstW68iwcprE+g6k70AxyeDC
         WL2NxpvEzGEB9pzLV00gZVEBDFMACLyxmKF3ID4IKpLNuKdaprzepflV5yxMZB77Grf4
         Sqiu8WupbeLYIgXDzf6mvridYSnwk/Adlh+xTnLtavNaYn5Tj5s5H0hSERdqWbW/09dW
         e5SsL3BXnUfqhCXPvb4keqXIjccYw9FkZ+YWkq/7oDHVyJZLq7MV11XfK9J2FvR0RONp
         S+7yOLcKUkRXa/HlLhd6NJ0aTjfPtp7mRfiC4cpp+3I8azbzL1sRMKnN1+6KdaBvNyaR
         +U/Q==
X-Gm-Message-State: APuU4Z8PRaTNqcsDmTPFtJ4qXPJ3aRLFvR17BcbE3vDoUZXIVIuDXz/X
	1RabhnPkGxSYM194LYMvak5ha4v/k+G0tSpJPXI3xM428BBdspf1QlKQ5i2zxMpS
X-Gm-Gg: AZFdTZfRN/wBIs56ZWp74dNjrtG3SX2DkH+3pH4C0KrrRn8Pd2hs8XhK0LNRIQ51qsX
	SOl8UOnlx99mcbYT7+0u1Q9gkoU0ROvzSiGdKLPcDtqtaofWcvihAmbV1QOE6wCBkroz3rX+vKY
	ofp1O/sG00nt3fFvOMUustyKAThRLAOVJFTRs981d1FoduyVCpprYRttKFOhyss+NKZALWurOM4
	9r23RqDdpIAQAX07VZArtaSAjBYYgJuQ8bjtm8XCzVFsvfOCSkGZoiVvvGNIUQ+pr8/SaaU5pQb
	PJC4B8xlEkKhrxUYlDnWNuI14P9KqKD+CNaz7O4JWLPrlOWrhB0bnxQU3LV5oqbgNOHyg7RmGpx
	ozbs7pROOnr6J7N1Q3LKy4rO03v+p6fmSBNTzi4+LOIhx+bi33fb7HStU6thiL38aTuIr1+WMWM
	Zns/fcaJaq/aUOGgLPntm/L8mvzovDKh+FHAecDpJ3yjlZtFAmnccNL75ph2GBxB+iWObzDa7Bn
	iEttY675tJ3sWXN2T0QBV73nf6khEgTsz039iN7xsitgdr6O+zkFWf5TK5Qg+IouMFTvhefRFNQ
	tKB+iRHfEGXFMh80Kyi3GxGC1723k/VbF1hHdwgUF0q78YPrDyusElxCSZe2RvE3FsaWC02GKed
	i
X-Received: by 2002:a05:6a00:a117:b0:883:71f6:5fb with SMTP id d2e1a72fcca58-8c87b4f42ccmr11288308b3a.13.1795483717212;
        Mon, 23 Nov 2026 17:28:37 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4d0:8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm6115243b3a.30.2026.11.23.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:28:36 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] watchdog: histb: Add HiSilicon STB watchdog driver
Date: Tue, 24 Nov 2026 09:27:36 +0800
Message-ID: <20261124012755.328774-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124012755.328774-1-mmyangfl@gmail.com>
References: <20261124012755.328774-1-mmyangfl@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog integrated on HiSilicon STB SoCs reuses the register layout
of sp805, but deviates from the standard sp805 in several ways that make
the existing sp805 driver unusable on these SoCs. Add a dedicated
platform driver to handle these SoC-specific semantics natively without
regressing generic SP805 users.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/watchdog/Kconfig     |   8 +
 drivers/watchdog/Makefile    |   1 +
 drivers/watchdog/histb_wdt.c | 305 +++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/watchdog/histb_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..d3421bb76326 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1183,6 +1183,14 @@ config SUNPLUS_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sunplus_wdt.
 
+config HISTB_WATCHDOG
+	tristate "HiSilicon STB Watchdog"
+	depends on (ARCH_HISI || COMPILE_TEST) && OF
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer in HiSilicon STB
+	  SoCs.
+
 # X86 (i386 + ia64 + x86_64) Architecture
 
 config ACQUIRE_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9ac406677aba..d2455e54ab23 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
 obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
 obj-$(CONFIG_GUNYAH_WATCHDOG) += gunyah_wdt.o
 obj-$(CONFIG_MA35D1_WDT) += ma35d1_wdt.o
+obj-$(CONFIG_HISTB_WATCHDOG) += histb_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/watchdog/histb_wdt.c b/drivers/watchdog/histb_wdt.c
new file mode 100644
index 000000000000..456de7e92562
--- /dev/null
+++ b/drivers/watchdog/histb_wdt.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * HiSilicon STB Watchdog Driver
+ *
+ * The watchdog integrated on HiSilicon STB SoCs reuses the register layout of
+ * sp805, but deviates from the standard sp805 in several ways that make the
+ * existing sp805 driver unusable on these SoCs:
+ *   - The ID registers at 0xfe0..0xffc are unimplemented and read zero,
+ *     requiring a platform device driver rather than AMBA probe;
+ *   - Writing WDTLOCK freezes the counter instead of only blocking register
+ *     writes, so the block must remain unlocked while running;
+ *   - Writing WDTLOAD never reloads the running counter; the counter takes
+ *     WDTLOAD when re-armed by WDTINTCLR or by enabling WDTCONTROL;
+ *   - Writing WDTLOAD with 0 results in a counter starting at 0xffffffff,
+ *     resetting after 2*179s (~6min) at 24 MHz;
+ *   - The counter only advances while unlocked and INT_ENABLE is set.
+ *
+ * Copyright (c) 2026 David Yang
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/spinlock.h>
+#include <linux/watchdog.h>
+
+#define HISTB_WDT_LOAD			0x000
+#define HISTB_WDT_VALUE			0x004
+#define HISTB_WDT_CONTROL		0x008
+#define  HISTB_WDT_RESET_ENABLE			BIT(1)
+#define  HISTB_WDT_INT_ENABLE			BIT(0)
+#define HISTB_WDT_INTCLR		0x00c
+#define HISTB_WDT_RIS			0x010
+#define HISTB_WDT_MIS			0x014
+#define  HISTB_WDT_INT_MASK			BIT(0)
+#define HISTB_WDT_LOCK			0xc00
+#define  HISTB_WDT_UNLOCK_KEY			0x1acce551
+#define  HISTB_WDT_LOCK_KEY			0x00000001
+
+#define MHz 1000000
+
+/* default timeout in seconds */
+#define HISTB_WDT_DEFAULT_TIMEOUT	60
+
+struct histb_wdt {
+	struct watchdog_device wdd;
+
+	void __iomem *base;
+	struct clk *clk;
+	spinlock_t lock;
+	u32 rate;
+	u32 load_val;
+};
+
+/* load cannot be 0, see documentation */
+static void histb_wdt_arm(struct histb_wdt *wdt, u32 load)
+{
+	void __iomem *base = wdt->base;
+
+	writel_relaxed(HISTB_WDT_UNLOCK_KEY, base + HISTB_WDT_LOCK);
+	writel_relaxed(0, base + HISTB_WDT_CONTROL);
+	writel_relaxed(HISTB_WDT_INT_MASK, base + HISTB_WDT_INTCLR);
+	writel_relaxed(load, base + HISTB_WDT_LOAD);
+	writel_relaxed(HISTB_WDT_INT_ENABLE | HISTB_WDT_RESET_ENABLE,
+		       base + HISTB_WDT_CONTROL);
+
+	/* Flush posted writes. */
+	readl_relaxed(base + HISTB_WDT_LOCK);
+}
+
+static int histb_wdt_start(struct watchdog_device *wdd)
+{
+	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
+	int res;
+
+	res = clk_enable(wdt->clk);
+	if (res)
+		return res;
+
+	spin_lock(&wdt->lock);
+	histb_wdt_arm(wdt, wdt->load_val);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int histb_wdt_stop(struct watchdog_device *wdd)
+{
+	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
+	void __iomem *base = wdt->base;
+
+	spin_lock(&wdt->lock);
+	writel_relaxed(HISTB_WDT_UNLOCK_KEY, base + HISTB_WDT_LOCK);
+	writel_relaxed(0, base + HISTB_WDT_CONTROL);
+	writel_relaxed(HISTB_WDT_LOCK_KEY, base + HISTB_WDT_LOCK);
+	readl_relaxed(base + HISTB_WDT_LOCK);
+	spin_unlock(&wdt->lock);
+
+	clk_disable(wdt->clk);
+
+	return 0;
+}
+
+static int histb_wdt_ping(struct watchdog_device *wdd)
+{
+	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
+	void __iomem *base = wdt->base;
+
+	spin_lock(&wdt->lock);
+	writel_relaxed(HISTB_WDT_INT_MASK, base + HISTB_WDT_INTCLR);
+	writel_relaxed(wdt->load_val, base + HISTB_WDT_LOAD);
+	readl_relaxed(base + HISTB_WDT_LOCK);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int
+histb_wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
+{
+	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
+	u64 rate = wdt->rate;
+	u64 load;
+
+	/*
+	 * histb-wdt runs counter with given value twice, after the end of first
+	 * counter it gives an interrupt and then starts counter again. If
+	 * interrupt already occurred then it resets the system. This is why
+	 * load is half of what should be required.
+	 */
+	load = div_u64(rate * timeout, 2) - 1;
+	load = clamp_val(load, 1, U32_MAX);
+
+	wdt->load_val = load;
+	/* roundup timeout to closest positive integer value */
+	wdd->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
+
+	if (watchdog_active(wdd)) {
+		spin_lock(&wdt->lock);
+		histb_wdt_arm(wdt, wdt->load_val);
+		spin_unlock(&wdt->lock);
+	}
+
+	return 0;
+}
+
+static unsigned int histb_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
+	u64 value;
+
+	spin_lock(&wdt->lock);
+	value = readl_relaxed(wdt->base + HISTB_WDT_VALUE);
+	if (!(readl_relaxed(wdt->base + HISTB_WDT_RIS) & HISTB_WDT_INT_MASK))
+		value += (u64)wdt->load_val + 1;
+	spin_unlock(&wdt->lock);
+
+	return div_u64(value, wdt->rate);
+}
+
+static int
+histb_wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
+{
+	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	/*
+	 * For reset, we start the WDT clock and leave it running.
+	 * The clock was prepared at probe time; only clk_enable() is
+	 * safe in this atomic (restart notifier) context.
+	 */
+	clk_enable(wdt->clk);
+	/*
+	 * Other CPUs may have been stopped while holding wdt->lock, arm without
+	 * taking it.
+	 */
+	histb_wdt_arm(wdt, 1);
+
+	mdelay(1);
+
+	return 0;
+}
+
+static const struct watchdog_info histb_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "HiSilicon STB Watchdog",
+};
+
+static const struct watchdog_ops histb_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = histb_wdt_start,
+	.stop = histb_wdt_stop,
+	.ping = histb_wdt_ping,
+	.set_timeout = histb_wdt_set_timeout,
+	.get_timeleft = histb_wdt_get_timeleft,
+	.restart = histb_wdt_restart,
+};
+
+static int histb_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct histb_wdt *wdt;
+	struct watchdog_device *wdd;
+	int res;
+
+	wdt = devm_kzalloc_obj(dev, *wdt);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	/*
+	 * Keep the clock prepared for the lifetime of the driver:
+	 * .restart() runs in atomic context and may only call clk_enable().
+	 */
+	wdt->clk = devm_clk_get_optional_prepared(dev, NULL);
+	if (IS_ERR(wdt->clk))
+		return dev_err_probe(dev, PTR_ERR(wdt->clk),
+				     "Failed to get clock\n");
+
+	if (wdt->clk)
+		wdt->rate = clk_get_rate(wdt->clk);
+	if (!wdt->rate)
+		device_property_read_u32(dev, "clock-frequency", &wdt->rate);
+	if (!wdt->rate)
+		/* 24 MHz crystal clock default on HiSTB */
+		wdt->rate = 24 * MHz;
+
+	wdd = &wdt->wdd;
+	wdd->parent = dev;
+	wdd->info = &histb_wdt_info;
+	wdd->ops = &histb_wdt_ops;
+	wdd->timeout = HISTB_WDT_DEFAULT_TIMEOUT;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = div_u64(((u64)U32_MAX + 1) * 2, wdt->rate);
+	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_on_unregister(wdd);
+	watchdog_init_timeout(wdd, 0, dev);
+	watchdog_set_drvdata(wdd, wdt);
+
+	spin_lock_init(&wdt->lock);
+
+	histb_wdt_set_timeout(wdd, wdd->timeout);
+
+	platform_set_drvdata(pdev, wdt);
+
+	res = devm_watchdog_register_device(dev, wdd);
+	if (res)
+		return dev_err_probe(dev, res,
+				     "Failed to register watchdog device\n");
+
+	return 0;
+}
+
+static int __maybe_unused histb_wdt_suspend(struct device *dev)
+{
+	struct histb_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		histb_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static int __maybe_unused histb_wdt_resume(struct device *dev)
+{
+	struct histb_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		return histb_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(histb_wdt_pm_ops, histb_wdt_suspend,
+				histb_wdt_resume);
+
+static const struct of_device_id histb_wdt_match[] = {
+	{ .compatible = "hisilicon,histb-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, histb_wdt_match);
+
+static struct platform_driver histb_wdt_driver = {
+	.probe = histb_wdt_probe,
+	.driver = {
+		.name = "histb-wdt",
+		.pm = &histb_wdt_pm_ops,
+		.of_match_table = histb_wdt_match,
+	},
+};
+module_platform_driver(histb_wdt_driver);
+
+MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
+MODULE_DESCRIPTION("HiSilicon STB Watchdog Driver");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.53.0

