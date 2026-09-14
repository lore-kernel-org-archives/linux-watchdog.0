Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB143F8243
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376170; cv=none; b=FEKUzD1ppu/jJ/XIqA3G8TrwmOLWvyrHD1crK9s7POs63F09Bg8dqx0CzkmZD5CrAnrzFkHXU4qdLTPrGphxEYLAUSNup4SHsEZ5snkUE7M8sYfesrbXI/YI/TpHLOOj6tV36Of72QvnXEVZb6h+h/XB5nxnawHpFkn0jSCbdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376170; c=relaxed/simple;
	bh=8DM52ZxJYSCTECoScr2jeTQHoMA3M3eAOqwROetVXIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+1uSwvboZJ2vgN+oNZOTzTC7WNcLRvLry1tYE9plWHkppAO1Txw49qc/wAgUS/OR04kOepxcyUOaNUhiC2L96JRqpBMmnGQIRoAxCMXJXoxBXlU1QRcp7clmK90/y9YTlsajty3VewKwbiFjYOTGof3gzw0YLIQLfVsYA2AXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gut6a78I; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gut6a78I"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db3305f94fso46783495ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376160; x=1789980960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kR5F0K9Uis9I6dBmqd9WemQ0wgMGxaZJC6u0jihBbyA=;
        b=Gut6a78I0S8hiZdutr9ru7qjIAEm2G78+ELDqopZM710Z3JBqTkyZaFndmym3lrfk0
         iOnRX17Izk7b1IP6cT5Pm6iGCTqe7o8HsQZEVWo4npE+3whdmolbORqREQZWwT25v8Gk
         XTYxf4skLtDt3Rk/TDsigB7axg1hIwhFlTf02GKUZ2qpYRFAJfWNrYslcL2p2LeViBO7
         SUkM22ZgHR5ekZi5JZ/ekh3lsNdcn5ydhgv7f5cm95YrBj50J0uzXIAD5FlLUlnKKxO9
         bVa3o5jh5O6n1RQgLyZBkhwyycLB83kGI4bnZ9eMzThC+O2p9ZyuSEzeJ/R7HGr4NkyV
         UlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376160; x=1789980960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kR5F0K9Uis9I6dBmqd9WemQ0wgMGxaZJC6u0jihBbyA=;
        b=jgd5CHrKynqGXDpdEWdmtAg3VQ6XQx39T6NWjZLj6WOGUlYh+eEGVWSkAZC2prAR4g
         kxlCPhtJsICMqaG5Zs0/YSBrfloIrBXDK0p+oYpeNnGQKT/SRghSZPhadWxNimFmd5zJ
         LFOBi70629CZPSNJceFrPv1DO+JQFbThHUd+4qVKn92oA6oTo7iufOaGI0nwaDXlI0Wp
         GJErumjkj7ub1yxNLcFPOPpy8quGBOSlsRIla9iNBQAwteEV5lqg8KbvbjP5gO6Bt/lZ
         6sEgU5Qo+u8Itm3XV4vcAyc9Ma+0ZIs9IEwbi8Xn9lKmABv01gz3Z1TTs0AEydWJQmWN
         hcfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPAzRrnkMVSjJeZayfAB0nYgxLCLoVI5K5MYoH/NgKxAKjhgw+VFiskOceXcuUU0nLD0GFy5oeMovdDWUNgA==@vger.kernel.org
X-Gm-Message-State: AFuF++m36f+xO0MM6SLO6IzZ6c4s2XUbLxbjG4au+Bcb8XBpvxZiZPap
	v7hwHmhdeiFtL3/JRQ7B9igqIuvs1tF4pGoXnRiNDdSpgtUxmU5i64E=
X-Gm-Gg: AYBFou3bHve1xEGz1vLUNpd/rH49jgvxd539hpClHgm8TiDl0ypFgVCNSBAiZwI8T3s
	NS6udiEyT9gj6MmQGe+0EKXVx9JL8bIWonRmliOo26C3/2tQee3/dm2kEx5mLfMy1NBHmUWvHT1
	6XNXrw5grWxF/2eMpV9ZEXy4Ga6gTKBocFL4swITeUHdwd7awwTzr0OgeABqgFRrAMkZVZbx7du
	MUphtD7bXU5QrSCWH7rnicPBh8O0qLViSIKy2Y8BcHbZg4XBG7wqASmUFUywmK0zlb5884CDCPF
	MebUdcdtbvpVlo44Khnm2xS/lWZQD8hxU38g8Ja26K4oLA9atkW99i+Wlsb/yXmNI4bH9BCensI
	XNs3gys8cf3aaL0AYEF8jpxSfgsBvWTBGcotQMWx26FedBllPSdEyfjUQdEBPeaSoUEeZ0ces1h
	96ySG4JXlZJBjzQh3ynLVBIails0H7XsPE7OCQMMfJcEjbnUjKlnduPwYMJOqbgQCiCkxcyacrp
	MGi9kftJcPh
X-Received: by 2002:a17:902:fc4b:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2dd6c5d0c4cmr37285505ad.3.1789376160522;
        Mon, 14 Sep 2026 01:56:00 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:00 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 2/8] watchdog: da9062: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:45 +0700
Message-ID: <20260914085451.891675-3-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/da9062_wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 426962547df1..95585dffba6d 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -248,7 +248,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdt->wdtdev);
 }
 
-static int __maybe_unused da9062_wdt_suspend(struct device *dev)
+static int da9062_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
@@ -262,7 +262,7 @@ static int __maybe_unused da9062_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused da9062_wdt_resume(struct device *dev)
+static int da9062_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
@@ -276,14 +276,13 @@ static int __maybe_unused da9062_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
-			 da9062_wdt_suspend, da9062_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops, da9062_wdt_suspend, da9062_wdt_resume);
 
 static struct platform_driver da9062_wdt_driver = {
 	.probe = da9062_wdt_probe,
 	.driver = {
 		.name = "da9062-watchdog",
-		.pm = &da9062_wdt_pm_ops,
+		.pm = pm_ptr(&da9062_wdt_pm_ops),
 		.of_match_table = da9062_compatible_id_table,
 	},
 };
-- 
2.53.0

