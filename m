Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947281;
	b=OJ5FXLF9Zy/cFEmpntGl4OhgngHOhFU51X2E+ltlE9qXkl5e6RG8j1lu5qb8qts0DVa7
	 C72ty3dnRzh8G29+PduqGwBMIISHL0S+oYAuhhYrtd5OFOiUvuVc8AfPpp6pXkd+Iovej
	 0s6zi2gMm4m0G40/nJkM7RVIxgQwOlz0MnzGbROw8HDHY8/HWyrVypx8qsE/HRwahDVkZ
	 GhEaGcbVpt7pFH7Lyv1yCvyIKGz5iRTS+ZNH4Xgt8AcLef/m2Vik+/rFZMAMNhReW/t8l
	 xFaVbvSHl3t2mayA61obqiZJrOEpvGAOBqfMHsiGXBsh8E1ykNfp01YpLtmH7m/6dtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947281;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=uyjLdfQmDiz2aFZH8ieqMJFl01UJOBLEY1l3fqQRALs=;
	b=oefBx6TzeziovzAQsJGYbEQsXA/knqNbBnJXE9t/AesC/RYLqHr3vzZFQ9iy3hrQASrF
	 Ypra2VcwH+MnOcLCb4BTlffOr+PotgBxmhRN6Xc1GLEy5bgkerhevMpREBK64qKOXyUKo
	 DT6uwY9Ld7f5aE/wLLbFBTvvDhfWOHtCNJOuXdL1CY/6YrsllXr269UKmHBZ0ur32s1IY
	 0/3En4drFx5NyS/E/OgOh5m1vwkunkLYGSH+L8H7MjrGWLnAT3j0z2+7NC2n6k50nJOY6
	 l/SoqKwA3EQMr7yKBlMQmburmbJtQkWAqlp3r7X7j8jfvqh25gzcZLPxkIBvSKs0kPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=4stt9mGJ;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB09606A336
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 06:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB09606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=4stt9mGJ
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id Ozsixd7KiVK9UPDdYxVNft; Fri, 06 Nov 2026 06:41:20 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id PDdXxL0cMpr6MPDdXxxQQO; Fri, 06 Nov 2026 06:41:19 +0000
X-Authority-Analysis: v=2.4 cv=Ec3IQOmC c=1 sm=1 tr=0 ts=6aed768f
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=c92rfblmAAAA:8 a=_jlGtV7tAAAA:8
 a=olBggFX0IELqj4Q0_iIA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uyjLdfQmDiz2aFZH8ieqMJFl01UJOBLEY1l3fqQRALs=; b=4stt9mGJeJQ8Qahm7XOtcudVH/
	2E7PhV5gOqeuNDlpX67SrV1MvXeXa1F3mWh82Wk1L8HZaVvEjv1vVEbZn3qU9k1x42zjW6wZtE45A
	Mf3myyLICS7YAigeSYkgLpsVOJGkp0/rOF0bpPPvaTtJe2xWHuratXzIaiWXASB83mwg+NkECaRWt
	edSNpfO23rOv9U7FtmeN1+tPvMqqnfOZJ/5QYhS5Y/3Q7dXgp1EC35OXGmgUu+0nQOUksvQmf+3ob
	VHhO6c7nSiz2ZmRwJpDFk4XarSQIHvXhjOuegqgpsKOdOHeLCEerkjTxYaoSpV/t582Y8NeDxvxdU
	jbsxiyQw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37432 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xPDdX-00000004Lih-0wwa;
	Fri, 06 Nov 2026 12:11:19 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko@sashiko.dev>
Subject: [PATCH] watchdog: mediatek: Register reset controller before watchdog device
Date: Thu,  5 Nov 2026 22:41:17 -0800
Message-ID: <20261106064117.2423995-1-linux@roeck-us.net>
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
X-Exim-ID: 1xPDdX-00000004Lih-0wwa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37432
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMw1Gau5CP/Vzf40d96Qd8QZhDouwPPXHcwuzBcCg7JfHN5mvbFKeTaovZQ+td/20uszs5OJDkQzsxge5FkcjST8/b69MBij1GEr99zZHAefBHj1c+Ia
 4EKYE/0XLsoj+hQIHSRA4MtXhjT9yr4AOCOeZDZyQTJHQ0xcs1uitodunNReYWrBY2kP5chI3zrsz6wte8l2PaAr82U9MFOTMEh/yZ3KE1q+uxw2mI19gSUU

In mtk_wdt_probe(), devm_watchdog_register_device() is called before
registering the TOPRGU reset controller via
toprgu_register_reset_controller().

Because devm_watchdog_register_device() immediately exposes
/dev/watchdog to userspace, mtk_wdt_probe() transiently publishes the
watchdog character device, registers reboot and restart handlers, and
logs that the watchdog is enabled before probe can still fail in
toprgu_register_reset_controller(). Furthermore, if userspace opens
/dev/watchdog during this window and starts the hardware counter, and
toprgu_register_reset_controller() then fails, devres unregisters
/dev/watchdog and cancels the core keepalive worker without stopping
the hardware watchdog (as WDOG_STOP_ON_UNREGISTER is not set), leaving
the timer armed and causing an unexpected system reset.

Initialize the TOPRGU reset controller data and call
toprgu_register_reset_controller() before mtk_wdt_init() and
devm_watchdog_register_device() so the watchdog is only initialized and
exposed after reset controller registration succeeds.

Fixes: c254e103082b ("watchdog: mtk_wdt: mt8183: Add reset controller")
Reported-by: Sashiko <sashiko@sashiko.dev>
Link: https://sashiko.dev/#/bug/linux-edb0d208-f5a5-496a-a6b3-caaa85d72719
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mtk_wdt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index ff72e0fb1154..2d530098a421 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -540,6 +540,18 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	mtk_wdt->reset_by_toprgu =
 		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");
 
+	wdt_data = of_device_get_match_data(dev);
+	if (wdt_data) {
+		mtk_wdt->toprgu_sw_rst_num = wdt_data->toprgu_sw_rst_num;
+		mtk_wdt->toprgu_sw_rst_tb = wdt_data->toprgu_sw_rst_tb;
+		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
+
+		err = toprgu_register_reset_controller(pdev,
+						       wdt_data->toprgu_sw_rst_num);
+		if (err)
+			return err;
+	}
+
 	mtk_wdt_init(&mtk_wdt->wdt_dev);
 
 	watchdog_stop_on_reboot(&mtk_wdt->wdt_dev);
@@ -553,18 +565,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
 		 mtk_wdt->wdt_dev.timeout, nowayout);
 
-	wdt_data = of_device_get_match_data(dev);
-	if (wdt_data) {
-		mtk_wdt->toprgu_sw_rst_num = wdt_data->toprgu_sw_rst_num;
-		mtk_wdt->toprgu_sw_rst_tb = wdt_data->toprgu_sw_rst_tb;
-		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
-
-		err = toprgu_register_reset_controller(pdev,
-						       wdt_data->toprgu_sw_rst_num);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
2.45.2

