Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:47834 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeEGNQu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 May 2018 09:16:50 -0400
From: John Crispin <john@phrozen.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH] watchdog: ath79: fix maximum timeout
Date: Mon,  7 May 2018 15:16:42 +0200
Message-Id: <20180507131642.11440-1-john@phrozen.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If the userland tries to set a timeout higher than the max_timeout,
then we should fallback to max_timeout.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/watchdog/ath79_wdt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e2209bf5fa8a..c2fc6c3d0092 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -115,10 +115,14 @@ static inline void ath79_wdt_disable(void)
 
 static int ath79_wdt_set_timeout(int val)
 {
-	if (val < 1 || val > max_timeout)
+	if (val < 1)
 		return -EINVAL;
 
-	timeout = val;
+	if (val > max_timeout)
+		timeout = max_timeout;
+	else
+		timeout = val;
+
 	ath79_wdt_keepalive();
 
 	return 0;
-- 
2.11.0

