Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33737 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbbKGLE0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Nov 2015 06:04:26 -0500
Received: by wmec201 with SMTP id c201so37042578wme.0
        for <linux-watchdog@vger.kernel.org>; Sat, 07 Nov 2015 03:04:25 -0800 (PST)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH v2 4/4] ARM: dts: meson8b: Add watchdog node
Date: Sat,  7 Nov 2015 12:02:19 +0100
Message-Id: <1446894139-6802-5-git-send-email-carlo@caione.org>
In-Reply-To: <1446894139-6802-1-git-send-email-carlo@caione.org>
References: <1446894139-6802-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

With this patch we add the watchdog node in the meson8b DTS file.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ee352bf..8bad557 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -105,6 +105,12 @@
 			#interrupt-cells = <3>;
 		};
 
+		wdt: watchdog@c1109900 {
+			compatible = "amlogic,meson8b-wdt";
+			reg = <0xc1109900 0x8>;
+			interrupts = <0 0 1>;
+		};
+
 		timer@c1109940 {
 			compatible = "amlogic,meson6-timer";
 			reg = <0xc1109940 0x18>;
-- 
1.9.1

