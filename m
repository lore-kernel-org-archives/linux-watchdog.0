Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43828 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab3J1Isd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Oct 2013 04:48:33 -0400
Received: by mail-pa0-f42.google.com with SMTP id kp14so5041409pab.1
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Oct 2013 01:48:32 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, trivial@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/1] watchdog: Fix a trivial typo
Date: Mon, 28 Oct 2013 14:17:17 +0530
Message-Id: <1382950037-19682-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fixed a trivial typo.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/watchdog_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 05d18b4..461336c 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -77,7 +77,7 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 
 	watchdog_check_min_max_timeout(wdd);
 
-	/* try to get the tiemout module parameter first */
+	/* try to get the timeout module parameter first */
 	if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
 		wdd->timeout = timeout_parm;
 		return ret;
-- 
1.7.9.5

