Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:54957 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbaIPUn6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Sep 2014 16:43:58 -0400
Received: by mail-we0-f175.google.com with SMTP id w61so436089wes.20
        for <linux-watchdog@vger.kernel.org>; Tue, 16 Sep 2014 13:43:56 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH 3/4] ARM: DTS: meson: update DTSI to add watchdog node
Date: Tue, 16 Sep 2014 22:43:36 +0200
Message-Id: <1410900217-5162-4-git-send-email-carlo@caione.org>
In-Reply-To: <1410900217-5162-1-git-send-email-carlo@caione.org>
References: <1410900217-5162-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 55feb14..ebe7742 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -70,6 +70,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		wdt: watchdog@c1109900 {
+			compatible = "amlogic,meson-wdt";
+			reg = <0xc1109900 0x8>;
+		};
+
 		uart_AO: serial@c81004c0 {
 			compatible = "amlogic,meson-uart";
 			reg = <0xc81004c0 0x14>;
-- 
1.9.1

