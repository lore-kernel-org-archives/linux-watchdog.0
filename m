Return-Path: <paul@crapouillou.net>
Return-path: <paul@crapouillou.net>
From: Paul Cercueil <paul@crapouillou.net>
To: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Malaterre <malat@debian.org>,
	Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 13/24] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date: Thu,  9 Aug 2018 23:44:03 +0200
Message-Id: <20180809214414.20905-14-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
List-ID: <linux-watchdog@vger.kernel.org>

The TCU channels 0 and 1 were previously reserved for system tasks, and
thus unavailable for PWM.

This commit uses the newly introduced API functions of the ingenic-timer
driver to request/release the TCU channels that should be used as PWM.
This allows all the TCU channels to be used as PWM.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

 v6: New patch

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 1bda8d8e9865..d08274ec007f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -43,27 +43,30 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char clk_name[16];
 	int ret;
 
-	/*
-	 * Timers 0 and 1 are used for system tasks, so they are unavailable
-	 * for use as PWMs.
-	 */
-	if (pwm->hwpwm < 2)
-		return -EBUSY;
+	ret = ingenic_tcu_request_channel(pwm->hwpwm);
+	if (ret)
+		return ret;
 
 	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
 
 	clk = clk_get(chip->dev, clk_name);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err_free_channel;
+	}
 
 	ret = clk_prepare_enable(clk);
-	if (ret) {
-		clk_put(clk);
-		return ret;
-	}
+	if (ret)
+		goto err_clk_put;
 
 	jz->clks[pwm->hwpwm] = clk;
 	return 0;
+
+err_clk_put:
+	clk_put(clk);
+err_free_channel:
+	ingenic_tcu_release_channel(pwm->hwpwm);
+	return ret;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -73,6 +76,7 @@ static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+	ingenic_tcu_release_channel(pwm->hwpwm);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.11.0
