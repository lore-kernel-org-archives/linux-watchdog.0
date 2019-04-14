Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6477C282E1
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A21206BA
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfDNK0f (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:35 -0400
Received: from sauhun.de ([88.99.104.3]:32882 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfDNK0f (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:35 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 21ED64B2018;
        Sun, 14 Apr 2019 12:26:33 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 01/16] watchdog: refactor watchdog_init_timeout
Date:   Sun, 14 Apr 2019 12:26:12 +0200
Message-Id: <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The function is not easy to read and has two problems: a) -EINVAL is
returned when the module parameter is invalid but the DT parameter is
OK, and b) for the module parameter, zero is a valid value but for DT it
is invalid.

Refactor the code to have a the same pattern of checks for the module
parameter and DT. Further ones can be easily added in the future if the
need arises. The above mentioned problems are fixed, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_core.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index eb8fa25f8eb2..85c136acc0e9 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -104,10 +104,11 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  * Initialize the timeout field of the watchdog_device struct with either the
  * timeout module parameter (if it is valid value) or the timeout-sec property
  * (only if it is a valid value and the timeout_parm is out of bounds).
- * If none of them are valid then we keep the old value (which should normally
- * be the default timeout value).
+ * If none of them are valid or all of them are zero ("don't care") then we keep
+ * the old value (which should normally be the default timeout value).
  *
- * A zero is returned on success and -EINVAL for failure.
+ * A zero is returned on success or -EINVAL if all provided values are out of
+ * bounds.
  */
 int watchdog_init_timeout(struct watchdog_device *wdd,
 				unsigned int timeout_parm, struct device *dev)
@@ -117,22 +118,24 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 
 	watchdog_check_min_max_timeout(wdd);
 
-	/* try to get the timeout module parameter first */
-	if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm) {
-		wdd->timeout = timeout_parm;
-		return ret;
-	}
-	if (timeout_parm)
+	/* check the driver supplied value (likely a module parameter) first */
+	if (timeout_parm) {
+		if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
+			wdd->timeout = timeout_parm;
+			return 0;
+		}
 		ret = -EINVAL;
+	}
 
 	/* try to get the timeout_sec property */
-	if (dev == NULL || dev->of_node == NULL)
-		return ret;
-	of_property_read_u32(dev->of_node, "timeout-sec", &t);
-	if (!watchdog_timeout_invalid(wdd, t) && t)
-		wdd->timeout = t;
-	else
+	if (dev && dev->of_node &&
+	    of_property_read_u32(dev->of_node, "timeout-sec", &t) == 0 && t) {
+		if (!watchdog_timeout_invalid(wdd, t)) {
+			wdd->timeout = t;
+			return 0;
+		}
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
-- 
2.11.0

