Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905549;
	b=I1L0bsoUuaKCR2/CnQIW/f+sA4QjtQ9xaDo83802/LVPqv5Ct5a6Xu4P7dYtT7gQUrlm
	 J+C7aXsA1MKG32TCefRsxB06vpQRxzuhpuDSUk1HsBQ2f7u0XY7NPaVSp0eEUJBUzsyzy
	 K6Mp9JAXHjVDlMUFTYvGaG6Cd7CjhzHzxvqEMVOBsweNh4zjkvKeiLkzmSB0tSfEkmhtp
	 3xi24LI11v3NbPPPmDP8Zl3g2Beox1NLb7fJZe0KQqqsuxw2pfGTe8JFA44hTKQZA9ZAa
	 inJ1jfVoWQyAPwEeu+SlGj/mrc07uXy4WWHD45P4h/iY8q0OL6ymmJ+etRYQJw4yUQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905549;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=QR9xXjFaM+AKXmLN8JCLRdwfCe/+u/KqDOhpWIH740k=;
	b=KnvS/hIzIr0czH5CXrdb0XteMylvr/gzmIu9nyVd/mT3frolT6e1/ihgr4c8mf/FbZjq
	 5df5DKQHVzMNdP38g1smTAmn5jb3T7kQmAchvdr6j8mW7YoRqu5ZhJtBQlgefYxCjzu5G
	 kPaNLH4W1sPJK8ISZNS39fh6RAcM7nz3+EEMjFfU4c4y30NQRI6y2ZHHvtWrzdejjl1CV
	 IL79NMq+mwn/eXE54NEU1ds2vIdh0PwobJ6vBJSMM0PwUybyMcM4c5rZaOUyAV+SYWQyw
	 jrR/h5ftfeKuvh7AKYmbwVS+htAP9cWyQcrkYgMkL13XhUBUSPN3sFwwrVFNuwcDJ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Cvn4DOgN;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B2606A329
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832B2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Cvn4DOgN
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id P2UMxdsZKVK9UP2mTxRWYn; Thu, 05 Nov 2026 19:05:49 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mSxAvXvVqSeP2mSxSNTa; Thu, 05 Nov 2026 19:05:48 +0000
X-Authority-Analysis: v=2.4 cv=eLETjGp1 c=1 sm=1 tr=0 ts=6aecd38d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=Sv3qB79qIwS6s3LpkmEA:9 a=O8hF6Hzn-FEA:10 a=KQ6X2bKhxX7Fj2iT9C4S:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=QR9xXjFaM+AKXmLN8JCLRdwfCe/+u/KqDOhpWIH740k=; b=Cvn4DOgNcu7w
	TRwKvK7iVqgJPU+dZEDe0HbRAPGISWFOrMDfQAef4Ygg4qPdvWWamPHWp+984xd8S8FxzAW01PaAS
	xShdxkquNpOf/tZUiwjDf4n9mEz3v9VLbYCSy2ZP28lR9mU4ASWI09ZIukH+2TeRN89MsNbM8cjuC
	w2IHKDVsdTq70qXD106NDoYabIz3QrLdcz5wP4hJRfF071sFgxiuQPXuef5PfH9UOlcbBlL/DCWgL
	Cod7gQvLLH2ya/dlrUFGT4TthYFi+IneDkEqC/JE1SGwNEfxwieZL828/Bg+cwNRoqJCm5xr14Cms
	cXdX4+qqfxnH73Qmtcl2zw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40752 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mS-00000003Q2M-1EIQ;
	Fri, 06 Nov 2026 00:35:48 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 8/8] watchdog: starfive-wdt: Avoid unclocked MMIO access in starfive_wdt_set_timeout()
Date: Thu,  5 Nov 2026 11:05:29 -0800
Message-ID: <20261105190530.2371854-9-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mS-00000003Q2M-1EIQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:40752
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 36
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLJ5sDLR4ETnXlK5xKAtuV86R8yeq/x+gEynYLmd/9t7zOHMpeUlyn9tksA2wjwQUDbauKTt6Xjx4F0F3HCeOQyvCMAge3vkulud3Zu8vzi/BwonL26G
 N4Zuhh7ggkvLHrYU01WS3bXGV5kgNnl2u2Ew/MA4rnuLICLI6csVC1JC2Ab2XhQc19fTu4HDcrkznoLVm2XhwenfYqPIyWHxQaQuiAKZ7homywafFA8GGbH2

