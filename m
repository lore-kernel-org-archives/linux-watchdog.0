Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905546;
	b=Dkz92/I2MrIzDrXHsCbyVxHu8AxW1TyLf+392bYPPYcBH36tMxeAt++EMlVoQVJgBsvp
	 cdA7MRcrY9tMRIdJ9d343AmmPjfVSbue/rYRoy5Q3y0CulyjMr1pjxVV6f2rEkqkcFb9G
	 HrDWwEXJXhsQzRaAWmzd4gcCz8E+JIPe/dgE6w2uvzi3wwSYXuaeegq738rnMers3UvP0
	 tjU4IOAwzEKLQX/Kple+nZK06SW0BLmGPvmJswURuDiCAJLZQDU9AIzQm7twx2FkQ1PDk
	 a3HAgwAaUU4V/uExPKbolpbwoOEtqUMT8J2VIm4nwfI+m35DSZug2gl8zF49zncWmXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905546;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=GjNxg0FhaEmnr2ad2GyMK0hLV0AuAfw9oi9BNY8qQ74=;
	b=xSb9PYHJwWQ13E6jx3+wsbUTu6dHK8uNHyUQpnO15rSteBCViQPYjs6FNMSYExqv8+C8
	 ceplMIqf5r9PUAk9w0+dvr5OxxBvBTIHmwl+SZJxa1rof3WJ6OP/oMZ5x9MfUgbJBUuhJ
	 214Gi1laBMN7PFNEJB6a0X1tY6pzMkFlbUr8HdkvoD6Ib+GXKH9H6NscAeDCMtOXj0qI9
	 dQ9wwfjdRoNESqpSKRx9534afMrZete7z0Eg9fLEigZXvVSKC//3VtNm/w3cOo8zLFJ22
	 +tqe/XcXg2yDOtzLxlvHRiMnT9MYuxDuBxP1qrNPXZY3CSKRdfTd1DSkruogS/XZtGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=V94Sz1UN;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC9606A32E
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97BC9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=V94Sz1UN
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id P2jPxbvtI4vCDP2mJxi4tf; Thu, 05 Nov 2026 19:05:39 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mDxXTofq5xIP2mDxSEfl; Thu, 05 Nov 2026 19:05:33 +0000
X-Authority-Analysis: v=2.4 cv=RayQC0tv c=1 sm=1 tr=0 ts=6aecd382
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=en8udx3QnVO87HUjueoA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=GjNxg0FhaEmnr2ad2GyMK0hLV0AuAfw9oi9BNY8qQ74=; b=V94Sz1UNXmmy
	+QGiFl3vk2B8ubej7DDLkdc1RfYPZvSrTLrSJAgCD8Lzu4MRWlX6RFrC+b0DcRuRd+cEqv+ZkDWV1
	SSAULat2EXeXV7Pa1VUDv4sRxpFFxmY8MRMKn8mODzHzNjBD7ldgpKr/O4FG6rNVl3CzZ4tsJ6o6U
	zJFSvLLYhwoLl0ah9tgdoJfd/efvBPP7/2XNNfTJXyrEQSWy8t4rw0VojqO9CxAjSSHlEELG+Ak5M
	HTxGtgD3tX/xlYZ+jSZemmPbEFi/VK30iwma+QIsNTA27PEi8PFKxL/ZovqQDz/FtZaevmve+tjd8
	ip/lwONLEtFHwU7qNhJ1nA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34128 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mD-00000003PFw-05ZP;
	Fri, 06 Nov 2026 00:35:33 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 1/8] watchdog: starfive-wdt: Drop runtime PM reference if starting watchdog fails
Date: Thu,  5 Nov 2026 11:05:22 -0800
Message-ID: <20261105190530.2371854-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261105190530.2371854-1-linux@roeck-us.net>
References: <20261105190530.2371854-1-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mD-00000003PFw-05ZP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:34128
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKYo/fRFsbqnbuTjrGeIvKXTtjTdeAkP/YfVdJ5fLaJWTKsB3pnnX1AGS/MmcC1n1u7t16/Hn31IyWZWZ8aa+JI7P8YBXGTkBw/3e5vSA3B+e7oPQFZ/
 1Dv7GJC4LjKLcBExUn5GgoB2uyKuX5mBVIZ0zjZFbHPLLbFr77GzzYeQYrIgFTUCBrUfaL0qukM79XBYKHIoEImZ7sa90k+ktpgsai+D+KwBHq7eJLGDaI02

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
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Reviewed-by: tag

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

