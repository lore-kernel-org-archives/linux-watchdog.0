Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792850945;
	b=sj9JEeMJhbz/L3SkwzNRBr+Appf7cRkv8U0KH7/Kp33nv5lwN/AuWpcGGFdaqfgaUzXn
	 ufqJZ4pPtb00Vp2lnsTDiEvn767Aq0tLPC3aAbsnLW+UVSg26dLta3aj6leY7QkneZBDG
	 BtO5Yd8JxuCL9k8QnceMcLsnDTakAz1MAl4yOTF1dD0mjHlBT8I9L38RHIdjBZAjp8bBj
	 Zee+syDo5QBUPfDJJd1SN4zWimLyvOx8Ydol9g2HWlQvbBQ7RCq2X1ImgC3WGlUcXIzY1
	 MUvCL7qLOpu/bqI2O1Xp9+bfDYH//DpPLVAwVt03SDQsavMBSn8zF0Yw/EpKQ4CVIKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792850945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MReo9dgk32myyGMu+6Miwtx+eR0PfmE9SoBWi9y9wmc=;
	b=iTmGNYr8K1b7AF5V/nIMMc/RHi3Z1o2ZD2SRez4vLLXZV6Q2RsEeqdAj3CTC1GQk7J7T
	 JvE/GSbkljQYXzpdrotuuKlfnqCxbwk8XIMcbJr7hmu9NTVSrRIfEmvVwajceFC5Scsog
	 1Zhkr85rNuuijtr46htdxwqIITIHy5hOu00jwNYSYwKJePte2hNZOZ+mj5BtdiHO+4b0F
	 lmsokk97BmFSDkfFqg3WrODFJ3wsLULfUBeXkAI2lLFVuVLrP+fSqIlhWgcXZHjb/6ER6
	 IwMssd0CUzwHN8ypC4zc2symlZenmitnPS8YXpOaxxOZj1JBpBNbK2tMIQrW6DdiLnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lrL0/RjN";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E9606A321
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 14:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A84E9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lrL0/RjN
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1880209f8f.1
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792850943; x=1793455743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MReo9dgk32myyGMu+6Miwtx+eR0PfmE9SoBWi9y9wmc=;
        b=lrL0/RjN4wg+cpui6nIWyPyq3Nkq2Myz8HlQH+782TnUvIqh+wRCDJru0uREYSnKUq
         lxOhzSM1wtVLh0BAI2M90yYd3KXIM4KuPKJ75SiOKoXZK72TAN3D9hoyiZXOfZvDHFyc
         Grkell2Y7xtempELYXyWI1JgjUBtFNieWRx+exo+FsE3AHozPOmSa2gIrDZb21ER5trs
         Zvpm0cfPvgPmC+qbb+mCbKg7Kq4OKRAiwSCJYrw0jzlFSjcXkdu1w9Ov4NKVM8IKoeHw
         saX/BwataPq9D/A8xbiutymVToFPyjKpKBrdzNDX+rJgMVcvWcF5wtjSX3hqY8mxeTlg
         h7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792850943; x=1793455743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MReo9dgk32myyGMu+6Miwtx+eR0PfmE9SoBWi9y9wmc=;
        b=v0a3aycvtiVq1FIbR76hQ+3t/h/wKD0zMO12oLVG7cpC4lNAd1Z8unE188BaWo0Rf2
         kNQnLzbBgaojQ/HNe179+KEvwTdajqjYG941PTyLneur1ERHXKMRUnoWybCRWDF6szYB
         cmiQZOZbWmhlbvZJQ8hjoxoJFxgkkxurPgHszOBhQi+jBXGv0IkQimyhnGoJZpRVNqxR
         tScB3tCsgxU32J9hRxWNcxAzaH3zVs1d1PLQzPGndkDIsz7EweZbx3ei5yvVMT3fB3SC
         32cKAG59st8SRcIf7iFLSfwzVY9CK+fz3Dhw6BSwd/SsGNb16DAQxYWydzSApRdWhyHr
         FaJA==
X-Forwarded-Encrypted: i=1; AKwUvByhjZEnJmF/csBh7dNb4O1Hh3ddHR+HzRrYfNOCcxhHfVyJWDdcTnqfGGxpHh/QiBbsIXoRc9XlsVhzvaUtIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLXvGki6PLvm8Cq1ZpsQRtgRy5ERNMgw20CXp0qQNuU9ZR5iX+Q
	N9m4mNwu6j0xnrRSrbPlgyFoyu2bJ/Qz604U9GE6EagvKia+2ebHZGqe
X-Gm-Gg: AYBFou08MBzZRRo/Z9oAQ1DyJ4FGAYV+WxrxCmRky/sisrEYDcDD94i2U3+Snzv50Cw
	q364EIJ43NKCij4CDYzyw56q/tvt9TxmJsbshjQ+vKOg2d96vZF7bmUJvrmMch81egx3cO4ncq+
	MDb2CgEKQ5P7uo1vE2OAlOzPGL9ZwjsjIoTPxfAfVZkvSuYYtVIBW/Dxe81dAOZ7BySuOTkTpb+
	qZEnz0/p3qY1BEU0vylHjg17yptAMY7YJac4kALaQ+nxgyMENVtg2LseJABlF1aAm3R8BqE3bCz
	pysOZvdedwBDxB+w/B5DNGr0e+Ts90XkRLtUSLdqUc+nC1Q5Qhd+uu/l2c0mgXsgUJKdmClFENa
	Qbqx2ck/hsBnv5/9F529LVn3y6E7rg6aGssu0uCGsQlSDkIe5sKJHjuSdX5h8ydTXZV6LQBfEFg
	+gtSEvmnloPfNBzEZd2QgLdmLtSVOw/3vX8PSw39px1YSin2h6fmYsqCJl7u0NxUTyEZz3XZBcV
	x3pEGcogireeIEJGyimFSvbI+rwhXbClryoEZMaH1nv+ctcF74mZM4BcYM+cb2sYyINJr+mnUqb
X-Received: by 2002:a05:600c:630f:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a35ae9e071mr33734455e9.12.1792850943100;
        Sat, 24 Oct 2026 07:09:03 -0700 (PDT)
Received: from NB-6746.. ([178.66.130.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08643dsm46716525e9.4.2026.10.24.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:09:02 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv,
	tzungbi@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] watchdog: dw_wdt: use devm_reset_control_get_optional_shared_deasserted
Date: Sat, 24 Oct 2026 17:08:50 +0300
Message-ID: <20261024140854.25664-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024140854.25664-1-a.shimko.dev@gmail.com>
References: <20261024140854.25664-1-a.shimko.dev@gmail.com>
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

Tested-by: Igor Velkov <iav@iav.lv>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 39031445d754..ebd27ee684d1 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -588,7 +588,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(dw_wdt->pclk))
 		return PTR_ERR(dw_wdt->pclk);
 
-	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	dw_wdt->rst = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
 	if (IS_ERR(dw_wdt->rst))
 		return PTR_ERR(dw_wdt->rst);
 
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

