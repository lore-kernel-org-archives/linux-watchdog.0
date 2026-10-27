Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116094;
	b=lf9ZBImRG6UEWBNIgJdJQj/A8I0Nb9iEDdZcKXLayXXCyqPg8Yr30l11szpI4uOka+S2
	 d7dzfg0Me9cH0mcXAAbl4C2ON8rneBU8K6kXHhjisU5MqdywbQCpucKMcObkGZK6Wy6gv
	 41TOGV5qPeKzE+qTTgz/G/KbCTgyZ2AZPOelxQx58RB5MTPAKjD/Z3IOucDieSLbYvtHh
	 LT7y09RBhw5Hy1JAkwJ/lKoscmq3pGlJdd0wWq/fccn0Ms4+u+E1Z+4nvVfCY3J7S4Wrb
	 M8z0HfZGYbSoluEXXVQejUtkz+OZn4C0oMrPRrfOKd1lac/m1M4lfmy1FAnTqEOX7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116094;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=P/10AHWvTXXg1IeFeEr3jCvHIaauZayPfb4XOkRgwq4=;
	b=RZ6YTtHbAzJgiRw7IUVNSHlIqHHdKPo/U/9HMd8mga6QEk0g4hAsopzGU0fXoBwqcnQ8
	 NvXPEqJV3ucoKOs4ynsJAJyCdyL6L1KN4+FM7hMumlkaWyfsNEzGEyFZOGkLhqdKMI0fa
	 XzFbe0IdnihKFsBT+r5pf7ns3ciMFaD2VIAAW1qZDo/z0OTL3JLGNIAb2A5f+9EAIe1n/
	 uLhMxo5A6dfkxxeGo95owwABxo1VPJgLmx7A8s2rbMttmgrNdmUnDlclPK0B+B41libZr
	 lQsDY2Dywdj3G2gBjIpUeKACJCMwaMGFCMmGw62Ypv0tWt7V1GksOHgVlhvZgHzGm+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=IaXKvHgr;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75676607351E
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 15:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75676607351E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=IaXKvHgr
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id Lcv1xF1oQc3XsLjPKxhdgp; Tue, 27 Oct 2026 15:48:14 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjPHxrtbS9DdjLjPIxIhgR; Tue, 27 Oct 2026 15:48:13 +0000
X-Authority-Analysis: v=2.4 cv=edA9f6EH c=1 sm=1 tr=0 ts=6ae0c7bd
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=5yiXoIB1VdVXcjoALQYA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=P/10AHWvTXXg1IeFeEr3jCvHIaauZayPfb4XOkRgwq4=; b=IaXKvHgr8MvF
	Bt2Vc7Kdy8tw85KVQnaJdlBij2Ly5Q8HIEgMTG+A22pZumVgOKoq8N2RXBZIL6B480f7hQtWovvQP
	6fp/Jzs+dnMmLtlWPbRY3KnL0mz6wFG70KqFEttMES0VDoqC2JvpFoO4dNPsvUazqlMcsC5/xKSEj
	/kdFGt47aI+LdhzyKZOUQN/W7GUOEcRmFQAWFGKDgOkpAG1lcH6iulIMRFe7v3RsZuk2gAQCY2P9C
	Qy4V0uGKqhrGuEatopcvJnqsqA0kcNHvtFz6bADnVHe4X1Z1n5KnsS4Cls7P37ycAe2HgFICqv/jg
	OadNhggcan6Y1zWcWc0qUw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37966 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjPH-00000000TlK-09lg;
	Tue, 27 Oct 2026 21:18:11 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/8] watchdog: core: Restore WDOG_HW_RUNNING if stopping watchdog fails
Date: Tue, 27 Oct 2026 08:48:02 -0700
Message-ID: <20261027154805.2518806-6-linux@roeck-us.net>
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
X-Exim-ID: 1xLjPH-00000000TlK-09lg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37966
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 52
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfICfSzXLBllkchChg1hXdsm/mMnnp1hyXElwhY5r5X2t8GTgaLJYJZ6a5XmWyBRhBmztLPygcm9RUObsN4hzF9qlE6kBEjdkAU0OZBA1MMSIugdr9ij9
 Mh3N4tWLWNMevKpZahTsyjTO1IB2ajCDorBznMTrCRVmip8WGsz2HvjKFlMThB/D2iGY2ejvqhydhfzNTrivdyujRrWFsycFfdT53Ml1WCr8in+9HyU1N0YC

In watchdog_stop(), WDOG_HW_RUNNING is cleared before calling
wdd->ops->stop(). If wdd->ops->stop() returns an error, WDOG_ACTIVE
remains set, but WDOG_HW_RUNNING is left cleared. As a result,
subsequent calls to watchdog_ping() become no-ops, and
watchdog_release() sees watchdog_hw_running() as false and drops the
module and device references while the ping worker (guided by
WDOG_ACTIVE) continues to run.

Restore WDOG_HW_RUNNING if wdd->ops->stop() fails.

Fixes: 3c10bbde10fe ("watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function")
Assisted-by: LLM
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Moved setting WDOG_HW_RUNNING to error handling after stop() call

 drivers/watchdog/watchdog_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index af756ee228b2..47b0735ed6ac 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -312,6 +312,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
 		if (err < 0) {
+			set_bit(WDOG_HW_RUNNING, &wdd->status);
 			pr_err("watchdog%d: Failed to stop watchdog: %pe\n",
 			       wdd->id, ERR_PTR(err));
 		}
-- 
2.45.2

