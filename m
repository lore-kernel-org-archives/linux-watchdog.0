Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:45311 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755282Ab3JCTLx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Oct 2013 15:11:53 -0400
Received: from mail172.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 027071058F3B
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Oct 2013 21:11:52 +0200 (CEST)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Landley <rob@landley.net>,
	Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Guenter Roeck <groeck7@gmail.com>,
	Yang Wenyou <wenyou.yang@atmel.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH v4 3/4] ARM: at91/dt: add sam9 watchdog default options to SoCs
Date: Thu,  3 Oct 2013 21:04:42 +0200
Message-Id: <1380827083-6872-4-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
References: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Set default watchdog options in every SoC compatible with the sam9 watchdog.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9263.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |    5 +++++
 arch/arm/boot/dts/sama5d3.dtsi     |    5 +++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 56ee828..997901f 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -648,6 +648,11 @@
 			watchdog@fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index d5bd65f..45fb0a4 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -523,6 +523,11 @@
 			watchdog@fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c3e5148..16534c7 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -639,6 +639,11 @@
 			watchdog@fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 9fb7ffd..eaef94b 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -537,6 +537,11 @@
 			watchdog@fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index e74dc15..6d31fd7 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -820,6 +820,11 @@
 			watchdog@fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b7f4961..3a17a3e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -891,6 +891,11 @@
 			watchdog@fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
-- 
1.7.9.5

