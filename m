Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C8357CFB
	for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492375; cv=none; b=apQB2go8Cp+TetPjHwklfQbLQCxMTLuB8pkUhT6o8jGLJOJp3lRgVSVQOUDzL21u+X5qbLWsQxesmZEW5hvM0QH4msnj1ACxHixx/zs0IDFoso3ChTQqo3aeprnTtqAPl9AVZ4kz68BusgNIS/Quh2wowYxSa0zSTD4Bzdja1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492375; c=relaxed/simple;
	bh=b7hZEdF9gGm5SUGjirtVoYQHtnJkko9xW3itleM/3Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNLSYOeQ5Ws3ill/xdrHczU54N6BBf6cmhZWt9Zq/L+kQsaZ+P9Ks6MljKvH5asB1NUbaRRZzKygXMfjmHyGjiw7fP2rKezvGFf6r0L6YfRFgJ/oMAbgX1UxyNjWRZWIn4Oo+bqrLbyVeGiRPSOmvX0jkUtPLu6vYnkX4Ke/K+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqIaYwU/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqIaYwU/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso6452535b3a.2
        for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779492373; x=1780097173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLbBePjPrv6qNDD1/f9ZKyQ/SjpAXnBSe6vKkphP87A=;
        b=UqIaYwU/51to5YEh47UZaBQSog9Ai48mz2p3t1ZUl0mJlbYJvBdgD5MZX8oVpjV0Vv
         tPEryylaK5IMhKfuJ8KIzGtB2Wjxm6DNSMVhMe25CD0aZsDbDYsp4zV6ZzdtwWxbPlv5
         eYp4Og2PN5KfIK1aJIHoH5xOkS8Vyhyj6fyLOTrA4LM9hItS8dL3aVwkhq2S6Nl8rO8l
         hpePgAKpvzxDyvIOSF/ypamN1PV+AzZPMBiI0Ni+Kd31WOfafL/EqnAvU0jCYYwX5TK8
         LZgBnNXikkcBJE2mQJIlN2LKmbSgeIRH/ROfD/iHcZGUcwvd6oV8+0+/FyF6c8EmB6yR
         d4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492373; x=1780097173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLbBePjPrv6qNDD1/f9ZKyQ/SjpAXnBSe6vKkphP87A=;
        b=WGBDwUD2uidmQvYQbsNmhtrkE0+niERivhQ1X6wjiMJMt9cyCmM9mWBc8VSfEKMBuu
         74kZbCq1QzIBQFkGkZRW8AewQVYqVRJBTFKNhljD8h/T4ha+u/aVXXs5d4sxamYXwitV
         G+EC5Cqov9O6jL3I7NHMgIPydw/5T1r3A0WA7WwVwhJOcQI3ef8Yet9MMzGuByF8oRfi
         z/MQt9QR9smWh1ZdnCPPEERviiQUnTu0Hv1NZ7fGt+7ITqweeCRdeo2O8ZlChzu9c5nR
         9jZrdFgeE8/DRJZWE7QukxtXiGyi9vfOPe8QiA6udXhG9YZxzGFkEypJQcRbbjw5xgCA
         fvCw==
X-Gm-Message-State: AOJu0Yyve0jzBSY7NZXsfvmggBgZhFEv3AcdQFQKk9nYVe6FdfbHLuVe
	mIhRijf5regVbNY9zlS/00yGE8Tq4gVpLUoYdwBa/jAvNDnILNLxXz9FSp9IRg==
X-Gm-Gg: Acq92OHbkE8fM+4Ly2PFNhuI9qKk4+XI8rayCpRhslxu53Y5vub/BvInzVNDbW35WLx
	qhPqgOp54ZyvZ76d6Tbh+m/trL5Zo7ysTBv0NFRoLilKRMTNNpaB+7Jq6E2V1zEfueJDw24+CCn
	ZfnZgeS757KDfq7/fm6bVgdtlEh6/bL2KzSgegs0BBW7CMtTfe0CVyvpxUMHY9+/rcFqjsznPtZ
	p4QI6eIlZakqFwU6RjUEVTTHJmjdbyj3+eUHG9ZMY7skUYgKOcmtDb/xs0DXX2UqUR4xwnRfOuu
	k69meDTzsG4wiocj89JaHjZUlAm8eLTwQ7p5/3BMAm9E4v2MDmu5ozxy6mevQ+5NeRF5jMErL/c
	dnAADAvbqvzf1spZKdxG67u0YBHEoswoEigdhf9nyrWd620BAVvDCF2GORofTiN98KMF04dRGOH
	uhOaXKAraJcgDS+1lrgjdVGySQSIo6klTI9Huhx3GiNQe7RwYSi9ByyPxRvzZjdumC+K49PTGtW
	dVp5MpLqskGDCTSrUpLSrkvmCNyZCv1vG4=
X-Received: by 2002:a05:6a00:138b:b0:83f:9c6:9c with SMTP id d2e1a72fcca58-8415f11f645mr6008369b3a.10.1779492372844;
        Fri, 22 May 2026 16:26:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm2898323b3a.4.2026.05.22.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:26:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] watchdog: ath79_wdt: select OF and COMPILE_TEST
Date: Fri, 22 May 2026 16:25:52 -0700
Message-ID: <20260522232553.44748-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522232553.44748-1-rosenp@gmail.com>
References: <20260522232553.44748-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has always been an OF driver. Select OF in Kconfig.

Add COMPILE_TEST for all platforms, not just ARM.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/Kconfig     | 3 ++-
 drivers/watchdog/ath79_wdt.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..8319c503319a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1785,7 +1785,8 @@ config M54xx_WATCHDOG
 
 config ATH79_WDT
 	tristate "Atheros AR71XX/AR724X/AR913X hardware watchdog"
-	depends on ATH79 || (ARM && COMPILE_TEST)
+	depends on ATH79 || COMPILE_TEST
+	depends on OF
 	help
 	  Hardware driver for the built-in watchdog timer on the Atheros
 	  AR71XX/AR724X/AR913X SoCs.
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 7df703e9852a..409a40b14901 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -295,13 +295,11 @@ static void ath79_wdt_shutdown(struct platform_device *pdev)
 	ath79_wdt_disable();
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id ath79_wdt_match[] = {
 	{ .compatible = "qca,ar7130-wdt" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ath79_wdt_match);
-#endif
 
 static struct platform_driver ath79_wdt_driver = {
 	.probe		= ath79_wdt_probe,
@@ -309,7 +307,7 @@ static struct platform_driver ath79_wdt_driver = {
 	.shutdown	= ath79_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(ath79_wdt_match),
+		.of_match_table = ath79_wdt_match,
 	},
 };
 
-- 
2.54.0

