Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033072;
	b=iD+9sJ775nZld+LKsDWvyH0alimFIXsljw5qWwcIwNIOonAOL0pnNq5E5PSRDBZP3dqJ
	 v0RedElv89KRpIY9nia3SBNF0rT7xZ/S1A8KFzdoRq7Lt0JnJeLUl1RGWYUqh+UadatTF
	 7rlN1ZLluJPpRMQSPtoUyTtqVMVk2P55FQpVT5UbgTZDLJG8lfqnXDvA5311UOYtyw2bl
	 VA5SgUJ0x3x7eBC90lDrkYkcuYHcEl5dkQhUU1UUcCjLXtRuVFDiWpxSnILAFJJm+neVA
	 lZeOcyjVm5yplTnaeaY9hsBGmw1dpaiTckuxRl03NVHzkFusSQU/SnMJEbb59P57rAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OcclpOoyR9VbzHL5lXvcmBGzh1lq20n1nrPwq5+OX9o=;
	b=lDXYAeFQnYj+s553ebZUW4dNKvD9w5CDtPt8Z9EkEvZmm6r/jttrwd5NcFQykXRlGeq4
	 zyIysIxr+YKQU5yxBmRFP7lzzVHoanjjHSKhW9V6jeOp82jMoFfIkJ52Ev77fuh+CQCEj
	 ZS6dgRuWmBJhHFv58iFI8XS3DlZHgeZk5jiwjncxiYS4+TCb4yXTLYEfRbgYbBVtqQgVX
	 G3nu5ezBQiM0sD5ShG1AhVTlmuSku7aRl5zSvOso9qARGBNFMsfmLzB/WlalFGEv1BLgm
	 At2kyEi+EBG3EtLrrH8tkkOY6W6zCimzdMp7oVFK5zCH2+PczeBv4HRsMnzDA6iHzFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZYI+R8wK;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBE606A32C
	for <linux-watchdog@vger.kernel.org>; Sat,  7 Nov 2026 06:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EFBE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZYI+R8wK
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36ff9c9da34so1778682eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Nov 2026 22:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033071; x=1794637871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcclpOoyR9VbzHL5lXvcmBGzh1lq20n1nrPwq5+OX9o=;
        b=ZYI+R8wK5I1Y3OH9QuK415gbEyaFx5Z8BY5+x5BSZeL82bX19jJR6vtzgwmKF2xc4/
         OuIeOmziZ3r8oVwuSdsCzXiI3CXVW8jfWU0lHT1fxEfjKWSwxp8f2kBqDjTu+l5FnL2Q
         kq5t2A/BWCGD3/h8qJZCuqbtiZ8kFUK3x6f15VqRVK0JoPCLzZOL4NIlrCNVCqBaE8v5
         VyArRGf9EuyzLn2a+PinCdNbWy85Ul79UeUBe0Xh56TC4RXVoaqs92G77WfD4574mJYi
         8dpPydxCpgD/CigqjvIFn4j2HDvMwrZIUAEE75KyOBWrnfvvlOQDDJsQkYO8W2GGN8Tb
         zIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033071; x=1794637871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcclpOoyR9VbzHL5lXvcmBGzh1lq20n1nrPwq5+OX9o=;
        b=VUYebpGMkrIDG449PTEsHGhkldEpLWSOBzYCFXcGsr72h0NEtV3GCo6BawsRgoNNk5
         WeF775axRbDsOJVNf+16X2o20E9Z4uRVcQ8ZHopPFy3EVxHxo65yjnY0Lr38PPsSgQkZ
         JLcwNj4RQfVoY34V00hZv5NOylB2A8qiQQx/p7/slizG5tOAaLpMQ1yCXgBXrrcs53uf
         41mc2sg5LuUPDQFC+kEWoDfOKxn0wH5pgjxNzUK8FRaIl9EsIxz2jEE03z8TWZa6GaAO
         l6lykd0jGxkUgE9hdgrBXbjYnn3ryQJ3ltbUPQ+mY7kBTpwIqBUJ9XzY23QZD9FXheI2
         wSjQ==
X-Gm-Message-State: APuU4Z+8fdCOA9t4HJqLEy6LusuI9H4eStB6ayEIMQW7OJdc+RCNCL0j
	aeydvUkx+bTDwC+WbzqsQpS8WPiwvDuxo+YARquEjI0BBJ+pi7lbaYe7
