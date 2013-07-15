Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60538 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392Ab3GOXdv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:33:51 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 06/10] watchdog: orion: Update device-tree binding documentation
Date: Mon, 15 Jul 2013 20:32:39 -0300
Message-Id: <1373931163-12670-7-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that the 'reg' property meaning has been changed,
this commit updates the deivce-tree binding documentation.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
index 5dc8d30..48a71fc 100644
--- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
@@ -3,7 +3,8 @@
 Required Properties:
 
 - Compatibility : "marvell,orion-wdt"
-- reg		: Address of the timer registers
+- reg		: First cell contains the register for the watchdog counter.
+		  Second cell contains the register for the RSTOUT mask.
 
 Optional properties:
 
@@ -11,9 +12,10 @@ Optional properties:
 
 Example:
 
-	wdt@20300 {
+	wdt@20324 {
 		compatible = "marvell,orion-wdt";
-		reg = <0x20300 0x28>;
+		reg = <0x20324 0x4
+		       0x20108 0x4>;
 		timeout-sec = <10>;
 		status = "okay";
 	};
-- 
1.8.1.5