When the watchdog is stopped via ioctl(WDIOC_SETOPTIONS, WDIOS_DISABLECARD)
while /dev/watchdog remains open, watchdog_stop() clears WDOG_HW_RUNNING
and WDOG_ACTIVE, and starfive_wdt_pm_stop() halts the hardware counter and
drops the runtime PM reference, gating core_clk and apb_clk.

A subsequent ioctl(WDIOC_SETTIMEOUT) invokes starfive_wdt_set_timeout()
regardless of whether the watchdog is running. Because
starfive_wdt_set_timeout() unconditionally accesses MMIO registers and
calls starfive_wdt_enable(), updating the timeout while stopped triggers an
unclocked MMIO bus fault when runtime-suspended, or unexpectedly starts the
hardware counter without WDOG_ACTIVE or WDOG_HW_RUNNING set when runtime PM
is disabled.

Only program the hardware registers in starfive_wdt_set_timeout() when
watchdog_hw_running() is set. In addition, reload the initial counter value
via starfive_wdt_set_reload_count() in starfive_wdt_start() (preserving
wdt->reload on resume) so JH7100 loads the configured timeout into the
counter when started from probe or after WDIOS_DISABLECARD.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch

 drivers/watchdog/starfive-wdt.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index ae2d84ccc76f..758030ad9c65 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -344,7 +344,7 @@ static int starfive_wdt_keepalive(struct watchdog_device *wdd)
 	return ret;
 }
 
-static int starfive_wdt_start(struct starfive_wdt *wdt)
+static int starfive_wdt_start(struct starfive_wdt *wdt, u32 count)
 {
 	int ret;
 
@@ -357,7 +357,9 @@ static int starfive_wdt_start(struct starfive_wdt *wdt)
 	if (ret)
 		goto exit;
 
-	starfive_wdt_set_count(wdt, wdt->count);
+	starfive_wdt_set_reload_count(wdt, count);
+	if (count != wdt->count)
+		starfive_wdt_set_count(wdt, wdt->count);
 	starfive_wdt_enable(wdt);
 
 exit:
@@ -381,7 +383,7 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 	if (ret < 0)
 		return ret;
 
-	ret = starfive_wdt_start(wdt);
+	ret = starfive_wdt_start(wdt, wdt->count);
 	if (ret)
 		pm_runtime_put_sync(wdd->parent);
 
@@ -412,11 +414,13 @@ static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
 	wdt->count = count;
 	wdd->timeout = timeout;
 
-	starfive_wdt_unlock(wdt);
-	starfive_wdt_disable(wdt);
-	starfive_wdt_set_reload_count(wdt, wdt->count);
-	starfive_wdt_enable(wdt);
-	starfive_wdt_lock(wdt);
+	if (watchdog_hw_running(wdd)) {
+		starfive_wdt_unlock(wdt);
+		starfive_wdt_disable(wdt);
+		starfive_wdt_set_reload_count(wdt, wdt->count);
+		starfive_wdt_enable(wdt);
+		starfive_wdt_lock(wdt);
+	}
 
 	return 0;
 }
@@ -497,7 +501,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_ping_on_suspend(&wdt->wdd);
 
 	if (early_enable) {
-		ret = starfive_wdt_start(wdt);
+		ret = starfive_wdt_start(wdt, wdt->count);
 		if (ret)
 			goto err_exit;
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
@@ -575,14 +579,8 @@ static int starfive_wdt_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (watchdog_hw_running(&wdt->wdd)) {
-		starfive_wdt_unlock(wdt);
-		/* Restore watchdog state. */
-		starfive_wdt_set_reload_count(wdt, wdt->reload);
-		starfive_wdt_lock(wdt);
-
-		return starfive_wdt_start(wdt);
-	}
+	if (watchdog_hw_running(&wdt->wdd))
+		return starfive_wdt_start(wdt, wdt->reload);
 
 	return 0;
 }
-- 
2.45.2

