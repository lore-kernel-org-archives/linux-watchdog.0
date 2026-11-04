Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810698;
	b=rjbrqoPJVVi53KHeLX9O7tHGvSoNYjPJmrMT5gVT0DqxpiiXpYrfHxv+i2L/SNoNLn36
	 RpxDjB3hJZl6slAyakoEcf5ZX7TU3CEp2mefnU4B7xvdJXQY1SAO8JJ5xWW3byXeMJKH+
	 fYHPeERCb+YhZcNMGRWAHShR6QSZij+YZnOM/5KQmYpYOwt/EIYgIE/JBvYkoCzak5uyS
	 cVYVLMPk6UACxI0Fq3ehZxtNmbMcWwqgX60BPzLJkN1CXYxQ139P9KzfhWp9uurA10tjm
	 31Ho70psPrGfHMK7YLuW5L0uSCEpC4o5q8Ya64prN1V5yux19VV+R/f2PrOyKEwDyfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810698;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=FGEYw6ZAaFklUBhel16kuMo73KkBNMiRaDAHV85KrsE=;
	b=ZsiCSAz5sScsFdrk5Zu3K1bt1njtMU7AdHSSnJu0tH5zWd+WoErtc5ZssJPOhR3G78A7
	 UKWjp/uQREknLzJibiSeB7sAwz1geyX8RJhaiQb64Y9vNNg1FZXPNHhilHHG+/7ETeO5m
	 2NW1OZg+uQFFSG6ukGLHRNt/uQM36rm2Ratb7ZHIR3A8Gy+CtLvhYz6aVathaF8p8TWwS
	 cRnT3A1KPjOqyO2cGaw/z9j37HgSI8BkSoHf74dqlGKsqbFsDz7EWVlSuVJ24pmsXZj98
	 vAJcpFWwZ9lQF1XT+P4RhvhcOOOLPSR9JRQUT7MBuK5jUBOF4yxb0P3cFTnauTSQRew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=1r7uW+rL;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1DB606A329
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F1DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=1r7uW+rL
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id OIFex0q7pAR1iOe6WxuHRC; Wed, 04 Nov 2026 16:44:52 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe6Vxxxzt0w3mOe6Vxuw2i; Wed, 04 Nov 2026 16:44:51 +0000
X-Authority-Analysis: v=2.4 cv=ZtntK87G c=1 sm=1 tr=0 ts=6aeb6103
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=Fy7aeiTQQSgHsYxaS7kA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=FGEYw6ZAaFklUBhel16kuMo73KkBNMiRaDAHV85KrsE=; b=1r7uW+rLWh0E
	zvbu0/ncLQR1P2HelXEvqpsXf8NMlJ4g4RTEabUYcPULAMWH9DRcjz1WL9JhLKFZlnKtVde8kLc9k
	h/uMyE8kaXmQdPJMYob+16NUvhAzJMG1jiZs0fCeq/WKO5C+tB4Q8U6nem12rE6e3uwoc5j5O+j9H
	odWdQ+FM7ROkm1aMFAc1J7zZWUXrESfzxPtetB/W/IPfjwBUeUgeT87RH5rvo/tzJAT5+PV9W96Ou
	RLC9FAv7VDfuD8m8cRa0n05+6N0sOvWgA2OLv7cwnUD1kdMw74WuRNotjUvgniNQ3fmrntk/0XNGo
	0H1sbTNJi/OUo9s3rK5TeQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41190 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe6V-00000002c6D-0SqE;
	Wed, 04 Nov 2026 22:14:51 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH 4/5] watchdog: starfive-wdt: Fix runtime PM usage count leaks in probe and remove
Date: Wed,  4 Nov 2026 08:44:44 -0800
Message-ID: <20261104164445.3209560-5-linux@roeck-us.net>
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
X-Exim-ID: 1xOe6V-00000002c6D-0SqE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41190
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 41
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE7KC7f/UQNjyWMSugTIKJ5UUxDcBpW8g0Kt6kS0VrGL+yrfyrsyyPg/WQJ3B78E7r+psrMovMtXaW9qN1Q3GHVUxeMpZkZBFp3K9LhZt1eW92Zqv+kG
 1GH2osYcMkQx+zEIJpufDgMenGexUnLhsMoi81bX4uDiswXN9FZ0yZiedPyxGoIEzfIO0tER49jc4041U3LX4HvlwRmqv+9sDa5rlLDXzRFNcxJQAfiDWeg3

When runtime PM is enabled, starfive_wdt_probe() acquires a runtime PM
reference via pm_runtime_resume_and_get(). On subsequent probe failures,
err_exit manually disables clocks via starfive_wdt_disable_clock() and
calls pm_runtime_disable(), without dropping the acquired runtime PM
reference (and leaving the hardware timer running if early_enable was
enabled and watchdog_register_device() failed).

Similarly, when early_enable is set (or the watchdog was left running
on close), the active runtime PM reference is retained after probe, but
starfive_wdt_remove() never releases it before calling
pm_runtime_disable().

Release the runtime PM reference with pm_runtime_put_sync() on probe
error paths (stopping the watchdog first if running) and in
starfive_wdt_remove() when watchdog_hw_running() is still set.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/starfive-wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 18301f5d1144..817f84cc2807 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -517,8 +517,14 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 
 err_unregister_wdt:
 	watchdog_unregister_device(&wdt->wdd);
+	goto err_disable_pm;
 err_exit:
-	starfive_wdt_disable_clock(wdt);
+	if (watchdog_hw_running(&wdt->wdd))
+		starfive_wdt_stop(wdt);
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_put_sync(&pdev->dev);
+	else
+		starfive_wdt_disable_clock(wdt);
 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 
@@ -531,8 +537,11 @@ static void starfive_wdt_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(&wdt->wdd);
 
-	if (watchdog_hw_running(&wdt->wdd))
+	if (watchdog_hw_running(&wdt->wdd)) {
 		starfive_wdt_stop(wdt);
+		if (pm_runtime_enabled(&pdev->dev))
+			pm_runtime_put_sync(&pdev->dev);
+	}
 
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_disable(&pdev->dev);
-- 
2.45.2

