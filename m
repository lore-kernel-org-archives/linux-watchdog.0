Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38994 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbaISUgt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 16:36:49 -0400
Received: by mail-wi0-f172.google.com with SMTP id em10so184904wid.17
        for <linux-watchdog@vger.kernel.org>; Fri, 19 Sep 2014 13:36:48 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 3/4] ARM: DTS: meson: update DTSI to add watchdog node
Date: Fri, 19 Sep 2014 22:36:28 +0200
Message-Id: <1411158989-8075-4-git-send-email-carlo@caione.org>
In-Reply-To: <1411158989-8075-1-git-send-email-carlo@caione.org>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 55feb14..e6539ea 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -70,6 +70,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		wdt: watchdog@c1109900 {
+			compatible = "amlogic,meson6-wdt";
+			reg = <0xc1109900 0x8>;
+		};
+
 		uart_AO: serial@c81004c0 {
 			compatible = "amlogic,meson-uart";
 			reg = <0xc81004c0 0x14>;
-- 
1.9.1

