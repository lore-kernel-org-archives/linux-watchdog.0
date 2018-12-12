Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:44934 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLLWVm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Dec 2018 17:21:42 -0500
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
Subject: [PATCH v8 23/26] MIPS: GCW0: Move clocksource to TCU channel 2
Date: Wed, 12 Dec 2018 23:13:17 +0100
Message-Id: <20181212221317.19335-1-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The TCU channel 1, which is the default for the clocksource, is used as
PWM on the GCW Zero as it drives the backlight. Therefore we must use a
different TCU channel for the clocksource.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v8: New patch

 arch/mips/boot/dts/ingenic/gcw0.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
index 35f0291e8d38..8abab14eb852 100644
--- a/arch/mips/boot/dts/ingenic/gcw0.dts
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -60,3 +60,14 @@
 	/* The WiFi module is connected to the UHC. */
 	status = "okay";
 };
+
+&pwm {
+	/* Channels 1 and 3-7 are for PWM use */
+	reg = <0x50 0x10>, <0x70 0x50>;
+};
+
+&clocksource {
+	/* Use channel 2 for the clocksource */
+	reg = <0x60 0x10>;
+	clocks = <&tcu TCU_CLK_TIMER2>;
+};
-- 
2.11.0
