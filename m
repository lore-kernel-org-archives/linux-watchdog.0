Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676641;
	b=dEBp8o4FQHeUrqYANhmkJ8Q+wB4M6mYarIzNh/1OoUB8p+tAYuEgJL4O/wZ+7yl/5mzU
	 86TnT+sPn+QyedMUrKedgdvBAi6jtujgTv3tOT6dDjV1H4kl3OQP53lNpCul0PVb9WTOH
	 Q4j5m0owdZ4kYLOFmh6f0YkJ1NlnW2VIH9UY06lJQsrnidR+0H/5qcoEKPKXW4s3n7krM
	 LjWxQ4tdfEqu1y2BMRY00vRrWZunXeRAjiNjLL5x6oy7SKxkzA2bOJ54OXy0mdDrSKr0u
	 /A8yq2HcLbsIpTspCm80Jxmbj73oNNhLR7+ZRCh0LQMrYXz8cSQmZfidTw2zSPWYYhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vel16q6gN2xg2Z/AVBnJqepV7LiP48eLiT0cnN1qO1c=;
	b=XfefE2iPQQwBLK4lM/fJaS+je/e3uDj06MOqnJ9RbhuGzHpaUrScYf57dTiL5ugG7Z1a
	 EqNycSdX75LFSjqCMdUc5iELo77SHXmOj2H9S5YrOI59Wl/sajhY9Lo7v5A12YfQ/3o0q
	 HljrHYDxYSKj/jGxwTyxr0AGHDXwwF1dE0E13rJQ2ikyEE+uIwyaTt3EymRyEm2vtVE+D
	 WrAEe2sjzYT7/mcvdh7oikP1avVaTq8giooCo8S4QganiK9J+ylY2IE7kWu3zHm3/D2Ci
	 JmpTn/0tw9efoP6fppn2K3Ff5eAYjnlFJDrNOw0YV1g/T6epf/KFZ/JHpC28RGaKR0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cHNjz5sA;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2E60A4AC6
	for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 13:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F2E60A4AC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cHNjz5sA
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2074a66beso5553485e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676640; x=1793281440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vel16q6gN2xg2Z/AVBnJqepV7LiP48eLiT0cnN1qO1c=;
        b=cHNjz5sAwvyB9ToNCxkji6vTSt2soKeHfWorF+IP8rQbOunLU5sxreU5yrka0ba8LA
         V+rhwu5GlHkm0nneC4diO+RLSl8tHKQ1Nc9e+hk4p38+PSpguBwYCT1V8gI2JJhdOs7B
         eTjFY+/7tEhysQy18IPQLz30KDRcamyv3nxpcuFRRVsBmiWj1Ifo1skHUli0YBgIZ9r7
         XJyd7JvqiXYqHTGuLUj2LzTJ8d+icRWZO+A26jvoOlHb3Qv+so57kR0QnJ0B0GrXpaKI
         bklAOoBazNtmV0LBHLaqmOR2WYtx7Ilq6d+9yc+7nqNjAvVVoUb2VPb0xuGyze4VkLYi
         70Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676640; x=1793281440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vel16q6gN2xg2Z/AVBnJqepV7LiP48eLiT0cnN1qO1c=;
        b=GUCuwcv/obU9Omwpz0V4w80RLvQ35ylwkJeUjTuZU5DXZSWj4dHBEp+Nfs43jEhYCW
         OYp9Xa8BNRrJ0/z69UMpf+/t9NJCsA+POyvx3LCDSeDeNweQP2IUzdzekf0mqnzWP3at
         rXFm02vh6FLWTVBJbWjnn8a8mS8i59bFglSTvhdYanhwz1/X88YYCncG5ihKiRXznkvn
         dDpelKsxFgPEfLZ/bOwXQl3wzp8km4xjB1O1/78SsF+BxO7w47s18qTAqj+j47RVveBW
         Twiz9sFQWec9baO030mNfUU/4n3U/D7c2RZA433xxQhWS+ddnI2FeZ2IftKgLpHrFKx8
         NeyA==
