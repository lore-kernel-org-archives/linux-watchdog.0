Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:41397 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753319Ab3FKKwa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Jun 2013 06:52:30 -0400
Received: from mail640.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 90B8FFFADBA
	for <linux-watchdog@vger.kernel.org>; Tue, 11 Jun 2013 12:52:29 +0200 (CEST)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: [RFC PATCH 4/4] ARM: at91/dt: add watchdog properties to kizbox board
Date: Tue, 11 Jun 2013 12:51:29 +0200
Message-Id: <1370947890-954-5-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
References: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
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

