Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:51344 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754728Ab3JCTN1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Oct 2013 15:13:27 -0400
Received: from mail172.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id CA65F1058F9D
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Oct 2013 21:13:26 +0200 (CEST)
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
Subject: [PATCH v4 4/4] ARM: at91/dt: add watchdog properties to kizbox board
Date: Thu,  3 Oct 2013 21:04:43 +0200
Message-Id: <1380827083-6872-5-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
References: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog specific config for kizbox board.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/kizbox.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
index 02df191..928f6ee 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -53,6 +53,12 @@
 				status = "okay";
 			};
 
+			watchdog@fffffd40 {
+				timeout-sec = <15>;
+				atmel,max-heartbeat-sec = <16>;
+				atmel,min-heartbeat-sec = <0>;
+				status = "okay";
+			};
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.9.5

