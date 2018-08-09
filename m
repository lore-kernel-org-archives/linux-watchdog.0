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
Subject: [PATCH v6 22/24] MIPS: CI20: Reduce system timer and clocksource to 3 MHz
Date: Thu,  9 Aug 2018 23:46:52 +0200
Message-Id: <20180809214654.21308-1-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
List-ID: <linux-watchdog@vger.kernel.org>

The default clock (48 MHz) is too fast for the system timer, which fails
to report time accurately.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 6 ++++++
 1 file changed, 6 insertions(+)

 v5: New patch

 v6: Set also the rate for the clocksource channel's clock

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 50cff3cbcc6d..f64d32443097 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -238,3 +238,9 @@
 		bias-disable;
 	};
 };
+
+&tcu {
+	/* 3 MHz for the system timer and clocksource */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
+	assigned-clock-rates = <3000000>, <3000000>;
+};
-- 
2.11.0
