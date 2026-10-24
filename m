Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844076;
	b=QS0RRd4oxRovO7xqBqbalzSqpEbeDlhTQozb+tYIrV8OuAg7tXHQZbFFRn7ghfi5b8/o
	 iKxkLwOngHa9cI007yb9W3vjU+OZ4cdJBhihg1ItHFViVIkMzqyQiJgC1/aBX4vt5PKzx
	 oZVju016kzfsXOPig4H1x/tL/tj1Cwr14vr5WXmQi39xRzaHrocZ5TrNjCE+H/CG7mS0p
	 Wy3KmHiH4Yk9lWwoJWOGkGC1gkwi8mz+oRK7UXC1QZcY2mDuEMehU2bAB0EUgD8m1chgU
	 Tv4a37VguCxb5JgPhbI+Iq3Yy9xR3Q1XBVFPf9po5BL/1bjQNGi0rNGAKEczf9x+NfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3IjMPJb38YAf6cwqMCv7g254aUrxQzhzPP6hfN2i0bE=;
	b=JmkI4JvkJw1fU2VLDMZ31/lgzRbV8jdYhPMTzHYHaVIWlZ9yE8wtuEHqRQduL54Nung8
	 Viml8HUpT5JK1tJK5LjrpqSOnKhoXhK3G5Ex4+w1bxOrU/7ah2DxIQ+758MnYEdke5lJa
	 iaFD37LQ6sSMjbLXSxlXVkwFkB8b2+cUhw+nYV6B8uGQoiP6Vvs674+Ac2Ve77i3J657H
	 ttTmpu36RxyTFT2csoZGdp3ULUv9IB8cpZVtcJv9GnWwKtyq3xXctzrdzdsZogFtjvE/F
	 W78ExFKNAN0v297sA0WtltNH1nXPIjSGoeG9tNkeUnqkti/QKSV+ZXxpZ02JNn7DYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lt49uhn3;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2EA606A32D
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 12:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2EA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lt49uhn3
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso991123f8f.2
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844075; x=1793448875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3IjMPJb38YAf6cwqMCv7g254aUrxQzhzPP6hfN2i0bE=;
        b=lt49uhn37Z+8mdul7EfjiDo090a6ajh+wxBaz5Rp3prC/KjJJ1lAaS4MjTRk1ywb15
         AgkGRq8fcuLvbpFpxXRcpKF2ATtGUc53WIJkO+hsZaALVZWgi9Vl/xWu2+3Y5mkImdJP
         e7FDQz/rKIBCQyHFkbaI1ysgWaFIzr14S81L3Q0qH/0JtH+EJL58gsa1AmtKHl7sWzzf
         cbuCnEJXY/RfE7XHw9wpACIfLBir7kyHbj8kgQDnOeTvL/3a6JwspCAA81wTa984tcgC
         DzKdskByJp7wPAG0/DD4TNAq67mBlpCwa8Ln65/uhCM4bmjBM4x1mZLmVZ43/pWxSgCN
         hBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844075; x=1793448875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3IjMPJb38YAf6cwqMCv7g254aUrxQzhzPP6hfN2i0bE=;
        b=foPFncyiof4DuMdRpiIfAQvv7t95ZktHRrgnGFsImH7RjpZRuYg9jPwXG2n992r/ol
         9HBgK/XvNWsSyIQlw1DEUOkOdLKzqav5ZnuJorXurXFMY8JqVcM56uGnr30kN8Xdfasm
         vjFNeTmsfJft7a7QA8AQH1NXWul3VWBqTqaceGgqN5AGs6rF2gUxSrwFuz0Tn6OI9bga
         75U4rPLOv3BH15wFNo7RySl2pXhSsjy5c3Uc7UWuf1ergm7pjJ4o22WBiai0BvK8C69H
         IF816Mx7QWeUnMB+sX6YOawxLJ/Azk9ydG2ZiaVcO9IV0bHJXdzxp/T6oT4c7peur8bt
         qyww==
X-Forwarded-Encrypted: i=1; AKwUvByKmYv41RZYTxa/qwvbOiTRQpj5UQCumOSLh9TwHTihQh2oKpRLQiZNHhdYnQtJM3sKupgrVnSCHWF3atjz/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIe/nyZNpoCKsLvD0YOSqffQRnw1Uer1yUPWVd/eDUMsoVE7PwU
	nWIIzXLxS/vQBKU3eEzt+QwiSGf5hnGt/O+PwcqGuLoMz8eCPyOezNZZ
X-Gm-Gg: AYBFou3RoKHcGi+1SyG6zHuRQYyFtvOE4Be8CxVw10ht2PMLPi0f0S3KUXqUkzNMSsE
	KGcymIbDWHYMfnd+sBlfp78kh8snz6zeywA38ZGXwZA2wcoLW7Y+OosoMfpBicORvoDmyEh4jiY
	849dZmaYyj6Dp0DCs+e13TWLfpRBQzp9199yembXvGTmxX2YTFBoK+EZke/XKBxSOfM7ZXYSXj+
	bUKpk0wAUAIfRAes5/8vG5iC2YE1AO7rTtxiIvLjgFAgbdborT7/68b/EAqSHceHzyy+6pcwbB7
	WOj+HXZozoR9eobnVHJotDrm6cK2YtJ5AOHcS02hxJWok+FmPA6X1HIgiCbloDfhyFb/J+s9xP2
	E4X13KDj/VJ4J5/P7xqK13jc79ym6DHTALDrIXESCPYpsRTVKiT/W+vl/sUBVQU4IAy4aqbm26A
	lUOBktfLyOVNGNkDk+KxhDdtkKea3yL7FvnXIkW/3hiNdx65a9xjFaknJcTfsQz/g1BdiNErWP1
	aPIkWJYqgoIeD2FPq/HVLtgaSm6J+i+pg+xFRgsObiAu9j8gtWRDIdp54CtwoB6Q2E+U6gYcUkA
X-Received: by 2002:a05:6000:27c9:10b0:48c:4444:f0a2 with SMTP id ffacd0b85a97d-48e3eb247e3mr2009823f8f.7.1792844074714;
        Sat, 24 Oct 2026 05:14:34 -0700 (PDT)
Received: from NB-6746.. ([178.66.130.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm3860411f8f.59.2026.10.24.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:14:34 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: tzungbi@kernel.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] watchdog: dw_wdt: use devm_reset_control_get_optional_shared_deasserted
Date: Sat, 24 Oct 2026 15:14:23 +0300
Message-ID: <20261024121428.18862-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024121428.18862-1-a.shimko.dev@gmail.com>
References: <y>
 <20261024121428.18862-1-a.shimko.dev@gmail.com>
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

