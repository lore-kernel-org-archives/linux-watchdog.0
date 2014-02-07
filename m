Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50021 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511AbaBGVaX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Feb 2014 16:30:23 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 3/3] ARM: sunxi: dt: Update the watchdog compatibles
Date: Fri,  7 Feb 2014 22:29:26 +0100
Message-Id: <1391808566-31008-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog compatibles were following a different pattern than the one found
in the other devices. Now that the driver supports the right pattern, switch to
it in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 26cf191..3e066b5 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -426,7 +426,7 @@
 		};
 
 		wdt: watchdog@01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index b114be7..cff37c5 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -387,7 +387,7 @@
 		};
 
 		wdt: watchdog@01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 5c121fc..0ecde81 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -351,7 +351,7 @@
 		};
 
 		wdt: watchdog@01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index d3f1995..2d2ff8a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -289,7 +289,7 @@
 		};
 
 		wdt1: watchdog@01c20ca0 {
-			compatible = "allwinner,sun6i-wdt";
+			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 		};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4fbe530..30d1eb4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -471,7 +471,7 @@
 		};
 
 		wdt: watchdog@01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
-- 
1.8.4.2

