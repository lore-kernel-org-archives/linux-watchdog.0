Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905555;
	b=LD9gait8ew3mjkkuqfko1dJpr0oAttVwQD+mY61U21AcMiENkSSTlfYqJ7SK0L7uvkGi
	 YXGPCfqbcs3UxRrvFZYr78O9cG4wwTVt0bKBDB39PMR03OhGKm/jojQSUU+//IwxQaQPQ
	 BSeNvrWYFx9dulmJnWHILr+0hIrekjgtxUnGVrSF0jsXG1HZpUXff/nKj96GGrKocrv4Z
	 HWkM5F8CSUMzObLc9VsFKf8LZMYRoJUigXjjtyBLnIp7YPi1GsrdYzLIU8NoleSZJQYby
	 4yeL/k2x8v02UHAyUaRpOTPte/srkV6B458HrSzu4eZye+iLI7bHZQPRv6svIn2tlWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905555;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=eE37djwi41DDz7zHMbxUXy4kyux/ww41BG8fP9fR+nQ=;
	b=ot30DdygjcGQHMLGMw0jQnUCRegPFoBvKbpN4aNC3Q59PYHpcPU9XaPxL8gXxDLerSQO
	 zsunQxqQUuARQeqM9IsfFq1T3Qb108oCKgIRGZYrpsSIAgZXT9uqoke3FCDnsV3HsWVgb
	 NjGLhk7JbTrbWGNv2WpRy+I5vEpx9pmeRRw64yyxptxzCC1m+5LTivJKiNHTz3ypwvY+R
	 0wjQofGRIdGZlm7rwlxjMVYHzp+c6ux5Jn6GzJZKss90NahoVwSTzuKOwY+3pYarE5bHD
	 nfNDv3EHbC8NUvYW8unbfRtE/5O+48xU1zvRvogIUYXRANu8o8EapnPEc54iZvk0xPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0LEl3YSL;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D65606A329
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D65606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0LEl3YSL
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id OIFdx0q6SAR1iP2mSx5riL; Thu, 05 Nov 2026 19:05:49 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mRxqHY1btpUP2mSxAbhD; Thu, 05 Nov 2026 19:05:48 +0000
X-Authority-Analysis: v=2.4 cv=dIqmmPZb c=1 sm=1 tr=0 ts=6aecd38c
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=LzuaQbZwHQHXnMqKkqIA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=eE37djwi41DDz7zHMbxUXy4kyux/ww41BG8fP9fR+nQ=; b=0LEl3YSLKUxj
	3/HYkTAJnsxbUTNAO5rmsCw98dz/VNa76tmudbqe23dZW1OWjT8erJuDZlw0JDZrNZF78rk7pBiIJ
	fTLwyzlF/UTiP0H1zoL6dZFuRfcqW5Xhy6lCSGZq7j4Dq4Gg7JdBE12zWtdp4FMwu8L+/OmnrpRGA
	btiLqnatWvHApyag+nYMeQgM0pon1QkJ2pqG+uPzi6Y/MoAc0ZofKv0vfpsBUV+pr90JEGYmLQjLI
	oCs8Wp8S3TdnMoqcbqIALyCwuTr5lTcmUUpXKWJ2MYtQeILBwEwJCB49LjdM2iGVPI16+3AnXA+kT
	mynK+lzN9LsTezsUkSUl7g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40742 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mR-00000003PaA-2Jb3;
	Fri, 06 Nov 2026 00:35:47 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 7/8] watchdog: starfive-wdt: Stop ping worker on system suspend
Date: Thu,  5 Nov 2026 11:05:28 -0800
Message-ID: <20261105190530.2371854-8-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mR-00000003PaA-2Jb3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:40742
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 32
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFwJJEG5O9mSg8UIsvoqDlpIHAbn33e0vTqoCod50GC3dZ5Egb0yaiyL2tnPeM9UVnGPNdLdK3AoVvPKOFzEMy+iAGGUVqzCwNt7V7g7CtXJq3kgzX3c
 G5QX2rF1mQFx5od8ONEhGgs7aBBsznC4Rc/uh2abHUanpXjvnMyybrL5fzQo8i38YlJ2oByBeZJS+O+qaDckQxdZ7eUO+2YHvbc5CD4Z2vikGe9sj5cDIuwl

When early_enable=1 is set and CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is
enabled, watchdog_register_device() starts the watchdog core hrtimer so the
non-freezable watchdogd kthread worker periodically pings the hardware
before userspace opens /dev/watchdog.

Because starfive_wdt_probe() does not call watchdog_stop_ping_on_suspend(),
WDOG_NO_PING_ON_SUSPEND is not set and the watchdog core does not cancel
its hrtimer and ping work across system suspend. After
starfive_wdt_suspend() stops the counter and calls
pm_runtime_force_suspend() to gate core_clk and apb_clk, WDOG_HW_RUNNING
remains set; if the timer fires before starfive_wdt_resume() re-enables
the clocks, watchdog_ping_work() invokes starfive_wdt_keepalive() with
gated clocks and causes an unclocked MMIO bus fault.

Call watchdog_stop_ping_on_suspend() in starfive_wdt_probe() so the
watchdog core cancels its ping timer and work in PM_SUSPEND_PREPARE before
clocks are gated and resumes pinging in PM_POST_SUSPEND after clocks are
restored.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch

 drivers/watchdog/starfive-wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 60a97ffa940a..ae2d84ccc76f 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -494,6 +494,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_stop_on_reboot(&wdt->wdd);
 	watchdog_stop_on_unregister(&wdt->wdd);
+	watchdog_stop_ping_on_suspend(&wdt->wdd);
 
 	if (early_enable) {
 		ret = starfive_wdt_start(wdt);
-- 
2.45.2

