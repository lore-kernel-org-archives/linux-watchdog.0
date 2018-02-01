Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55317 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeBAUoV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Feb 2018 15:44:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id 143so8431015wma.5
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Feb 2018 12:44:20 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: corbet@lwn.net, linux@roeck-us.net, wim@iguana.be
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/3] documentation: watchdog: remove documentation of w83697hf_wdt/w83697ug_wdt
Date: Thu,  1 Feb 2018 20:44:12 +0000
Message-Id: <1517517852-35113-3-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
References: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since w83697hf_wdt/w83697ug_wdt watchdogs drivers were removed
in commit 7285fae9345e ("watchdog: Remove drivers for W83697HF and W83697UG")
There are no need to keep their documentation

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/watchdog/watchdog-parameters.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 603140485ac6..beea975980f6 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -371,19 +371,6 @@ timeout: Watchdog timeout in seconds. 1 <= timeout <= 255, default=60.
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
-w83697hf_wdt:
-wdt_io: w83697hf/hg WDT io port (default 0x2e, 0 = autodetect)
-timeout: Watchdog timeout in seconds. 1<= timeout <=255 (default=60)
-nowayout: Watchdog cannot be stopped once started
-	(default=kernel config parameter)
-early_disable: Watchdog gets disabled at boot time (default=1)
--------------------------------------------------
-w83697ug_wdt:
-wdt_io: w83697ug/uf WDT io port (default 0x2e)
-timeout: Watchdog timeout in seconds. 1<= timeout <=255 (default=60)
-nowayout: Watchdog cannot be stopped once started
-	(default=kernel config parameter)
--------------------------------------------------
 w83877f_wdt:
 timeout: Watchdog timeout in seconds. (1<=timeout<=3600, default=30)
 nowayout: Watchdog cannot be stopped once started
-- 
2.13.6

