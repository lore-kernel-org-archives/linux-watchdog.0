Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:58383 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938474AbdEXGpV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 02:45:21 -0400
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        yamada.masahiro@socionext.com, hayashi.kunihiko@socionext.com,
        owada.kiyoshi@socionext.com,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH 2/2] arm64: dts: uniphier: add watchdog node for LD11 and LD20
Date: Wed, 24 May 2017 15:34:52 +0900
Message-Id: <1495607692-657-3-git-send-email-hayashibara.keiji@socionext.com>
In-Reply-To: <1495607692-657-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1495607692-657-1-git-send-email-hayashibara.keiji@socionext.com>
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
index da881f5..a3205dc 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -393,6 +393,10 @@
 				compatible = "socionext,uniphier-ld11-reset";
 				#reset-cells = <1>;
 			};
+
+			sys_wdt: watchdog {
+				compatible = "socionext,uniphier-wdt";
+			};
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a6b3a70..cd08a61 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -417,6 +417,10 @@
 				compatible = "socionext,uniphier-ld20-reset";
 				#reset-cells = <1>;
 			};
+
+			sys_wdt: watchdog {
+				compatible = "socionext,uniphier-wdt";
+			};
 		};
 	};
 };
-- 
2.7.4

