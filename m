Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7F31E821
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015002; cv=none; b=OS26USxLletdw92TH+LKS+jyMPU1Bg0v7Bnu77/7Q1CnRCqi1lBFJo0JKynUFfAkxSnmBbAlRUbNecvnhEQG+CpvCS890i7pSSvykcEphM+iwQQIC9TaD66j2A4tJn3/nywlev7qC3roRKbBFPouiCanRJe2s0BFNw2jVDTd+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015002; c=relaxed/simple;
	bh=3LWibOs9TxedP9ncR792x77ukU9MglwtOvq/2B7chl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raM70+GK2y5tuuJ7z30h1DriM4TpctXi0SxAS0XAzde5dU66RJ/GEdHUBMNhjNRZ2OSgtOdZFdlFijy/AMVZJpwkSW6q34ssj4QM20c++xaPrmN+maFCjbSajEyPsBzRinOQwHVBOGShqnyvNOE+eM4YKF7e24+XXVH6CGv7kTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kABZVDCY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kABZVDCY"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870778358aso13276881fa.1
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014991; x=1774619791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq6rCSVjpPdpCa46VU2uh9O/JAm9y3IH5EDT9V6DNvM=;
        b=kABZVDCYs7zb+DHDm68/DIgXkUBwZUck5di1IFptWl4Ji1Hw20ou06x79QtgoZiv3C
         LJj7TMW9iQc+zXdI3+vxgjQLF1tAZYIH9RPqPJ+Jcv4ed4z2Zp/KXc30NPwkCEJkNJxe
         MiQ4gitj9+mREVGixLWTSy76J4RgC950dBUw3KmgeB/wGS6oQDFxJrQzdP1xQu7uCWXJ
         ov6zzHCfwEO/RtRx6zKQvYgiIvow932XAKp3y4MQURrIiDZCsSz/P6obqsm5f5GbIGS3
         s+R5FeOCUselx6ojYtc/a4oB3JUHyjhXHLi/lGyYT6EwRQQGDfRGv3C7ta7MwKRiCtci
         4eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014991; x=1774619791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dq6rCSVjpPdpCa46VU2uh9O/JAm9y3IH5EDT9V6DNvM=;
        b=T7qg5mE9WR94s8lnDHfn0yZUF1mQA7Yh6nBB/sLERAYtcKYIrHG0EtnwjECwEZv98E
         0Q4KGuk6Td8yYdko63D4zp6UjO96U+O9Do3ru9trd12AO+q77I/BVEUPfkVb6DgU+HKT
         7FUQrul67LkughXnPCOZlyASdJbNxaDIPUAHFpsNB0d6GaqPBmcnzeTXuddh1r9DtJXu
         5OatjZQ1quDwAyXh/g6kvydyI7zp+K0V58HsZ4+K001k6BjZajZ/CRhj0ZOFkMS6Vcu7
         vxL589Uv7Qo2v6zhECU+Q+jk5ggxzg9bily67FWlqY4Qiptcl4KET/P5PrKwgFBg41yE
         s78A==
X-Forwarded-Encrypted: i=1; AJvYcCV1J50NNsPJZ5s3w2N5Wiq3KM6ev0+IvGdeX2O7ZKu8LXERFvgCVdzGlZ4pa77g3KD8AkjFIEriRTXlldeJTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe83cmT1Yo3q1HqvWRZXV9uaJ/HPHgNt5vp6YqUornY8g0XrFa
	YChQk2yFrUfp5ONDNyK09/Ws1QJGkYptFXq9iUy0sG0sSrSvRamdGRiH
X-Gm-Gg: ATEYQzwS5wOmojJQFCOYAmaIUDoPjzG5JDTDJ2M2+kjw7Ht1z6WGHM1yWlSD75M1qfK
	3qHna/5Ty8ssgJp8jWcawte9JD7Topd0BDSrdy2bsmL9raSdP90aDR2ZDlcDwdNc8TYi9ks4FFs
	JMRhmv+hr0PV6YOX3jKJ6e1ftCaHrpOWfP57EAt2H+AqL4EothPdUVpe36OAsRAwjBZYsVqJqUD
	oibETOjOVzEosV8/0qYX7kK2X+tTuqMFgEnHHkXY74OYZi6gIzp+aZ0ruhOlKOoeoasvpMmRX9M
	KV/EaTtjQZDUir4ropqjP6NyLcKxVZ3fVlDIx/uhHHIpBopgqdYqiIlcUZrBAGk57UTEXBZJKBl
	K0E6lYW6jwR13gEVpnd9Q9pF2WZJhA4BGWoshiyh9Uhr9WCx9fbDj8egwzKaYLilY+QyMQx7h1C
	zgcHaJ/CZMBkQ61cg5mz5pQAGxwecmajYNHYmpL69DNQ==
X-Received: by 2002:a05:651c:551:b0:389:ecf8:16ae with SMTP id 38308e7fff4ca-38bf9731f77mr12595271fa.28.1774014991356;
        Fri, 20 Mar 2026 06:56:31 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf97709d9sm5468761fa.18.2026.03.20.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:56:31 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] watchdog: dw_wdt: Use devm_reset_control_get_optional_shared_deasserted
Date: Fri, 20 Mar 2026 16:56:20 +0300
Message-ID: <20260320135624.223863-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320135624.223863-1-a.shimko.dev@gmail.com>
References: <20260320135624.223863-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently manually manages reset control by calling
reset_control_deassert() during probe and reset_control_assert() in
error paths and remove. This approach is error-prone and requires
explicit cleanup in multiple places.

Replace devm_reset_control_get_optional_shared() with
devm_reset_control_get_optional_shared_deasserted() which automatically
deasserts the reset line on acquisition and ensures it will be asserted
again when the device is removed. This eliminates the need for manual
reset control in probe error paths, remove, and allows simplifying the
code by removing out_assert_rst label and related assertions. Use
dev_err_probe() for consistent error reporting.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 724ba435b3c8..27b5098832d5 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -588,13 +588,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(dw_wdt->pclk))
 		return PTR_ERR(dw_wdt->pclk);
 
-	dw_wdt->rst = devm_reset_control_get_optional_shared(dev, NULL);
+	dw_wdt->rst = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
 	if (IS_ERR(dw_wdt->rst))
-		return PTR_ERR(dw_wdt->rst);
-
-	ret = reset_control_deassert(dw_wdt->rst);
-	if (ret)
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(dw_wdt->rst), "failed to acquire reset\n");
 
 	/* Enable normal reset without pre-timeout by default. */
 	dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
@@ -623,7 +619,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_assert_rst;
+		return ret;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -657,15 +653,11 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
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
@@ -675,7 +667,6 @@ static void dw_wdt_drv_remove(struct platform_device *pdev)
 	dw_wdt_dbgfs_clear(dw_wdt);
 
 	watchdog_unregister_device(&dw_wdt->wdd);
-	reset_control_assert(dw_wdt->rst);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0

