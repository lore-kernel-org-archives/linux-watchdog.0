Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAB38B140
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376173; cv=none; b=YCpd/1yNJq5Fof3GuxreKleKGpre42QqqW8kLnh5qjab5Ivnj2fAL/2rYzRZl1nhsUaqhG3Ro0jC7uTn86wW5911BNxcLP9p0hfnJ20hlKG9h3pk1SiHo6dQTTlhkhYOuyPlgF1rsq1E1bnjzpnczRdQItQFNBgkSHBMEWkW2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376173; c=relaxed/simple;
	bh=RTx5WaxsisAj0HLL0P1fz576+Kb5f7F2t2qZp8J09GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVUDPOlQFd7VQMdT0M93/CQFmTBIqQUD40GFwQ5b03bY7rMoD7P7YikCsN/IQqfciyOLTh4CW5jZS5pHGX5vMJM4oZ1IG78sTs7OglnA7RZjILaRAo5iemZ6zDHBHl8mrhzKzjXoeAqZLmqqe8LC5Vgi8KRlKhI0UDDFfoqRRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbWC1qTh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbWC1qTh"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefadfso3317025ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376163; x=1789980963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3yUcjSw+ELbT5990YXFbEuKGTao/RyBM42W2/FthmwA=;
        b=NbWC1qTh7hi42rw5zgZTtr9V/AVaf5xV6JToRdPItIuCofkiwsOKr3ZrrEU9jJa6Ox
         3EL9nFh1i7KV7O0MWPoIbi+eg6SZyEP8BTxocWpySJFkh9M8TUsqyFZSFQWJ/picEcXa
         s8d64JM37N1zX3i/BtvGmtWiSJCWJlDt2s+t+hpkmoA3OUHy4cY/SUZoGWZIYpyAs8xc
         K0HxPiGrUgpc39bYlbxbwW9XddvzM6ZW99N3TIAzAiSpP/Vyc9rXm1biwmvUsvuXF9hA
         80PBESHaqwUMp0n+hSGJbE/+0VsSMB6sNpfWd2+lq/4RfebzunpBYZmDHlPNQkao0IOR
         lBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376163; x=1789980963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3yUcjSw+ELbT5990YXFbEuKGTao/RyBM42W2/FthmwA=;
        b=XtwivotHmY3S94mWVcOFqeTw4lONQWBbUcXiMWxzwfmbGA0J8MjQWGLfKrSKDVvB9O
         8SIut5f1C2dKV1ggdkGYMbUe7aOKmg1UOxvB6Ub62mCpDtYWE0mgrGkhkexNJ0bAO2+9
         IOSAfo58h57q18OJhpw4V/adLqJ2DOIzVsPbRMArygNrH2mHgCxe8JQaoGTz0X2V+nuA
         I+5plnnGc8D4g2UBrvlDY24eOksC3jcKYFFwRxSsDDgl1qYJjsQA8ttCjaBNRriLc7fa
         2u/6N5Z0YyL11ZSA5w/MLbClopa5qLMSd1QEz8rSCAUBu4zfZYznY7o6Eeg8CraehzbZ
         gzBg==
X-Forwarded-Encrypted: i=1; AKwUvBz4IXP0qDO/S7TLnAoIRcoNjv9iq3pZL5HoEYLDCbWncIu03+ECMD70whXsIQb6SahjFm0wM/yOIf7zj7F3+Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lsqvIDzlFpIs3ak3jZdYltI0khiP89Eessc983m3V01PLXvWVH
	juLSmOKWr0hyXpP+0KdQDJg3By9t1BggbhEmecowvvqtd3cAeQDs5z9rgRkU1Mc=
X-Gm-Gg: AYBFou1Pi05oGeVMvGkf+MS6vG8uAIErXrdouVRIBTjZZYRldBuBQgrdw+9AhCw9Lqc
	+6NIsEX2uDhuF+WocRO2+FmqAqwU5/fPwNudRDGtKDhLw82FUXyM3Pf4NAJpioE95UnvTNEMwSX
	Gag2nvzjXQbNWyDxajvwlWHzFBvYmZ7mliTK/z/8ubCL5dioNK+aegzsSyBx8q+0I1N2LSRgl2Q
	a1mAAW7Dcd68X/xRBJFUQuwszW8Yx8/yiyrlLYtux2TEFJ+omLFLf+Nnnugh6aZIBFOUd+vUCU3
	ZxgT9G1ki7ZWW4Deuvn1fUn/mrq1m/sSDGdBTv69nioEfoNCLvxGksXST1H0ZofBcipZT1+ogk0
	pXCRp0w+ZYJD55vF48sxENOuLzCoI7gAf3rXRc7p5dOU9zuAXGbTpUEtuotrGIZ3/KIa6NjMQz7
	u2DSveWIR8+JnxEYibksv0+GQ+baurfNUHFKcIRXfMaWpGAM05TFIRMh/Tj/FplFVfcJfkIBo/0
	riXTfErD5jE
X-Received: by 2002:a17:902:f68f:b0:2db:3d84:efff with SMTP id d9443c01a7336-2dd6c60eba2mr20724315ad.2.1789376162686;
        Mon, 14 Sep 2026 01:56:02 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:02 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 3/8] watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:46 +0700
Message-ID: <20260914085451.891675-4-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/keembay_wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index 7c8e53921e40..2c187b20a5ec 100644
--- a/drivers/watchdog/keembay_wdt.c
+++ b/drivers/watchdog/keembay_wdt.c
@@ -250,7 +250,7 @@ static int keembay_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused keembay_wdt_suspend(struct device *dev)
+static int keembay_wdt_suspend(struct device *dev)
 {
 	struct keembay_wdt *wdt = dev_get_drvdata(dev);
 
@@ -260,7 +260,7 @@ static int __maybe_unused keembay_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused keembay_wdt_resume(struct device *dev)
+static int keembay_wdt_resume(struct device *dev)
 {
 	struct keembay_wdt *wdt = dev_get_drvdata(dev);
 
@@ -270,8 +270,7 @@ static int __maybe_unused keembay_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(keembay_wdt_pm_ops, keembay_wdt_suspend,
-			 keembay_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(keembay_wdt_pm_ops, keembay_wdt_suspend, keembay_wdt_resume);
 
 static const struct of_device_id keembay_wdt_match[] = {
 	{ .compatible = "intel,keembay-wdt" },
@@ -284,7 +283,7 @@ static struct platform_driver keembay_wdt_driver = {
 	.driver	= {
 		.name		= "keembay_wdt",
 		.of_match_table	= keembay_wdt_match,
-		.pm		= &keembay_wdt_pm_ops,
+		.pm		= pm_sleep_ptr(&keembay_wdt_pm_ops),
 	},
 };
 
-- 
2.53.0

