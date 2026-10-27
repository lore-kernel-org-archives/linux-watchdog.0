Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117040;
	b=VXrDy6IFqUFcaOq2it+yrzbvAL5tXP7gZjJaFMnH6Z3LKTe9MyCEGaJ7V8fFqhQonjfL
	 Zel8WEeoykEf9qTyZ5i79kUbbFbEhftrdQvLQ23SyVgQg2j6aXqlw+lTlfLOAdYwRz3TZ
	 4AXQoKp0cHDv8mZKyrwxP0qni1lyIog1KYxgKLDvyrXaPoNpuTE0pjjZh12G+pwClj10r
	 COjAKFZ9DLeIxCQLSrA/9vF8hTs63x4Q+C9zsYmcaNC44yHlsZ3v57dU8O+/JK1fbGDV3
	 YsM9zNqefc3Zf8jkNv1eepZ/M94kUtbC0ef3iQD+9KwKm0JdUVBjX3Qyw2DgXxnoCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117040;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=G7WmGa+q/qyZzX1UeYVZE0NjpgxCb/EzGNcYOw3xb40=;
	b=MQ0T3+BvZqNgHG1Pz6ar3Wl6hGfJ6j0BCeELwsd8Nk8NFXx38+ZiHcRY9R2W/KUTGahI
	 rliE8pGAIPXPmV4JuYeMhgGQ4pGsQZ/zUAkWYJltn32zFAd39jrFugHxhKGUkcaa0xiM0
	 qvFqiJubb2xax5tZ96R0LucggVbPHvXetmtwiBq5XQ9W7psXSZEXBsMCojgNh4Mq8Qrlo
	 w236LRtwZ3QTCtF4hi17jeIUOmwAjj1LtZ05ZNePnSVB3cud2RXp/IaQjMmCAH/4rkyJU
	 8rd26DfW6BKPOr8L5QPrQue/aUb2OD+x+vbCUmc2LBHDrEdkGes1PWe/7xf0MXbp+Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=QLI++SA4;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740F606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6740F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=QLI++SA4
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id Lh4px8WXgLvgbLjeaxvawA; Tue, 27 Oct 2026 16:04:00 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjeYxlBfVCWbvLjeYxJQvm; Tue, 27 Oct 2026 16:03:59 +0000
X-Authority-Analysis: v=2.4 cv=bNEWIO+Z c=1 sm=1 tr=0 ts=6ae0cb70
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=c9sp0fkGIfdX0urBxCwA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=G7WmGa+q/qyZzX1UeYVZE0NjpgxCb/EzGNcYOw3xb40=; b=QLI++SA4LCC2
	WwR9cBHtwdYaPBv/mBZECf8+3cpBhwpiF9fmf370GNKlmJxGT/HqXD+FrFUrTHVH501cVB3F3Sxl9
	fDlqknZbFR0av3B+/4aZzLDcav+zXfA3v464/U7fp0re1bd8kyoolILtJXBtY+PihEjDRv0CPH168
	AzU3rynQL5pkus3iDtCZ/wMawnRSQ7EiQkVFfv6scKWQgJxzg7I3dBvimLLFoWfsNxiW3XmXOr3Dy
	dACSgEdAyRgw4cvJSU/FijSDgP8sbGUTBnjW/nFUDJZG+JIqdhAFrvOGmRuZksFaG1V5wpHfhLoAW
	K7Gwu0lntQ5telPkxec/+Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51364 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjeX-00000000cje-34TI;
	Tue, 27 Oct 2026 21:33:57 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 7/8] watchdog: core: Fix unbalanced module_put() in watchdog_open()
Date: Tue, 27 Oct 2026 09:03:52 -0700
Message-ID: <20261027160353.2519323-2-linux@roeck-us.net>
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
X-Exim-ID: 1xLjeX-00000000cje-34TI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:51364
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 20
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE7tGXpnmUAHAirC7pDXkpMvCzAY0JOnso/RNOTgPD7N694Olb7qATsHqJHTBB9zq/3Kkxt165Iiqk3NGOe/vF6gqBAdX2CsH72MVanMXGdojtrSl38e
 wEZMRc6WOj1HnXA6l3lRQSOJVcapJ4K6tR5Z1ZbK+BXgF0kzjCAsnfGm2gBN7rTOzFhbQTqtJSaBsb/cg2393Sxj4fvedD8bLlnswoVvHwU0BL9VkE6PtzcI

If the hardware watchdog is running (hw_running is true), try_module_get()
is skipped. However, if watchdog_start() then fails, the code jumps to
out_mod and unconditionally calls module_put().

This can cause a premature driver module unload while hardware timers or
interrupts are active by dropping a reference that was never acquired.

Only call module_put() if the hardware watchdog is not running to fix the
problem.

Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ef2254188f7f..7c80d3753252 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -936,7 +936,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
 out_mod:
-	module_put(wd_data->wdd->ops->owner);
+	if (!hw_running)
+		module_put(wd_data->wdd->ops->owner);
 out_clear:
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 	mutex_unlock(&wd_data->lock);
-- 
2.45.2

