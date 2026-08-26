Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98638F65D
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724559; cv=none; b=Jl1PyjVsLM23a+wSSBxzsi8/YcUD0J+idL1qNUDFLpfQ0Sn/JF9GslrwO/GcWDhecpYnmtFLdhYTLxNeVg/k86IgLxkxGJplyvbGffe8mFLR+y7K+53Fg08fTg8fO0w7g7p9rMRWxcKa2DzRSymLza9td+Igwz4hrOBpC6cR33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724559; c=relaxed/simple;
	bh=lEd8/L65E6rmsvdv5a1DTlH5mv6tLuGRJze+JPuMVgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmIsFb/HYoBhDN59YKblh+e01P0adB0yIYttRkl6yHEacap6Or2kzydq5nPtmG4LmwaY3fqpboC9Vol80Z/26Lw0P4fbAiYilXof8tUBD4d2S8ew1wbl3oo/YniU4n6tkqSyE0F7XbLhfsUnQx1cdShF4VWuMJq7xfHas3UqJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqPCFC/s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqPCFC/s"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso7188895ad.2
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724553; x=1788329353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlXTZ8HT5DRthlQxwhN1n0mM4QzzpbflT+YIGb8vI6M=;
        b=TqPCFC/sT9ZGHOlvW7lROsPEL75rIdpLFsmLY49Rr7MD0F5WqbVIsYbq5eqKv3QoEU
         Et4XNdloZCgckQ/41HQPnGuQ+jWa/8XueO8LV/wQHbQbfnZGNlvJNjJHkeUObhR6T22S
         3G7ZjoezihMCkrk2RRnR7KRe7Wd8y6YMGdV0EYUW3zyWN1KOwRf6MAXfePG2dVIiOpd/
         IQJpb1rQkBCZ1EuuzyjSCFR3VIPKggnpCYBiGX/THgun5xsb2SP/JwButxrg1AoL5ckV
         nJo8S/6QB9gd+1v9RO8HdoJnqPQP8nr6Po20MMx1WDW7Ey2XZVj+r/BvUndyHG1t5aA6
         BXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724553; x=1788329353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rlXTZ8HT5DRthlQxwhN1n0mM4QzzpbflT+YIGb8vI6M=;
        b=U1LIoK3rTE7luVlWLvvk78dQgzcAZKzTXjjfvshlw4cUqevcRlFZKRX45/KY6QLVIn
         tjbsLyrDuiREgtokllGD0z2ahYPcAicUlLANYbLNpqbmTaRMZKGNGQ4nqrjfqWXR0vkI
         RWtgt3wWPAhf/RlA+wIDAHVbjjG3XtAjnGMimMhg1FR+JIIPVLMTQYASCnga//l0noB/
         pOaPzfFr7R5Q1JveNhGm51qSjA+1wCgWBSABKBLLjDFfMWrlT61RbR9mdEKD8MjAYEF0
         Juh7AfcnKbYD/8TWpWjF+SwW+uwoclnTeG2PF0mFuT9ffEWrBpa2cvqGyiMJy44l5uDX
         mnBw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1bVbcjFwEJ/t+SQuuoFLmFcWErAsEgVlZ8zhIxN44c5JeZSGAdpP7HTXpxm/vv/p82UcyTI7vygIAHgMWDQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nlKttyozREamTBXmbugjgQdwt+ZGW0BXEdf7mKy4rHmZvhsEBy
	JG3dI2Q97y3r1u5ldN7Mrq5Vlt1J18tPds8HItNYh76mgV6rMnoItGM=
X-Gm-Gg: AR+sD11olqccKYXjC2dFxTWapsIok4PH9djKZgz3zkgDFsOcfnoU+0Yt+Sj/m/mpO42
	Er0vBqZOj+4mduxvV2OBE4B2bFDFpwHNLjj/mubL26uUdzJEh5WmXCeo/FUnrPlG8OQ3nEO+cX/
	GjzgNzGZYkK8Ku9+7ZiyiUzSmHgjlQWPFtYOEeMVbLiL+/SszTA4cJOuimEb0u3261UHzhnUcdU
	1nooTgbHMflpcgCi4IpxKOUeRapuiO+TsjVRMSsI979DDLaT9kAlcT8bLIwQIUUr7S2OrcbL/bC
	Brf5e8D8PfSv7oXfDbhP3GxQ+x8Q5A4Yr/EjR3Qh8xGccWUDzOM/k2SdmCdeyCoqpKhY5joL3JW
	GX6xwiMkIsDupKoFC32fgQj+3yR7umwWTbqZ3nMl+0cjkYVdI7tBGX5t/iZIhJIpeAa34z0gUXt
	pAFo78M7fa9cewQFJItPoT0vtavPQ3g8fgRk43TD5Y3Z23NDfpktAwHOhgaQiy6tlt40LVgBvl0
	yUxz0mmARmN
X-Received: by 2002:a17:90a:ec88:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-3966d1f585cmr10374465a91.6.1787724553055;
        Tue, 25 Aug 2026 23:09:13 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:12 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 4/8] watchdog: msc313e_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:35 +0700
Message-ID: <20260826060839.203297-5-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/msc313e_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index d962589e2c55..10de94205600 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -132,7 +132,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &priv->wdev);
 }
 
-static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
+static int msc313e_wdt_suspend(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
@@ -142,7 +142,7 @@ static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused msc313e_wdt_resume(struct device *dev)
+static int msc313e_wdt_resume(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
@@ -152,13 +152,13 @@ static int __maybe_unused msc313e_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
 
 static struct platform_driver msc313e_wdt_driver = {
 	.driver = {
 		.name = "msc313e-wdt",
 		.of_match_table = msc313e_wdt_of_match,
-		.pm = &msc313e_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&msc313e_wdt_pm_ops),
 	},
 	.probe = msc313e_wdt_probe,
 };
-- 
2.53.0

