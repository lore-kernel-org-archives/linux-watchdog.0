Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7893955C6
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724560; cv=none; b=apKwJdWe+zmpDrITkFZVuETfGsuggs+BqBW8rtMORlIu6wilYOrYPHF937ycawMqMgn5WECZIYpOMDV52sgOeTE9zq0zHEaBE2YNwzVstZRCim5sxNTKPESIP2dagorW92Uzuin8AlGfNpmdwKZoweFpLIDaenk4ZQpRbbOq7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724560; c=relaxed/simple;
	bh=0ALC4f+FUtLfLsi77jJaMiFzGvxSB6bnGX0QNSk1q2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBiuifWJTATC+fpQh1vIERoxu+MrSxmIXKyqx50c4gv7ucr7J8jldZSZY6CVEFNbrVDDvXSsMcCVOK8SqoqLXt3WH6MVa8ljm5WfQz4/eP7D5Yvyu4xet/NW6F9roEeeNYo5GHONJR5RWnnmQEqZChQXl8ZZqO60bpqoeyWEPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPw0FIew; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPw0FIew"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39647184c73so1590392a91.1
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724557; x=1788329357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzKZqx2IOBeBbfLlz+13hpGVsFFBqwuqEwFlJeM2Bdk=;
        b=lPw0FIewy7kfM8jW2qxZidroFNA/GMPuMW+dmC+wACBUTUFUF87C9ebJs2snMFKnSB
         uIVLKK/cNIx1nSuCWCIH69Zd+w8m1Up1H5fw9Rn7Et5Xl4llA0nBaNX+70kKSwi/HeWs
         m9cfQO6xw13bHvN8hpWqI+VOK9mapgqulnANs+Ybp3TYmxBc1ntFCFkcGiJluCAXic02
         Cnjd52LwnbTYfgLSC/ssFkSwqCo+3tLkJsL60t3Ziwja53QvIH2MYgWMWx3cuGE1XrAl
         /V5qpTTmry2BbWBcmHT5xpbRrFrBdygT+1gKy/cSUipOSUtGnPFK/kAOZtEeRJmOITqE
         7HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724557; x=1788329357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IzKZqx2IOBeBbfLlz+13hpGVsFFBqwuqEwFlJeM2Bdk=;
        b=Y9Zt61XlLMA4AZbcIjhtJhTsCEomcgcNe36BuKR5JmBOKAjhnWtlwh6X4PiGdOKzOP
         2AGKUe4lRWNbNoiNGbPcLiG3k0HWA+y21qgMbIIeGDB1dNcW+e6rERfItdF+cS0ZPNp+
         hKphqhimZYBtKdDQ83lzJPsxBLya28MAHq3Aeqic32ChN1xstfaVLEAjxa0mZ9HYPVag
         ZNZ+K+LUxxhk2dVU44VXoEBKqoXDS1WB4PzTNDC7wydFnNqHrwzCw4tdeSJZjfkMPCGX
         6RFQ/z/lPdJwTeHnOPk1139Ke2mqrc4yDNQbpmGTzEQaDwTJRqTm4OInUqFtu76Gt/XF
         VlSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHtBTGGvB3CBbgH8A1+PAu+jfHVe0ZdBLvSwy49E3jLag2uscymF/cwOh47m+3AebQe4e0Y1NM3PvUys6jMA==@vger.kernel.org
X-Gm-Message-State: AFuF++m3dwpgln5tSppG4vBjZ4rzHuWllZj9/zRyn9KPJEfa261aSp1+
	ZRw6mAsAepvGh97fPUDvtZdLqhQQ9gqxteVQ/T6JoHTfG+B8556aR8c=
X-Gm-Gg: AR+sD13dACb8DsjRecBmajcj0vydqK79jSnsi9GzoTCSh/1cPRHY+ph2bXUEwO/mMFy
	3DTi5xT4dhB62Vgh3duFrguS2i3maJpJeRWwkKcxuM+F4m4KUmcVjTBqTRYkdFBvucZOVDJlka3
	42wkr/oujfNK/zizGOjXsEI3ljRCtb8Pni1SMKBT9OWJhm0SPEkQv3hTF81eGuOEYgJMBhLrglv
	tCbf0hQs6gDypM5MbTjAsc2eCYyGs/mnrX0kZoySSjMZajmK5ilcNp+pHuHI2YhqKzZz4t+PEJs
	QMVvbQ2EBLemmt7SGZPfX5Qr8IumrrhFOWKogL4kV83yRFkQpR9YqE+kTOd/RTYUq1qtA07ipX6
	fY4SIYu6or9gANBhlCJCLzb9k3iazLfmdqMYQSbMea5I6zcN/CdmV4QrN5T5V+Y67I0CtgvC9kT
	jI/5mw3D2GnFLWv0OSmJgXju857OCUw5XZ7Q/1UWOnFv1VZG9777dTqrlZ0bqiwq4ZncQb78rwl
	w==
X-Received: by 2002:a17:90b:268b:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3966d003f46mr5328430a91.0.1787724557507;
        Tue, 25 Aug 2026 23:09:17 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:17 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 6/8] watchdog: pm8916_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:37 +0700
Message-ID: <20260826060839.203297-7-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/pm8916_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
index 007ed139ab96..a7ae57fb2453 100644
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
 
@@ -253,7 +253,7 @@ static int __maybe_unused pm8916_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(pm8916_wdt_pm_ops, pm8916_wdt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(pm8916_wdt_pm_ops, pm8916_wdt_suspend,
 			 pm8916_wdt_resume);
 
 static const struct of_device_id pm8916_wdt_id_table[] = {
@@ -267,7 +267,7 @@ static struct platform_driver pm8916_wdt_driver = {
 	.driver = {
 		.name = "pm8916-wdt",
 		.of_match_table = pm8916_wdt_id_table,
-		.pm = &pm8916_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&pm8916_wdt_pm_ops),
 	},
 };
 module_platform_driver(pm8916_wdt_driver);
-- 
2.53.0

