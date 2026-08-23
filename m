Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52467E0FF
	for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484167; cv=none; b=uxynyFu4qr3DgRz3B0gQPtnXxUAR5w7Y/XSN/UCQsoh5qkd2nKdAWaHens7PEA39hByrdWcC9HkKyXqumq7pwaqq20uJbqX1sYSGb07f2zGeKk+5ygej1Y8FVF3vzj8g4Rwvcb03ir7coOz/XhK5VHESrmNtI44G//FDy/6ENA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484167; c=relaxed/simple;
	bh=GomAz875jLQKcwMOfTkFY21F9gXp50FWM5kTIsdpD3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jd94pRvi74CNESlqn7RxkKcxmGgAM/xqI8IVPGJoFv7E+HojNT0+ZoxfC3JtA8uGzcZW9dVSVAScyly5Rgj8OJFrYOdXgLoJgEq+O2yMR7KM3kOUiQuZEXYvucrTSlUIwuJyFGKQ8vWpbYVawzRdcaOuuc7U0raeyhHdRCDof+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLn1Iwxy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLn1Iwxy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso37367845ad.0
        for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787484165; x=1788088965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AxkhkxLQVPs1G87kY3GvmBQImMHj9C8bOIWENzdXhj4=;
        b=FLn1IwxyVj2+kjOHVLn2HOim+orp6qIvAeqCzN+CxNt20rlSMAoZSjFPSHUhMTjutn
         NWNUirOIQKNMLLSu89rtYjri9Ul94cI8l8J4ZB/2kUdvfnhm9IoBCL/kt+BlbifYUc03
         +ELMDPXfkkrKtfPL63T4dttPAJXBXat7ptX6ObNY90ETI49XS7vjwv99bUNfotDkOVkO
         wPaByweFL3y/HDOzUqO1rDhTsOJK1fvtoNIZ2k4hdAw9LUrzFXd1uxKOeld1/2QiRm/g
         XAHtElIfa3zBQsfNdopxPnPZA0LLGHukuP4yAR09f8DoqHxyhtZM+cfgK4g6wjxrHo+S
         b6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787484165; x=1788088965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AxkhkxLQVPs1G87kY3GvmBQImMHj9C8bOIWENzdXhj4=;
        b=Exm0sfmEGX7hAstaAutCINhkaS3u/e33Us+Xsp/s1+MkRq36LixaXCQVk5dx0la7sY
         8BoyMTVO6/vC3fdbKOFoEsdhohMXLxPt+hJh9MtGL7Tt/kdRhkem4Znh3gDUH3pBu0mm
         CF2beRX2sBJhJl6U3t+aHg1ojMj5U9ixqT7uQdcMrmArNWJXNwUEPC2Uki+oxJsE7rv6
         mK6RsWzIamuRQ6zHgknqKPQFW9FA7rk6HAClKplPnh4cltIWD3uiX+luhIiZR/0XpQ7X
         QZgqOkmjR9/cn2RVOQTOGWsRFimGmG6xJzQhPizKz8RuCDlYQUKVZZfaqWh37PnuOeXv
         e+KQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFRaX26SJ30qbsve95/Uc8CJsKlrB1G0p8gkFPMu7wyXRDVeiRjPDIC73pHTT7g9LNobgI9K7bWExjscZtMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ndJLvrmRLQOUMuNmqEDF1Tgov0lDEZYUHilFctexGwZ6eqZvk2
	xCKlXtauOLSyijPabY8YStVFDs+ZQe2u+wRo81pgLMJj+jFGvcpDeo9wybF1cwcn
X-Gm-Gg: AR+sD12FSGVU0qAVXt//jf+y2xJuM73g7nmQYYS0tKiYTsq7huSWoBKmSHE8yslwRyq
	gahUFxp/ntiIoy9z8uIWp93bHZEMODDi2AtZxs2hjOomvhQrG8y2PLS3pNT+wlouJ9mOJve34OD
	tljEMN+5cLBZJjNsbUnoj6GUPu18MHDBSDj5IyyAhjZ4hR7FLBMv9SLTufBN0v4/1Sw7H1ae6HA
	k+NL/k+y9Sp4Exg9CA5RZdUK6Lp+0ZAXM9+iY8V8mdxtV9AdwWvLr+SLKk8lq8UP6yBWXWNmpA9
	MnzPwrddEk2ozAA/ylRb7uUzzZNGdbLIHmCd06/MS/lzEJPgs8tVlOncbXntddV6epDpKbcLDMS
	adg2dc7JIBWR0EqoDO/TSs4rKeOjga0K0bjjpalXS3ardyNLbVgH02YGm4+l921PLMjo4CL39G3
	QCVZuyIev2xgq89AGk78gch7G+wGaJSeNVXa8eZWem/A6cdnBuuF9NP8rr9YrhuPE+mYSLQMgR4
	Bn4s+NWWxb2mSqxA4FTiJRaF4oetk4V9FS5OII/Oc9RDLE2rh4yWv8VwERnVCa3TpqIUq6DbskA
X-Received: by 2002:a17:903:1aac:b0:2cf:af20:4254 with SMTP id d9443c01a7336-2d61a15e594mr320661155ad.10.1787484165196;
        Sun, 23 Aug 2026 04:22:45 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:a5e3:6c88:cdf4:5469:310])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923f2c0sm22763109eec.30.2026.08.23.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:22:43 -0700 (PDT)
From: manushprajwal <manushprajwal555@gmail.com>
To: xingyu.wu@starfivetech.com,
	ziv.xu@starfivetech.com
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: starfive: fix runtime PM usage counter leak in pm_start
Date: Sun, 23 Aug 2026 16:52:25 +0530
Message-ID: <20260823112225.1107-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfive_wdt_pm_start() calls pm_runtime_get_sync() and returns its
error code directly on failure. Per Documentation/power/runtime_pm.rst,
pm_runtime_get_sync() does not drop the usage counter on error, so the
caller is expected to release the reference itself. The early return
here skips that, leaking a runtime PM usage count on wdd->parent on
every failed resume, which prevents the device from being suspended
correctly afterwards.

Fix it by calling pm_runtime_put_noidle() before returning, mirroring
the same balance the counterpart starfive_wdt_pm_stop() already
maintains with pm_runtime_put_sync().

Signed-off-by: manushprajwal <manushprajwal555@gmail.com>
---
 drivers/watchdog/starfive-wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index af55adc4a..ecb704b2e 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -373,8 +373,10 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
 	int ret = pm_runtime_get_sync(wdd->parent);
 
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(wdd->parent);
 		return ret;
+	}
 
 	return starfive_wdt_start(wdt);
 }
-- 
2.46.2.windows.1

