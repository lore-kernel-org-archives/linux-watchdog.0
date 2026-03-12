Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD07387593
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Mar 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349637; cv=none; b=PT7wvjpHC473VLnJ7661AzDG40nPCz5r7BQgR2IHx5EM39GAJV3K9Gc76aE2XbpqHADmPvvCMmUTP27gjGz3AthTaZrYRNAcEAv/8BKuJOKFXMl9ZBMVJqOJkHooD1FxuyJSBjkSU3Hoi7nol1BHybDVyt7z3axNAKra4yuHXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349637; c=relaxed/simple;
	bh=9gG3wqs+eoj6PWo97on+0MLsVivSeibJ8oWlHghoREk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKAmp00cM7Sz8V/gv3ZLwwEs4+YhbGftS/9VIFxAuKcP1JnBsHAG/utepoB8MKnHUoV0eG1NpJzI32nwrRJxH43u0dafn89d920Nn/fHTNuUxaEtyq6G8Cc1uqo5uglweW1j2KvcdLbmTKf6aY4SrkjYBUr5Tb8AnS9EYXSjMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8NNPBpX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8NNPBpX"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439afc58ac7so1815338f8f.0
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Mar 2026 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349635; x=1773954435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7PJXadpofuFYWHdYoWUxU7FNlHspcolSnOK601aB6Q=;
        b=j8NNPBpXko2M5ZWNSyp56jjHjdwieZmN4RhXmJg407qiu3gt/qPF2kmS7UFVGXT9Ju
         ikSDZFeaoVcy/u7Ji2+bS1LD8QiQSwxdLFCjmLSJT0Ch0kTgpuAHKmBYdtz/bkHSSf23
         oLAE54Wcoyo0iLg2Vy24IewBiTAe8Bd9rILmRtte7ETnCZy//QozQh90tB+3y3iScvpt
         TEKMNPpSFKpOGnMUMxCKkga7hgj/0J/ff0iLZa/ELjVNjQOOc8jBtb5nG4giLxQ/35SF
         uqkH+Wf/u9uItlDJGlNsGCDxbsrHm+Uw1iZQjNe4dZ5lZuYxlkRCwEJ4SqF0yWyk5++Y
         HAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349635; x=1773954435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7PJXadpofuFYWHdYoWUxU7FNlHspcolSnOK601aB6Q=;
        b=ts412gB/YUqqL1K0PVy667wfk/iDVFYyCl2+5I1xg0BkqzImje8u8CHBWPdMii6p3J
         5BRU0G4BSiCB5tVtaR5GuoYRTIxnGuhEZokDIJw3lmIyrImJ19CiMF71EgKBOkFF6ajI
         6at6ol3f7LiBiQTPMP5smb9eWjndF60cMOsDIGUXX+RPAoC6pml//MPn4y2fWijWsW8U
         HRtFvNVw+VitRxVxZXE3tzvk7jwRHmrVk3ABMqZhFX9AfgQTs0sFXv6NECy0UQRK2Nr0
         0JrdRi3ox7M9mMszGC+TyhcjstqJPuJBKrxlb8Z7tjzgN+YSq3nhdoI0C7D9LF1Oa0cT
         v/8A==
X-Gm-Message-State: AOJu0YzwoRykvMv4gsEWd+IG3qMBCo/1hxCxT869FwkJfh4n50LjJpFD
	b9OBqb61yXHi9rtpSA5tRyyuZq5k3RUTNoeUuEwKmeecIaaf0dLWhE1EQXMD9g==
X-Gm-Gg: ATEYQzy0YSofY2VgUCf7L+8cotJasziedK9ehiU3IHIcKiWK11bl3jXbIF9fNHPePjD
	MxSAb6QALEkkbT1wENosbnqnVR9s+QxOEknKY7AHMRgbaDQKMWG/AlwYwY4bsxvV0R0oolImw1x
	5oZsmOOA150UoXGtNBFa2Vs2XuwQvsBtWxzYL7nMUKXnOl1xnUuEt71LZhei2yX2vLMSOEZCDgM
	nKvhuOGOY9ZzwSWrESI1FpH0e/rOXYxI5qlQIP36I7La0Va3cKF2/D8WSLRgQTnp+Toi9/CyN5S
	fgtrZdMSfke5vZ+KESXcSAjezOphicYlAllYa7OsqdCQaA+x/tyzNTmsxnkYK7lavL3W/XHoMF8
	08FR+FcENcdDpLT29bIbE8LUIPtgyuDBf1aBCPt6HzpNg10lyLb0bM3MQYx6zPBpc+bOL08yfqy
	dzpabRz2GMUx1qB+mW0iiWLz+8P3uueDfuZvs=
