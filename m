Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41794 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab1LAXnQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Dec 2011 18:43:16 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/2] watchdog: documentation: remove index-file
Date: Fri,  2 Dec 2011 00:43:12 +0100
Message-Id: <1322782992-18706-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1322782992-18706-1-git-send-email-w.sang@pengutronix.de>
References: <1322782992-18706-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 00-index file in the watchdog directory is, like many others,
outdated (conversion-howto is missing) and doesn't contain worthwhile
additional information. As it seems to be a maintenance burden without
much gain, simply remove it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 Documentation/watchdog/00-INDEX |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/watchdog/00-INDEX

diff --git a/Documentation/watchdog/00-INDEX b/Documentation/watchdog/00-INDEX
deleted file mode 100644
index fc51128..0000000
--- a/Documentation/watchdog/00-INDEX
+++ /dev/null
@@ -1,17 +0,0 @@
-00-INDEX
-	- this file.
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
1.7.7.3

