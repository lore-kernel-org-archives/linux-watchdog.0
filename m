Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16673 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbKJAKz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 19:10:55 -0500
From: Andrew Chew <achew@nvidia.com>
To: <linux-watchdog@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<abrestic@chromium.org>, <treding@nvidia.com>,
	<swarren@nvidia.com>, <jimmzhang@nvidia.com>, <linux@roeck-us.net>,
	<wim@iguana.be>, Andrew Chew <achew@nvidia.com>
Subject: [PATCH] watchdog: tegra: Stop watchdog first if restarting
Date: Mon, 9 Nov 2015 16:11:38 -0800
Message-ID: <1447114298-5516-1-git-send-email-achew@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If we need to restart the watchdog due to someone changing the timeout
interval, stop the watchdog before restarting it.  Otherwise, the new
timeout doesn't seem to take.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
 drivers/watchdog/tegra_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 7f97cdd..9ec5760 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -140,8 +140,10 @@ static int tegra_wdt_set_timeout(struct watchdog_device *wdd,
 {
 	wdd->timeout = timeout;
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(wdd)) {
+		tegra_wdt_stop(wdd);
 		return tegra_wdt_start(wdd);
+	}
 
 	return 0;
 }
-- 
2.1.4

