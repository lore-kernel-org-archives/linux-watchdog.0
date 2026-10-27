Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116992;
	b=ykdlXhe4sBFvKzhGpgED1GfRBhwStL/mYVdJgnEjk5zgdjoS03yS6MlcDuhTM9hMZzpx
	 NZZ35kY05m7nTRa3dJ0u8AqkkgD7DyCKRhqXNiWu2pLhnQhqtqp9VUC94wIdcXkPKJvpW
	 +g0BRyby6Dgs7R2pDPCEEiuNavYnSUrZPYTR72gqwHPR8dHd3EhwTvVnR8BwIfd//RvxW
	 on6mkGTy9xfADk8Y6dfyTMK1v21K8r5VneFC9xUGh6XA8zkJ5DGHrQbhcXGlv5om/ncxS
	 RaLUV7d2Bb63cnKIO+Gq+EUk48GtCjnq9kpq+hD11wr++55YZtY7sC9Lagb6WYVcbfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116992;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=4tf5jp72b9mmtNlArsH2jcFwIQOwqOIebwrOBPuEsBU=;
	b=HtsiWA93V+s591CAo9tgCOeX1jS2SK1C/FndPZjfXdaqX7r+T6SvxV4keGzV9z3vCX5t
	 VuFw4SKDf4RkXbjHyp/Li21+nWBZiq+3M0X05V8Y5wBHJuDQ8kOibZ8vv4VkWD0XTfYU/
	 jHG6nH7gQHBofXijveYElqDTXFP0v+0rGdES4ojGZqd21TJPBKdd1nHicI8WEL3msBKsm
	 cIeEXuSsh4bcXthOFusNPAmzoVqWqQpjJdM/iP951giJZfulroS9dWdQWu9kk0uaxLk1T
	 JtmUm9tKeRrzIT2jdN6EzRwCxNEqKLWc+BT0Ags4bU2zeLL0UMAIRyRToMkmw9Y2n8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=LRcByQ3R;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34055606A322
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34055606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=LRcByQ3R
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id LhzaxxpbBv0ndLjdlxLTQ6; Tue, 27 Oct 2026 16:03:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Ljdjx7kWYnUK5LjdkxJNvR; Tue, 27 Oct 2026 16:03:09 +0000
X-Authority-Analysis: v=2.4 cv=ae1hnQot c=1 sm=1 tr=0 ts=6ae0cb3d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=7vxEA1HKIkwBDEoJgLAA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=4tf5jp72b9mmtNlArsH2jcFwIQOwqOIebwrOBPuEsBU=; b=LRcByQ3RMZfs
	cKKZfYS+ZNu6k/UXwdjqiDurL/3oS+jANaYQHSlhX/ihJ4Alu9AaA2Uhk5jLz7lot9uDVToyPDdPe
	Q6khd/ebnnAUGGwo3eo+X2SFhcuNA+zLKy58GEPefMkAGOgoJTvuqEf+gcGXflB8Q9fF2Yvwb2fEM
	daHPfVYYUQjZGlteCM6rKgp7eDp9Mr97gQYjGrT7hlfYBJMdWgCs50tiXlaf94iDoxb0K4oLSUVF0
	NvyRtvDd21STaiMXEo9vd4uA+WorRw4INpXW+LD1jeOaSYY77IlJFkVYCkWIdRyjjrUkxQdy7tpcy
	d7gHwlZR7M2Wd1KoFg7yxw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47904 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjdj-00000000cHM-1r2U;
	Tue, 27 Oct 2026 21:33:07 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/8] watchdog: core: Prevent ping worker from re-arming timer on suspend
