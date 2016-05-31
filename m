Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325AbcEaGIv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 May 2016 02:08:51 -0400
From: fu.wei@linaro.org
To: wim@iguana.be, linux@roeck-us.net, panand@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	timur@codeaurora.org, dyoung@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, Suravee.Suthikulpanit@amd.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 1/3] watchdog: skip min and max timeout validity check when max_hw_heartbeat_ms is defined
Date: Tue, 31 May 2016 14:08:08 +0800
Message-Id: <1464674890-10512-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Pratyush Anand <panand@redhat.com>

When max_hw_heartbeat_ms has a none zero value, max_timeout is not used.
So it's value can be 0. In such case if a driver uses min_timeout
functionality, then check will always fail.

This patch fixes above issue.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 7c3ba58..65e62d1 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -88,7 +88,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 	 * Check that we have valid min and max timeout values, if
 	 * not reset them both to 0 (=not used or unknown)
 	 */
-	if (wdd->min_timeout > wdd->max_timeout) {
+	if (!wdd->max_hw_heartbeat_ms && wdd->min_timeout > wdd->max_timeout) {
 		pr_info("Invalid min and max timeout values, resetting to 0!\n");
 		wdd->min_timeout = 0;
 		wdd->max_timeout = 0;
-- 
2.5.5

