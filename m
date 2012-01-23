Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48101 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab2AWTRp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Jan 2012 14:17:45 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH RESEND] watchdog: documentation: remove index-file
Date: Mon, 23 Jan 2012 20:17:38 +0100
Message-Id: <1327346258-28697-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 00-index file in the watchdog directory is, like many others,
outdated (conversion-howto is missing) and doesn't contain worthwhile
additional information. As it seems to be a maintenance burden without
much gain, simply remove it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 Documentation/watchdog/00-INDEX |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/watchdog/00-INDEX

diff --git a/Documentation/watchdog/00-INDEX b/Documentation/watchdog/00-INDEX
deleted file mode 100644
index fc9082a..0000000
--- a/Documentation/watchdog/00-INDEX
+++ /dev/null
@@ -1,19 +0,0 @@
-00-INDEX
-	- this file.
-convert_drivers_to_kernel_api.txt
-	- how-to for converting old watchdog drivers to the new kernel API.
-hpwdt.txt
-	- information on the HP iLO2 NMI watchdog
-pcwd-watchdog.txt
-	- documentation for Berkshire Products PC Watchdog ISA cards.
-src/
-	- directory holding watchdog related example programs.
-watchdog-api.txt
-	- description of the Linux Watchdog driver API.
-watchdog-kernel-api.txt
-	- description of the Linux WatchDog Timer Driver Core kernel API.
-watchdog-parameters.txt
-	- information on driver parameters (for drivers other than
-	  the ones that have driver-specific files here)
-wdt.txt
-	- description of the Watchdog Timer Interfaces for Linux.
-- 
1.7.2.5

