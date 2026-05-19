Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D718050;
	Tue, 19 May 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215068; cv=none; b=T+LvvC2xiqnSduiU7zUklKTFRMhxHEysZiEarGOn+QdaStHuWfFeh+jodJ3Mfn6LaHgYjs08rS9a6nyOrUUB6m2IYdT0Gu/lLLKOyOWvJGR1DlAUV6g3LLGx/2rlk+xJTJefJZ663aZOJ2CA48F6teqKV+wnD2l5I0iFP6Pjp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215068; c=relaxed/simple;
	bh=qmV5xbAyVS4BQeUO1W/uwU/Qw00sxj16nPTKPsPWqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxCx0jmjX/vZDjPhx62rP5SgZTz5eS92Va8JL13eclAnQm2qAMXLACkFdkYbkJaKCK7IktGmHDgnfd8nkpHHPvKfCpF7CQ0Y7YUd2Dnl5GUk0mx+QpfJBcUylvTqDhE/3YITZ+uKizoQms9RbUz5M5nF01GexrAE29RcpkplpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=V29DsdL+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="V29DsdL+"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 19BA426F39;
	Tue, 19 May 2026 20:24:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 41jrzNc8Kqu7; Tue, 19 May 2026 20:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1779215064; bh=qmV5xbAyVS4BQeUO1W/uwU/Qw00sxj16nPTKPsPWqRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V29DsdL+waajJ9hoHQjXLnh089LekBPproiNnaHYqI2RM9St07xbxp1+ZXt3oEwlF
	 3lAs20abW5RZcrn4f5/73+UVSHP1m51v1Tq/Wnhkpjt+skXhB6uNhSFf1rLdV3t8RD
	 St59+t8xX/anQ8ozMrWR5SN195OcfWG185hwb9NaJQCYtRSiAgPQpbu8EffEwWTY5Q
	 eMSYQi9RSs5msCJYK1rdAnXNJDeslqKRxZWw04S86NWKs5ONWH6TOnvfBQBF1eFOtZ
	 hi/e1tkeJTDSAuAxWfmorWO8buKlPwgtPlrdkCoSShzgbcFlxeC8re42brT1NlvE+N
	 HJQn+GiIrRrtg==
From: Rustam Adilov <adilov@disroot.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sander Vanheule <sander@svanheule.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v2 1/1] watchdog: realtek-otto: Change to use regmap API
Date: Tue, 19 May 2026 23:23:29 +0500
Message-ID: <20260519182329.24472-2-adilov@disroot.org>
In-Reply-To: <20260519182329.24472-1-adilov@disroot.org>
References: <20260519182329.24472-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change all of the register access stuff to done through regmap API.
This helps us to simplify the code and allows to make use of specific
regmap functions like regmap_update_bits to replace read/modify/write
instances.

Add the REGMAP_MMIO as a select to REALTEK_OTTO_WDT now that the regmap
is used.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/watchdog/Kconfig            |  1 +
 drivers/watchdog/realtek_otto_wdt.c | 74 +++++++++++++++--------------
 2 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..5c32d79b126c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1076,6 +1076,7 @@ config REALTEK_OTTO_WDT
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
 	depends on COMMON_CLK
 	select WATCHDOG_CORE
+	select REGMAP_MMIO
 	default MACH_REALTEK_RTL
 	help
 	  Say Y here to include support for the watchdog timer on Realtek
diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 01b3ef89bacf..504a7d379f4a 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/reboot.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 #define OTTO_WDT_REG_CNTR		0x0
@@ -66,7 +67,7 @@
 struct otto_wdt_ctrl {
 	struct watchdog_device wdev;
 	struct device *dev;
-	void __iomem *base;
+	struct regmap *regmap;
 	unsigned int clk_rate_khz;
 	int irq_phase1;
 };
@@ -74,24 +75,17 @@ struct otto_wdt_ctrl {
 static int otto_wdt_start(struct watchdog_device *wdev)
 {
 	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
-	u32 v;
-
-	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
-	v |= OTTO_WDT_CTRL_ENABLE;
-	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
 
+	regmap_set_bits(ctrl->regmap, OTTO_WDT_REG_CTRL, OTTO_WDT_CTRL_ENABLE);
 	return 0;
 }
 
 static int otto_wdt_stop(struct watchdog_device *wdev)
 {
 	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
-	u32 v;
-
-	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
-	v &= ~OTTO_WDT_CTRL_ENABLE;
-	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
 
+	regmap_clear_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
+			  OTTO_WDT_CTRL_ENABLE);
 	return 0;
 }
 
