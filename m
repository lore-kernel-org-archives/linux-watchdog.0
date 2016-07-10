Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37980 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbcGJJLV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jul 2016 05:11:21 -0400
Received: by mail-wm0-f43.google.com with SMTP id o80so15263829wme.1
        for <linux-watchdog@vger.kernel.org>; Sun, 10 Jul 2016 02:11:20 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
Date: Sun, 10 Jul 2016 11:11:06 +0200
Message-Id: <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..bcca82f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -136,6 +136,12 @@
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			watchdog@98d0 {
+				compatible = "amlogic,meson-gxbb-wdt";
+				reg = <0x0 0x098d0 0x0 0x10>;
+				clocks = <&xtal>;
+			};
 		};
 
 		gic: interrupt-controller@c4301000 {
-- 
2.7.0

