Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41943 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab2CUPKf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Mar 2012 11:10:35 -0400
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] watchdog: Add a flag to indicate the watchdog doesn't
 reboot things
To: linux-watchdog@vger.kernel.org, hdegoede@redhat.com, wim@iguana.be
Date: Wed, 21 Mar 2012 15:25:06 +0000
Message-ID: <20120321152503.20045.41514.stgit@bob.linux.org.uk>
In-Reply-To: <20120321152418.20045.35525.stgit@bob.linux.org.uk>
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Some watchdogs merely trigger external alarms and controls. In a managed
environment this is very useful but we want drivers to be able to figure
out which is which now multiple dogs can be loaded. Thus add an ALARMONLY
feature flag.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 include/linux/watchdog.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 0d5c3af..fdd5dbb 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -45,6 +45,8 @@ struct watchdog_info {
 #define	WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
 #define	WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
 #define	WDIOF_PRETIMEOUT	0x0200  /* Pretimeout (in seconds), get/set */
+#define WDIOF_ALARMONLY		0x0400	/* Watchdog triggers a management or
+					   other external alarm not a reboot */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */

