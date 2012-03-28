Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:39996 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257Ab2C1J6u (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Mar 2012 05:58:50 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <spear-devel@list.st.com>, <viresh.linux@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] watchdog: sp805: call watchdog_set_drvdata() early
Date: Wed, 28 Mar 2012 15:13:25 +0530
Message-ID: <78377bb3c0a861281cfdc5c166f0c082e126f4b7.1332927751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

wdt_setload() uses watchdog_get_drvdata() and hence we must call
watchdog_set_drvdata() before actually calling wdt_setload(). This patch moves
watchdog_set_drvdata() up in code.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 40e628a..ef85676 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -250,6 +250,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	wdt->wdd.ops = &wdt_ops;
 
 	spin_lock_init(&wdt->lock);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
 
@@ -260,7 +261,6 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_register;
 	}
 	amba_set_drvdata(adev, wdt);
-	watchdog_set_drvdata(&wdt->wdd, wdt);
 
 	dev_info(&adev->dev, "registration successful\n");
 	return 0;
-- 
1.7.10.rc2.10.gb47606

