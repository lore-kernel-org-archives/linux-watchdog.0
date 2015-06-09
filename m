Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from asav22.altibox.net ([109.247.116.9]:42576 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbbFIK27 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Jun 2015 06:28:59 -0400
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 1/3] dt-bindings: Add Raspberry Pi compatible string for watchdog
Date: Tue,  9 Jun 2015 12:21:43 +0200
Message-Id: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Raspberry Pi has changed how it's firmware detects a poweroff
and needs special handling for this.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
index f801d71..1a80931 100644
--- a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
@@ -2,7 +2,8 @@ BCM2835 Watchdog timer
 
 Required properties:
 
-- compatible : should be "brcm,bcm2835-pm-wdt"
+- compatible : should be "brcm,raspberrypi-pm-wdt" for the Raspberry Pi and
+	       "brcm,bcm2835-pm-wdt" for others.
 - reg : Specifies base physical address and size of the registers.
 
 Optional properties:
-- 
2.2.2

