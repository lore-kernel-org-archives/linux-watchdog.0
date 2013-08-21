Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.177]:57265 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751613Ab3HUMq5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Aug 2013 08:46:57 -0400
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
Subject: [PATCH] documentation/devicetree: Move DT bindigns from gpio to watchdog
Date: Wed, 21 Aug 2013 14:42:09 +0200
Message-ID: <1377088929-23694-1-git-send-email-johannes.thumshirn@men.de>
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
 .../bindings/{gpio => watchdog}/men-a021-wdt.txt   |    0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{gpio => watchdog}/men-a021-wdt.txt (100%)

diff --git a/Documentation/devicetree/bindings/gpio/men-a021-wdt.txt b/Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/gpio/men-a021-wdt.txt
rename to Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
--
1.7.9.5

