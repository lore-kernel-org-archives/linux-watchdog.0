Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695774908A6
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404655; cv=none; b=dO7qUer1IMFJyiFTdLHQIV2FqrpO/SiDRpA//7EspjJoUEQ38Q9uUeTAClHrMH2eh6aKpXh4UoCgHAl2gY1mIUW+TqIUNmuJGLi/BEM/G7Vs08pyLX+aMWmJpsAFUoUvO/e0yA5X4Z2Zt+VMJcv2qQnt9Lxrds94DPqbd+3lJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404655; c=relaxed/simple;
	bh=NgiDLzNvPxgzCJGn7AD4Tdxqijq1CnNJtk2CT/wXjbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERTKv+l4hm5Hk9JevoAHDT+WI5hGzUaaIEJxZhxbHtfAV5jaE8OW+PVBDef4UwUBDQZZFvo3a/X+fnLULOCClHk7REipRcHwxBqfK7v/WeS2rPgYvG+9b2zxfOw/qogRIfV0h7mRN3S8rC6Y2e2SviOApXZW/wF+1yeoHSUHdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grZ0I5UH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grZ0I5UH"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2334565a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789404653; x=1790009453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWgw8e/ZbiIFBfDj3eDifximzU2Ze39xiIPr56fiqbQ=;
        b=grZ0I5UHq9fVMkcCbdmXKiYsB7ftEgu6URbpkA/UdmwGbBKcbkmaa7Yetz8NgxM6Gv
         0QTc3gjkVGZQJS/KrjO9Um6uaRnnq1VjMf3X9W53JaIAibjQSBxaKY8Io7h4/jVZ9hPO
         N+tvwqja2fliSoESuQ7CbL6O6gSloIhLYGGfe2vXhr5qQcxFoPlaJ4z6TynGIlJZEGJ8
         jff3Em/0heq3Ry+ItiStZQTP5OKqNBD+sroQBQTVtYz9Jg9J3sWjzdZ8g+7Jk+8uQV6U
         k9UwfD+oG8qE2m30Zo1JQOstToSgQaLe3r8AysMi0ojSX/zBFVwPUOZcqAQkwM/yvXzK
         2s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789404653; x=1790009453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWgw8e/ZbiIFBfDj3eDifximzU2Ze39xiIPr56fiqbQ=;
        b=k2rsMSEA9COFqN4TqBAjOqEgjLACf2o/UPJeDw0iPUyysO8o8extVz8EAWTPLq+Q8L
         c8WqL1KMsaijA2J2O0g6/XKlxr0APFFa7zy9f4O8FgANgQe8tjkh1t69O+ra8ZnljY6F
         uppF6aj4OhgXENZbCwzYprGoHAz4giDMy1NVzCH57Gsf+d/OBnukrxFSzlANGsVCIBjH
         wt1AFKoW5I9VhVI9zGQF6Qfrtyd1OEpkznYdCcUNVpRd76fIWcBR3Syf8SnGPv1Dx/Xp
         km5ntQMp/duegG/fZoTjHU2PAG05UlR1KMmQeHjgvdo/w0qz0VdAfGFzYibZqq71xyIq
         sVhQ==
X-Gm-Message-State: AFuF++kbS0nGWWM4C31ssJo/S4IRGQVsteC7f55dSNoHxsZPz2k6VL+f
	VS9uiOhk1zuF8RHed17xhmLNDXp4FHZ7LfUs2hou8tpSu18El1TmmoGhkZiTkg==
X-Gm-Gg: AYBFou3F8XE1HpUhLh541ian2VS72arKqxJ/UriNyqAGJQRASm+DIsmPIwikNOxS+sG
	OMFq5UbUPsh4VCPqHhJGhYbRyBIA7Od0h8uE8Ha0JC4C9r+Ts7Hok1fiINnhxucKBAJlO6tFOYE
	l9aqll1kUZxVDtgfTpLKzQ2kXY/eHUEe6+iCREOJ+BqI93hU8fQb6DQ3s0I1uQ1ef2htVU0DRY7
	oeu/REFmBoBHtWn4ntC+RMERqrGVmj8scDgq8vNt/h2wA2Y8yauhjtet+p2i5V+7QtT3OS9DNC0
	vCP6/+QcBudv2A8ArV7I1hD6Ol/DAYs4QwUdlcjB2KdtKs1oT69Zm8DrSnVrt3e8Ddqevk5CAfc
	1S0VADi7eH/d0F93QtsQvLshYpu/VyNvMr2YuEFm3QXa+nUct1l2kimhy357gcJcoubGzsiWbQz
	kkEegeCPHApm5UcjSxfaugt14wAlcj58P8vl8eVpySS8YsMlqrB/RyZqfbpYzGMHSg
X-Received: by 2002:a17:90b:39cc:b0:398:c150:e7b3 with SMTP id 98e67ed59e1d1-39debf54a04mr7903953a91.4.1789404652772;
        Mon, 14 Sep 2026 09:50:52 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::c570])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfba020d1sm507114a91.2.2026.09.14.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:50:51 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: xingyu.wu@starfivetech.com,
	ziv.xu@starfivetech.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] watchdog: starfive-wdt: fix PM reference leak in probe error path
Date: Mon, 14 Sep 2026 10:50:22 -0600
Message-ID: <20260914165022.169877-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_resume_and_get() increments the runtime PM usage counter
on success. If a later step in probe() fails (reset_init, clock rate
check, watchdog_start, or watchdog_register_device), control reaches
err_exit, which calls pm_runtime_disable() but never puts the
reference, leaking the PM usage count.

Add a pm_runtime_put_sync() call in err_exit, gated on
pm_runtime_enabled(), to balance the earlier get.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/watchdog/starfive-wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index af55adc4a3c6..f87f8d5a3dab 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -510,6 +510,8 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 err_exit:
 	starfive_wdt_disable_clock(wdt);
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
-- 
2.55.0

