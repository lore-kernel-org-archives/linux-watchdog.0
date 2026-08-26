Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD65345729
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724553; cv=none; b=Empxq7IvRKKJHVG3lrPmOvZAAtul1ez5A5pZIcGpZLwE9S+EsUPZIaxk4Y3hscEigOw3n2tnMrnKyQLbOPGebP80x5ik79jPkLqeoyV9peFqVljjn7NxznCemlNkUQ8GWnN1ppUn7SDYZ8oK1gYsKD88mwn4wl22PiU0mW7vJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724553; c=relaxed/simple;
	bh=G22pS0+2rtdWLqTf6PQZCjkffsbgfYqpaMsRInZFPCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6Ys8fyL/vbZzEbGBfXfTUG0KSx3ufIYiRnVbksQuwAr9ly6JKtOJyigW8YR8HIDotn1ElevXHBTEdoYo1hdstLZm4OsiaIxGADFWB/0ic8yK/2ml2IsbiW0pqRAq7UagaeksoJ3rp0GJTXU/4sPuTB0DDl3Q/SALNW2sYG9enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfxVlbKw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfxVlbKw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3900e39d935so889482a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724551; x=1788329351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPn/3wb9oJDZdGnim67DGVmQKm2RQ4WiOKyK9w+6P8M=;
        b=QfxVlbKwAQKqhUWT2AkgcTFPvRoVUeWgVMuW8nt5APOR8KT+BI39aHylJ0SIwffNc7
         NijFIdF+ePB68iEmpazmE8o8KsFHsPAHlU2TynnkDhu6Ho5AVs9KrmkM675sXxc9pQK+
         q2f7mkyklbSDKemznkHAlEWAvT9dUSsiSmK7ilBhL4yo0VbVyClNZkMdkGXqBXB8diy7
         oZPwhvrx2U+x9CB+jO5JtHi8FiRzGwoWniSn5RPmn8JqE7XwEpGCZC2nKHFYf6gRy8UH
         ATAIQAzBXOKXjcT/Dc/kvjob7P6MNNWyJUtfYptSUBDTldl9g97pblu5zYG9ao4yK44i
         1ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724551; x=1788329351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yPn/3wb9oJDZdGnim67DGVmQKm2RQ4WiOKyK9w+6P8M=;
        b=YC/u6WlmyGY0KQJTvNSPkwyBjSJaJG6FGujw8+c5yY+eKYfbjAIt4NQoz4vfH9B5Df
         PFZGjaCsal9AA8wh9601zW7KKozoVrxsCCcr6qzrJKmEWFYQ9er7tTjRelGYcWHEEVhr
         EzAyf/3nfTfDZ9gisXuh7aXFA2S3tn/jukM0+oXYSrEEk8XPExzxPO5/oDTutrkFDCmC
         o6FM1FjINVpKjxwWp99HS1bzzyw8PK+V043X7d74kccSsZ4hQ+oZdU70zc+pSPkN/noW
         M8e/LR7v3SkKD5xic4Sv4Jn+Hm7Rf9tp+CgoBllvy+M30Ls0mwPIlA96lA/odokDK1U9
         8IfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHNmKIOO7H5QEUePNcadxfFGrB6y5L+C/tt4ikKfDd0guIOyLOf1KzdY6eoyibjmLJYeKaBvKGwS3nEnLzPA==@vger.kernel.org
X-Gm-Message-State: AFuF++kfsiPh/P5O3yPZVACB5b24Xr0r8SeY7Kxq6AKkQ3e2KCrOG/sa
	HpP0M485AVo82oZX0r7Z6tYImNZLddPEd6yNNP+OIUUwubWyDPkynH7uSZJCCLg=
X-Gm-Gg: AR+sD13VLHoT5kiZQmnbhWtXAZ9tKTAFj+nCLRP0EHhHa2WzSGuEZ3EBXjmq1sMWjf1
	+/oCXc7y4O9Bthzl3TjWTc/JqQ2EkVq9BfF4VPT+Kq51HTftYRa2j0ZJDsZ48iJfyaPDyJi2xNp
	ODnToz12WJYlAMCBQarmhG+xrekBQIE7ODsRCT+qHHtOXjd8HajZV3+8iUx1hUH+CRWVOVu6VJ6
	44HmoKQin/+US8li/5moqQPpSt6qIl6MH1SEWHP2QBaBtVI4w4f551Q09PU7+sFIe5geMeWrZzp
	aoOqvhRDUd3nkRiEbGZMVQRlC2/paFJFVMrKXrn8o3EjdV8r1cHOTcp4y8WVR55q91g9OCS5QLg
	6PIgg4KDvrUpvQAMqvXoeQ5oYZJSWvRrHSFqvGIW6g+MCHoTYekGjn8MY9p/fkgB/zJQfRJ7+jM
	RGs3hb2IT0U+Q7ufd2BhLv0XyzTOgWgXwBv/DBc5mIfCcdJOb3kerjkvvUTRmd6Sj/tpX7nPtq9
	Q==
X-Received: by 2002:a17:90b:4b8b:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-3966d3d9581mr9137264a91.6.1787724550854;
        Tue, 25 Aug 2026 23:09:10 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:10 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 3/8] watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:34 +0700
Message-ID: <20260826060839.203297-4-triet.hoang.dev@gmail.com>
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
 drivers/watchdog/keembay_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index 7c8e53921e40..20b9eb6a2727 100644
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
 
@@ -270,7 +270,7 @@ static int __maybe_unused keembay_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(keembay_wdt_pm_ops, keembay_wdt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(keembay_wdt_pm_ops, keembay_wdt_suspend,
 			 keembay_wdt_resume);
 
 static const struct of_device_id keembay_wdt_match[] = {
@@ -284,7 +284,7 @@ static struct platform_driver keembay_wdt_driver = {
 	.driver	= {
 		.name		= "keembay_wdt",
 		.of_match_table	= keembay_wdt_match,
-		.pm		= &keembay_wdt_pm_ops,
+		.pm		= pm_sleep_ptr(&keembay_wdt_pm_ops),
 	},
 };
 
-- 
2.53.0