Date: Tue, 27 Oct 2026 09:02:57 -0700
Message-ID: <20261027160302.2519282-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027160302.2519282-1-linux@roeck-us.net>
References: <20261027160302.2519282-1-linux@roeck-us.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLjdj-00000000cHM-1r2U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:47904
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGm6A70JXffcTSKatFeDoMSqMF0Ln5BFnyP8FmgBTPpYfYFIbIcuIEYXy1SVU0dGOK6+qraglhokzb1vQ4B1ihx4pWeGO2ZkzfczLJEfggzUUPut2Sf+
 d1LT0leQUI0e/FSXs1gR6jtnQ9wvnZjiiIyeFuE0sEpj04m74GgZiMmWMUhEGu3xHLvDL1kQ3Jk/zmZ9fW39iw7Z3LMBRlrlEexXt3MQH5naRhW6SGkCrR35

In watchdog_dev_suspend(), hrtimer_cancel() is called before
kthread_cancel_work_sync(). If the timer expired just before
hrtimer_cancel() and queued watchdog_ping_work(), the worker can run
and acquire wd_data->lock while kthread_cancel_work_sync() waits for it
to finish. Because no state flag indicates that the watchdog is
suspended, watchdog_worker_should_ping() returns true and
__watchdog_ping() re-arms wd_data->timer while the device is suspended.

Add a _WDOG_SUSPENDED internal status bit to wd_data->status, set it
under wd_data->lock in watchdog_dev_suspend(), clear it under
wd_data->lock in watchdog_dev_resume(), and check it in
watchdog_worker_should_ping(), watchdog_need_worker(), and
__watchdog_ping() so the timer cannot be armed while suspended.

Fixes: 60bcd91aafd2 ("watchdog: introduce watchdog_dev_suspend/resume")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_core.h |  1 +
 drivers/watchdog/watchdog_dev.c  | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index ab825d9f9248..c6df5a584357 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -60,6 +60,7 @@ struct watchdog_core_data {
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
 #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
 #define _WDOG_KEEPALIVE		2	/* Did we receive a keepalive ? */
+#define _WDOG_SUSPENDED		3	/* Suspended ? */
 };
 
 /*
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 50224877ff49..e38f1ef8e683 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -81,6 +81,9 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 	unsigned int hm = wdd->max_hw_heartbeat_ms;
 	unsigned int t = wdd->timeout * 1000;
 
+	if (test_bit(_WDOG_SUSPENDED, &wdd->wd_data->status))
+		return false;
+
 	/*
 	 * A worker to generate heartbeat requests is needed if all of the
 	 * following conditions are true.
@@ -154,9 +157,10 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 	now = ktime_get();
 
 	if (ktime_after(earliest_keepalive, now)) {
-		hrtimer_start(&wd_data->timer,
-			      ktime_sub(earliest_keepalive, now),
-			      HRTIMER_MODE_REL_HARD);
+		if (!test_bit(_WDOG_SUSPENDED, &wd_data->status))
+			hrtimer_start(&wd_data->timer,
+				      ktime_sub(earliest_keepalive, now),
+				      HRTIMER_MODE_REL_HARD);
 		return 0;
 	}
 
@@ -207,7 +211,7 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
 {
 	struct watchdog_device *wdd = wd_data->wdd;
 
-	if (!wdd)
+	if (!wdd || test_bit(_WDOG_SUSPENDED, &wd_data->status))
 		return false;
 
 	if (watchdog_active(wdd))
@@ -1318,6 +1322,8 @@ int watchdog_dev_suspend(struct watchdog_device *wdd)
 	mutex_lock(&wd_data->lock);
 	if (watchdog_worker_should_ping(wd_data))
 		ret = __watchdog_ping(wd_data->wdd);
+	if (!ret)
+		set_bit(_WDOG_SUSPENDED, &wd_data->status);
 	mutex_unlock(&wd_data->lock);
 
 	if (ret)
@@ -1346,6 +1352,7 @@ int watchdog_dev_resume(struct watchdog_device *wdd)
 	 * ping worker if needed.
 	 */
 	mutex_lock(&wd_data->lock);
+	clear_bit(_WDOG_SUSPENDED, &wd_data->status);
 	if (watchdog_worker_should_ping(wd_data))
 		ret = __watchdog_ping(wd_data->wdd);
 	mutex_unlock(&wd_data->lock);
-- 
2.45.2

