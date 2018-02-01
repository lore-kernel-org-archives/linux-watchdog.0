Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42847 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeBAUoT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Feb 2018 15:44:19 -0500
Received: by mail-wr0-f195.google.com with SMTP id 41so19049958wrc.9
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Feb 2018 12:44:18 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: corbet@lwn.net, linux@roeck-us.net, wim@iguana.be
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/3] documentation: watchdog: remove documentation of at32ap700x_wdt
Date: Thu,  1 Feb 2018 20:44:10 +0000
Message-Id: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since at32ap700x_wdt is gone, no need to keep its documentation

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/watchdog/watchdog-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 6f9d7b418917..407d013b8643 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -40,11 +40,6 @@ margin: Watchdog margin in seconds (default=60)
 nowayout: Disable watchdog shutdown on close
 	(default=kernel config parameter)
 -------------------------------------------------
-at32ap700x_wdt:
-timeout: Timeout value. Limited to be 1 or 2 seconds. (default=2)
-nowayout: Watchdog cannot be stopped once started
-	(default=kernel config parameter)
--------------------------------------------------
 at91rm9200_wdt:
 wdt_time: Watchdog time in seconds. (default=5)
 nowayout: Watchdog cannot be stopped once started
-- 
2.13.6

