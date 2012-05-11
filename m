Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25281 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757787Ab2EKKAe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:34 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alan Cox <alan@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/9] watchdog: Add a flag to indicate the watchdog doesn't reboot things
Date: Fri, 11 May 2012 12:00:19 +0200
Message-Id: <1336730427-1664-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Some watchdogs merely trigger external alarms and controls. In a managed
environment this is very useful but we want drivers to be able to figure
out which is which now multiple dogs can be loaded. Thus add an ALARMONLY
feature flag.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/watchdog.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 1397cbc..eee8ac4 100644
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
-- 
1.7.10

