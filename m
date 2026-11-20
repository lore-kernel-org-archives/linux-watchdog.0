Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205440;
	b=xBo3xJ/Nnuxa1eUweU+zUy5TkHHRT7d24Y4a4lGia6Xa64heWxQJFh4VVO/2c1YEOhfY
	 UwHLvpwg9WP2PLNn5VLV2voiayFSN9RWluG7feWBIfZVymvJG+XXQPE0SBiRJ19FtTv20
	 cJbYBa7JkZaanISgKHoZX5/zSySNwMN5Vbt2g4GhMMbwVSvIqNlyCt/P8kOQe0aqJyDmG
	 Bb8hCjbvEgFrffybpUzVu++Fod261z2cHSV9/qgFJChgfUYnDgehJHlTbq4ZpoVInWTuv
	 XbIv/0un09d4z7CM6lpOBC3TzOZp/1U27e5KIb8Yjo9LDwJ8gDzdq1eCWT5FOZMgedQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=48fG40u44IzRAj1aROD5Y2Q1HOpJ9Yh55cmOS8ndJXw=;
	b=vLVOzwbOQCAfl6aIRI5Y+wlSL4gtnTyJ3lcBGVwrQCk93M5dDC1t4OcB4LRdi3K9f+M/
	 GxTD0nrLsg2FM9HpYfo8P0KgjNI4+rxc3Mt+R6MHCRP7Z3humdql7PWHUbA8jZsOk2Hg4
	 7ecKRGKfsX6nfANeBx7vDzucwG12rSGzufCjPThSMXaaAq1/GcJU1Rimzr6hozBPd8rQt
	 PG34GmgiHftr+5Nn1kyqHVfZ4qzlBY37xEZsGyqhiysj00nhT7iqIZ06VmjeUVE/gY7T9
	 3AyU36WZhmXLFetpM9fykd/ro1RHJRzni1yzi3c5P/Sn88/tk7W4aY0t9GXwts1zy5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4Jknyks;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041C606A6FD
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 20:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9041C606A6FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4Jknyks
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso1481776b3a.0
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795205437; x=1795810237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=48fG40u44IzRAj1aROD5Y2Q1HOpJ9Yh55cmOS8ndJXw=;
        b=r4JknyksnkeFoXBitM2CtrdTAt/WByFNDdLy8fW8o6C+SCZHcfi3haoQwrCcoxrSPQ
         /thSr3/NDKFBjjugwQ3XfxvkApFm0SR3J6zXBVhDJlv7BN2Y07A4ssVX8yys65ZyaIZ6
         lBSjfDDHKq50FuHmmchlfoMqcC2sY4pzJhNGwCXu96Tonp/aO5WrpgNPPCQ7Fligl8vF
         fIRsbh6s2fGkotYFjUEDBYUkglEEAEe3Jv4ArntzTm2mQRU6sjDp3uoOu0FXzhSN+Iyv
         vww2suKoXeMaqE9r8Yk6vcgwx1LW6Lh7NIV/DtRq3KU+1fxNHNsKhK9KnwWPNN8s8E79
         5oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205437; x=1795810237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48fG40u44IzRAj1aROD5Y2Q1HOpJ9Yh55cmOS8ndJXw=;
        b=Bbg9J+Bq3Cyy3MSuL52OMemBjZCGaXWy17GPWvmkuCH6iUV4xNzc03KqpYXzPoKRAQ
         M7/i7ByZ3xSpME/yuEiXYeHOLtIdKvi30ELhdyT2mC3a2r3xKksyEDgwjoT4A1opkw1W
         9pgkcfcCpuwngfYINuQs9UWTMLUk/JETlOHvnrEJhQUFf6/Sn0lPMQGj8RJYuoKAi4l9
         nwOE5S21RrF3euatd+SmyQsSvQcSki3q05rSBFZ9gEc6XhsQJO1g3if4Oq1/abzJlGE/
         JI4zRXgifSO0FGg1+5epjR8uSAC6+d1Jaf99wu9h3UxRmJgwknvUo101oCMemHZ3Yhq/
         uZAg==
X-Gm-Message-State: APuU4Z99G0+UndgJNXDt7lKCZfHgQ/SeqLzbhRLnuMsfTE/jlXojIP8D
	KoinfhxAFyXzcs/ugUz3LYSKBuWGbY07Uw2GtOuBNUMArEUqGP4Ra8B82LwJqrka
X-Gm-Gg: AZFdTZfAQaRAG4I7qUpSMSOwtWVJ4z82aK/a+VmQw6n+ASoRJPaaW/fe5JwBvIgfUuz
	FhT0fAI2LHwf2j+iDZEJAi5X4rZvgKKJebn6SV7LxobdL5eKF+GpzjA0JsBaAdosXnBGviou776
	ZTZSsMEf2M9ZdBUl5kN/mc+80QUIEhaWvEXlxcTR6xolU33Xo/Iov8fX2vS5qCLyVeDNOu9h9ul
	pLVLnlAujDZDkGLfvoe2lCdfySuUQfItUcayJTotU3mRXMZIDvUaiUlLppPe04G9CPtrzOzAY73
	JIYcPy6Dphht43TrLgFRZEcJgCtuMB/wmezFlqNZRxGMaLBU2HNzINmo6FFdYLPCU9KWrjp0tD9
	4/DC+leWynZ7wRsKA0fFH7/hzLRhTCveHd1kdDnoZODH9TrLvSYDLimvjmFN5JQ5OtF1QbDYcbc
	hgLGH2TTt4SxmZ0Tf3BSqL4n6wB189x2+M6TOAEatfZWNG9+lQmeGrDS9L0mGfwjIr5Xgl6k0Rr
	2NIUAMZG46oof/5itJNwMGdSaUqUl8DsWuRYFcEquM0L5BPG5tz3SJbPlJASnl0zwouVZ3+4ZEB
	bZRwxq5y5kvC4JrRckeVXS7gdKyanW17HAd+gDuo0OL5wi5/IR914xcprRse7+B0tPZ2O9QJqQ=
	=
X-Received: by 2002:a05:6a00:3d44:b0:8a0:5eff:ad5b with SMTP id d2e1a72fcca58-8c7ddfafeecmr3911362b3a.33.1795205436562;
        Fri, 20 Nov 2026 12:10:36 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c86d821637sm2075227b3a.0.2026.11.20.12.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:10:36 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: sp805_wdt: re-enable the clock in the restart handler
Date: Sat, 21 Nov 2026 04:10:26 +0800
Message-ID: <20261120201029.1685193-1-mmyangfl@gmail.com>
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

wdt_restart() fail to reboot the system if the watchdog counter clock
was previously disabled: If userspace cleanly stops the watchdog, the
core calls wdt_disable() which disables wdt->clk. No reset comes.

Re-enable the clock in it as in npcm_wdt.

Link: https://lore.kernel.org/r/20260911031916.A8E051F000FF@smtp.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/watchdog/sp805_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index a14ff7ac0db4..20b2fbb7334d 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -138,6 +138,9 @@ wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 
+	/* For reset, we start the WDT clock and leave it running. */
+	clk_prepare_enable(wdt->clk);
+
 	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(0, wdt->base + WDTCONTROL);
 	writel_relaxed(0, wdt->base + WDTLOAD);
-- 
2.53.0

