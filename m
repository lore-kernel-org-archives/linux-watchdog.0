Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E94418353
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376179; cv=none; b=h5tdWykSO0xFbldAqThU+Axrds7DT57TjKbnw1loCpu/VK48iYgJT/3o/IGegyeQEIQPHlWV+vwm5ojP99p6Ux75Z2wNc0FSt6qptqjgE/oDe09Gei63GKmfmlBykBpGBK16werOe8xO94Q6IlzPyA5uYrVV5Inaj2ElUqCXhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376179; c=relaxed/simple;
	bh=VJiv67mwrVIrgYZjYbjLcy3MCF7os9CZLrjt3yy/g/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq8wTYZF5t/z/t7OWAswsSYCHcDHb8UNf/zzVSbNRGurgl9FeUa3tvzJFBb+kA0AcItOTGDTBapLG4H9y6syc8z2jDo1wUazRluIS70wOO5Qe04BH7Lqp0WTjjWC9Q32w4DEEm76/om1wB6EwilR/w3oe6wbYlA5Z0QYIBuOpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmdTjezE; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmdTjezE"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f6so11006145ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376172; x=1789980972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i1h8gGQ0slKUu38u6edByv4D8YDTtTT2PSzYga/X6JE=;
        b=mmdTjezExf9Ivp3ru82myHQ2fNAwA8CTzZxJ8ZE3jMvNfwelaRFQfYyZLPMM1AKsnW
         SmlyLWL7vIUws2ytBemx2HrwixIVqVwlMtOwCum+0sAXryYXIfWwP2dnbK3FQ5X9olOv
         H1AkgYk07Z0altyjG8Uo0tq08BziCbKVwDizK6rhgiwdp6G7Vuwblv81g8YNs4e1mg0Z
         ojOkkJiqutQ6w1lbeX+x6eEwx6J/DrgGWWve7Mmq6lAAb/aNUNT5Ijo7G9ScAbaJqOj7
         RtMr7RBr27/gXov5xxJFlMcPjUbPeWa59+yeVb7aC4HKEKDrjTmnHgXyQgIH8Iu4Cud/
         gVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376172; x=1789980972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1h8gGQ0slKUu38u6edByv4D8YDTtTT2PSzYga/X6JE=;
        b=lvQAZpkkSjlwUWX4U09SVpduVFtCZOFbIZ/aWDO9hGH+QjewN2858KGQnoe8Qpecc0
         TZ1h8FHMOapqRbHcccmQiHKcD7MKyKcZRYMBQMol9ebWb6hQIiY57IAPdIDiF8HN1uUR
         /PajCNU5IcHQfMRW/Qotzaxquo9pmqVTyV63FU1ENMCSxoTh3u9CtW2UNVPjplimpeua
         LG8rXruLSqRfL9ZAgzEkdPgtCL8ysQGAXyFrdHWYUtUthSfvXROFdZ58oNh8jkzkHTPF
         JrJo1cxgP31P4yVD2px5Yq6nGayZhpnILYpgZ42M6rzGszWdTF6MNT9XnmOtQF6gqqhF
         9Ivg==
X-Forwarded-Encrypted: i=1; AKwUvBwh+RmMvSqEl9M5+4RwuWpaxvVO7oURz1nEalXVR9UMoZPGZ3/kAhURX+PI5TDQ5ITnRKl9Df1l/EqNDQVNBw==@vger.kernel.org
X-Gm-Message-State: AFuF++lGA1QVHbJ6p1fJFH3XtMDITz4qG1IOIZk1H28noi0UaV36HJUZ
	iar1ahKdXwvilj59NReNDxIOf55/31goq8wIy9OLJaI0KJi1TXLxtRE=
X-Gm-Gg: AYBFou2CsMARuNtUVypHS85XmAA3xLXqUSbfhhmCLKfsOkvUc2FEiiwG8bgZYBQy1hl
	sUS28C5g+kpezg9Ri1ilUZZDqZ+Afoy6P5IHQOiEzA2wixPNGhTJpylqluzfRKZUf+HNLD+76xg
	niAYjKziDnQT21T/6hw9vA3xHeQB7Dzuxevp1DD9JgOmLT3fPR556j0dcgHHco3ZvQ+T3nhrfdR
	t3PxtZbOnEgTAZtdKuhYBDkX81hOeXgbI/YSCxXj+ReegXHpYM81HgovKkLxFkJt4u35IDOc7E/
	P9rTnnTq6uaQm0rRpsEVsqvhMqwF5NhwITRD4jV9F2/rP/Vj/ENQRPofkNQWqZ1ACf+NPn+zLKZ
	cxko6Cgj3LcQMuvyPWRISqCtlHKfnMj9K6qcw4cBcOltHm9isfMnuThV2MJ1QIB6d5uwuwV9cnk
	bzFLUAKcmAUP4jmthFfal2Nu7avqBOLU7w8ZeEVQq+ntFfiLupjjEkEm6djzTeYNNEOHsSbSw5N
	/yAnJOPk9CYUORHaty4Eyg=
X-Received: by 2002:a17:902:f608:b0:2d9:33d4:a910 with SMTP id d9443c01a7336-2dd6c5bfbb2mr40132535ad.4.1789376171709;
        Mon, 14 Sep 2026 01:56:11 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:11 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 7/8] watchdog: sp805_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:50 +0700
Message-ID: <20260914085451.891675-8-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/sp805_wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index c2125f204a13..73f821e2611a 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -321,7 +321,7 @@ static void sp805_wdt_remove(struct amba_device *adev)
 	watchdog_set_drvdata(&wdt->wdd, NULL);
 }
 
-static int __maybe_unused sp805_wdt_suspend(struct device *dev)
+static int sp805_wdt_suspend(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
@@ -331,7 +331,7 @@ static int __maybe_unused sp805_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused sp805_wdt_resume(struct device *dev)
+static int sp805_wdt_resume(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
@@ -341,8 +341,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
-		sp805_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend, sp805_wdt_resume);
 
 static const struct amba_id sp805_wdt_ids[] = {
 	{
@@ -361,7 +360,7 @@ MODULE_DEVICE_TABLE(amba, sp805_wdt_ids);
 static struct amba_driver sp805_wdt_driver = {
 	.drv = {
 		.name	= MODULE_NAME,
-		.pm	= &sp805_wdt_dev_pm_ops,
+		.pm	= pm_ptr(&sp805_wdt_dev_pm_ops),
 	},
 	.id_table	= sp805_wdt_ids,
 	.probe		= sp805_wdt_probe,
-- 
2.53.0

