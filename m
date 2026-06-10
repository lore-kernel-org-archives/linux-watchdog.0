Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402339A06A
	for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081325; cv=none; b=AAK+hMbin0yKgfpFhRlcUYeXGoUSxhZvelWvB0y8R5ZEM/Oc08FWSFpgrfApaMkzkua8oih5CTv3YGiWOffZxiWMaC1EM2QE/SEvC48F/kws5cTDvNJ8jTiwuhvnLfzTlIuWvTlT//ZQtWZF+QLzs6GQWfUe9uQ3F8VX7dxXUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081325; c=relaxed/simple;
	bh=jg1WA8Rwg2N/nFZSGUgY3r0q9rqAQQ9t3QBUEappQCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCtdfpOJWVAIlIMi0DATo2S+Wb1BeeByqf299mGAashyhOosUDjhmdEa6BN3Biy1ZO18Uo1VrzN6k2td+3yYYnzhqAv72YismcqtKwAsMv/sxKYoct+WUmjF3N0oDUqKnxEyGp44LN2Asw1dAT0zw9GW006fBnIWgqiMwWtjiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KsBR85l+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KsBR85l+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so72012135e9.0
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2026 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781081321; x=1781686121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucHb0b3fnQrSNHzN+PHqZCMp7bFru9xoYJEdBbi+u5o=;
        b=KsBR85l+/RHmauyu6QU1snTrBViuyzt4uvwx1Xwar0gl+pJ5eQn0DVnN1ane4hOoqR
         qwTu7uIz6ImMUP1Za4jTlYVBwe+WwSe7K/Xf8H34QPtKo72z6nds7wyOw8nI/i6D1YQX
         IO2xSyVPnwhaytpi04mJ+utxDECZF832SBqE2dZfb4473/+sZriP1BZXxZ1TjhJzkHTo
         m1Uh67RtXLRDO4q7/fbltIjcrJKzi6Il3BiKLwop+xTZCHJsSMu/oi/Og68nt1sRxF6s
         QbTXI1RlXhY1/nyenkMVCPKoAOUBNYFJWq0xOEwdGBk0H4kxrcVzvEWMBk/QOpEHuzYk
         a0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081321; x=1781686121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucHb0b3fnQrSNHzN+PHqZCMp7bFru9xoYJEdBbi+u5o=;
        b=IBFcmtfnTwesV7PRdlOGMQMibCmgSQjnTyE17TEop7Pey82M2VX0nCBnzfVFBwExNb
         +4haSeN4FFCv2iCbkXn3lasqJKX1KvbDA9rkrVVMWP38818BhEmRE2bcRoMh3z7DjWAK
         Cqh7sCTE1sYFIB3yUXVJiQhxzmckc6Tc9a6wokkFTUQUNHZa1I3+S74NYLCFhBAjuuN7
         vrII/oE6JynAQfJLgBXD4OIc6+mZvUfdDb0w2vjL4HAVE0CvqEpHd9CTyPV7t++NvGPL
         M8Gv/f/y6LfrspJdjABOJJi0+rUzaCsmifi8+tpmF0AavCUXY5XKJ6OIuPDkrPK8A5cg
         A1vg==
X-Gm-Message-State: AOJu0YyStRaq7k2cQL0+mvszi5QQGyqg1lWYbU4VmlnazoXs7IqmNutF
	SuA2wXKzn988kKfaEx7cBDYWQ5wFao/j7LiqeiWrjW/Fohh3sPjy0VgmqTguSYtR2ZE=
X-Gm-Gg: Acq92OGVCCLvjAW5DyRbbDQM8tdIT7JJ+z00PXWoLJXV6VKHbLxLE0pPGa6yafjRi06
	NdDi2EWM57s5WlXdWgWAhIRH+TVBr9IOuplK6XiWTSdOnhb2ed69b89Gzh5vvg3ktieS539Dx6n
	LiDa12GWLXJYY3gOL1nRPzHvY12FLT/rEfB9QfpuDFbZd6+9oXMcANXLXp8Eh2Ric3uDYkwWnOm
	tSC/P90Vxlj+QrsLvycDyxcD5Snn759vKrug+C/37g58BhIYJOqcRis4J6FxpGXWUoYS+bkU264
	Pg9x+mbK1OyOSM/+Xn/W1RmZ1rI5ldjEGrjDfBxcHHxbM3MmSGmA1dlnGJo7G6gWu2tFDCKuuYg
	Pt5nCjwjEQ3Boeq38dUzxfup15380sgstXtY2t42CUW3cJse4EgtI8djJTwQq43HoESwExcLUim
	pGKHLzNVuwPTqZfJPY9HayS4oE55yw8WDOEgdfWQA=
X-Received: by 2002:a05:600c:a011:b0:490:58ef:cea7 with SMTP id 5b1f17b1804b1-490c25ee058mr396519625e9.22.1781081320765;
        Wed, 10 Jun 2026 01:48:40 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dcde3sm71663674f8f.1.2026.06.10.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:48:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Zwane Mwaikambo <zwanem@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] watchdog: sc1200: Drop unused assignment of pnp_device_id driver data
Date: Wed, 10 Jun 2026 10:48:22 +0200
Message-ID:  <0793f81a854f9e5880ad38f54c8583b3d56e5d60.1781081216.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=jg1WA8Rwg2N/nFZSGUgY3r0q9rqAQQ9t3QBUEappQCg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKSTXE7KKY+D9/3eUsJo3lLV+/NLg7Y8sfCStV P3EGlTJBnSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaikk1wAKCRCPgPtYfRL+ TvHuB/9wht2iW03mT7+wruIuNVphBieHf7Q2nHdIvpAYjhAVntaofDsozPCXkjlL9Pq9YWGyxL1 qgsceydBjghrN/N3B/xp8BT+h0ChBeVBmE0TQ3s1dTFkpe/wkQbRugDYYt0FnUA1cfrV2gVlPfN Mj7td8zm7IclevKonCpJHPsJqd9QyBTy99Z9xLkho1rqV8xqw0ujb+yVRjFJr4X5ofEXScc0k6d tvuatJS/9e8dJIhLeAXKrRgTut7OmmGHPie2GkdAkBK20EO2uekBryeDK2teGsz9e4KcMetpKrB nYlseTB5Krh8iJGSmjjyAvVvBOiSwCiw3iw6SAKfP0x7OVBx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver explicitly sets the .driver_data member of struct
pnp_device_id to zero without relying on that value. Drop this unused
assignments.

While touching this array simplify the list terminator.

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with builds on x86 and
arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I intend to change struct pnp_device_id and for that it's required that
.driver_data is not assigned using a list initializer. Instead of
converting it to a named initializer, drop the assignment as the value
is unused. So this is both a cleanup and a preparation for a later patch
series.

See
https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/
for a more verbose description on the mentioned change to struct
pnp_device_id (though this is about platform_device_id, but the idea
here is the same).

Best regards
Uwe

 drivers/watchdog/sc1200wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 76a58715f665..1d3300c98d43 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -339,8 +339,8 @@ static int __init sc1200wdt_probe(void)
 
 static const struct pnp_device_id scl200wdt_pnp_devices[] = {
 	/* National Semiconductor PC87307/PC97307 watchdog component */
-	{.id = "NSC0800", .driver_data = 0},
-	{.id = ""},
+	{ .id = "NSC0800" },
+	{ }
 };
 
 static int scl200wdt_pnp_probe(struct pnp_dev *dev,

base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
-- 
2.47.3

