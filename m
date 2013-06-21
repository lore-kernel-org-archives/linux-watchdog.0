Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:43268 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758811Ab3FUHY2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Jun 2013 03:24:28 -0400
Received: from mail432.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 0E844FF9112
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Jun 2013 09:24:27 +0200 (CEST)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	Yang Wenyou <Wenyou.Yang@atmel.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH v2 2/4] watchdog: at91sam9_wdt: update device tree doc
Date: Fri, 21 Jun 2013 09:23:34 +0200
Message-Id: <1371799414-3654-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
References: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add new at91sam9 watchdog properties to the documentation.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 ++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index fcdd48f..e043106 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -9,11 +9,37 @@ Required properties:
 
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
+- interrupts : Should contain WDT interrupt.
+- atmel,max-heartbeat-sec : Should contain the maximum heartbeat value in
+	seconds. This value should be less than 16. It is used to compute the
+	WDV field.
+- atmel,min-heartbeat-sec : Should contain the minimum heartbeat value in
+	seconds. This value should be less than 4 times the max-heartbeat-sec
+	value. It is used to compute the WDD field.
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