X-Received: by 2002:a05:6000:2c04:b0:439:d928:d783 with SMTP id ffacd0b85a97d-43a04dbbc7cmr2334916f8f.30.1773349632423;
        Thu, 12 Mar 2026 14:07:12 -0700 (PDT)
Received: from localhost.localdomain ([147.235.207.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm11025362f8f.4.2026.03.12.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:07:12 -0700 (PDT)
From: aviv.daum@gmail.com
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avivdaum <aviv.daum@gmail.com>
Subject: [PATCH] watchdog: mtx-1_wdt: synchronize timer teardown in remove
Date: Thu, 12 Mar 2026 23:06:45 +0200
Message-Id: <20260312210645.10613-1-aviv.daum@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: avivdaum <aviv.daum@gmail.com>

Replace the ad-hoc completion based teardown path with a proper
timer synchronization call in remove.

Stop the watchdog and delete the timer synchronously using
timer_delete_sync(), then deregister the misc device.

This removes the open FIXME about locking/testing of queue teardown
and makes the driver follow the current timer API pattern used in
watchdog drivers.

Compile-tested: ARCH=mips CROSS_COMPILE=mips-linux-gnu-
  32r2el_defconfig (drivers/watchdog/mtx-1_wdt.o, W=1/W=2)
Compile-tested: ARCH=mips CROSS_COMPILE=mips-linux-gnu-
  mtx1_defconfig (drivers/watchdog/mtx-1_wdt.o, W=1/W=2)
Compile-tested: ARCH=mips CROSS_COMPILE=mips-linux-gnu-
  malta_defconfig + WATCHDOG=y + COMPILE_TEST=y + WDT_MTX1=m
  (drivers/watchdog/mtx-1_wdt.o, W=1/W=2)
Signed-off-by: avivdaum <aviv.daum@gmail.com>
---
 drivers/watchdog/mtx-1_wdt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index f75426cfa..85fe006de 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -33,7 +33,6 @@
 #include <linux/fs.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
-#include <linux/completion.h>
 #include <linux/jiffies.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
@@ -46,7 +45,6 @@
 static int ticks = 100 * HZ;
 
 static struct {
-	struct completion stop;
 	spinlock_t lock;
 	int running;
 	struct timer_list timer;
@@ -69,8 +67,6 @@ static void mtx1_wdt_trigger(struct timer_list *unused)
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
-	else
-		complete(&mtx1_wdt_device.stop);
 	spin_unlock(&mtx1_wdt_device.lock);
 }
 
@@ -204,7 +200,6 @@ static int mtx1_wdt_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&mtx1_wdt_device.lock);
-	init_completion(&mtx1_wdt_device.stop);
 	mtx1_wdt_device.queue = 0;
 	clear_bit(0, &mtx1_wdt_device.inuse);
 	timer_setup(&mtx1_wdt_device.timer, mtx1_wdt_trigger, 0);
@@ -222,11 +217,8 @@ static int mtx1_wdt_probe(struct platform_device *pdev)
 
 static void mtx1_wdt_remove(struct platform_device *pdev)
 {
-	/* FIXME: do we need to lock this test ? */
-	if (mtx1_wdt_device.queue) {
-		mtx1_wdt_device.queue = 0;
-		wait_for_completion(&mtx1_wdt_device.stop);
-	}
+	mtx1_wdt_stop();
+	timer_delete_sync(&mtx1_wdt_device.timer);
 
 	misc_deregister(&mtx1_wdt_misc);
 }
-- 
2.34.1

