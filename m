Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:33282 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751257Ab3JDHih (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Oct 2013 03:38:37 -0400
Received: from mail631.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id DEA62DC14AC
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Oct 2013 09:29:00 +0200 (CEST)
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
Subject: [PATCH v5 2/4] watchdog: at91sam9_wdt: update device tree doc
Date: Fri,  4 Oct 2013 09:24:13 +0200
Message-Id: <1380871455-7324-3-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com>
References: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add new at91sam9 watchdog properties to the documentation.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 ++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index fcdd48f..f90e294 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -9,11 +9,37 @@ Required properties:
 
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
+- interrupts : Should contain WDT interrupt.
+- atmel,max-heartbeat-sec : Should contain the maximum heartbeat value in
+	seconds. This value should be less or equal to 16. It is used to
+	compute the WDV field.
+- atmel,min-heartbeat-sec : Should contain the minimum heartbeat value in
+	seconds. This value must be smaller than the max-heartbeat-sec value.
+	It is used to compute the WDD field.
+- atmel,watchdog-type : Should be "hardware" or "software". Hardware watchdog
+	use the at91 watchdog reset. Software watchdog use the watchdog
+	interrupt to trigger a software reset.
+- atmel,reset-type : Should be "proc" or "all".
+	"all" : assert peripherals and processor reset signals
+	"proc" : assert the processor reset signal
+	This is valid only when using "hardware" watchdog.
+- atmel,disable : Should be present if you want to disable the watchdog.
+- atmel,idle-halt : Should be present if you want to stop the watchdog when
+	entering idle state.
+- atmel,dbg-halt : Should be present if you want to stop the watchdog when
+	entering debug state.
 
 Example:
-
 	watchdog@fffffd40 {
 		compatible = "atmel,at91sam9260-wdt";
 		reg = <0xfffffd40 0x10>;
-		timeout-sec = <10>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		timeout-sec = <15>;
+		atmel,watchdog-type = "hardware";
+		atmel,reset-type = "all";
+		atmel,dbg-halt;
+		atmel,idle-halt;
+		atmel,max-heartbeat-sec = <16>;
+		atmel,min-heartbeat-sec = <0>;
+		status = "okay";
 	};
-- 
1.7.9.5

