Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:56410 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388468AbeGYAgl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Jul 2018 20:36:41 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 13/21] pwm: jz4740: Add support for the JZ4725B
Date: Wed, 25 Jul 2018 01:19:50 +0200
Message-Id: <20180724231958.20659-14-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The PWM in the JZ4725B works the same as in the JZ4740, except that it
only has 6 channels available instead of 8.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

 v5: New patch

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index e1cb618bb234..b19437c75232 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -26,6 +26,10 @@
 
 #define NUM_PWM 8
 
+struct jz4740_soc_info {
+	unsigned int num_pwms;
+};
+
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clks[NUM_PWM];
@@ -195,8 +199,26 @@ static const struct pwm_ops jz4740_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static const struct jz4740_soc_info jz4740_soc_info = {
+	.num_pwms = 8,
+};
+
+static const struct jz4740_soc_info jz4725b_soc_info = {
+	.num_pwms = 6,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_pwm_dt_ids[] = {
+	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
+	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
+#endif
+
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
+	const struct jz4740_soc_info *soc_info;
 	struct jz4740_pwm_chip *jz4740;
 	struct device *dev = &pdev->dev;
 
@@ -213,9 +235,11 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(jz4740->map))
 		return PTR_ERR(jz4740->map);
 
+	soc_info = of_device_get_match_data(dev);
+
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
-	jz4740->chip.npwm = NUM_PWM;
+	jz4740->chip.npwm = soc_info->num_pwms;
 	jz4740->chip.base = -1;
 	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
 	jz4740->chip.of_pwm_n_cells = 3;
@@ -232,14 +256,6 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&jz4740->chip);
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id jz4740_pwm_dt_ids[] = {
-	{ .compatible = "ingenic,jz4740-pwm", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-#endif
-
 static struct platform_driver jz4740_pwm_driver = {
 	.driver = {
 		.name = "jz4740-pwm",
-- 
2.11.0

