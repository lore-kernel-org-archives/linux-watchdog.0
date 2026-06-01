Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56542F8E8A
	for <linux-watchdog@vger.kernel.org>; Mon,  1 Jun 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341617; cv=none; b=tNjI0Rt+xmG/MPR41ce1o3I6+7DME+BLNyjcuWTnTfEydiaBjUjcmdk2DJHWZc2XmJudwJSNCjzZUye3HzriJhY0PbWrOLD0xN2ds9B/17Gfue42TniKGNKdcIl88K1ZQGeJ1WV4YHfBgVVY1wI/o+Cop/ny2/ntjDaBO9jObhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341617; c=relaxed/simple;
	bh=jOgJ83c10vyqCNtY2iWTtz9+bIiFdLMtkTch3qJ39ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtjR2au9q365LcLfdW3B7+Bfn0FfByFL9RCgIkXQCDuq06uAJvXizEqdUlMkyPc6f+ZFJGj4yjJ7sQcGGXlMgJZadnRqGgdFgBo84dxA14qFgkchPERf5r8neDluYLsvsfaL22p0LivZAd53yIF3uTl1YLEkb+PgtWSeubqhbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVXW9syO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVXW9syO"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9155126daaaso206162085a.3
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Jun 2026 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341614; x=1780946414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZKHLboCk6OHxzer0uEgo6LCbcjNpnRvCpbKSl1TcxM=;
        b=VVXW9syOzwOqiBxoPMeNNSR9FKZbZopuQ47V9jROrICA+V1GIbjyY4dlWn/JKMew6S
         dp1P2oltEc/nR0y404vpq6dk2nUlKEwQkmcPGlJU5A7nvZcc0ZFDjrbBBlqFPxET6l/u
         aF0VcR39uz2mGGmksRZuoTK7mXAtSxtHBXrjX3pHbeD0sGMQae5qjMsLQjvKom8lVRfR
         vZAYiAUnOSF6fQnU4pbb7SskW9YIamsAcMb6S+2T1DAHb+pdkzX4dUz5qxTsfPIEkWQi
         qFxsGJPIJlXlYNMSaf8U0nLlpmhhkv94z0OFuLUxT2lYP1t2IzSpoHxIOF6z0EsxQ3pd
         1C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341614; x=1780946414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZKHLboCk6OHxzer0uEgo6LCbcjNpnRvCpbKSl1TcxM=;
        b=QnsF0CPPaJQMBTmrwiVMNsQ71uizRAEoLUyp8jFjaGv6HFG1+/A7eTrM++Xtxr9UC2
         tlSdF6WKb3MNI/i7tPbnAixlrfV3aF1ETDJGCotEQs3DHP+8rGgSjenvzNK4IKrn1v2i
         b4/EpJvdspiINP2C5TLEUQqX/gM/3uLg46+56+OeJyApxCUtXJklvE1ctrEmW+izfXyj
         Nbwi4GCdBkdC3fyxQeA+Xa7D0vkcfCAUqpJ6nq5qg6Cnli8jQ0rCf+J8ASOdYCcCaUuU
         iyf/RL+l0R+3glUUah8YJxPcV33E9Xj0eu82mDSnODtjrk/7k9KKTMrnF+ixJa6Wakkw
         PPzQ==
X-Gm-Message-State: AOJu0Yy7adRHCi/PhIMZ8HYPZuph3lSRVNMZGt4/OSvF9rYpLGGGIRTs
	LqSwZ0lZ73qJGvx6LDE01P+H6UWeESufs9Xd66Q8v/EwRjGuWV7MbvFz
X-Gm-Gg: Acq92OFncn1Eg+og9ueVP5Q3w36ljJiH5QVfi3Ss01G3awM2ddFHWUhXpgSbgFKxmMm
	GT1Sl5hgdYZz26+WtTHWH6C3/kLFvLFSaNFYvUZwCHJNJiYI61vJgcBR6n/Ckm0g506VYS+ppU/
	SSWQTlEJAmVqAoa669F1HytxkI+e/wMCkprr7xa3M/pyt1wlzDI/1fkH6ltRvoc4RrfT6eSyPUn
	STNvpudaX9wgkbYvsPiSyUqYKOJOFuoxV9rPCoCkcVHxGPgvoc6+VYqKdEgA0CueI8ubUKrwTlp
	kCv9AnrDHpvdAKBEvTEPcuEBVqVGGu2oj+UvH9XCEoNfQge3nvFUVnzFS6QbFXqbAso+ZR4oDl+
	FHSddGjWryqI2GTs39aKCkjMt4gwdxJQnkJhd2RsAcVaxH4H65Fk5D82Z5fa9SrSPS9gzY40Rah
	U1PI6Ti6Nz01xz02mX67TlfZeBAb/9sNQi3hRm+R4jJUpFU0741Lg=
X-Received: by 2002:a05:620a:c4b:b0:914:bf8a:ba81 with SMTP id af79cd13be357-9153d9cc4c5mr2002069185a.27.1780341613562;
        Mon, 01 Jun 2026 12:20:13 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915325fd899sm1079168485a.30.2026.06.01.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:20:12 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] watchdog: unregister PM notifier on watchdog unregister
Date: Mon,  1 Jun 2026 15:20:05 -0400
Message-ID: <20260601192005.1970805-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

watchdog_register_device() registers wdd->pm_nb when
WDOG_NO_PING_ON_SUSPEND is set, but watchdog_unregister_device() does not
remove it. This leaves an embedded notifier block on the PM notifier chain
after the watchdog device has been unregistered.

A later suspend/resume notification can then call watchdog_pm_notifier()
with a stale watchdog_device pointer, or at minimum after wdd->wd_data has
been cleared by watchdog_dev_unregister().

Unregister the PM notifier before tearing down the watchdog device.

Fixes: 60bcd91aafd2 ("watchdog: introduce watchdog_dev_suspend/resume")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/watchdog/watchdog_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 8300520688d0..6c087b4ef5dd 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -391,6 +391,9 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
 		unregister_reboot_notifier(&wdd->reboot_nb);
 
+	if (test_bit(WDOG_NO_PING_ON_SUSPEND, &wdd->status))
+		unregister_pm_notifier(&wdd->pm_nb);
+
 	watchdog_dev_unregister(wdd);
 	ida_free(&watchdog_ida, wdd->id);
 }
-- 
2.43.0

