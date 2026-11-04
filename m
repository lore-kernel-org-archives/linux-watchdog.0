Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810695;
	b=bD/NGtoh1m8TMFvAtU1S3FtrI7wSTxIH+/ifO6s9Cj6IESSH4eu/0gT35sCnoySfCrK4
	 Tu5cYaG72JCiLXB7QUc2s5ZGmfE2pqcJegn4FXsB8hCfZHq7WZVPK9aSrEX/XBQXhZbRu
	 9SH6eibygdjWaliSoOMPzQY1P48XThCPm6PKCPLwLpPh9+c+xHB/qe5kppckLWWJV1fcE
	 pVOhKuRD8QJh4iLP1OXQF1JVn7fCAIb6LWe4gJtkfqwE/KsbObXK5s15rMk90wqU8qIU/
	 I7Ux6zjENPlV7repwKpcoZNRHmXzbna5vzqL0Y6VC03cOPhG3ZenZIHxYo+UNC13CZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810695;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=faRsbaR6r8pIukvZBlvmGoQQ9+ouH4SRBXHxj7klvOg=;
	b=erB9HxBJyHTL2xC25wFRVNxCnUdL6k/dBYHi9beUrnTJgydSkm4DT87T+O9kQw8+Pgcy
	 wBYb3mVVmxdLgkRFHdgEkd/z8T595Vi2hmMf3UchE9w+kKPKY65Y3BAxKL9JHeCQ6Tj8c
	 hS83ybW73UHXADc8XF3UrGP3DyHraCHjK0JhU4Sa9+nKOD4yJ3xl3yDDcK38F9rv/H01B
	 UqgfbLVMnaRjvrJmaNZshknDhdCkzdjuKeL9XP9W9V7DdOxjmVncTNPBe91D6+t5jI0o5
	 lzd8vNMVvtCeOGeo7HQHD16ynTKTh3AlRQDK36zJtO1nCQWeEXyuQFk+mDMyaH5UY2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=HlRdRm4D;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C92606A32F
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C92606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=HlRdRm4D
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id OPMBxpZFhyb4YOe6Yx9vFQ; Wed, 04 Nov 2026 16:44:54 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe6TxhnnPxqjjOe6TxW8I8; Wed, 04 Nov 2026 16:44:49 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6aeb6106
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=en8udx3QnVO87HUjueoA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=faRsbaR6r8pIukvZBlvmGoQQ9+ouH4SRBXHxj7klvOg=; b=HlRdRm4DRZgG
	5Tayl4sFMhfwgK5KAFh9qBanN5aCIQ8zIT47+9Rh4QsXulGTRSaUbVFL41bQYnjzIfc5qB+/bAvKV
	9VmUmhacCRZxem+nOnNMPRaHiHSIFbEyiFqZIJKZK48G3BTxttKuDGXegAk58LkUYZKzhmh2EPSBT
	hCGuQ80PY2KnC9RK9S5w/e89anQevo8hnPY0giVImRK4VRaTE/0PoK/hX8UXjfaSaHkoWf9FlZKHT
	+t3FwvVV3w7xISIscLDRXTya1PBUN4j0DCxbmmdy0qVhB+wHTQ+EQWZf3dXcT1KH3aZGMcS6NeKSo
	6afOjJh1otnwH2G0T08VGQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41156 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe6S-00000002bzp-2wnX;
	Wed, 04 Nov 2026 22:14:48 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH 1/5] watchdog: starfive-wdt: Drop runtime PM reference if starting watchdog fails
Date: Wed,  4 Nov 2026 08:44:41 -0800
Message-ID: <20261104164445.3209560-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261104164445.3209560-1-linux@roeck-us.net>
References: <20261104164445.3209560-1-linux@roeck-us.net>
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
X-Exim-ID: 1xOe6S-00000002bzp-2wnX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41156
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 32
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKseFsVFMemqzcMrez36AeTCQccUbHB2AyiePZXTY7JwdZ/McRc0p0fR+tZ9Axu2SFlaH3PY0JJRe66yxcDAOUC8u/n6iEjdU4dVwvo2pGbL+xi/I7aI
 ligGXQ1QZWcjnUWmJ8crCxeDl0ghLMkF7N2j2aRWe6cxmsvVKYsNijWZWp/wBNj4ZgYPDTPyS+lOPXX6/n93tLl3YRkTRgv6sF6cfNTDs9awvH+XfjdB3aLZ

Commit 8f0ca55016a7 ("watchdog: starfive-wdt: Fix runtime PM leak in
starfive_wdt_pm_start()") switched starfive_wdt_pm_start() to
pm_runtime_resume_and_get() so the runtime PM usage counter is not
leaked when resuming the device fails. However, if starfive_wdt_start()
subsequently fails (for example, on a timeout in starfive_wdt_int_clr()),
starfive_wdt_pm_start() returns the error without releasing the runtime
PM reference acquired by pm_runtime_resume_and_get(). Because the
watchdog core does not invoke the stop callback when start fails, the
usage counter remains permanently elevated.

Drop the runtime PM reference with pm_runtime_put_sync() if
starfive_wdt_start() fails.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/starfive-wdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 044b4fdb7350..ab6920b8d7d8 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -372,12 +372,17 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
 static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 {
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
-	int ret = pm_runtime_resume_and_get(wdd->parent);
+	int ret;
 
+	ret = pm_runtime_resume_and_get(wdd->parent);
 	if (ret < 0)
 		return ret;
 
-	return starfive_wdt_start(wdt);
+	ret = starfive_wdt_start(wdt);
+	if (ret)
+		pm_runtime_put_sync(wdd->parent);
+
+	return ret;
 }
 
 static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
-- 
2.45.2

