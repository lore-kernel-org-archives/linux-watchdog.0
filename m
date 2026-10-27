Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116092;
	b=JmqvPJ9+DqLKsYVFEFLtYCsj5b+ISwT2WqJ4ak8+LExHMkJitv6rKjWFIO7QIoO6jb/I
	 hiRgaMMLCX9E+KJNGKq2l0fQlBChOPYqCdgYgG4S0uORQuuWiG8EcqbK1rHXLMe8yz02P
	 IBaLmcHHJXGpRsdzure0tR6dKcobWCWGg5R4cVmcIUST0+UQCNhFMLfBe6V8VVGxIOa19
	 FQn+jyKXJ9dp0dwxpKJKvwac2yvfIVo4KncjXPMdb5wPPitbYNFo46H1w27xgSGC1n2t6
	 xJtKXBUzNIDjtrGhCiXUx7AWvsMauikqGT4c9fcimbYoqsvCepVlTS6ZI6pob6mIv6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116092;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=8AAC2DvYMVm3X7kh9fZIoqASoYfKVm15YrgVxJtPndE=;
	b=3pLqJjOcjvY3UpZnxllqP8n6tbMod21n8dtpV7LxgXFLb8JyqwhdC4CaKC77ZoOHPSIk
	 E9Cd9ruzGU/YshFBRDyC9RZVhqegUrMMKSQUQ9LYjhJpabwEZiaPMOTi6Yxn7U7S8GfCb
	 USvkStsxASK7R//jWPAz8CxJjea7sy/PEXbZCaIDWZJooz5x8d+80VMeCUp32IYbzLgWw
	 rdO1DDG0/puS8l5z2S0Rp3SycyrXWlNoL6uqdVydWazM1C62ocxrytuduEma9ywWfa63y
	 0k8E1K64aJFCY+3eQSvgFvUXztrXUKEOCQnqdFY5ZzVZ54dOCR6/poS63YqntvQBZIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=qmGXOPXk;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2942607351C
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 15:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2942607351C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=qmGXOPXk
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id Ld1nxYZKKJFmFLjPHxKNul; Tue, 27 Oct 2026 15:48:11 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjPGxmdJnf7H4LjPGx6eHU; Tue, 27 Oct 2026 15:48:11 +0000
X-Authority-Analysis: v=2.4 cv=KrVN2XWN c=1 sm=1 tr=0 ts=6ae0c7bb
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=VfW3V8pwLglsGW-52dUA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=8AAC2DvYMVm3X7kh9fZIoqASoYfKVm15YrgVxJtPndE=; b=qmGXOPXkavOX
	CjL+9JpQWFfDDnW60STtM8vNBOO8RFZ1a2TdY1ivnRzpiLmQqRd/KNDc+UPZkLaMX2E3cvjd9pO5O
	5jQ6UObPmgXcOTKWsr3DeyFV86Aibbi06cf34CosD+vgtgPlnnmeZKQYzwycm4xA24FrwcjY9Lbxr
	XrJ/UE1Ev0bvc2eiYnEGSMK1YGlMGwwRXcvzvoYlc93FtEI+nP3QC/vDPODPe8EWXuRpEu/H6vLLB
	Qywrf4eQDzOWezfQQ0vByYIwr07bEH0cUrB5S6wgH8B3zxR2KdlcdGEB/FtnMnLgd79FvtAGs9Aw5
	u3wVKyM/8LyVNJeHpZ9p9Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37960 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjPG-00000000Tk1-1Ihh;
	Tue, 27 Oct 2026 21:18:10 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 4/8] watchdog: core: Stop pretimeout hrtimer on suspend
Date: Tue, 27 Oct 2026 08:48:01 -0700
Message-ID: <20261027154805.2518806-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027154805.2518806-1-linux@roeck-us.net>
References: <20261027154805.2518806-1-linux@roeck-us.net>
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
X-Exim-ID: 1xLjPG-00000000Tk1-1Ihh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37960
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 50
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBMtyfUuLyO0RzAgsVtOJnLc/VCrYj7TpIRNiKm1D8Sar/VOXi1uXbasqqIL9eSp3cMn6gB8CL5QSRVLSGdoe5J/Rm+xEfOUXYq7Lkl0Xic61Df2nQCd
 SeIfFLGTaaXWAwzGLua1qlYS2rwY9Tpw/WDZNg29qb4OU9pF4uqyKJMRaTAYnOtlQjyq4hguA8QpV1Mbp3HxzXJ/u1up+KZ/XrW1/37nJk553YhvTUSedSCi

During system suspend, watchdog_dev_suspend() pings the watchdog (which
restarts the software pretimeout hrtimer) and stops the keepalive ping
worker, but fails to stop the pretimeout hrtimer. Because
CLOCK_MONOTONIC continues ticking until the system fully suspends, a
suspend process taking longer than the configured pretimeout will
trigger a spurious pretimeout event.

Stop the pretimeout hrtimer in watchdog_dev_suspend(), prevent
watchdog_hrtimer_pretimeout_start() from starting it while the watchdog
is suspended, and restart it in watchdog_dev_resume() if the hardware
watchdog is running.

Fixes: 60bcd91aafd2 ("watchdog: introduce watchdog_dev_suspend/resume")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_dev.c                | 3 +++
 drivers/watchdog/watchdog_hrtimer_pretimeout.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e38f1ef8e683..af756ee228b2 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1334,6 +1334,7 @@ int watchdog_dev_suspend(struct watchdog_device *wdd)
 	 * suspended
 	 */
 	hrtimer_cancel(&wd_data->timer);
+	watchdog_hrtimer_pretimeout_stop(wdd);
 	kthread_cancel_work_sync(&wd_data->work);
 
 	return 0;
@@ -1355,6 +1356,8 @@ int watchdog_dev_resume(struct watchdog_device *wdd)
 	clear_bit(_WDOG_SUSPENDED, &wd_data->status);
 	if (watchdog_worker_should_ping(wd_data))
 		ret = __watchdog_ping(wd_data->wdd);
+	if (watchdog_hw_running(wdd) && !ret)
+		watchdog_hrtimer_pretimeout_start(wdd);
 	mutex_unlock(&wd_data->lock);
 
 	return ret;
diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
index 49a05ea60c97..5c88e6467994 100644
--- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
+++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
@@ -31,7 +31,8 @@ void watchdog_hrtimer_pretimeout_start(struct watchdog_device *wdd)
 {
 	if (!(wdd->info->options & WDIOF_PRETIMEOUT) &&
 	    wdd->pretimeout &&
-	    !watchdog_pretimeout_invalid(wdd, wdd->pretimeout))
+	    !watchdog_pretimeout_invalid(wdd, wdd->pretimeout) &&
+	    !test_bit(_WDOG_SUSPENDED, &wdd->wd_data->status))
 		hrtimer_start(&wdd->wd_data->pretimeout_timer,
 			      ktime_set(wdd->timeout - wdd->pretimeout, 0),
 			      HRTIMER_MODE_REL);
-- 
2.45.2

