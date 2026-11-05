Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905549;
	b=gX/AIH8awgFIJtCWg7YEaGzp8JoDM8/wO2iw7UkGrE/eAN2uAgiRgi6Wpo7Pi6XckCm4
	 yaKVOHuaPg1LkGMX+hJP4zoNQI93XGwQtGJwk37LNO7nTIhOFe03yCP+4xlrR0G3ODax8
	 Vzm4L8FFWAkq7UZUCaPiv7mULuxcmk7KpCCsaEEQ84I/n/TY0RWPxIKx6EC/zNNOOuJoC
	 O2vQHVyJCP9hVMUhziey+q1IkoO5wwLx5PHivZot5dOdDAlYWLKB4nlRl20L/tJ/NB98Y
	 tUlZ5Jg2UADd42Xh1w7OF408wep4oKVDYvGurJ4kScB34eVcC35Z7OALbdls4TwEEkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905549;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=3LiUcmR/XG4SmX1xHUJ4qPXQ8O9XVUvjGOiZ38C2/Rw=;
	b=3MzC39p35ktF0JNBiKlFft4EZf+GC4ReLOo3a84L0mPopiG/dIOfzqr2zM8UgRrEnUIV
	 xpPg+bVhE/c+tBhV3F647AQYAQk9urLxkmFzBOc+ecVKW8YH/R5shATY6E+Tt0qs82P4Z
	 PRweu3geogawUBkfcD+y/Hi18LAwSnPi4GS1Fs4WiTmTSc+s4jWFEaqU1t6BxRFsikOHb
	 MuyjskO22QxBz0FZEqz5ea3OgFjPEqzm+5tlG4/oYbLmUjKrdp6K6UoGVsMXiUjobEZ19
	 QKwLglTRhUkIutyfoH4MT4dyyurGUeypPdQGg6Wqr8CXrnnrJ8guintxKlr9DaULsHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=4LOtfe6F;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AA606A329
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A77AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=4LOtfe6F
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id OsOBxnPtROOJnP2mRxd2qp; Thu, 05 Nov 2026 19:05:48 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mRxKgZeKD1BP2mRxC5LA; Thu, 05 Nov 2026 19:05:47 +0000
X-Authority-Analysis: v=2.4 cv=N6MpF39B c=1 sm=1 tr=0 ts=6aecd38b
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=0_lNOxZCVW3vH2WxJGoA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=3LiUcmR/XG4SmX1xHUJ4qPXQ8O9XVUvjGOiZ38C2/Rw=; b=4LOtfe6F/8e/
	N49o0Ai7a2n8l53GSOxv3dM4QVBpYbXFvWn/NrRefyEpBXMW20i68iBq5bu1S2fE6yb2eQ/WUNVv4
	rG/5W2GohgLwimN1JZtbl/NnSgiMCb7OxLtWfC6LNWgn9+EbeP23VpgiEyN/488zmEltg31m+B7B0
	+xjZ2v1YL5caaSmURyQ26wVyUj1pUfPDNq7sjjv/JZaWpKIRM2X/PsA91hlYtvIAVRPJ53HM5SdlW
	vAo35/HTAJ6f9FhY8iN5v6bqh0RTR4VsMyot2xcpd2fEsx2mFLDigINzILgYzf/SG9EzkN9bC4IKz
	Qmm61iKcTjI98naBzCiYuA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40728 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mQ-00000003PVz-3SA1;
	Fri, 06 Nov 2026 00:35:46 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 6/8] watchdog: starfive-wdt: Avoid unclocked MMIO read in starfive_wdt_get_timeleft()
Date: Thu,  5 Nov 2026 11:05:27 -0800
Message-ID: <20261105190530.2371854-7-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mQ-00000003PVz-3SA1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:40728
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 28
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOfBhg14JxDIkPcZuYYrOcL+9lrfqdsSP9KN0NFL8HpaNrRGClx3I96ceB1P12jpxDK+tYZwyZBsHHXUa9I6XWqWJEfD/DgIjLfmPk2Zl9HG6oYkiRoB
 k/Iso7EdQbp9syv4mzLqkbG1hW33/npyHFNMdR4vX7rPHoMoQnqQXtqzU9JFOzfmJQpPw7sObUVAAO/Miq7JHKZ8mntYEpAlNhNLBKlJuh2y0+MZP2EF23nZ

When the watchdog is inactive, runtime PM suspends the device and gates
off apb_clk and core_clk via starfive_wdt_runtime_suspend(). However,
reading the sysfs timeleft attribute via timeleft_show() or issuing
ioctl(WDIOC_GETTIMELEFT) calls starfive_wdt_get_timeleft() unconditionally.

Because starfive_wdt_get_timeleft() reads the counter and interrupt status
registers without checking whether the hardware watchdog is running,
querying timeleft while inactive performs unclocked MMIO reads and triggers
a bus fault.

Return 0 immediately in starfive_wdt_get_timeleft() when
watchdog_hw_running() is false. When watchdog_hw_running() is true, the
driver holds an active runtime PM reference keeping the clocks enabled.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch

 drivers/watchdog/starfive-wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 4142e1502038..60a97ffa940a 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -312,6 +312,9 @@ static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
 	u32 count;
 
+	if (!watchdog_hw_running(wdd))
+		return 0;
+
 	/*
 	 * If the watchdog takes twice timeout and set half count value,
 	 * timeleft value should add the count value before first timeout.
-- 
2.45.2

