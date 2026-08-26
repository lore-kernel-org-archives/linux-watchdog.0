Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F412066DE
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724564; cv=none; b=rkQ2EuALqMA6ctSrMv6F7VRK6OtZo/M8KJcydT8tABXnBIzBG3b+12jlNjIOAgEh2ZZG9hQ8CThrqwzD6qUJLhvzcn7G5uO+nBAMMBbnfxm1dN81SajZlrE4zUOkXFkRc906crfOmABskxG3V5m5uZ1TEdd0+aXWe0I5r2lIIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724564; c=relaxed/simple;
	bh=paPFtuRcykyTAMbw4Wtm2kckDKrqbtGHWFvHbGnsc/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFbsfex+O1NpXweMACbO8LNK5omTjyc52zu3SpoWMBntG/wVYk4/FmbIl94KUowIJG91GC5nQ13Y3muIfzl4ti2pJgtC+4sguv2+LPdGP96/JY4lx4NC5h3qevxpgOQKVeN9V3h+o5iVZf41moZljVt4DKeH+glNtEazGogbuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8e8HPW3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8e8HPW3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so621229a91.3
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724562; x=1788329362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p1q3Ohty1eFRIa2pz+p7AF7flmf1FakjLT24rtEvnh4=;
        b=P8e8HPW3RDjeZVG0G8tG40IlJQ18dimBkfX7pqbga2Y57A8cx87IeLQsd8m/Ym+wuU
         Z5VqWDu2JtmXymeIswOtHuex9H5vLLcpA07fnmavbGWtWm8dQSa3DO+DESqkQ/8EbzDq
         /gIujAkPeGy1lnBqIZzlEZg53xj3EYB3HEdAnofJIxXjHxEILW9B4m0UumezVnKV/Qzj
         golv+TN9w83wXyVNLqLpjDPCDtCOHkyUoG70C/3/ZDDKDk8cTJtpcgAzfHIf6Rso1VkD
         m7+HGRnMgBaXPjQnJqBmB+cujhhvgQrnAzOyNfMOYJsUGXYkTmgyXlM3cSMFKWZwb6HQ
         Ed8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724562; x=1788329362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p1q3Ohty1eFRIa2pz+p7AF7flmf1FakjLT24rtEvnh4=;
        b=Rkpk1l5BWQriFBXamsOmRY0csfNCrSdBhieqWFt0zorGS2fwdrRo/SBnnKjj+5rMZC
         ScGlOiC3ZtmlvqeG3+99GwHwoK0nFOZwVX0Qs6yXqI1yY5Pr9f16LbcYKV8JHnBvZky1
         clst3cNOvaAS1mX/K7++CJQeOmMzUhMTe1A0E+uS9e1TOtWbbQ7IkURmijW+CGTTmKlh
         54TFp/yBogzRDUVxFKsWe6jtxvwcOTNkUBZUew88HCxOvSFIIg5QZyiRANqpzJ/rxZno
         qeBhtpbrhZAptKBiZ0Y1iEwBJnmXyeHXVSNvZUCt7pOOc1EYU+Sq8HcJ3QqtZSjclHAB
         EnCw==
X-Forwarded-Encrypted: i=1; AHgh+RrtuM0WukXu7Z9Qf18IkAB3+mGGyyYY914VhEXTlOrvNVEmUT3UCtlw0Sz15042TXkWZcQkiOXBPxdcH0BCQA==@vger.kernel.org
X-Gm-Message-State: AFuF++kneI7p525iMfUqjSlKR97DidETqqBe2by1zPCDlevpJSQCoS2L
	USfwMwVo9R9iRfmVrk5XoxCvext2jvZKm9bLYrq7LsuhokR98g4zprU=
X-Gm-Gg: AR+sD1052e71kWKdgjMbvDReAx1HVEQxP8Z03qBsABSf4Bj3lKIUuhWo+WV/PVES5y0
	WBzQr/P/FihweFnnSGvHJ4FsocEZg28gh6H1L1yxqx6V69khZ4mRCmVJxK/eIY5tIRER0cZitqE
	UGyct8MYWItajw52FKdQDpYnF7+E4ig3/Znn91G8FYaO5hTt71YYcEyvS0t3lWE30GtAkmmDgo1
	t2tVb7Zhig2R5bFSmWoA/1d6Xvv3XCpkY/6+CaaM8OvvqS+HkW4cvxuKl5Bmyxf/h9YjubcVKia
	bJZOuq+zuwHOpGTanBK8UJlPB14o21V9F2c741GhRub8SC7N5e2nPivlOa9RPVsBFsV8QxR+4Jo
	0hWoMsHfXfOtoPouH9hD8xETo49lu2s+zLgo9X4TH/wBwl43yhjJ9qSBRlX6+vP2ikrvbh8sbkS
	OOxLcAISAbRZCSR7CIG4BVoM5beJ+BSH/MBByQCNahseE+dPh7tus8Im+HNi4mbuHS6oLN7yuzq
	w==
X-Received: by 2002:a17:90b:1dce:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-3966d3e1cfdmr9354153a91.10.1787724561988;
        Tue, 25 Aug 2026 23:09:21 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:21 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 8/8] watchdog: stmp3xxx_rtc_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:39 +0700
Message-ID: <20260826060839.203297-9-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 060447101f48..958e68746f8e 100644
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
 
@@ -134,13 +134,13 @@ static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
 			 stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
 
 static struct platform_driver stmp3xxx_wdt_driver = {
 	.driver = {
 		.name = "stmp3xxx_rtc_wdt",
-		.pm = &stmp3xxx_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&stmp3xxx_wdt_pm_ops),
 	},
 	.probe = stmp3xxx_wdt_probe,
 	.remove = stmp3xxx_wdt_remove,
-- 
2.53.0

