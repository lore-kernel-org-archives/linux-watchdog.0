Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:57221 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab3H0LRo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Aug 2013 07:17:44 -0400
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Rob Landley <rob@landley.net>
CC: Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [RFC][PATCH v2] documentation/devicetree: Move DT bindigns from gpio to watchdog
Date: Tue, 27 Aug 2013 13:10:37 +0200
Message-ID: <1377601837-18989-1-git-send-email-johannes.thumshirn@men.de>
In-Reply-To: <521672A1.6010202@wwwdotorg.org>
References: <521672A1.6010202@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I accidently put the devicetree bindings for the MEN A21 watchdog driver in
Documentation/devicetree/bindings/gpio instead of
Documentation/devicetree/bindings/watchdog, this patch addresses this error.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Rob Landley <rob@landley.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 Changes to v1:
 - Use named gpios, as suggested by Stephen Warren

 .../bindings/{gpio => watchdog}/men-a021-wdt.txt   |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/{gpio => watchdog}/men-a021-wdt.txt (61%)

diff --git a/Documentation/devicetree/bindings/gpio/men-a021-wdt.txt b/Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
similarity index 61%
rename from Documentation/devicetree/bindings/gpio/men-a021-wdt.txt
rename to Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
index 370dee3..0008f28 100644
--- a/Documentation/devicetree/bindings/gpio/men-a021-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
@@ -16,10 +16,10 @@ Optional properties:
 Example:
 	watchdog {
 		compatible ="men,a021-wdt";
-		gpios = <&gpio3 9  1	/* WD_EN */
-			 &gpio3 10 1	/* WD_FAST */
-			 &gpio3 11 1	/* WD_TRIG */
-			 &gpio3 6  1	/* RST_CAUSE[0] */
-			 &gpio3 7  1	/* RST_CAUSE[1] */
-			 &gpio3 8  1>;	/* RST_CAUSE[2] */
+		enable-gpio = <&gpio3 9 1>; /* WD_EN */
+		fast-gpio = <&gpio3 10 1>;  /* WD_FAST */
+		trig-gpio = <&gpio3 11 1>;  /* WD_TRIG */
+		rst-gpios = <&gpio3 6 1     /* RST_CAUSE[0] */
+			     &gpio3 7 1     /* RST_CAUSE[1] */
+			     &gpio3 8 1>;   /* RST_CAUSE[2] */
 	};
--
1.7.9.5

