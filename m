Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330692;
	b=IEx6SE6YSvrya1DK67pVyDZEBb52jCFZl99N/qdMV14XNw2kqZVcoK9wSmwXFMIaCugG
	 LnHCfcxZZum3oTC1sgtLwWDkimHD8ztETAZ2Be+1MVtXrZqm6qIoDkahPmdCBOQxMUvib
	 xNXXm0VYUaM8DJoPDUkeIpV8W6SgI0rTBn93jrqlzLRuF0ewRo3EG0oUNLx5GJEYqA6Pl
	 6sMDdxLBVPQuouH4zh9ZCOXEBNMHUTUbIrp9pE8FGRM5QeOOsq2BPzbnKA3FERcXSb0TS
	 jbPxHYsjtOZiindq1MdJ8/U3VLVGQN0gfxl9TU8jvBkMkz9GNRnkbUvYn7GRR9gxWeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w+PnSLxKsJCEKZh3Ds403ivdl+AA4FlpjzNhhNO09oY=;
	b=GmTi5OhOrqp8uwSO/RuDe+LoraPKTzg+x4tEmjPTR20GPYamRZye3gKsu2Vn811mjRxl
	 0lb+w7FeqH8PCXHKI/pNKUucyKF5jmcnxafFzVWPOURyCp0TujnKbCGQtkBMp93AYIbPL
	 SUTPqFsc9AwG+DJaSB6Hu36VPA1rgB88U4D96C5Du7ylKNO3JkB6VJ9pVs0U8p/8x9Buv
	 lNoCPHs9gcVVOukXuem2tpjV7j54k097no5CWJxUWbKneZXdV+w9Dvbn2d6Y1e8bNcGMV
	 n0VyW9VfB68xU0Q8jnHWY9BNR41i+osN4Fjrcp91ONFyaMlVEPhc7BOZ/1F9ELTKqgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKY8UVpz;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93065606A320
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 06:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93065606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKY8UVpz
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2efe591a1f6so7658245ad.2
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 22:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795330691; x=1795935491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+PnSLxKsJCEKZh3Ds403ivdl+AA4FlpjzNhhNO09oY=;
        b=oKY8UVpzKhjVKafswLUERPYGhhuJRjrxLQQvx/ETBnU7BjQ2U1eW5Eec82p9yUZSQM
         69uRrRN49rT5ki6eGLZdjWpK0iFa9hFcu4wc9nXn/Bp8SqlS5ABwSjJmy/8SKLjMcNSN
         E45Kc9P9FXDD8FCZB3Mse459Ccr+1VPgxJPHu5mX2h+V5P9u7qGOFfTVZx8K/aAkuydZ
         g3ubIm4r9b91xF+Qu40r4Ubh2J3pqSOdr9cABqN+bT+F6GnzohxpwXn/mB+bDsF4hX18
         jSuFLH9ww06Mwg+e8v0l+jJ+6Vqdg5L2tEdLXp+P0a5oEa7Sq73XhcG8d2SVKjJI9B4u
         vPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795330691; x=1795935491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+PnSLxKsJCEKZh3Ds403ivdl+AA4FlpjzNhhNO09oY=;
        b=F5RLjdHkfaeZjMzC5l7qaIsrL4t0fPslwtxuukFsxTPFx7RCFn0Dneshskr17kKBnT
         B0Oma1BNht+xGg1IHG55tTq14xSm6iBLctXWXta0jeUvGF1HWWyRQUQhP5+Kkkm17jjj
         w9Wdz0WmXT6tpGT+FSAbMIigmoN74cQNDLYgkRiCk2FrGaXBf5qfAKP+cxQ2jdg+Xc3G
         N/aMMljES7P/fhLt0+HrESyq+ZOBE5iI78T7lR9UL+Tgw2/VDh0uTMTGYujwpXzS8Bjd
         5arZ4OY+wvTR8Td/SWx+ZaZVfUR5HsVc+ezO/UaPqSTy4s6WMns7wewfbnTAfnrb2KNK
         S3Tg==
X-Gm-Message-State: APuU4Z9Sph36sHz20Kfe32jxKW8x1xa+fRXnX1Ygasohqa9hLfesvgyF
	te+I553hRLYan508qg+x99tqwmqRHKrn8wpfxsup8MSUccFsvhivZOiSD0vKIhri0zc=
X-Gm-Gg: AZFdTZe7/ON730oL94ObZbVR26Zlh7MwISz5wotis3Xw447FTQEtgof60zT7g/TBlS8
	cj9gALGIiFKWo37U3HkAv7J3gEarkLeLFQOquZmXMz9zGVCYHS5+ny/Y7BymLbbHsLCoB92HJSO
	pmiIQ3YTNEGkKOrOXyi2G+DkSpALeaXmAssgQCXrYnQXx89MFjYKa3qDEG296XYiWu5nBf/VaoC
	RwHk7kTLo2npKAhnYIygaspLBNu6lbcqLnKP9fMQ33N1ms1FFnzCRxEkxC8M6o/RZPtXavkFZK8
	fJqHhUTJC0SGe5NdmTBiMLU37WwHeGR4+sUUm+MseOiVfmWM9/ViaXdTZs8k7uQGvbVcU+0uDps
	oJa0Ekz0MCMOI6JgvLf4KigXb0qZeFY/4k+N3bBmYcwFk3rVnsnuhCZjw6KnsHUULTMi+liH8wA
	Z5b7Xn3/YHIqYR8W7UmhcftCpk9vYpA6puTsAuloa/bK0bDOPdUvml1i/xZHUYxYsBZGes5xYAy
	E8V4R1jnIiVY3HZocNL3TX7ZZb47jyuC+vYBa1RMFfq3FhFNZa/hqibLFB//wifns56ZSeKc1qZ
	R/az9IbNQtRRm4/zIAXBLi52kG89gqZfWT/SPl2FlHyUsynRIfzX
X-Received: by 2002:a17:903:240c:b0:2f0:3382:cf52 with SMTP id d9443c01a7336-2f03f156ddemr67246795ad.15.1795330690792;
        Sat, 21 Nov 2026 22:58:10 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm34287345ad.58.2026.11.21.22.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:58:10 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] MAINTAINERS: Add HiSilicon STB drivers entry
Date: Sun, 22 Nov 2026 14:55:23 +0800
Message-ID: <20261122065549.3265519-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122065549.3265519-1-mmyangfl@gmail.com>
References: <20261122065549.3265519-1-mmyangfl@gmail.com>
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

Add a MAINTAINERS entry for the HiSilicon STB platform drivers, covering
the histb-wdt watchdog driver and the existing histb-rng hardware RNG
driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ac5128b756e..f248a04b925c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12187,6 +12187,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 F:	drivers/mfd/hi6421-spmi-pmic.c
 
+HISILICON STB DRIVERS
+M:	David Yang <mmyangfl@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
+F:	drivers/char/hw_random/histb-rng.c
+F:	drivers/watchdog/histb_wdt.c
+
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Weili Qian <qianweili@huawei.com>
 S:	Maintained
-- 
2.53.0

