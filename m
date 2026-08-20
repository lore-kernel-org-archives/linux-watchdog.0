Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3953B71B0
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230416; cv=none; b=bopm499jd/ilumoL3Mw86gMLM1AMx5i6nYF7Km7g2E1KfOvwWXUpRTnngWfiuauNiV7f6SkyZHjwki5CofIEIPBDfgh3IJz5A9ABubO+8d5tSB8JIbqQ6OMDODuwkpBoNlhX5ewjBx4vwqpJeiFYOoRtQttjhzK2/WQ+Mx7lrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230416; c=relaxed/simple;
	bh=i7Ex07U774I7DiGt853siXDDQTXqZ4dPZOAGQE3rog0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBMtdET/9Of7ph3rkPdevKEweNeMgxISnBfTpq8jcKPZoQZGV6cVkALSyxheNnNdeEQ9XlozyrvtMAhWV+veLDmMEUusNpteamcap8kZivIaQa6nR7Q2EtbjQWyP7IvRY8G/SGLeEOvqUinYUC5fiRllTk9QQLiKIWkXbTx4d2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za; spf=none smtp.mailfrom=ffroot.co.za; dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b=cthLIAbF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b="cthLIAbF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso18781855e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20251104.gappssmtp.com; s=20251104; t=1787230412; x=1787835212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qv+EG7MngiG1wf6ZlDGOACwuZ6/qljnKXWIF+vWzmyE=;
        b=cthLIAbFPKH+En2uaF5BMFdx/u7l1VmKUCRqGioDpcw3++0qa7L4FWauhCR2JVuFPt
         701eLlg2JemrviU7riKOa6XedEEjwlfy1cE/4Bdxm2W+w1lsjNP/P8okbf0S4YDYqc5J
         310Y+eI/HDlL28H6jQYrgW7BQ3i+HtZqv0QC0qnIuGhIpYw0Da6Lw0QqQ9HloY1w21pE
         pYLvAaTIoTM6QTsuy3+iU5hKupsXmqEfp2eSB5+WPVQ/QHlEfXlBrjtn+8TF/XYeFpUe
         Mf0pqztYvpP1sVLSiJWchcrKhxfWX99bkuThnZeUDmBJVqf57xZ5v29hAqBK21BmES7E
         SYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230412; x=1787835212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qv+EG7MngiG1wf6ZlDGOACwuZ6/qljnKXWIF+vWzmyE=;
        b=ImGW31CJnFWh+bKpmCNglfr/wHZZVqmbUDNq/ywWbyd3U+Trko4zhG5dCImZaineHB
         CJLVY3PCgkoLEFBAhLshFf36SZM7TEF+olWDMnCIBwbzhzRGOiwgvPZA5WTPlmWjrPIq
         UC7aGzkcx5eiXp4NeRbAqaR3M6rAprYxEKaGDdexceL8XlGFsBWW3585XJY9sCJWTsts
         c/In9C5SIblrn8Ps33EFaBkb0UOsGwEsetatuNj4gRaDj2m5Vy+1Kk5CPlmXa2nxemF4
         bhrQq6g6jiUIREnKCcpP9KOn/QtRPdlJN2E3nczNUz4ENC+1PNoerfuCzPQ7S7cnitw2
         XXBg==
X-Gm-Message-State: AOJu0Yx0Lt2ckU8rqB3ecCAElDb953JtLE/rxC8PvL/WgxLDd4YjDZNc
	Pubu/HF7/hol21zsFr07udHYFyOzgRfKbaOPGm3LmPCpZDer5v0Uz13Zypnx+98WbVOtlZDjWQo
	bFEYTcXU=
X-Gm-Gg: AR+sD11NrW10adPtRk7vgbSk2S6iSssbK9VONJwxW8TMWfsNevIyEjb1ISnGsuWU3CL
	lS74XMTNBJ91qgokpfLzJW/V5+I+64VLtpyGy2WCuJ17Rxzp09YkuSAI0O0UZ5YTgHcavO3svly
	DnHn5Q7e9n1Vq1siaqcgCdAPL2/Ic2R+0HNIXUHKBrJwb0qjbkXr17EcsU5cLOhNF2MOSXipdCA
	lrfnTXNRBa1ZJjolIKXcMJyjIP+k5VmDPPcOrqABN57GitBUhXqRnTKT6LhptIsLKc/bUe+oxib
	Bh1UKGag8et4KrfAOgNxvWF/Hw6sNPzLBvhxRY5V2oVwhPNPSOQ0T75Kjstvr4dBD7PCiZaRyCV
	Sw6Dwd1TW1UmoGlB1zFqJAngf3vVZGo293XudDmaWitYg69qIUk3EDUYy4+gnGY8GjwP8CsX+ey
	ZQCrx3usOYlqc5RW3vd6FjahyU1qLkINy8KHY2KLuENajTrlnihi0hQ8S6fmoMjfyrzbsNRzH78
	EENjZHr1IPOiTw6QDlXzRUR
X-Received: by 2002:a05:600c:528d:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-499aa17d6a0mr239192205e9.6.1787230411698;
        Thu, 20 Aug 2026 05:53:31 -0700 (PDT)
Received: from dev-ag.figment.co.za ([102.33.165.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1755b2sm143998605e9.11.2026.08.20.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:53:30 -0700 (PDT)
From: Andrew Gaylard <ag@ffroot.co.za>
To: linux-watchdog@vger.kernel.org
Cc: xt.hu@cqplus1.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-arm-kernel@lists.infradead.org,
	Andrew Gaylard <ag@ffroot.co.za>
Subject: [PATCH] watchdog: sunplus: fix sp_wdt_restart spin loop and timeout
Date: Thu, 20 Aug 2026 14:53:04 +0200
Message-ID: <20260820125304.1583383-1-ag@ffroot.co.za>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sp_wdt_restart() returns immediately after writing WDT_RESUME. The
kernel continues executing and the watchdog kthread could pet the
watchdog before the short timeout expired, preventing reset.

Add a spin loop so no other CPU can pet the watchdog while waiting for
the reset. Set the restart timeout to ~1.5s.

Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>
---
 drivers/watchdog/sunplus_wdt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sunplus_wdt.c b/drivers/watchdog/sunplus_wdt.c
index e5212f3d2e24..b44dcc307634 100644
--- a/drivers/watchdog/sunplus_wdt.c
+++ b/drivers/watchdog/sunplus_wdt.c
@@ -61,10 +61,16 @@ static int sp_wdt_restart(struct watchdog_device *wdev,
 
 	writel(WDT_STOP, base + WDT_CTRL);
 	writel(WDT_UNLOCK, base + WDT_CTRL);
-	writel(0x0001, base + WDT_CNT);
+	writel(0x20F5, base + WDT_CNT);	/* ~1.5s at 90kHz */
 	writel(WDT_LOCK, base + WDT_CTRL);
 	writel(WDT_RESUME, base + WDT_CTRL);
 
+	/* Spin until the watchdog resets us. This prevents any other CPU
+	 * from petting the watchdog.
+	 */
+	while (1)
+		cpu_relax();
+
 	return 0;
 }
 
-- 
2.53.0

