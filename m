Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117041;
	b=w8hPreMyU5haspD/Cy6LdmY73CPM+n1cTusgN4U8O7RPjo2NiVP6TciGS5S9nXuI1r+E
	 XIaKQlvtCEjeROPLdPesrkj4E22IUP/FBiW1VuvyiOWBBqurvIvZJ9pMQaBk4EUIAbz+s
	 MFGAFBQX8QwpRF3aVXQCtNOjRGbPa1Kg+6ACX+D/8hJCiIzkmGriODmu9ioVtVFGnU75C
	 ukDyt8nX+A8ExCtbcVy4syIKsiU6sG96CZqZs8qpCG5eWeVb1ffMK783pNSxXtO0/VAhq
	 uAU3N4yu0+NfUtF8EOdtYTy2ktFBK/zXYLfPnilOb/dUSLeTzg7WpLO/3yitocRvHuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117041;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=hBbi9g9ZVtQVIoSSk1BM63hfeBIzHoo6OEqeAmYP5JU=;
	b=YTqQETMHYlMDUnfpKxOcGksgN5pxSEmaP9oNSnFYZUu6jzh7lhbANUJBfN8X3YHIJ/5l
	 SwI821uJxbMReyE+zXJmRp48TSZC+2L6OSx7LqHTlIcue+f5XUzQ4AodtjHYAY2ORM5JA
	 OYjDyPZwMV6Gi8fu1dQAknckyvpmstO/5twJlRdf9XL/atb5Gj0YoPO4JPDRIRaemnCSv
	 0g0SZFbCrzmBWMeueBDpd05Sk5cJ8HErJVG4m6DaLV5iFmlCpyTVKZqgTY4q9d4o93eDv
	 V22DjtKBHJCveU+O/ALP04VisI4EIebqjJN7/4oREgsXYjzfEEtlHntcFBbjRUWkOIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=dOMLqysJ;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2E606A31B
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A2E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=dOMLqysJ
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id Lh18xxY5cv0ndLjeaxLU6l; Tue, 27 Oct 2026 16:04:00 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjeYxXd0ef4wOLjeZx49kd; Tue, 27 Oct 2026 16:04:00 +0000
X-Authority-Analysis: v=2.4 cv=db2A3WXe c=1 sm=1 tr=0 ts=6ae0cb70
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=tzbB3BBAKiYyW1D0EaAA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=hBbi9g9ZVtQVIoSSk1BM63hfeBIzHoo6OEqeAmYP5JU=; b=dOMLqysJbq3/
	mHmgA6kcyNvBZRDz180JDLYa3t2PQIW4Fc3kWdBc3LptlAW8ouwJNSnGWqYmK70Ud5o+Hi0ef6PE0
	Xl+vWXzaWn4N88DCBzf84upbyEDC9zLBtJjTRSgQD53N8Q+ULdWdfaHlhkp2tyVImub0v1WRNHpiV
	+uhCG54uBn0LZ/rCd/3zO5H1QKHI4EkyQf1+DC30exrB+PvRctw19GP90m7KCTG6/75P+cWkGG++7
	taeiVkqdrOs9De2OWaFBqzLobMvQUa7VJWZQ0zKKN/ULfs0FNBhaHVrIOB4hBkPw7CKqBRjyzguzD
	Jkgk2oNt93qGastQMbHUrw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51366 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjeY-00000000clC-2afQ;
	Tue, 27 Oct 2026 21:33:58 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 8/8] watchdog: core: Update last_keepalive in watchdog_start()
Date: Tue, 27 Oct 2026 09:03:53 -0700
Message-ID: <20261027160353.2519323-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027160353.2519323-1-linux@roeck-us.net>
References: <20261027160353.2519323-1-linux@roeck-us.net>
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
X-Exim-ID: 1xLjeY-00000000clC-2afQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:51366
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 22
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHRUxZjaCtlcZ/A8/skK+9/zUhEZ3ULLDs6h6yoA61BIaFRynnDdztwCQZhFOFxq6m1uHWLgZdRcynVDf+6Y6BSj+CKjxAbgE+WeTfIKENj5F0pkZBIG
 Ixqsvc3qSjr9jFLwEyiVJQDjyc3Ll23pwA2K933FXVyQis/BK/1H55WJjBDVJY+NdRkqiXqsxZ+e2BxMzZq1zr1uady+mKa7RtxVJu1LJ+TRzWVdF2fG97Cf

When starting a watchdog whose hardware is already running,
watchdog_start() calls __watchdog_ping() before marking the watchdog
active, and fails to update wd_data->last_keepalive. As a result:

1. wd_data->last_keepalive remains 0, causing watchdog_get_timeleft() to
   calculate the elapsed time since the epoch and return 0 time left.
2. watchdog_update_worker() inside __watchdog_ping() evaluates
   watchdog_need_worker() and watchdog_next_keepalive() while WDOG_ACTIVE
   is still clear, using wd_data->open_deadline instead of
   wd_data->last_keepalive. If open_deadline has expired, the background
   keepalive timer is not armed; conversely, if the active watchdog does
   not need a worker, the boot keepalive timer is not canceled.

Set WDOG_ACTIVE and wd_data->last_keepalive to started_at before calling
__watchdog_ping(), and revert WDOG_ACTIVE and update the worker if
__watchdog_ping() fails.

Fixes: fbbe35dfcf94 ("watchdog: use __watchdog_ping in startup")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 7c80d3753252..aad3f1f1b4ce 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -264,10 +264,14 @@ static int watchdog_start(struct watchdog_device *wdd)
 
 	started_at = ktime_get();
 	if (watchdog_hw_running(wdd) && wdd->ops->ping) {
+		set_bit(WDOG_ACTIVE, &wdd->status);
+		wd_data->last_keepalive = started_at;
 		err = __watchdog_ping(wdd);
 		if (err == 0) {
-			set_bit(WDOG_ACTIVE, &wdd->status);
 			watchdog_hrtimer_pretimeout_start(wdd);
+		} else {
+			clear_bit(WDOG_ACTIVE, &wdd->status);
+			watchdog_update_worker(wdd);
 		}
 	} else {
 		err = wdd->ops->start(wdd);
-- 
2.45.2

