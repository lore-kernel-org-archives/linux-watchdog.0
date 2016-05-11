Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36836 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbcEKMry (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 May 2016 08:47:54 -0400
Date: Wed, 11 May 2016 08:47:46 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Add ebc-c384_wdt watchdog-parameters.txt entry
Message-ID: <20160511124746.GA5314@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The WinSystems EBC-C384 watchdog timer driver supports two module
parameters: timeout and nowayout. These parameters should be documented
in the watchdog-parameters.txt file.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/watchdog/watchdog-parameters.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index c161399..a8d3642 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -86,6 +86,10 @@ nowayout: Watchdog cannot be stopped once started
 davinci_wdt:
 heartbeat: Watchdog heartbeat period in seconds from 1 to 600, default 60
 -------------------------------------------------
+ebc-c384_wdt:
+timeout: Watchdog timeout in seconds. (1<=timeout<=15300, default=60)
+nowayout: Watchdog cannot be stopped once started
+-------------------------------------------------
 ep93xx_wdt:
 nowayout: Watchdog cannot be stopped once started
 timeout: Watchdog timeout in seconds. (1<=timeout<=3600, default=TBD)
-- 
2.7.3

