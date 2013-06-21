Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:34263 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965317Ab3FUHnC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Jun 2013 03:43:02 -0400
Received: from mail432.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id BA5C4FF940E
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Jun 2013 09:32:42 +0200 (CEST)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	Yang Wenyou <Wenyou.Yang@atmel.com>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH v2 4/4] ARM: at91/dt: add watchdog properties to kizbox board
Date: Fri, 21 Jun 2013 09:32:29 +0200
Message-Id: <1371799949-3887-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
References: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
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

