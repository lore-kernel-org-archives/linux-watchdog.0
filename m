Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:20163 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdFFJLq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Jun 2017 05:11:46 -0400
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        yamada.masahiro@socionext.com, hayashi.kunihiko@socionext.com,
        owada.kiyoshi@socionext.com,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH V2 3/3] arm64: dts: uniphier: add watchdog node for LD11 and LD20
Date: Tue,  6 Jun 2017 18:11:34 +0900
Message-Id: <1496740294-12653-4-git-send-email-hayashibara.keiji@socionext.com>
In-Reply-To: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add nodes of watchdog timer for UniPhier LD11 and LD20 SoC.
The watchdog timer is included in sysctrl.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index da881f5..5fee3e3 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -393,6 +393,10 @@
 				compatible = "socionext,uniphier-ld11-reset";
 				#reset-cells = <1>;
 			};
+
+			watchdog {
+				compatible = "socionext,uniphier-wdt";
+			};
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a6b3a70..d4d82c8 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -417,6 +417,10 @@
 				compatible = "socionext,uniphier-ld20-reset";
 				#reset-cells = <1>;
 			};
+
+			watchdog {
+				compatible = "socionext,uniphier-wdt";
+			};
 		};
 	};
 };
-- 
2.7.4

