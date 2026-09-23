Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D64A0121
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160081; cv=none; b=eDYyiqkwUPe2UHbXHQr8Y/uIV5SXTGceXnetnC8dxTGIMOy4fTBIEnhGsCN/ox1XG36v2BHUXICP4jfczeKO9kqiHoHHtUZBWNm1QlfiGn8XASiPGS7W+05McK/zyr3ZP3ktpnb/SizONkeWfZlgqwfC4DZIYukD2KSM6sr40u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160081; c=relaxed/simple;
	bh=3FpZ2LQPJEraDRB+xfM2+yX1c/xN43QUsBqOJ6MBVec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITut9LzFUYoBS47hOZSM7CaD19lxGOaTGaXQwEqdPWu9nsl0GsIZiDkAI7Gp09rnulUBVg1u4Ia4eOzSBasLXD2r5YRyxGPwZg6K1qRZfqZvIubhfeySXqu4jUhqn1btctrGhGGfmL5n6nrL2Hgdv3rdTqkN9jsF8fCCe8kXT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTjAnPwz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTjAnPwz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so4005135e9.0
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160062; x=1790764862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uy1/P3kdVU6Z6TgBEn/xi8p7dGk/j3Q9N42vq6jL5bA=;
        b=kTjAnPwz1Kc5kesTwhtOES+DFBF1BnpH065abtkiGjK6nCcj+w1P0ppyICpgFexZVY
         Odg8dcA6Ga/BsRmIbalJMhroOYhB8bpa3ux4EGHclq3yG/lyXlhWA20qOpy61ii5fFX6
         106BvpkqmlnfW3wWuDHtjgtjD5t6Np9lRvxCg2hc3VCREdSrI2+JvtY4Q8m6f28ZwQe7
         ZxQLKLmJ3lTXfR4BUu5Xlo7hdXDavFzhtMhtofvHq8WTRFEotG6cB+xSSFO7MNwrcn5N
         ACMiZEnmD6zLh+4DUWQcJVnT6Ie1XCwfcf+DKEDd+2cztOxF0/Yiqj9spdblCrzDV589
         ysfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160062; x=1790764862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uy1/P3kdVU6Z6TgBEn/xi8p7dGk/j3Q9N42vq6jL5bA=;
        b=sKWnzTEL5H+WJr5iPD1inSFLLck/aDjnn/E9SJaL8cBibaW4nCu5l7r++4HxN40XT4
         Yagbj7vGIgu5txj9IF4hO80a9hBIEXgMzkz/956+H/bsAgmMXuLQK6kO7Hw0g+/cehzE
         Pc6kEUC392kUYIURP7oAkypmg9hMfdpBew3IHa1RzFrkEM0HlTADv1T+JHjUezj8i0Hh
         Y4FOHZccHod9HGgj0o8ElKt0kM0AsAC94ZzcFcLFNZEzfDuz+zcCl6KdIgXe2odWavMM
         vPLtnYstNJTYhsOEUQ5ImbN/jYvjcb6f7U1UD64Kd6uDFkEaXfKYA/atelJMwPns/UJB
         cOUw==
X-Forwarded-Encrypted: i=1; AKwUvBx/ezRWMHuD2NHygUGP80mai/2JAYLBC7FQbuDMUiScS/7Y6URD91EHKwhSDrYJPBdeJBBJSAKrEM5iSQ8hPg==@vger.kernel.org
X-Gm-Message-State: AFuF++mADpxJFPfoclmSRv7avRPiAYuLPxj2swITJe2QfUey1MYzMq6k
	onO92NKDhMaGI0SIv+YMZU9psAqvx9icCk2h0gTskgPvEJIXoWKow2eL
X-Gm-Gg: AYBFou0ioNn4b9aNXut/QbRRGpXubODJzkPPEDXJGzez+ycii7R5dENC54B3BNeNl0W
	/HDYLdyA6BWn9Wk5BR+YKAVjK7xrkq00C6YOGrNMRnXcQsMycD1PHTWFSlU7rWh7ALbZTpR0C7O
	FXkAse5o1oKOcWwqbycottNL7zopgUds+u381jAmgJXml3niQDCM3fpaSmqk22Vrv/wYGV8r76n
	Jx3GwoMz5D9pnQOHs/xk/QMUJDX62f1q58DxM1iJ3pQv/01UdfL0RCiUx3WUSwCf8EzPAHSpdSa
	S9gRNIZA05a10YskjuXew/EWdVoLPFROAEKEiDZUZD5B26HUSUNxE/SrDDQ+fVQNitHT6c2eT+b
	cyDMKxhC1h7Ujn+akouNVoCpXHEWkvJtK+vqMb32+6qmqq1DoqN7VbYQw1SbfCgraBlMhvRpGVv
	ZqKQvokJ4IdRBA1FtOfwZcZOB/HEo7v3LpbohKydT2r3g0cQqD3a2JlE5JqeK8pGOOvviGevesf
	GgoacLJmpNnV9hAvJ6SBggk26JivL21oOq+Rbs9Jf4lDZJX9bb9N45/HbJkTTu67VKrRgwd+Dcg
	t2YMyr9o
X-Received: by 2002:a05:600c:c16d:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49fdee0b7f2mr26577895e9.6.1790160061713;
        Wed, 23 Sep 2026 03:41:01 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:885e:6ade:cc5e:a35e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm65170415e9.15.2026.09.23.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:41:01 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 3/8] watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
Date: Wed, 23 Sep 2026 11:40:49 +0100
Message-ID: <20260923104054.3324830-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS is unused, so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v5->v6:
- No change

v4->v5:
- No change

v2->v3:
- Updated commit message to reflect the change in v3.
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index ee1649e0edae..9774fe8e441e 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -39,8 +39,6 @@
 #define WDTCR_RPSS_25		0x00
 #define WDTCR_RPSS_100		0x3000
 
-#define WDTRCR_RSTIRQS		BIT(7)
-
 #define WDTDCR_WDTSTOPCTRL	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT	60U
-- 
2.55.0

