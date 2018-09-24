Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:55356 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeIXRLX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Sep 2018 13:11:23 -0400
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v4 3/4] documentation: watchdog: add documentation for armada-37xx-wdt
Date: Mon, 24 Sep 2018 13:06:53 +0200
Message-Id: <20180924110654.7329-4-marek.behun@nic.cz>
In-Reply-To: <20180924110654.7329-1-marek.behun@nic.cz>
References: <20180924110654.7329-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add documentation for the kernel module parameters accepted by
armada-37xx-wdt.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 6d6200ea27b8..0b88e333f9e1 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -40,6 +40,11 @@ margin: Watchdog margin in seconds (default=60)
 nowayout: Disable watchdog shutdown on close
 	(default=kernel config parameter)
 -------------------------------------------------
+armada_37xx_wdt:
+timeout: Watchdog timeout in seconds. (default=120)
+nowayout: Disable watchdog shutdown on close
+	(default=kernel config parameter)
+-------------------------------------------------
 at91rm9200_wdt:
 wdt_time: Watchdog time in seconds. (default=5)
 nowayout: Watchdog cannot be stopped once started
-- 
2.16.4
