Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794180822;
	b=0/yCNSJaSVHdBV6srxJtou3T7gQ0O3D5Sdf0pgMAxC/oIkNbXrMOZpk9leHuFTSB7TTO
	 ZlQccGRPOuBbKm4XM1B8R2nNVLEtKCX58z6LXAQtOJmbENC0OV7bdR+bsxqtqAOSKEPaE
	 SC0HXzJqNUtyIQqOu6PIMTjAx2vLZrVaZqcRHN6TTisiHoMecvqeqZpI6SnSXHbLZFblU
	 g/xsfJr/aQoEh6lIvE3WebLJG33mphYA0uJ/kLrrHOTs9UdgWfDdmyJCP7wYDHYrbPvxN
	 BETsEoKLlI6iQEAeI9bTsUKREPfeQbgr5h3fVXo1mpcuiXOK7nLM0JzscRLUXyYZqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794180822;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=CCBhk7xF1qAkNksDzyEm9nXk4o4UkX8N8KUgRXorths=;
	b=skE+kt2VWg1ud91Sc9zZnXF0pfnPSiXCpfd5NF00jZCksSSm+pXCZhjJ0U1kVhauxj0q
	 xHMzGuk8oAsF24oBFFpJjKdaILhhCeN4LQ2obDZO/2BdzoJf8ye8UCmxVUYrna8Jp1XoT
	 eh3CjkrwX2NgleZcy1S3Youh/gBM03wpRqJz2PUps3LeguxM4zz0hbvU/iaW1eAsyXMDb
	 Jc4heCJTjgJ8JBesy8gh+vQ/EAiYi+wSZCRkADr7RjoutkMfqhwipSBaAd0mpShn8GqOu
	 3g4sUA1sOfE9BLWRCZK/quu3/gZTK7dj+B61dHKTXRiNrQVwVpZenZ4Mq//ImTCeMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=OC7Y41BG;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEC606A31C
	for <linux-watchdog@vger.kernel.org>; Sun,  8 Nov 2026 23:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0FEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=OC7Y41BG
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id Q2V9xo49aVK9UQCOFxmOx1; Sun, 08 Nov 2026 23:33:35 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id QCOExAwNiYskhQCOFxChmS; Sun, 08 Nov 2026 23:33:35 +0000
X-Authority-Analysis: v=2.4 cv=CKMqXQrD c=1 sm=1 tr=0 ts=6af106cf
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=zToufjKEFpFfIM_YbRwA:9 a=GvGzcOZaWPEFPQC_NcjD:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CCBhk7xF1qAkNksDzyEm9nXk4o4UkX8N8KUgRXorths=; b=OC7Y41BGEqlnV7pqL0+8uIys5W
	jrnp857o7nWNgAkMKOgs7jC4D7LIKB6ifMM+2V+p8McZ3UqEKLfLMDGSVoca95Ly5sJMgHTSdAX5i
	KCLw0PjBvpCOyvyEcH7j+Wm/eDjBTdi3jTJNyV4cd2NZf3xDw+hX5HGUxrxlFqwAA3maagwMKfY47
	DZQr8DuDqWpCEJTPpzwCh1l1w0BUR8bkfSrfbzJSOR9H2oR0as1bNDljS6IssBHYaJpkvDC0bWFg9
	t0AJBYGIEeV2c+j74sE/oO11T170YNLiK37OkPVRbCHDQizlNq2Ljc5dg/Spnn2V8n/CBa5GxYIT/
	cNVb3Szg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43460 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQCOE-00000000tLn-2XRK;
	Mon, 09 Nov 2026 05:03:34 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] watchdog: dw_wdt: Stop ping worker on system suspend
Date: Sun,  8 Nov 2026 15:33:29 -0800
Message-ID: <20261108233329.1059273-1-linux@roeck-us.net>
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
X-Exim-ID: 1xQCOE-00000000tLn-2XRK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:43460
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNcEujIAgu2vfA5o8pgl0gh2JHsYpKTiDrulRhemL/Ssk1s6kjCNN0a1rXLaZ06mAwsKnaXKap/jCOMUauVGP53abBSRJNc6BGLYqvZH2xuUx8Bz38fA
 Gxe2u0qpO6tPqwVS/f47noVa9Y7haW8cNudHW7l9RpDDFi8za9VmGcSc5zDD7Mg47gSqwyhUTTqz8iKlYQhP0C8YtJYxekxD9A1G3pOfg6CbDrRncRpCaNmw

When the Synopsys DesignWare watchdog is active with the watchdog core
heartbeat worker running (such as when WDOG_HW_RUNNING is set at boot,
when the watchdog is left running after /dev/watchdog is closed, or when
configured with a timeout exceeding wdd->max_hw_heartbeat_ms), the
watchdog core arms its hrtimer so the non-freezable watchdogd kthread
worker periodically pings the hardware.

Because dw_wdt_drv_probe() does not call watchdog_stop_ping_on_suspend(),
WDOG_NO_PING_ON_SUSPEND is not set and the watchdog core leaves its
hrtimer and ping work active across system suspend. After
dw_wdt_suspend() asserts dw_wdt->rst and disables dw_wdt->pclk and
dw_wdt->clk, an expiring timer queues watchdog_ping_work(), invoking
dw_wdt_ping() to write WDOG_COUNTER_RESTART_REG_OFFSET while the
controller is unclocked and in reset. This may trigger a synchronous
external abort, bus error, or system hang.

This did not matter and actually worked as expected since the watchdog
can not be stopped directly. However, commit 1bfe88893808 ("watchdog:
dw_wdt: add stop watchdog operation") implemented stop functionality by
resetting the watchdog core, and commit 0b0ff67cbc2aa ("watchdog: dw_wdt:
manage reset line during system suspend/resume") puts the watchdog hardware
into reset during suspend, causing the potential problem described above.

Call watchdog_stop_ping_on_suspend() in dw_wdt_drv_probe() so the
watchdog core cancels its ping timer and work in PM_SUSPEND_PREPARE
before clocks are gated and resumes pinging in PM_POST_SUSPEND after
clocks and reset are restored.

Fixes: f29a72c24ad4 ("watchdog: dw_wdt: Convert to use watchdog infrastructure")
Fixes: 1bfe88893808 ("watchdog: dw_wdt: add stop watchdog operation")
Fixes: 0b0ff67cbc2aa ("watchdog: dw_wdt: manage reset line during system suspend/resume")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-4cde70aa-2cd0-405d-a626-7b41bfe6bbb7
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/dw_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c1d40d7b2165..7c1c2378f475 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -653,6 +653,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	watchdog_set_restart_priority(wdd, 128);
 	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_ping_on_suspend(wdd);
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-- 
2.45.2