X-Forwarded-Encrypted: i=1; AKwUvByLqGrRxKuDa+GzeQieg3QbfvPch/pZf5XxxhuQ196RUPSabI8aOujJdq5A0nZbUpQBKsdabnupmUeX8qh0Iw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/R4/E/yKwIioTJUMBCd7vkQK7jLGxS0uMlZ6gqP1p9whV+3Fx
	6SyvOFSwI7WZPPAKsa8jApxDQm2WBQLI+P5ajEcoD0YXy8BWxXTmHDHedj0I3w==
X-Gm-Gg: AYBFou26fEQohQQ4bQbFuFzmJJH0ulP+3DLvTbrPEYguT7FBKDL4Z4cBbKf7UUA4NI+
	93Rb/wcpntf/D/GGRJKwyqaM1ZAaR0PYVSVeSgwC5zfR/mYUk+YQJDg1srbToUEwkYr+iI+06Ds
	+hfb5k9cZkmXqZ58kmwR7BsYUkQKbkHBtzXH6vqqcDu4fyz3sMGDJ8pFztP2mfhkSqJx/sX7DYK
	6YMGrLsUQSAzdBdRRTvbW/nR8hFy+euEL3VCTVSebrtSuUBXofOljKMEskZ5g57sPpVMOh4YPdG
	TSNAPP2iqfr8CF8nAwkDSdBsPjAKuRwtcC0onaA6fkr5vL9cG6GG2O6lhSesBLnNcC3RBO0QA6j
	GW2F3mN+E0fp70yrT50MJ3pTf9A9iyfVjzqTZJD1XI1AdIVg7UhHAI+XZqWv3u8PUvgIdKEeRnE
	7sGYIG3sNfaFNCXvT389XL119ImgMbDuRdzdcKjALQCB/hy9vJKL1sLdQIWZJugPx9i71TVRA9J
	TxH1HysegnOcYxVtHXXDzKgibPst2EETISeYlsojY4wwwgKb6BtbetaMZlUBI4tfRosvcJt2DYp
	CSo=
X-Received: by 2002:a05:600c:3e10:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a20b89151dmr19236685e9.10.1792676639696;
        Thu, 22 Oct 2026 06:43:59 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm13621390f8f.40.2026.10.22.06.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:43:59 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] watchdog: dw_wdt: use devm_reset_control_get_optional_shared_deasserted
Date: Thu, 22 Oct 2026 16:43:49 +0300
Message-ID: <20261022134354.534642-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134354.534642-1-a.shimko.dev@gmail.com>
References: <y>
 <20261022134354.534642-1-a.shimko.dev@gmail.com>
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

Replace devm_reset_control_get_optional_shared() with
devm_reset_control_get_optional_shared_deasserted() to let the
device-managed API handle reset line deassertion and assertion
automatically.

The driver currently manages the reset control manually: it calls
reset_control_deassert() during probe and reset_control_assert() in
error paths and remove. This is error-prone and requires explicit
cleanup in multiple places.

Switching to the _deasserted variant deasserts the reset line on
acquisition and asserts it again when the device is removed, which
allows removing the out_assert_rst label along with the related
assertions in the probe error paths and in dw_wdt_drv_remove().

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 39031445d754..2cffe337b4ea 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -588,9 +588,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(dw_wdt->pclk))
 		return PTR_ERR(dw_wdt->pclk);
 
-	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	dw_wdt->rst = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
 	if (IS_ERR(dw_wdt->rst))
-		return PTR_ERR(dw_wdt->rst);
+		return dev_err_probe(dev, PTR_ERR(dw_wdt->rst), "failed to acquire reset\n");
 
 	/* Enable normal reset without pre-timeout by default. */
 	dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
@@ -617,11 +617,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 		dw_wdt->wdd.info = &dw_wdt_ident;
 	}
 
-	reset_control_deassert(dw_wdt->rst);
-
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_assert_rst;
+		return ret;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -655,15 +653,11 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_assert_rst;
+		return ret;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
-
-out_assert_rst:
-	reset_control_assert(dw_wdt->rst);
-	return ret;
 }
 
 static void dw_wdt_drv_remove(struct platform_device *pdev)
@@ -673,7 +667,6 @@ static void dw_wdt_drv_remove(struct platform_device *pdev)
 	dw_wdt_dbgfs_clear(dw_wdt);
 
 	watchdog_unregister_device(&dw_wdt->wdd);
-	reset_control_assert(dw_wdt->rst);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0

