Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69E442FCE
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188989; cv=none; b=Y5bey3iLZPMxZTaBU8jR4Ffc/9CGTdyMJbn+Dov/GqikTQxrxy+75oX8+XkDy02sRdTIcQcga2jCno7IaCqDlWuPyUzV0CvMVItTYD95cHJCsSmSPdkIYtlMKKV/JkBIbLW0bFMy4g+JO5P1baznZ4GPf03YYAyGDPphH1FKd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188989; c=relaxed/simple;
	bh=OIaEkynfAr9WKeooJY/3g2U/O1bCDEbfzmAGfhXmYIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxCLnGSw0YkrCi7k6FCIUUW8fbxGC4u8X5tHI4N1CXBLG8ydNZZ6Q695RWJEfGmkIqkgXNHhZQ62A6hKTGtoXoQpJ/FizVxrdsVoTDJ9oQ69hh1nUwr3CY3uH+kf2hkKSm8966BTI6ECxfSJ9Erw9z+iyJlR7fAlxj/TJpkjYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwT7Sv3w; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwT7Sv3w"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-170135e43c7so251852c88.0
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792188987; x=1792793787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKMLDd4ELr4QXkQblGO+w5ZqVhuimx/sg35XuBzMtks=;
        b=rwT7Sv3wcsEj39GLLbHQvHAmM97L4+hg1aflLTjVOwSgdgJiojI6V9c6hIBckuh/lq
         4hy89RquscP0WVEWDHzcT9V4VgLFXoXQ/p62sjLevdajXmjtaKPlf89f34TgVVb/++cU
         3qGIhey5fJJYZ2/X7mUBHnen6RFp4qH+fvPqH4ZOKlaRGN4iu0bkkdJGotv2MGMh634+
         kVJw3E8qnMGhyZcMPHybMTH4nWfG1sAEvEbxwS87+oy3ytllx5AP8gcCvjPucul9EPAp
         nS/TT9a8IYJ2tifBQ1oke34GH1b/BtWNxqjUdTPsO9lNdUGMOq9PoVDRzHNmjPjMcYKd
         72Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792188987; x=1792793787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKMLDd4ELr4QXkQblGO+w5ZqVhuimx/sg35XuBzMtks=;
        b=R8Bbx60SYpFZlVpU0RNZpy7jLCSImqj4WpvuG7Xzjf25OlAvQWktV1InZYiyUPzIwF
         bl1+Gq2LbStxyTKX15Tmp2NcRvmHtwlrBQ2l/TbofWOLJaFchfrieVb81CoffDZScA5X
         O4xn6TNr+Fg2fyusIfPhYuUD2oo2ks929ClCQ+ssHcw0yaYFc6J2Zt7Fob4ZD4ZoSVvF
         TdA3/goPlEUlJY0JxB0OR1IVMffS3rY92MZkgNOdUxmjenUVrVFDHSb2kxrSc12lPjM5
         /5F8Qb9ifJs3QFIIyn8D2h9BkZ2fiS+qGSdGK7ZeK6BIJZt6oCybCH1OkEou+nViZiw0
         3ZDw==
X-Forwarded-Encrypted: i=1; AKwUvByjzWkst/L4vY8xGSOi+oNRlNqUwj9Tl9glGDHkcJ0NmAro5jRjJHQGhU9nEbmTqcr51e4Oh/C63nwtvcR+bw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI+USb5U9a1vBPKT/wvm8vPbpF4BEVk4p5rcf8UDuUzupoQPc0t
	Y3f8mBgSAvmrQ/TuCq98TU5el8v2AErf62ymrXp+KXpZc7fKCZ99D4CK
X-Gm-Gg: AYBFou1dZU8jXZxbO+a59w+Z/qBDYhzc55euDo8+h/NTvVw/356efGubht6dvTH9OW+
	8QTlf256B6Jh2Ie7ZrPw4oWeYK7JUT716EwWDFmXbdIi6e4bLuCdL3ViuHaWHAcPXcHwqhVtjM7
	aUE82N9UQTvV2jttxrithTVqHm4EzqKlEjbtnzSqfeTdU3mLjd3zEVuv8KsoFaN7PDAvq6ACNMS
	Lo5MC+lEDAFm2LTMfXFfefr1SCyCblKjsZuWeoqkbTH7kKVUj5bjJMnlwc4oZ3dlgbnDD3u8ccb
	s2BHq+vrd1iSuaU4hQDzUpnO8hwlkuOsAG+Xa/ACHzSzRMGS0Dds57BpnZA592pPMYNb7A+A7jG
	ySTO/Ns+n3UgNwns9ywKt2f7rZqr0QDazu6wuZaMDA511T3Hgm9m/3ERKcGgHfaI3+cl2wWpFdt
	2scc9mf7Se/MFMuT5mJxN9YeECKHvFZUhyOJ55d26oeSL+ABI4oZTQGrigTB5rhXQ6RWhQ5yMFy
	CidIb7Q
X-Received: by 2002:a05:701b:4284:20b0:163:a197:722d with SMTP id a92af1059eb24-1850cda6b4cmr1715523c88.4.1792188987400;
        Fri, 16 Oct 2026 15:16:27 -0700 (PDT)
Received: from eldorado ([2600:8802:b00:1f84:d294:66ff:fe95:a98e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm10480863c88.6.2026.10.16.15.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:16:26 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	manuel.lauss@gmail.com
Subject: [PATCH 3/5] watchdog: gpio: Support watchdogs with a minimum heartbeat interval
Date: Fri, 16 Oct 2026 15:16:15 -0700
Message-ID: <20261016221617.2223004-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016221617.2223004-1-f.fainelli@gmail.com>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read the optional hw-min-interval-ms property into min_hw_heartbeat_ms so
the watchdog core defers keepalives that would toggle the GPIO too soon.
Reject zero intervals and intervals at or above the hardware margin.
Devices without the property retain their existing behavior.

Remove the arbitrary 65535 ms upper bound on hw_margin_ms as well. There
is no register width to constrain this software interval, and the MTX-1
watchdog needs a larger margin with a 1600 ms minimum ping interval.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/watchdog/gpio_wdt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index ff323d6e692e..a431c77fa179 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -138,10 +138,20 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	ret = device_property_read_u32(dev, "hw_margin_ms", &hw_margin);
 	if (ret)
 		return ret;
-	/* Disallow values lower than 2 and higher than 65535 ms */
-	if (hw_margin < 2 || hw_margin > 65535)
+	/* The core feeds the watchdog at half the hardware margin. */
+	if (hw_margin < 2)
 		return -EINVAL;
 
+	if (device_property_present(dev, "hw-min-interval-ms")) {
+		ret = device_property_read_u32(dev, "hw-min-interval-ms",
+					      &priv->wdd.min_hw_heartbeat_ms);
+		if (ret)
+			return ret;
+		if (!priv->wdd.min_hw_heartbeat_ms ||
+		    priv->wdd.min_hw_heartbeat_ms >= hw_margin)
+			return -EINVAL;
+	}
+
 	priv->always_running = device_property_read_bool(dev, "always-running");
 
 	watchdog_set_drvdata(&priv->wdd, priv);
-- 
2.53.0

