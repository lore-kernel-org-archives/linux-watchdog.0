Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55314 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0LFVDB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Dec 2010 16:03:01 -0500
Received: by qyk12 with SMTP id 12so14926419qyk.19
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Dec 2010 13:03:00 -0800 (PST)
Message-ID: <4CFD4F5F.8070108@mvista.com>
Date: Mon, 06 Dec 2010 14:02:23 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-watchdog@vger.kernel.org,
	Kumar Gala <kumar.gala@freescale.com>
Subject: [PATCH] powerpc/watchdog: Propagate Book E WDT period changes to
 all cores
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When the watchdog period is changed, it needs to be propagated to all cores
in addition to the core that performed the change.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 drivers/watchdog/booke_wdt.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index d11ffb0..c8ffa6c 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -85,6 +85,22 @@ static unsigned int sec_to_period(unsigned int secs)
 	return 0;
 }
 
+static void __booke_wdt_set(void *data)
+{
+	u32 val;
+
+	val = mfspr(SPRN_TCR);
+	val &= ~WDTP_MASK;
+	val |= WDTP(booke_wdt_period);
+
+	mtspr(SPRN_TCR, val);
+}
+
+static void booke_wdt_set(void)
+{
+	on_each_cpu(__booke_wdt_set, NULL, 0);
+}
+
 static void __booke_wdt_ping(void *data)
 {
 	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
@@ -181,8 +197,7 @@ static long booke_wdt_ioctl(struct file *file,
 #else
 		booke_wdt_period = tmp;
 #endif
-		mtspr(SPRN_TCR, (mfspr(SPRN_TCR) & ~WDTP_MASK) |
-						WDTP(booke_wdt_period));
+		booke_wdt_set();
 		return 0;
 	case WDIOC_GETTIMEOUT:
 		return put_user(booke_wdt_period, p);
-- 
1.6.3.3.328.ge81f
