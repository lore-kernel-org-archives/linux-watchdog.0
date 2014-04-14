Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59156 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752242AbaDNNYs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Apr 2014 09:24:48 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v4 9/9] ARM: mvebu: Add A375/A380 watchdog binding documentation
Date: Mon, 14 Apr 2014 10:23:33 -0300
Message-Id: <1397481813-4962-10-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit documents the new support for "marvell,armada-{375,380}-wdt"
compatible strings and the extra 'reg' entry requirement.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index de11eb4..97223fd 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -5,11 +5,18 @@ Required Properties:
 - Compatibility : "marvell,orion-wdt"
 		  "marvell,armada-370-wdt"
 		  "marvell,armada-xp-wdt"
+		  "marvell,armada-375-wdt"
+		  "marvell,armada-380-wdt"
 
 - reg		: Should contain two entries: first one with the
 		  timer control address, second one with the
 		  rstout enable address.
 
+For "marvell,armada-375-wdt" and "marvell,armada-380-wdt":
+
+- reg		: A third entry is mandatory and should contain the
+                  shared mask/unmask RSTOUT address.
+
 Optional properties:
 
 - interrupts	: Contains the IRQ for watchdog expiration
-- 
1.9.1

