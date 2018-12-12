Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:40724 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeLLWQw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:52 -0500
From: Paul Cercueil <paul@crapouillou.net>
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 12/26] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date: Wed, 12 Dec 2018 23:09:07 +0100
Message-Id: <20181212220922.18759-13-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The TCU channels 0 and 1 were previously reserved for system tasks, and
thus unavailable for PWM.

The driver will now only allow a PWM channel to be requested if memory
resources corresponding to the register area of the channel were
supplied to the driver. This allows the TCU channels to be reserved for
system tasks from within the devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v6: New patch
    
     v7: No change

     v8: ingenic_tcu_[request,release]_channel are dropped. We now use
         the memory resources provided to the driver to detect whether
	 or not we are allowed to use the TCU channel.

 drivers/pwm/pwm-jz4740.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 6b865c14f789..7b12e5628f4f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -28,6 +28,7 @@ struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clks[NUM_PWM];
 	struct regmap *map;
+	struct resource *parent_res;
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -35,6 +36,31 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
+static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz, unsigned int chn)
+{
+	struct platform_device *pdev = to_platform_device(jz->chip.dev);
+	struct resource chn_res, *res;
+	unsigned int i;
+
+	chn_res.start = jz->parent_res->start + TCU_REG_TDFRc(chn);
+	chn_res.end = chn_res.start + TCU_CHANNEL_STRIDE - 1;
+	chn_res.flags = IORESOURCE_MEM;
+
+	/*
+	 * Walk the list of resources, find if there's one that contains the
+	 * registers for the requested TCU channel
+	 */
+	for (i = 0; ; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+		if (resource_contains(res, &chn_res))
+			return true;
+	}
+
+	return false;
+}
+
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
@@ -42,11 +68,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char clk_name[16];
 	int ret;
 
-	/*
-	 * Timers 0 and 1 are used for system tasks, so they are unavailable
-	 * for use as PWMs.
-	 */
-	if (pwm->hwpwm < 2)
+	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
@@ -208,6 +230,12 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	jz4740->parent_res = platform_get_resource(
+				to_platform_device(dev->parent),
+				IORESOURCE_MEM, 0);
+	if (!jz4740->parent_res)
+		return -EINVAL;
+
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
-- 
2.11.0
