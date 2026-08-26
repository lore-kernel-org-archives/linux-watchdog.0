Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4639478F
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724563; cv=none; b=VMgB/VRglrmeFJzoc5fjmxq42d36iMhNPckJjIjqOSi40SlpINoAuCj9fK4NU6vVaJPQKuMk2l7h7mwMgQiAUU88H6PvrFmr2DlnDrDMWPIj25IdGfTtCl8w2EsgilUBISFQixESg38+DKQS4hC1fQWXopWNNqpzuOihxvdnzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724563; c=relaxed/simple;
	bh=WPOwA+yac8hsqUsQDIxaT6/R9BuD+xFhnOv2RTozUH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MM5sa8xZm6D4wJaTlUFux1HuyOgjnuJHi7lk6DTRoTL7jVIApG2e/htrS1wVNir0GzDm2RB5Qr+5yn8YttvOk8d9NgSqs4CvSI/vV/PqHtU79u9EB62ranjgaYW+d9Q7w7W0qsV1YefQbTaFYBiruS3bHGAs4x/5BVuy2vUnYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9bMPJD+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9bMPJD+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so723403a91.2
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724560; x=1788329360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8U7+Z+YKwjHD3UMS4jalYyLwSQgyg6EGsaicv67Mxg=;
        b=h9bMPJD+S/ovgezMBZjtgVhJW4/IPNPq7lrb21Sr6G6P5aovbIX5welOik8lSuhHfo
         0iNlU8MMjgan+JcJ7djcmI6Jkp2YvSy7QBVs4ZoB3jSgp9B/U6nls/bwKc0eUC9PJiyZ
         i68rjxEY4yxukywlEbSoTLlyBK30IiuXa0ay4fMG9DBiwczcJqEAYEy20raTh1H19gbm
         92L/ts0me67rqZ41NqnjdXgu3TYvgUzoZ53vkuHPKaF0zXizRb/O7QAyV+QBVFQMlaHB
         /HFp5J+dcUwubvUM2L4LS1ppWrKfXedQ8V6qsFfWkjA2wc20C4S4Ck0GEC5e2Ufz1Uii
         aONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724560; x=1788329360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8U7+Z+YKwjHD3UMS4jalYyLwSQgyg6EGsaicv67Mxg=;
        b=T8lPmW4dpK0+NR/Xi3/V+q68Qu1z4TwB2Zyyvl0OjVadtMEqkRGBwGXXArrTF8UCty
         EHQPU8SmywthJNOzXrp6ZDYrdLKKilxhALYdO88sf6cPP/CoZaNx+mqw0SLqgpaD+Wkp
         jpCx410OUkDDMS8Vav0tNkZRF1BSdntM+WokrOYjmhgHqYBIwcg7x/Z/+iG60GIY4+5U
         zuqlEvfJWENVNDyZPYhS6vP6pxc6kZrsnY7mdRG5Ll/Vd010SsxiTwBP3GQl+6eb7kOW
         P7ZqS3sKE3A6xm5VYEODKmkAi+7NsC7Vsdqi1ZIF/cz6edMR8j6OfEEAL+BjNaviJHtx
         +ZGA==
X-Forwarded-Encrypted: i=1; AHgh+RpkoMsO3tew86TimEUW944TGJtPsS0MD/gzBaHES5jeyA/a9UjTHCRnulJNVUdDLkouar2FdDsTrKKehdH5Tg==@vger.kernel.org
X-Gm-Message-State: AFuF++lcvXjN2kftE/k7+BSDZax6I3BxgG1UFUcryxD6W0JYhtzzy6EV
	bQLZ2pwLrhdh8/wnCz0SEnYxOPBhza3puvIM9BP7ugm0DmH3UmysKvo=
X-Gm-Gg: AR+sD10bJE2emdQkm+hM4jjqfc9Xfvk4iAUBTfsxH93r0sqGmO4+VspvNOUVq8cfbrb
	sHdGUO4dn+tVgX0EG8H7zIRC24i5SqOUejNQKZVwf58RXn2EdYeiaXVeXw8BmfoGYm1rg8aB+6a
	N6vcDBUVgN548xuhsSEum5XIv0GhxkRlzTiBczRgPr0DhuUyKpexfz2V3m56Ag6Q9BDf9pFSciQ
	qeIApkmyEMvQPnBIyz4eKRiomD8Fiy+863/ha2X5Fa3OHWTcuKM2Wl97loexo62ONNtUDdlm7sd
	Pp6zf0yssrkPjQljkzZ5MbBkxqpiGQmMBps3MraoRMoIEfJS8UR2StlVD0e8WaRQWetfV5MQ0XG
	q9/Q8b7QJvHAyYl/KDssK4TJhSgLIloKsyFAft5aj9+XdRw8WRK2GYtKFx00iKNuVP/MgyUUGK5
	gnDMaso0ecyvk8m28GGAv+RxgbPOAKdiHFrVY8tgxzxpCncy7IoLE5VdHLiLvg90Lk+T89XzPNM
	A==
X-Received: by 2002:a17:90b:4b04:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3966d5f900dmr9197383a91.8.1787724559761;
        Tue, 25 Aug 2026 23:09:19 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:19 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 7/8] watchdog: sp805_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:38 +0700
Message-ID: <20260826060839.203297-8-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/sp805_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index c2125f204a13..7b01011a5bc8 100644
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
 
@@ -341,7 +341,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
 		sp805_wdt_resume);
 
 static const struct amba_id sp805_wdt_ids[] = {
@@ -361,7 +361,7 @@ MODULE_DEVICE_TABLE(amba, sp805_wdt_ids);
 static struct amba_driver sp805_wdt_driver = {
 	.drv = {
 		.name	= MODULE_NAME,
-		.pm	= &sp805_wdt_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&sp805_wdt_dev_pm_ops),
 	},
 	.id_table	= sp805_wdt_ids,
 	.probe		= sp805_wdt_probe,
-- 
2.53.0

