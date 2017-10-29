Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2903 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdJ2ICl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 29 Oct 2017 04:02:41 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [watchdog] watchdog: mei_wdt: don't use of variable length array
Date: Sun, 29 Oct 2017 09:51:19 +0200
Message-Id: <20171029075119.15667-1-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fixes sparse warning:
drivers/watchdog/mei_wdt.c:530:18: warning: Variable length array is used

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/watchdog/mei_wdt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index ea60b29494fb..b8194b02abe0 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -526,12 +526,11 @@ static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
 				    size_t cnt, loff_t *ppos)
 {
 	struct mei_wdt *wdt = file->private_data;
-	const size_t bufsz = 32;
-	char buf[bufsz];
+	char buf[32];
 	ssize_t pos;
 
-	pos = scnprintf(buf, bufsz, "state: %s\n",
-			 mei_wdt_state_str(wdt->state));
+	pos = scnprintf(buf, sizeof(buf), "state: %s\n",
+			mei_wdt_state_str(wdt->state));
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, pos);
 }
-- 
2.9.5

