Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6122194A6C
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151082; cv=none; b=SsAX9aCOt2pqS48pZv8pXbNDV4RPvc8tZFCt2Vdnp/ir5OUMm+6T7xU1nqF1X52rUPZMCks5YV8EwL5ErqrG9i1sMAimJo+5bqVSyicXdcc/u/tlHFrkvPt8+SL6RKQH5w2AtyReGGsgGMEJVHH+XmJgee6x6rnNl+mhUKSrit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151082; c=relaxed/simple;
	bh=on8OCBOZny6M7srzCxkmP+cPIBVLozeTWdPsPciAkmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r82eBO7NNOPv/rdBlj7V4XDRWm4XVukk3+aF3TVOeBfX/ryu91LUv9NGAtNIdBe0FTQ/8iiWG/KDtqSelXMO6yvHRna/6MMJGmh4wjeUplC4s3kG04oHXoadz+HSVnl2Lk7HhottTVDVPwtmxBQzcYYG99nUkTpf2yWjxgizCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjxngs+U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjxngs+U"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso1062865a12.1
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 17:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779151080; x=1779755880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Djeu0hYBUhuCK4K+K8VSI28sNd7bw2pzRVQ1agobe+g=;
        b=Yjxngs+Ua1gROMMqfjCsg7q45iHPJywrCjy9kpsafhCtD6LLSWG/tUL1f++XTG/f05
         yxHfBCG7o934W8DlICsM8nwzdl6goEW3CPlo0lxqUUPeMvt/Vyi7iEyJwC0OXRtu9e3S
         z88Y21tSRm12tv6Bi83Rgvw/j/ELY2/2SoeFSVB0Vhjgj+9I0iYMYMQv5FfOqTDv28W1
         Qv0feKOL3PGyMcKMPipVL0/tKywrHrGnaCl0GBj9zTgpL3sp/5ujsaXRZZN6ZB5dVfu7
         /14SOtoSn6YcWjmNmnjvGg0x2obxeMs8MEDdt6trEruXoS4P2uO2opsKNZ4GYU9pr87W
         ZQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151080; x=1779755880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djeu0hYBUhuCK4K+K8VSI28sNd7bw2pzRVQ1agobe+g=;
        b=nmUnPk/J53/0Gze8FvtjkCT2DA+ZKppbQCnyjAYmcm0rDsSiwTXIyqbk/p3yNx65m/
         QsLImRaEbOUqqoJOKypK+b4G8zkJvGFeb8j4ixU7vBxgsvP3FJLaY5ZCpg8N/sw4vnJv
         us+5UgKJZT+yVHZFIyTPEaXvLGc/tR1HA4wzESraCOb+EohENlzStXksQ6tei+HM6INK
         tqwLLntF3dbwTHC13IsYkL7YlH4zYZIyC0kQG66KLy5DsBiJljhAruWcVYsyYf4dkykv
         m/m36tRqqcHVN+pgc977j1Vk298distktAPIZAHOTV8aGi6QMQhsHt6npwMx/IG6svql
         emLA==
X-Gm-Message-State: AOJu0YzY4YiMF+P7Oa2O1yWq8bh4qrwbn0weD+iny69vNZqLXvhyrDmR
	DOzTX1j04Z0mPDTVlUDxBcPNcw81CWosbEKH387+GrpUl4mSjSdZAQ1O6YxtyLBh
X-Gm-Gg: Acq92OE1IGulHZigHDa6IxlKTlWfkq5OMSiyAwTAjOt/0nyVA7Z/P+J21hILtqFTIP7
	Ap9eX7XC0Rn+YqIPlMKufFe7KKOOOlQxUd7QNUNOGNqBNboFzmvWtNbgOI8hUGhQFvmF7gfm4+T
	YQnK0ElpNkJljU/aTFSK/slaosdSpwifz9gCpW74aoYBis44GA8ibvHLmQe3cxScm6OsLgO9fpd
	Vpw66j+w6taL0tuV+gUYfF9Xf436luWmNSt9ywXJcQijyOnonhcgMTq/Pbf7rkd5ry34uxhbly+
	UKjalp0HNxtYhMNhkS9LdHR/eT5tklXogYJcP8z6F1qYcmde4hAhuBrKHNK9rtoswLr5V5CPw2c
	BZ80SXkTFx7ZeDIPDOhCOLN0g1zbuqHu7Xzn2Zb5dZ67DyrzvmmtSs6PKbJ4YJGAkqf+UFHyOSI
	tGmCu1607qGF18GT8vMVZz0FFGbOGVyjjtm3ROzrBZ5qT2+TBwOp+JBn4yS1nNH9M3g1zRabMz4
	qll9OVWvU7mGObNy0NdOwlgZlSWmLccvMI=
X-Received: by 2002:a17:902:b409:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2bd7e8037f7mr131633455ad.1.1779151079906;
        Mon, 18 May 2026 17:37:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm159848935ad.34.2026.05.18.17.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:37:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: orion: Use of_device_get_match_data()
Date: Mon, 18 May 2026 17:37:42 -0700
Message-ID: <20260519003742.626477-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to fetch watchdog match data directly
instead of open-coding an of_match_device() lookup.

Keep the existing legacy fallback when no match data is available.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/orion_wdt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0e145f762f6f..a92701ff2653 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>

 /* RSTOUT mask register physical address for Orion5x, Kirkwood and Dove */
 #define ORION_RSTOUT_MASK_OFFSET	0x20108
@@ -554,7 +553,6 @@ static int orion_wdt_get_regs(struct platform_device *pdev,
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_watchdog *dev;
-	const struct of_device_id *match;
 	unsigned int wdt_max_duration;	/* (seconds) */
 	int ret, irq;

@@ -563,15 +561,14 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;

-	match = of_match_device(orion_wdt_of_match_table, &pdev->dev);
-	if (!match)
+	dev->data = of_device_get_match_data(&pdev->dev);
+	if (!dev->data)
 		/* Default legacy match */
-		match = &orion_wdt_of_match_table[0];
+		dev->data = orion_wdt_of_match_table[0].data;

 	dev->wdt.info = &orion_wdt_info;
 	dev->wdt.ops = &orion_wdt_ops;
 	dev->wdt.min_timeout = 1;
-	dev->data = match->data;

 	ret = orion_wdt_get_regs(pdev, dev);
 	if (ret)
--
2.54.0