@@ -99,8 +93,7 @@ static int otto_wdt_ping(struct watchdog_device *wdev)
 {
 	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
 
-	iowrite32(OTTO_WDT_CNTR_PING, ctrl->base + OTTO_WDT_REG_CNTR);
-
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_CNTR, OTTO_WDT_CNTR_PING);
 	return 0;
 }
 
@@ -126,7 +119,7 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
 	unsigned int total_ticks;
 	unsigned int prescale;
 	unsigned int tick_ms;
-	u32 v;
+	u32 mask, val;
 
 	do {
 		prescale = prescale_next;
@@ -142,14 +135,11 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
 	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
 		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
 
-	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
-
-	v &= ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | OTTO_WDT_CTRL_PHASE2);
-	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
-	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
-	v |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
-
-	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
+	mask = OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | OTTO_WDT_CTRL_PHASE2;
+	val = FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
+	val |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
+	val |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
+	regmap_update_bits(ctrl->regmap, OTTO_WDT_REG_CTRL, mask, val);
 
 	timeout_ms = total_ticks * tick_ms;
 	ctrl->wdev.timeout = timeout_ms / 1000;
@@ -193,7 +183,7 @@ static int otto_wdt_restart(struct watchdog_device *wdev, unsigned long reboot_m
 
 	/* Configure for shortest timeout and wait for reset to occur */
 	v = FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) | OTTO_WDT_CTRL_ENABLE;
-	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);
 
 	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));
 
@@ -204,7 +194,7 @@ static irqreturn_t otto_wdt_phase1_isr(int irq, void *dev_id)
 {
 	struct otto_wdt_ctrl *ctrl = dev_id;
 
-	iowrite32(OTTO_WDT_INTR_PHASE_1, ctrl->base + OTTO_WDT_REG_INTR);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_INTR, OTTO_WDT_INTR_PHASE_1);
 	dev_crit(ctrl->dev, "phase 1 timeout\n");
 	watchdog_notify_pretimeout(&ctrl->wdev);
 
@@ -250,7 +240,6 @@ static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
 	const struct fwnode_handle *node = ctrl->dev->fwnode;
 	int mode_count;
 	u32 mode;
-	u32 v;
 
 	if (!node)
 		return -ENXIO;
@@ -272,19 +261,25 @@ static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
 	else
 		return -EINVAL;
 
-	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
-	v &= ~OTTO_WDT_CTRL_RST_MODE;
-	v |= FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, mode);
-	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
-
+	regmap_update_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
+			   OTTO_WDT_CTRL_RST_MODE,
+			   FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, mode));
 	return 0;
 }
 
+static const struct regmap_config realtek_otto_wdt_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.disable_locking = true,
+};
+
 static int otto_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct otto_wdt_ctrl *ctrl;
 	unsigned int max_tick_ms;
+	void __iomem *base;
 	int ret;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
@@ -292,18 +287,25 @@ static int otto_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctrl->dev = dev;
-	ctrl->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ctrl->base))
-		return PTR_ERR(ctrl->base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ctrl->regmap = devm_regmap_init_mmio(dev, base,
+					     &realtek_otto_wdt_regmap_config);
+	if (IS_ERR(ctrl->regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(ctrl->regmap);
+	}
 
 	ret = otto_wdt_probe_clk(ctrl);
 	if (ret)
 		return ret;
 
 	/* Clear any old interrupts and reset initial state */
-	iowrite32(OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2,
-			ctrl->base + OTTO_WDT_REG_INTR);
-	iowrite32(OTTO_WDT_CTRL_DEFAULT, ctrl->base + OTTO_WDT_REG_CTRL);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_INTR,
+		     OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, OTTO_WDT_CTRL_DEFAULT);
 
 	ctrl->irq_phase1 = platform_get_irq_byname(pdev, "phase1");
 	if (ctrl->irq_phase1 < 0)
-- 
2.54.0

