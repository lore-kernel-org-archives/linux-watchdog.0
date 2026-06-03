Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA63F1AA3
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459373; cv=none; b=PrkO2JYIVCkSI9zPWXhEA433Rp5SgD9ritaeurnQby6NJX43B45tQ2jRBpP0R2mNGe9dAQwuOYgAWPIHf+oDFHrEEfsxNyHRcklpGPD46RgsS1PjINIwcfLz2P8ml2Pck4NZUMc0O3Ls4YWzZGH/cOQjUgGAEgjFkFE6mQ/qzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459373; c=relaxed/simple;
	bh=bcKpYqoPUHWasQlX0WYVDXtFx97SHRuBB65S0PW+MR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyqk9m86/NtQBakVJ8CxqJm3EGu402NZAz5Kkaf7TpetCKglOTOKyUw6xspWFR37KE3w4+DtkgS/kQ+o/Y+UTMYIt9cHSzBI+pw3XTjJp49PyTAdMxfQ0c5pcD46K1dnU5kdH2w3g9p24ybzWugVEbMHaod3eFSsx+9Yl2+yKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQq/5i+N; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQq/5i+N"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9153e2708aeso454860485a.0
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jun 2026 21:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780459371; x=1781064171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl9G5VO4avXvABVHuyEo18kgYiDl/pIYaaxCZM8hBps=;
        b=HQq/5i+NVa9kJZMkoqvcWemF9iqcg6xfygiUpjVrXX4EJflqQ3v9yX8MIyO5WoqaAx
         7tI+sjkCbidYKtmAeNy5DjCFn+OYmA+m9kQAmTuNWg5IKDueVPbzIyklBFYuuzXC5dEu
         LVYYQfxmVs/5wadOvSceRpxj47x161sBeRL94Fe0QODeSwopEoDBiUyINDziv2HVS9Jj
         u0U33ca0OIPDCyZZATjMMxDvkbjlGfVk2G2Mv63KUD38rjXA+yZPJBs1jurLkO3EcGGK
         xsVBIBgWecJm5xonbxHJl0KaievfT6V/gbH7+1Exz8KD94jioGVplE7I3p2qXtIuLjBg
         bqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780459371; x=1781064171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wl9G5VO4avXvABVHuyEo18kgYiDl/pIYaaxCZM8hBps=;
        b=XuEGWu5Smao5miA+tZuFaI8jMiJ84xGWD5NfJXK6AFLnAEvxThk9g7s1cPMjZ5Y1sw
         RRoP9zE/XZbaySjm84CON2uTaCxrFNhFnKsebMe54f0BKn8UT7vUrUcA/j0eM5tupND+
         bMr1NTtIwWbyCiDyVuolvbhCaW5W14dkTuc1N53fjjgBGBQGJGWtlulKb/Z3J2U8Y4Bw
         33EExZUphyMQGM+NUdAMdpsTjLDQ+BnGoaSwPtjGUavI76TuTy/iy6nwu8MG16+u2JR2
         m0xQpBhL6u/agh1nqHLQQgwUbFiXPIv1ETYR6/C7HU9h3I67ZMnYUOFxORWg7V3OQzec
         THvw==
X-Gm-Message-State: AOJu0YwvRptNf8u4VFwHBIeZ4ySAeAgygonZM33Fd6Rs9AGQL+dQbH2W
	eESXlhV0k8QvtsUtkR27gbZtBVFBDVINWfr367z0cSZ/z4dtJYUz6mHP5upoq38x
X-Gm-Gg: Acq92OHRH70fdBL5y2lqO4g09njgssy4RR2WKZrgcHK0VsuYhYLI4tVuCkyI8DvGM27
	r8lBLGbWke8wzDruXoC8j+J/Hv+6arrF0GYhmxWSd0P4QosumZqmVoscDGteSvmGGmHYg4Ku1oU
	hwMKQ4VoHg4JEDXUa6cOBF9PchLIZCwrrY4s7e7M9JymES1IAkE2F2opi1bhYvfRimrKQSPv2N/
	szHOeNw8KIcR/Z3l40nReUq++KbFQnQUC24f3sqAZtjFgMXcAy1blkeX4WKzDpCg10AFg6fuUNj
	2Dx42QOkr+gEY+5wDuqd6v6nqsQaUi4E/gpHTSGhoUoY0W9isCwUuwvRYJfZAZHG2V1QpXYTg1T
	sSgt5lIMkpC4GTVE+vW8AbFwp2l0m0U3HEEkRlP6uw2Rt+zAmBNL4O+I/IkKQ9KwdZ6Pwux8/P5
	GnYGlNWXfj4Wrwa5GOLUcNK6DBwO8gKW2POWeexG/6kga9WVOlOsrvkmMHFrEg3Ud8Y28GOsk4R
	yeizfAeZrh/zAIvrFHSHwlIAIOUGuxKb4G57vC5lEIIbQ==
X-Received: by 2002:a05:620a:6cc7:b0:915:8c48:497b with SMTP id af79cd13be357-9158c484d58mr219508085a.31.1780459371048;
        Tue, 02 Jun 2026 21:02:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3eea49sm127604285a.44.2026.06.02.21.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:02:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] watchdog: pika_wdt: fix timer leak and close race
Date: Tue,  2 Jun 2026 21:02:29 -0700
Message-ID: <20260603040230.318998-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603040230.318998-1-rosenp@gmail.com>
References: <20260603040230.318998-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two timer lifecycle bugs in the PIKA watchdog driver:

1. pikawdt_exit() unmaps the FPGA IO memory without stopping the ping
   timer. A timer tick after iounmap executes pikawdt_ping() on freed
   memory. Add timer_delete_sync() before iounmap.

2. pikawdt_release() uses timer_delete() which does not synchronize with
   a concurrently executing timer handler. If pikawdt_ping() runs on
   another CPU after timer_delete() marks the timer as deleted but before
   the open bit is cleared, it can call mod_timer() and re-arm itself.
   Once the open bit is subsequently cleared, the condition
   (!nowayout && !open) becomes true and the timer keeps patting the
   watchdog forever, defeating the intended reset-on-unexpected-close.
   Fix by clearing the open bit before calling timer_delete_sync(), which
   waits for any in-flight handler to complete.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/pika_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 87b8988d2520..60a846cb3601 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -127,11 +127,12 @@ static int pikawdt_open(struct inode *inode, struct file *file)
  */
 static int pikawdt_release(struct inode *inode, struct file *file)
 {
+	clear_bit(0, &pikawdt_private.open);
+
 	/* stop internal ping */
 	if (!pikawdt_private.expect_close)
-		timer_delete(&pikawdt_private.timer);
+		timer_delete_sync(&pikawdt_private.timer);
 
-	clear_bit(0, &pikawdt_private.open);
 	pikawdt_private.expect_close = 0;
 	return 0;
 }
@@ -291,6 +292,7 @@ static void __exit pikawdt_exit(void)
 {
 	misc_deregister(&pikawdt_miscdev);
 
+	timer_delete_sync(&pikawdt_private.timer);
 	iounmap(pikawdt_private.fpga);
 }
 
-- 
2.54.0

