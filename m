Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104DCA4E
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376173; cv=none; b=V2DtXvBu2LRSjzvNcTitOEJMKISz+ge1iSklDCGjj6X88Vz63QtWfOxQoPHI4d9uFpSWVy9l5fXjlM7fDJGBAe2z5S3HRBQ1OIoKx7n4IyOS7v/3fobRlPMlKDQUSuGWHIWdWkNTE/zF8VMW598Lcx2ZTXGRr2BtLD4NbXJFR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376173; c=relaxed/simple;
	bh=Aq13WwFZ5IUb4sLjIzePFF+aTf4ieMLXlYis4xhqArU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxire29cDWvEX5kcyMcbzf4umSwWLHN8Vgw0ZjaxOS7B39cbCHf+QGtwPXlJZDNASM/1zYvTchjMRpPho77MReaJPw1nwWHk+HzAQ0pdAldWuDfoNessl0ZIyZ/j4AlYrjIl1bHcPz5sAoP8AS4W5g80ZPfwg8pwLRkjihNmlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTtTcFYY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTtTcFYY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d942c7cc2fso28816965ad.3
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376165; x=1789980965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRCQV878jtq6GctMBbJVislS20aqHZzAEyWzyuDnmA8=;
        b=VTtTcFYYsygX5/xlYBq8KHZCLhyoHqVlQTKoXXOUtX3azlRHeAD9XVEMDEu8vu/4cc
         ubf6wlL0quQM9mvT/x5ZjpUXCnpWA8tiTRqoTICCv0ybt8DS1YKzNrP7+n0cd3G+i6Ss
         aFeULxCAxzWnV2WNXHHskUjJXVEu/f+vFnKmZZM1Mb058XeNtXtyhes0y1e9X2zoFDF7
         BFPQ9q0gfR2gQqphEijB/fSupkDrehN/b1++pQOIMw+19FQv1bPIc+n4eTqvr5t1lRHc
         ECF+VwkZwaLrs99dZqmTn901NOtJPswOGCBa3KBhXCZmCOT83Z4b9nWn4fg6tEUj2Ldm
         7eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376165; x=1789980965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sRCQV878jtq6GctMBbJVislS20aqHZzAEyWzyuDnmA8=;
        b=fNTzHKlZ1uCUjh0+/hjhwgCJoONLZCOhTPzusQsWDlulhu6FJA9/YOcZAmZZYQoFHM
         4LLG5YNHfSQpKkF5xyYV5T9QGFqnByIWJc2vCqD6Pzz4tHBPA17Y21XGES+ua6LUV5bK
         sf70b5CVgmXA68cDrzb3ZjM0GT5GTkzXyl0lzNqeHk/IPk3VywoLyzrjSYdTOSbSKoe2
         mBd6T23O63HLk4jpQCznwrliheT3u8Bkjx63o4hEGJIEIw7TMBETH+r8P0BLHW/Nb2R8
         pHDHRckkk7ARD9q55SNj4HZc0y/Tc1LG3sJIQ6FVmjnvWXNhWJKKCGSM6M7Zc3QJpc9H
         Y9pw==
X-Forwarded-Encrypted: i=1; AKwUvBzaoG8FiDisvR8fjp2S89Dk+JT8mGYfc0OfUaZ9M5+KnInwNBFKRXJ9291mK3Ip4tWbTmwnJuOPJwA21kBd4A==@vger.kernel.org
X-Gm-Message-State: AFuF++njaXNPPT8rzUfHutqNbgQg4u2h2iMlUWsvH4zKJpcJconoHgog
	noLeZG3L5jz+zgKxHpPeCxUrJB0uCVlUJMzCB0IJWKJsJ2VQoLrFats=
X-Gm-Gg: AYBFou3DGdt31j5lN2kE6bOMK/L0RMal6n23gz06c4xFbNx7IHWobCbio+cZHiINDiO
	Vgsn442C5rrFr8cN0G0khDRlWnO/T7xdhQPyi3dyxrLj3JSKqosKhsSAfwM8r6Q8E2HFILLeQ3e
	mne27hK/0rfai6o9PMEsLDPP09/84TQA3o1159oiFKo13aGvAXcuyGakBaHwEYk9U9CI5SQ/uQL
	Q2Ug8Xzhwpx3R2MFZoAHh21o+js1hyHo9rTPLW6twcAhMPSZGJQnu16RKNI4MXx6AYZsJMWKMKE
	TU5FEXyOVqDOnfiuz7PMngdxDZN/1r4L4xPuFZbAKka8FqfUb0aZ6U2ZzSc6lc6bMWldhDc3OIe
	DUteNfljtWK6WQ0itmK4R+5sT+C8KuyBmorWqshzdlJpfoeTrEg0F8Ktx6Xgh83ieD7gMVpBbwK
	sMKfN89gzrUGTGgMNzZttgUIM/Dm+wNMU+1ZrWDOJtSSN7pWsRxUkVVNZtioHDFCLHP5BvYNPTy
	RHOqpXKlzxu
X-Received: by 2002:a17:903:37c7:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd6c5be5damr34524815ad.4.1789376164939;
        Mon, 14 Sep 2026 01:56:04 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:04 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 4/8] watchdog: msc313e_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:47 +0700
Message-ID: <20260914085451.891675-5-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/msc313e_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index 4a5cce2a16b1..a77ff57a4457 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -178,7 +178,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
+static int msc313e_wdt_suspend(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
@@ -188,7 +188,7 @@ static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused msc313e_wdt_resume(struct device *dev)
+static int msc313e_wdt_resume(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
@@ -198,13 +198,13 @@ static int __maybe_unused msc313e_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
 
 static struct platform_driver msc313e_wdt_driver = {
 	.driver = {
 		.name = "msc313e-wdt",
 		.of_match_table = msc313e_wdt_of_match,
-		.pm = &msc313e_wdt_pm_ops,
+		.pm = pm_ptr(&msc313e_wdt_pm_ops),
 	},
 	.probe = msc313e_wdt_probe,
 };
-- 
2.53.0

