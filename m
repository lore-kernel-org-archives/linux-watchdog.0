Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:40272 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2AZTaE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Jan 2012 14:30:04 -0500
From: Dmitry Artamonow <mad_soft@inbox.ru>
To: linux-watchdog@vger.kernel.org
Cc: Timur Tabi <timur@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: fix GETTIMEOUT ioctl in booke_wdt
Date: Thu, 26 Jan 2012 23:24:30 +0400
Message-Id: <1327605870-9226-1-git-send-email-mad_soft@inbox.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit dcfb748422 ([WATCHDOG] fix book E watchdog to take
WDIOC_SETTIMEOUT arg in seconds) fixed SETTIMEOUT ioctl
to use seconds as a parameter instead of some hardware-specific
"period", but missed to apply similar changes to GETTIMEOUT,
so it still returns "period" value. Let's fix it!
Also, while at it, make SETTIMEOUT ioctl return real timeout
value as it should do according to the documentation.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 drivers/watchdog/booke_wdt.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

NOTE: 
I'm no longer have a hardware, so it haven't been tested actually. 
It would be nice if anyone could test it on some BookE platform.

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 337265b..7c0fdfc 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -198,9 +198,13 @@ static long booke_wdt_ioctl(struct file *file,
 		booke_wdt_period = tmp;
 #endif
 		booke_wdt_set();
-		return 0;
+		/* Fall */
 	case WDIOC_GETTIMEOUT:
+#ifdef	CONFIG_FSL_BOOKE
+		return put_user(period_to_sec(booke_wdt_period), p);
+#else
 		return put_user(booke_wdt_period, p);
+#endif
 	default:
 		return -ENOTTY;
 	}
-- 
1.7.5.4

