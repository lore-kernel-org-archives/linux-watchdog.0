Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA6340408
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008316; cv=none; b=p+FyWjuka0z1j/kxf6HkFLf0qQo4dXJhVU7G0DCBz4TgEWs2jGmRZuwzNBZEGOn0A194Rycoz4fgfENnCjqxtEDcTrjt8SQeIc3dUbR5jtjhDzsVvkTjOg7zCak09/Cd77asA36eX5YTiJCO5hukTkG0cgVLv4eUYBD093Ntavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008316; c=relaxed/simple;
	bh=U1yr0rmZWpngaJ/BudO4/jmhPQiRqYk79Fyt/OQ0N5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQvnycKyhe7NeYCSIyoNIKaCBfN9qEKos21urS9TUCuBtqeJTdS4V0GlrbROI25NT+SSCJc3dBmsAyHPxquXOp09er4N4cPh3Ni24pDpshNrYfGqq4CuyDJfXLD9vQBIVvJEX5TlPcE9AI1CZYTX0n5gtvXDFFWUSKQGYBMrzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhhGXzKf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhhGXzKf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so16456525e9.2
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783008313; x=1783613113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FziwhrrBaAoQlQIWrQ6Wv9jX6eR8Vhyo1gV1RAx6nac=;
        b=dhhGXzKfSBKc5YAA7v+Yu2TuelJ+or0V76gy5/7W1MFmzLwjuZlR6AhqsrZvDeAyf/
         0MRvroTHcJsaE33RsZ/MM1k/BAf6nLmzCOx4K0zfUOZ32ZhiYLaRPzex7mBqlkqF7+Tg
         vG9A0YUxa/DRBxj+gWndwoJGhdl75l4XL1cMH91wgpMLU0mtoasY/BjFeceOfKrIj3KA
         CFgTpozDGcx1DenU9wW8dlRxH1xKNMHTSeaPSOszPAVOBsDhfTzt3WZ91yV4uVfLHULO
         64CpPjCJQZjPVLij7M5CrTqjkv+6dN1qOcxaOncVEqSFhuHd9RiA88u3/IEyg/8Lf52M
         T5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783008313; x=1783613113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FziwhrrBaAoQlQIWrQ6Wv9jX6eR8Vhyo1gV1RAx6nac=;
        b=p9UQy9GqTpvVnk2+cHOSyJBII5z/Yk4wQO5pDrDLkJtZKLjUpQuPs7TXcvHXH9HTqM
         NjvrGpoUdkC7pmQAD4CyUait+sujOHM9/8DLiWBbMAhu807ZUkt6ZPaWiQ/LceuqTc1G
         BzyxHYbg4Fa1t66eVpKh4tYJ/s/MJusxTKUQJfNBTJm0H68cxslz3l6jh2TjP2oMFqBJ
         vbaZtrPl/V99jyIcSoQyLyV823cI7cH0z1WApSCAFy3W0GLy07jX0dwRX4BR2hiu9iXq
         3zc4NmFfOeZPxlwLI6qPQtDeSLRn5ZFz4bZSU8gMwj3rt6rReq/C4SYr6RPTVjHHGh9S
         oSbQ==
X-Gm-Message-State: AOJu0Yy2KmVFSl4Sq2guYuGK83KV/Iw3CbSH4nzvRs7LuFNsR97sY1P1
	UBUsxcltmshfRzgj3Zmbm5u3v+gn7+uNYZ1pQIho68A5+CaHPKiJuXM/
X-Gm-Gg: AfdE7clix1uIq17uUGupi81QblIGjtNV+vD2qlxcjqf6cbVgsn52oJka4uCSg3QLB+e
	ZeRXQvZ6aifTQ3+bFPZacp80dxRpclUTWDbUfq09qennmWmxorDtDQ6cNrqfJ3wWx1wIG8d3VDb
	aOUd0QVCvGrVgs9aB73C4RKSPUXCrtvwyoxb/rwwhddLc4ZCDpWqVTzy6LfVJjk6gPT5BgHSpW5
	NWwnK7ik7hOzM0J8OcAuPV5EQonA2P4m/bcxM162D+kbsRqih77qf0AEYE2qhRv2/asuxJfLVrx
	ATI4jMRVTf5ER2u8UQw6M+IXP3sLGCKGZXuDfQdtpRhpMf3LzWzdtrskG9x34j32rP1e67FNyb6
	p4lToDM6+eppzvmB4q0v6Ct0uHyULS8HxEMm4DXPHmqggj8hks8nZfwZOUpTEFDa72U2mbfbNY0
	Gf27j9JZyBxw2taqzUMMOpSM9yD5MkEuFviBplaJyD3wqAQ3Ibvxd+1jQTek0WYMY2UKmiZhw33
	wM9743permJerH0CIpWBg36HeU=
X-Received: by 2002:a05:600c:c4b7:b0:493:c785:e0d7 with SMTP id 5b1f17b1804b1-493c785e283mr37402085e9.28.1783008313040;
        Thu, 02 Jul 2026 09:05:13 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm85444715e9.7.2026.07.02.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:05:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] watchdog: rzv2h: Drop WDTRCR_RSTIRQS macro
Date: Thu,  2 Jul 2026 17:04:57 +0100
Message-ID: <20260702160457.1884345-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS macro is unused so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index d0b38450cc32..e36f3d3c98ea 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -40,8 +40,6 @@
 #define WDTCR_RPSS_25		0x00
 #define WDTCR_RPSS_100		0x3000
 
-#define WDTRCR_RSTIRQS		BIT(7)
-
 #define WDTDCR_WDTSTOPCTRL	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT	60U
-- 
2.54.0

