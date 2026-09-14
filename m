Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D8418365
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376179; cv=none; b=By4keRqUOQ7Uh8VqqKw1hdmO244qjzljETbuvI3Anbg0GmEIqT5caseBm4GDS7ESXU3QSt+hwvxZRIegTkKytRS/JgIx7Lkt/lbJtrsiFgrKsP0ot8ZtzoJBSf8X5666fbd8q407H+dF1AxhrE5FyXf07PqC/+PWBvMjpnnQY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376179; c=relaxed/simple;
	bh=y7LKP0hPBt0w9rE1pUDYU13Xz7kCbBtwcqXAb5/KS50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTcZWUXPN79hS3LuWozgcsNebKH5Dfnewo3pFvmBdCA5J9oCoelT9lZ60PC4BXRLg1r/hh7Zrfr2i4Inor+VeW8J/+WSccrA8E+grORanl9hoUg9J6LCDK1GkOPz2/SDFZTi2QwZI6TfDbk7Y1UHhxf31TzxvxkKo6daN4VYvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMh4ioFt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMh4ioFt"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fe517774so22861365ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376169; x=1789980969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrzJJYdH2i3lLZDFeZVpijQjrI6XyK+8ogP7QUaZAPQ=;
        b=mMh4ioFt0v1P6p1d61k7esv8H1fVx82d8PC1xNjsnDsL0UJeD2MlXGGGLMDiolY6h+
         h9R9ewF9TFBKWdDdKhmHldsdvMJ5Qz8LUAiL3zWG8xyvIgVAomuypNXc3XVJXtFPo05Q
         Qx4UZTHbY/RJniPHbhc6jKMBqJDLL+3XWk7PIa3wU9vVAEYndltW7U4+EMNCdsIWLsap
         RwsfCdvxSkTa4fJI4/FC/si7hfGe4Ddwpj4CX7Kx2kWNLsQtj2ITLzz/35Cq8X885DsA
         hkyqo0AoknfLh75jbAj3NWflPtqL3PX6hXMk2BjCjJxnECMmyStBAUrc6W645/LIhXLX
         cpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376169; x=1789980969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QrzJJYdH2i3lLZDFeZVpijQjrI6XyK+8ogP7QUaZAPQ=;
        b=tZOINQLKOWFPjf7xXmoVquGA7ybJBZvskpREsNjCZA6wx+PSvoRwJU2Vnj+1gOkQxM
         pE2THh/97RP3PkMnxzk9JD+JRNjv2+dNAZzz0oJVEqvW6BnlBAAir+OUti2YUfRPgy2n
         zdIbW4fIjnqJT98N5T55GObn9Plfrj3AYd/9F5bxxMAuTro02egP3DF4ELqLjghBErtf
         c2nf07iu9CLrRM4+v9qfEYumnqwMnQovvONJDvvlVAxQyXsTkg9SlZ0f7nSXFHPQy2Zb
         9jAvu2HjOIZWOGGJyrtszWGfdBdkCX1eNYH5z78B0L5zL41Cn5Ay0OALGL+ENRL/tZoi
         8RhA==
X-Forwarded-Encrypted: i=1; AKwUvBx8kOd5F1DRLXmpquvrBkPwx4fjYmCSjsj6YuOJGGr5aO7A5Gn+KSXDfzuaLzyqkGZb99uq+QdlPMvKX6j9KQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lH+wovAI2i3c/mN6y7dK2mEpw71qTprD3jTDgIsVkm6b/7/sJk
	mlIOvjOWdZhuklZ++/Uf4tgKtPw74LHM2+oKo15z8zFKilk83sUFFuM=
X-Gm-Gg: AYBFou2rDcIONnMK4MfjPhZ2ojiIaS52oJyTF6Rvtx/7zIPQUWs2+F1B4g1x2cSQrz9
	w2oNMf1jtYyTAMbHYCTSa4XDRPMAjcGPeT0VHr9okeCaHnohu0RDXbo8vYmL4ejU6Dz5F+IAdZk
	dvjQgyPTzoH9nWVPx9xBqoPi29ocDEdbkP6bmh3Micl8JSFfjxoP20XTTUT5WNaf+/x7PTRxSeK
	OfKYp+KMmjg+lkAJmSkjrxoMkoNQLFBXIAJ0G6h+KV6CH2sxcV2I6OqxvZddLV/i3xniZdZ0KEp
	sv4NTTc1yCEUd/7eBIfRtDDInz8bCjxsK/cQLutqFeMeFJLB/cjmIyn+d/Ro4UoR+6Un6GVm3JI
	TAOLJXuxa5KGHpmiSFDQg/rDTYnMV00LKWqhseay1DszCm7/ZGtmm/xqUe+cBz9vJknMiSgezD3
	EY1Bo1KSaMCOcyS3ZL3zxSrHQhG8LDvQHFivnSwgkVSexb8MWG+o3AT5AqldGQoDk57IJ6Sm+ok
	z6S9AZg69F6Azn+iko/CFIh
X-Received: by 2002:a17:902:d4c8:b0:2d8:d4cc:be65 with SMTP id d9443c01a7336-2dd6c713ce4mr30781575ad.18.1789376169491;
        Mon, 14 Sep 2026 01:56:09 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:09 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 6/8] watchdog: pm8916_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:49 +0700
Message-ID: <20260914085451.891675-7-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/pm8916_wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
index 007ed139ab96..b97c132de321 100644
--- a/drivers/watchdog/pm8916_wdt.c
+++ b/drivers/watchdog/pm8916_wdt.c
@@ -233,7 +233,7 @@ static int pm8916_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdt->wdev);
 }
 
-static int __maybe_unused pm8916_wdt_suspend(struct device *dev)
+static int pm8916_wdt_suspend(struct device *dev)
 {
 	struct pm8916_wdt *wdt = dev_get_drvdata(dev);
 
@@ -243,7 +243,7 @@ static int __maybe_unused pm8916_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused pm8916_wdt_resume(struct device *dev)
+static int pm8916_wdt_resume(struct device *dev)
 {
 	struct pm8916_wdt *wdt = dev_get_drvdata(dev);
 
@@ -253,8 +253,7 @@ static int __maybe_unused pm8916_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(pm8916_wdt_pm_ops, pm8916_wdt_suspend,
-			 pm8916_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pm8916_wdt_pm_ops, pm8916_wdt_suspend, pm8916_wdt_resume);
 
 static const struct of_device_id pm8916_wdt_id_table[] = {
 	{ .compatible = "qcom,pm8916-wdt" },
@@ -267,7 +266,7 @@ static struct platform_driver pm8916_wdt_driver = {
 	.driver = {
 		.name = "pm8916-wdt",
 		.of_match_table = pm8916_wdt_id_table,
-		.pm = &pm8916_wdt_pm_ops,
+		.pm = pm_ptr(&pm8916_wdt_pm_ops),
 	},
 };
 module_platform_driver(pm8916_wdt_driver);
-- 
2.53.0

