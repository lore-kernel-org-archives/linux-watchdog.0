Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158185;
	b=Eybm09AgUFnDMNa1Jt92a8lwG57PXX166bOwkhHq/qXjrPmVmno5HUNH2i/QQCFNKFJE
	 v7dRQ5R5Ws2yFCrmZVWqDbxTobtjqk7Rn+AM6idMuQgM8oWRbpWIXGdIwqi2DgSRbgWnG
	 vpUGkkLEuftRKqg6j/ygKVnIoot4liADckH4N05dD+tI5bQ8ARqdb5k3LtdDBpXeyQt1Z
	 DIyuQNeB5q9YJnplKQx87ebujor2oNU1TP3ymscEdiQBuI1VKTb3REekvGhLYDWOVFRv2
	 ALO2JPUw+buJJQbPnjWCG9i6HEK/8rNYmk8NcPymDPSQw3Ux28AP4LovCUNl+vRHAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158185;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=ny40ItD42mZpCgBWTqVLSfuH066APrnwUjNEEqd6zYY=;
	b=vAizLTNbt+3gl5+1BMGxTh6iy1Qb4HNxDqIa0LkmzyEmE1tFftysUWuZYoc9/GwVhFCy
	 K5vEpwqti36VeU1y5iKSxzWfThzaGw7tiVVmEr8smg9Xr7aB6kvH4w7WqKWVblHDN8NG0
	 Vln465KY7nSKldhPYH21azYYVyhde3HshNgJoFi2GzTOKNhgFulopy8dQlSc9aI96q60k
	 2l1irQ0A1EMhrzJxC3sM2xwcvnNwUBQosCXCs1HP6XOeYvZYWk7y5OynUzXPAxRxNX3eX
	 0zoZ20V7MjZ/9R6rx3MZ1h5lB51hcW4X7ZpGuyxogL377D6UaIy28I9LZ+Bbz3gb9JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=eMdm40Qj;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE0606A31C
	for <linux-watchdog@vger.kernel.org>; Sun,  8 Nov 2026 17:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFAE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=eMdm40Qj
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id POXqxFDODAR1iQ6VExPORq; Sun, 08 Nov 2026 17:16:24 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Q6VDx1SphYskhQ6VDx4UY1; Sun, 08 Nov 2026 17:16:24 +0000
X-Authority-Analysis: v=2.4 cv=CKMqXQrD c=1 sm=1 tr=0 ts=6af0ae68
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=jIBaumMvAAAA:8 a=_jlGtV7tAAAA:8 a=NcQoncRBLtcgVmGgl7MA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=I5rtZN7oS8nO7Wt2A-SP:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ny40ItD42mZpCgBWTqVLSfuH066APrnwUjNEEqd6zYY=; b=eMdm40QjeSMeNFvKwm0C+EhTgU
	BjxmCAB7AuJRTBFkHePxm2IrF5mtvvfKEGTylyhNKe9ZCiVxscKleZ+b7VC3abpCLSlKEyaH285Pf
	KUICfUZ2qI7PYCRT4puNQA4EQz64ldXkqGatvAml1aUI3YHqExMhzJo5IOX60JKkdVLgdu9K6iijB
	rYCVa46GeEdUSsONDN/SgWz6ACs0hSILokdkPqEZKo6imyJijtLqXNxww/P7CMNylvEHQ/W/82HAO
	ZrTAfKOgPd7W13CObTp9ZiBw9sxPOJ/ocsTVjXeZHv1ZCx+POlOO6eefMmqiun1F5ZqtKvogiTVat
	hDdlHcfA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49168 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQ6VD-00000001kTE-181P;
	Sun, 08 Nov 2026 22:46:23 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Walter Stoll <walter.stoll@duagon.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] watchdog: omap: Fix early_enable handling in omap_wdt_probe()
Date: Sun,  8 Nov 2026 09:16:21 -0800
Message-ID: <20261108171621.1042105-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
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
X-Exim-ID: 1xQ6VD-00000001kTE-181P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:49168
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIAwm37P+Egd+V+Flo57bcESEvMzZj/7Nz+H1owDsB1XWyRBsYkrUIQ6HPvNIZ/O/UtJEMsTnq9e+KMW8jRieBBSkJyoK6mmZxqa286Mwnjx/R1Zbtix
 aKlg6wqRTzSPxugGgYaOOz1iTopSPj9FphH6KXKaYAByA5Q2HumB85x91gtpsqI7leiLauarr+hyINF1y1pIU5GrbPN5gw5oI7mEPauUIgSx8GnJYaxLugqa

Commit cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
updated omap_wdt_probe() to call omap_wdt_start() and set
WDOG_HW_RUNNING before watchdog_register_device() when the early_enable
module parameter is enabled, introducing two bugs:

1. During probe, omap_wdt_probe() acquires an initial runtime PM
   reference via pm_runtime_get_sync(), and omap_wdt_start() sets
   omap_wdt_users, acquires a second runtime PM reference, and enables
   the hardware timer. If watchdog_register_device() subsequently
   fails, the error path drops only the initial runtime PM reference
   without calling omap_wdt_stop(), leaking the second runtime PM
   reference and leaving the hardware timer counting down without a
   registered watchdog device or core keepalive worker to service it,
   causing an unexpected system reset.

2. The original post-registration omap_wdt_start() call was left in
   place, so when early_enable is enabled and registration succeeds,
   omap_wdt_start() is called a second time. This leaks a runtime PM
   reference (preventing runtime suspend even after the watchdog is
   stopped) and races with userspace after /dev/watchdog is exposed,
   potentially re-enabling the hardware timer after userspace has
   reconfigured or stopped it.

Stop the watchdog via omap_wdt_stop() when omap_wdt_users is set on
watchdog_register_device() failure, and remove the duplicate
post-registration omap_wdt_start() call.

Fixes: cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
Cc: Walter Stoll <walter.stoll@duagon.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-80221bbd-42ac-4fc0-bc11-3d1fd19f7c32
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Also see
https://patchwork.kernel.org/project/linux-watchdog/patch/20261104021535.1468760-1-vulab@iscas.ac.cn/
for a partial fix of the problem.

 drivers/watchdog/omap_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 2a6de73e6f0b..e96c1c513374 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -277,6 +277,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
+		if (wdev->omap_wdt_users)
+			omap_wdt_stop(&wdev->wdog);
 		pm_runtime_put(wdev->dev);
 		pm_runtime_disable(wdev->dev);
 		return ret;
@@ -286,9 +288,6 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		wdev->wdog.timeout);
 
-	if (early_enable)
-		omap_wdt_start(&wdev->wdog);
-
 	pm_runtime_put(wdev->dev);
 
 	return 0;
-- 
2.45.2

