Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41597 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965105AbcDLP4X (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 11:56:23 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] watchdog: core: fix trivial typo in a comment
Date: Tue, 12 Apr 2016 17:56:11 +0200
Message-Id: <1460476571-2351-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Let's have balanced round brackets.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index c1658fe73d58a1..6249ed34214a9f 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -104,7 +104,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  * timeout module parameter (if it is valid value) or the timeout-sec property
  * (only if it is a valid value and the timeout_parm is out of bounds).
  * If none of them are valid then we keep the old value (which should normally
- * be the default timeout value.
+ * be the default timeout value).
  *
  * A zero is returned on success and -EINVAL for failure.
  */
-- 
2.7.0

