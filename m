Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C22F5498;
	Sat,  9 May 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344319; cv=none; b=czDO8cVNYzAa+ZpJ/V+3of0Fuv8vlnu3D/dIslj2WLL4m9oAUyDHrPOSa0pbQEGLRCnGwxdbP8JZ/gTfTYElrIiCQTjGt2RCvUM9cr3xwA2wtD0OflIViFscPtctNFGp9cc+eEwbu7Ei4uJ5VffthQdgv2/JJmJkuNnH7jENaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344319; c=relaxed/simple;
	bh=WWf9q1E6XbQWFMD8+fJxEdH7LtAIIp0yFaiafA9BQkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTnDcEXGZjnG28iSgLtacRqE/yJ6wRMqMfZPAMye6DN+5aAjH7m5ToaFOY8UzBl8lBeA3vLJjMqq0G79vFGBttk9HTac+P3qaq3R9A5MjfLsMeQkPMJarWXFy/5JOuKN9dQEh/sO/WQpkK7fYrMMxn+/d/NNa4V5er8E5fBglI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DLE2zcfq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DLE2zcfq"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 54F8D27275;
	Sat,  9 May 2026 18:31:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLgxE-sMskkb; Sat,  9 May 2026 18:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778344309; bh=WWf9q1E6XbQWFMD8+fJxEdH7LtAIIp0yFaiafA9BQkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DLE2zcfqEKBjfzS3SyL+t/xGZtnrqD4DNh0wSJzzwKwUPdgz9g1DL6Qj+vnuxPKk0
	 jjCMxhfsi1boROMOKEgqF0Dpvvcb8pfThLHNrrtGEZk9FERjeHx2FurtQ+vXexuYe7
	 F8WLkrrOE2wdTUGY7YRVGtbUe8q/d57PwGOHUVpYBxkWXpPBHqVYLFa3OrDNULz460
	 4dHOeVMt/o3rQ+ILd2IRFCIIKmbv6w174egeY8WrNmWYiDqRv0v4rt/DRX8ZU2WpGt
	 V8Qd2XSDO3YyFD6rQIQggfd0PsCEG4ZVN3CB6Plh68YkYg+VcxmRKWrz1y+okbEerY
	 cGVKV8YJQc6Jw==
From: Rustam Adilov <adilov@disroot.org>
To: Sander Vanheule <sander@svanheule.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH 1/3] watchdog: realtek-otto: Change to use regmap API
Date: Sat,  9 May 2026 21:30:59 +0500
Message-ID: <20260509163101.722793-2-adilov@disroot.org>
In-Reply-To: <20260509163101.722793-1-adilov@disroot.org>
References: <20260509163101.722793-1-adilov@disroot.org>
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
 drivers/watchdog/realtek_otto_wdt.c | 73 +++++++++++++++--------------
 2 files changed, 38 insertions(+), 36 deletions(-)

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
index 2c30ddd574c5..e5e9cb480f4f 100644
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
 
@@ -132,7 +125,7 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
 	unsigned int total_ticks;
 	unsigned int prescale;
 	unsigned int tick_ms;
-	u32 v;
+	u32 mask, val;
 
 	do {
 		prescale = prescale_next;
@@ -148,14 +141,11 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
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
@@ -199,7 +189,7 @@ static int otto_wdt_restart(struct watchdog_device *wdev, unsigned long reboot_m
 
 	/* Configure for shortest timeout and wait for reset to occur */
 	v = FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) | OTTO_WDT_CTRL_ENABLE;
-	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);
 
 	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));
 
@@ -210,7 +200,7 @@ static irqreturn_t otto_wdt_phase1_isr(int irq, void *dev_id)
 {
 	struct otto_wdt_ctrl *ctrl = dev_id;
 
-	iowrite32(OTTO_WDT_INTR_PHASE_1, ctrl->base + OTTO_WDT_REG_INTR);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_INTR, OTTO_WDT_INTR_PHASE_1);
 	dev_crit(ctrl->dev, "phase 1 timeout\n");
 	watchdog_notify_pretimeout(&ctrl->wdev);
 
@@ -256,7 +246,6 @@ static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
 	const struct fwnode_handle *node = ctrl->dev->fwnode;
 	int mode_count;
 	u32 mode;
-	u32 v;
 
 	if (!node)
 		return -ENXIO;
@@ -278,19 +267,24 @@ static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
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
@@ -298,14 +292,21 @@ static int otto_wdt_probe(struct platform_device *pdev)
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
 
 	/* Clear any old interrupts and reset initial state */
-	iowrite32(OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2,
-			ctrl->base + OTTO_WDT_REG_INTR);
-	iowrite32(OTTO_WDT_CTRL_DEFAULT, ctrl->base + OTTO_WDT_REG_CTRL);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_INTR,
+		     OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2);
+	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, OTTO_WDT_CTRL_DEFAULT);
 
 	ret = otto_wdt_probe_clk(ctrl);
 	if (ret)
-- 
2.54.0