X-Gm-Gg: AYBFou0IAejusdgSVRPnHjTADMyv1EMY5BLKT7ZA67l47cWbj9apkQUEH6CUOLT0UJ8
	0AHUWohbskC2ZdBMpaKQt3yUUosVRrTss1IMfaL+V8oq6+PtVlKOEqpdRLtcFd3aVSUVlzd6mHG
	pE1YpJ4NWT9ZiFY4WROs8p8oSxGp2GfwU5LaPvPqQRjf+7ua81f5AubjQvAA7RaexWVKsR15LXg
	5lH2ut/cb15P6IA3PX62g5hjvH4Ausx2NENeegucZoNn4rhuzY09iwS8Jm7BzTxt+FATVxe6h4f
	nPUHzsp2PHaABRb0uQO8Lfi88Uljig8STiveY5mK5yFL9jkw+3HGqJQy3W3OPDCvauLnuEL8GNU
	U6Q7E1fRLejEV8lIufbTXrDaSQ1iCICAd+3GUYnQxvABRUbo/mblRO3dg5yIFN3Y/cfoqymNrYN
	tJmGqw6B/2r+9TZrtYN6txRkMu0u1PckNkVVxpOJwrerbD33cDba7CglbTdschPf4+Hj9aHu8r5
	Db65R5y8IzW6Saxhc0DhIBM4j1k1fJ3LShodHtAL2YHAuqj+I4Kcim2WceHuhhObTYONXKDJ615
	oYUHOBxQEe+XsQ6mp9c+xZ1gbxo8CgzrE8psXyTQ61+Gk0JwW2jcwg==
X-Received: by 2002:a05:7301:fc0c:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36f75f25cecmr6718753eec.23.1794033070720;
        Fri, 06 Nov 2026 22:31:10 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([49.43.7.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm12405728eec.26.2026.11.06.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:31:10 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] watchdog: omap_wdt: use guard(mutex) to simplify locking
Date: Sat,  7 Nov 2026 06:31:50 +0000
Message-ID: <20261107063151.441-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock() and mutex_unlock() calls with the modern
guard(mutex) constructor from <linux/cleanup.h>.

In each function, the mutex is held across the entire function scope.
Using guard(mutex) eliminates manual unlock boilerplate and guarantees
that the lock is released upon function exit.

Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
 drivers/watchdog/omap_wdt.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 2a6de73e6f0b..956d9513a81c 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -27,6 +27,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -133,7 +134,7 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 	void __iomem *base = wdev->base;
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 
 	wdev->omap_wdt_users = true;
 
@@ -158,8 +159,6 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 	omap_wdt_reload(wdev); /* trigger loading of new timeout value */
 	omap_wdt_enable(wdev);
 
-	mutex_unlock(&wdev->lock);
-
 	return 0;
 }
 
@@ -167,11 +166,11 @@ static int omap_wdt_stop(struct watchdog_device *wdog)
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	omap_wdt_disable(wdev);
 	pm_runtime_put_sync(wdev->dev);
 	wdev->omap_wdt_users = false;
-	mutex_unlock(&wdev->lock);
+
 	return 0;
 }
 
@@ -179,9 +178,8 @@ static int omap_wdt_ping(struct watchdog_device *wdog)
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	omap_wdt_reload(wdev);
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
@@ -191,13 +189,12 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	omap_wdt_disable(wdev);
 	omap_wdt_set_timer(wdev, timeout);
 	omap_wdt_enable(wdev);
 	omap_wdt_reload(wdev);
 	wdog->timeout = timeout;
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
@@ -298,12 +295,11 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	if (wdev->omap_wdt_users) {
 		omap_wdt_disable(wdev);
 		pm_runtime_put_sync(wdev->dev);
 	}
-	mutex_unlock(&wdev->lock);
 }
 
 static void omap_wdt_remove(struct platform_device *pdev)
@@ -324,12 +320,11 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	if (wdev->omap_wdt_users) {
 		omap_wdt_disable(wdev);
 		pm_runtime_put_sync(wdev->dev);
 	}
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
@@ -338,13 +333,12 @@ static int omap_wdt_resume(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	mutex_lock(&wdev->lock);
+	guard(mutex)(&wdev->lock);
 	if (wdev->omap_wdt_users) {
 		pm_runtime_get_sync(wdev->dev);
 		omap_wdt_enable(wdev);
 		omap_wdt_reload(wdev);
 	}
-	mutex_unlock(&wdev->lock);
 
 	return 0;
 }
-- 
2.56.0.windows.4

