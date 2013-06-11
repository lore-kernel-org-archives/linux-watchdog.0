Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:54848 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753628Ab3FKLa3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Jun 2013 07:30:29 -0400
Received: from mail640.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id A6680FFAE58
	for <linux-watchdog@vger.kernel.org>; Tue, 11 Jun 2013 12:52:26 +0200 (CEST)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org
Subject: [RFC PATCH 2/4] watchdog: at91sam9_wdt: update device tree doc
Date: Tue, 11 Jun 2013 12:51:27 +0200
Message-Id: <1370947890-954-3-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
References: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
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
+- atmel,max-heartbeat-sec : Should contain the minimum heartbeat value in
+	seconds. This value should be less than 4 times the max-heartbeat-sec
+	value. It is used to compute the WDD field.
+- atmel,watchdog-type : Should be "hardware" or "software". Hardware watchdog
+	use the at91 watchdog reset. Software watchdog use the watcdog interrup
+	to trigger a software reset.
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

