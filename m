Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:55479 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab2FHNJ7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 09:09:59 -0400
From: Tony Zelenoff <antonz@parallels.com>
To: <linux-watchdog@vger.kernel.org>
CC: <wim@iguana.be>, <antonz@parallels.com>
Subject: [RFC 2/3] watchdog: move err initialization to place it used
Date: Fri, 8 Jun 2012 17:09:56 +0400
Message-ID: <1339160997-160581-3-git-send-email-antonz@parallels.com>
In-Reply-To: <1339160997-160581-1-git-send-email-antonz@parallels.com>
References: <1339160997-160581-1-git-send-email-antonz@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

err variable is used only once with -EBUSY, so move it to
proper place to prevent useless ticks consuming.

Signed-off-by: Tony Zelenoff <antonz@parallels.com>
---
 drivers/watchdog/watchdog_dev.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e89b9d3..e43bbaa 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -427,7 +427,7 @@ EXPORT_SYMBOL_GPL(watchdog_may_open);
 
 static int watchdog_open(struct inode *inode, struct file *file)
 {
-	int err = -EBUSY;
+	int err;
 	struct watchdog_device *wdd;
 
 	if (!watchdog_may_open())
@@ -447,8 +447,10 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner))
+	if (!try_module_get(wdd->ops->owner)) {
+		err = -EBUSY;
 		goto out;
+	}
 
 	err = watchdog_start(wdd);
 	if (err < 0)
-- 
1.7.1

