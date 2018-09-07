Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v3 3/4] documentation: watchdog: add documentation for armada-37xx-wdt
Date: Fri,  7 Sep 2018 15:05:52 +0200
Message-Id: <20180907130553.14271-4-marek.behun@nic.cz>
In-Reply-To: <20180907130553.14271-1-marek.behun@nic.cz>
References: <20180907130553.14271-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Add documentation for the kernel module parameters accepted by
armada-37xx-wdt.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
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
