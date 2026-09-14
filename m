Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC6419303
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376185; cv=none; b=iomvZvnz3f5L+UHn3/K5mDbUeIbkVIeP4O1IblhK6sWp+/SifNJSMlas9yGJ7/gwMir9DwH9XzxjhyChIzx0/kC7D3oYrD/iFruQRObmsx0Zb4sbidYHgUKVoOBLRHnqorZJwR1KgsEARzb+N9ZWHcOJY3c9ZbtUXU+QGptsyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376185; c=relaxed/simple;
	bh=Vjq8CiV+AcjbGl5WrMdRx4kgcRKSqFinvXEF5hweCog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSrt0msx6kPWv25/hqTJT2FIaV92IJ7IX/qxECkfGQsmUAH8G8GY+CuQaCXNh8xgiq5CJeUxmSONcy+tDBEFnN7K04v8KbT3LcV+GnhmC+ND+wIzQyOjne3e+Y+jWm0pertbPYE7vlYHevl7K3At9xgmTHxGgE3ICnEijTPy19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOCb5vLN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOCb5vLN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6d28aa26cso22097955ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376174; x=1789980974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tm1uWvgjniSyNtPcFMhaA/1vZV2icpLuG4huWPMXaXk=;
        b=TOCb5vLNYloaaLbcGMgRk8mlY2rCFxzMr2EiipdYOwGZ0ca3jvsrMMRSICt/BbWrdh
         P+qqq1MKNr68P7nQmHB6XOogjR0wDMQGNotfxuEJWEWRq3g0x5RfYyd7woMwfdm4mkMt
         ck4iRqc8sdZQtzoPr6Y3jEzqBi1HvBsFquFhWHRr5VSYWCfvN/Ww5bL8+pvSsT4PEBmW
         OlARlYaTk/XaXShPsFAJiO7KzQvt4J5dluHShZfl02Prgvh+GCBzD6echUCrjWWTOUNh
         O5kxhU/fMILZrPSUWHRe++B+HCzMEohdfIpickRjRJOShT7JgRXOTguc2ecWqjdbP2to
         gl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376174; x=1789980974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tm1uWvgjniSyNtPcFMhaA/1vZV2icpLuG4huWPMXaXk=;
        b=bvK2j/zNv6TNXF5FDHvhm3vxuco6QIXjAbrvnxPeSXe0gf9if+XQfUiPujEyBx7z+m
         Lt12fNnZGmpQUvF69ys65YNYktVnXFi+9GkHTkGUO35gN7Cid0ymeeKqTakC4IILKxVa
         NldqMDSk46OZFnyymbsj07bM2tH05TroXsirigwmf+2FfiJcCVXJwAMfbNCg1NI4FNC6
         TKRdubJmQ1Orq0JxOsnTmjuKPxYGe7ormrC/V7S5CQEo1Joybvbz31OUp3OBHJQBPTRJ
         ecs5pKwKbkOBcX3+zzHpFNYlVuRRGOOAc73qJ8o1/1zQeUeGM3kpadWz0mt4F4IKREHD
         PeQA==
X-Forwarded-Encrypted: i=1; AKwUvBxppo3U/xDIdS9b1wgdQybPPkVneJ1dJDlk2nOOVDo72txmC9TWah431GH06765V8uXLI3cdzC8ECwhltdkgA==@vger.kernel.org
X-Gm-Message-State: AFuF++msRkNJHTZR2HT5ErnLerGPjnKan/n+Lcnu+uJp9lhNLhEc51QH
	mLmYi1owSD7q5LQcOMOz5c9YLpOUkDvUxIGfKWPpFrMyoARcKRS0au8=
X-Gm-Gg: AYBFou1utcl+yKkGnZ5lAjYNXH9vwaW4+wbcriYd0c1mwNuf355YJL/mi4zWOSw8N+f
	ddrmFqvH6x7jl3IpKPstYDYl7BHWDZiXwCXNhAaxzejkiKVBGTyS1uePZmvPnS5VDrSP7x1AAg3
	zjdlwmwULhfm0P0JON5EXOqDp6LgfBQ7jUSacMab1ljc3Jm1R1B0uscfAAZXCbSscFDB870bpc3
	zHD0gSF8QfXGk88WogdIGE4FmrXDIvVKq1qIBZN+uEjrJRBKoodfi3OakZNo0nIr24E5wlmH/XY
	2EB/THzzrXKPkx1kNG8xNeqXAvwb1twwo//DBqSRCL1t+O4oF+2W8yrqEbAt+mejcH9qJwRHFcx
	dBkYdPj/8fTEfSjyz/i8c40IXRjq4NGeqzzZLfyJ7+SQfyPrB/5QAwZqi5ZmIWEUprrOhRoRd+i
	vZkpjreVusjaH0FXsoAzPFxm4E/sobgo3X7qLBWbrqtyViTfTlyOvG0McPBIYIuja/El8wgdygn
	PZiGxg3tAVu
X-Received: by 2002:a17:903:458f:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2dd6c70a474mr28892895ad.16.1789376173904;
        Mon, 14 Sep 2026 01:56:13 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:13 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 8/8] watchdog: stmp3xxx_rtc_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:51 +0700
Message-ID: <20260914085451.891675-9-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 060447101f48..cdd02661758c 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -114,7 +114,7 @@ static void stmp3xxx_wdt_remove(struct platform_device *pdev)
 	unregister_reboot_notifier(&wdt_notifier);
 }
 
-static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
+static int stmp3xxx_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
@@ -124,7 +124,7 @@ static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
+static int stmp3xxx_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
@@ -134,13 +134,12 @@ static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
-			 stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops, stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
 
 static struct platform_driver stmp3xxx_wdt_driver = {
 	.driver = {
 		.name = "stmp3xxx_rtc_wdt",
-		.pm = &stmp3xxx_wdt_pm_ops,
+		.pm = pm_ptr(&stmp3xxx_wdt_pm_ops),
 	},
 	.probe = stmp3xxx_wdt_probe,
 	.remove = stmp3xxx_wdt_remove,
-- 
2.53.0

