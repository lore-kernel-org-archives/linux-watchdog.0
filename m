Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [85.220.129.37] ([85.220.129.37]:33419 "EHLO smtp3.goneo.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbbFQJO2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 05:14:28 -0400
From: poeschel@lemonage.de
To: wim@iguana.be, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] watchdog: docs: omap_wdt also understands nowayout
Date: Wed, 17 Jun 2015 11:13:27 +0200
Message-Id: <1434532407-6989-1-git-send-email-poeschel@lemonage.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The omap_wdt kernel driver also understands the nowayout module
parameter. This updates the watchdog-parameters.txt to reflect this fact.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 Documentation/watchdog/watchdog-parameters.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 692791c..74252c4 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -208,6 +208,8 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 omap_wdt:
 timer_margin: initial watchdog timeout (in seconds)
+nowayout: Watchdog cannot be stopped once started
+	(default=kernel config parameter)
 -------------------------------------------------
 orion_wdt:
 heartbeat: Initial watchdog heartbeat in seconds
-- 
2.1.4

