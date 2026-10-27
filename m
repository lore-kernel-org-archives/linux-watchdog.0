Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116991;
	b=TS9xMAx+OLXQNTa5ArNbZrs5AMbfNmZ6H3PePPc4essPyZjHQCctNHCxn5/Wgat8GMof
	 I049Am6ryUcZFsGUSSDhlCk7S/T+zBViK+YCKQHQgms6B5XiM/aJx5eRmls83xwfHn5cZ
	 5nstHQLbfWahquCITH5HRVGK/LkV3L+mOzTGi5AsnzCy/PfEGfHTseS6QRiayzgGd3N9U
	 oCxqEWbawkIqAnIzFOddgVFZtMgHGKN43oTCWnpLpQiGFrONtL5iOvaygTLE92fkUCA5k
	 ZMHRL+hUay31afbKbjb3UDfJtGpHAP8jJWc5Qoj/DoNa7BHIlZjjebZMUWnfnf7bfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116991;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=8AAC2DvYMVm3X7kh9fZIoqASoYfKVm15YrgVxJtPndE=;
	b=4dfyABh3xLfDJZYrmaygn9c5MiwsgS/oaCwb0QETbpyQKS9/zp8X5NkcEGX2LdFrSCqG
	 SwRPrw7R5OpIzodSx2b7nXPGFe0RcMnUFwTeJjwjCqIaUOPflouVbhnC3MOrYKVz3ge2/
	 +SyWPFQB7D5z6C3mpmMuRsmyvw2dRudOJRaQtaxCiSZs32CfPP3GM8xAM43IrXJCN+us6
	 mcEvhagGOsiTwD/sq/zY7FqiqFz1B7UYWjJx+cmgAPZ1zMZHkvDlztrLdt7l7O/L+Xy6E
	 MjNs8ZyVb4k/VCtcFKMVPNsMfDNHFkqyj+SCm09U8fSwx+uavzwK6Tnm1TYVAaTlwwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Ra0wQDxC;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35251606A323
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35251606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Ra0wQDxC
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id LgmexxTsqv0ndLjdlxLTPb; Tue, 27 Oct 2026 16:03:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjdkxG7Uv6hvPLjdkxXclh; Tue, 27 Oct 2026 16:03:08 +0000
X-Authority-Analysis: v=2.4 cv=cqCbk04i c=1 sm=1 tr=0 ts=6ae0cb3c
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=VfW3V8pwLglsGW-52dUA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=8AAC2DvYMVm3X7kh9fZIoqASoYfKVm15YrgVxJtPndE=; b=Ra0wQDxCrxsT
	FJ68okCE6p5qjKf1zEKHMEc9giIxAdCKCEMRzg8QH2rIMN3MgMdWM4A2/D3aDPAmR4w6asss+KQkW
	IuhlKWciaZGg79UX/EWXflIbH8hLCJsS47I7rHHVNpeUzEe06EflCctKvYlAUWMvmbMcFxnx6P0mz
	ElWOthn/shFocMixGqNRKUu+3vBq+xnNBfGX51367sxAT0IlMx3j/+FgUNYS30HFjM5pvrKdZtF39
	ossgC53LzK4Lh5PQQRWbQ+QVTJPsIzrSgSFR7VoYaywIaS3/M3C0qe+Nv1beCCPYBPwIsFf2Kv+a+
	hqEP7FrLXbSaeSTbKW84OA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47910 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjdk-00000000cIT-0jNs;
	Tue, 27 Oct 2026 21:33:08 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 4/8] watchdog: core: Stop pretimeout hrtimer on suspend
Date: Tue, 27 Oct 2026 09:02:58 -0700
Message-ID: <20261027160302.2519282-5-linux@roeck-us.net>
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
X-Exim-ID: 1xLjdk-00000000cIT-0jNs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:47910
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 10
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDGqX+4wpUjOWDAvJIYzLNF0To2q41VlyRyl/AbYwaXWAAHmh2MrQQUoe1Eba7BBtDCr0xonx7k+74E+25gRxFZIO3hCN9C/bSlKDXReXfcw13pSXbxS
 miKz0njaTvSYX/EMCmvUhxp1qRVhCUKmk3KlrsqMLIYu4bg4fOc2tGgIWJkP3FHySaBdZEWJuhl0f7mH/rcNCxrgNR+LkVlzZiWKcdSt1yjJ5r4ovIlRKhhu

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

