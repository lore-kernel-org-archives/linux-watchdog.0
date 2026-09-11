Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67429CE9
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125482; cv=none; b=ZVbG+timze7HkzgV64Fsf0/AsD/ctKXTvOrurFScd590SMdUtvYJx6w82DuSOxeJoodLhjF4v+L0VKfhSviNtIYPcDcFcmOCVx4fPhUnntXwM5Ldzub/hzBdwKTd0EbQQyT6jFa1FZjiz2N/f4I8VKbjNM8Domcok5oGuK25xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125482; c=relaxed/simple;
	bh=KyfbDt9czf3+HI+uydLbr5vC6KLYpGEYKOcYxmAcr6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCjAvXsUtc/gHGeJK6JtsocpzbBQjnHPR06NHYyZLlKJmcqp2wprtpBhswytfKU77JJHpsTmD0NG4pw0KRJABxUWDB1chvkaDVKwdOPuzu2KbaWg/48V/jmYeey57ZcJ+x8k6e8fMsc9QNDoZAdefBELeRAqdT8HvAkU0KuUOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0X4IQvx; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0X4IQvx"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso223722f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125465; x=1789730265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sS5eU6IT9I1jv6dzRX1Sx143P1BXIUwdXxgwRP/Lqvw=;
        b=r0X4IQvxCbzOW7exDOnA1OsWQcSLxZqsqsHwW8aGQ0DzV60jQb0CzskZwoaPJguVa0
         hKVjlfgoAWRArRODmBt8vP3foAen9RgAcH07orqHTl6tWRqqI8ufudSpZ7X1Kt4If48b
         aHOJcckHTlOw9m6nlnjTR2mdA0GxXSq/Jgs0/UgPmdTDjdXU1FANzTWvglQ/Wy9mXBlB
         M2cXIBX/XTiChYZBmp8k2GXY2imu0mRMqJyuUqb8Fl8dBftQmvBEzpHD1idaGZtWjAKt
         K0gsZSzmPtET6G/QdpuCEKVjDZRjfII8JUdcO8oeXG+A28h6fb+WMdzRJklL+dTG7HNN
         wPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125465; x=1789730265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sS5eU6IT9I1jv6dzRX1Sx143P1BXIUwdXxgwRP/Lqvw=;
        b=Mkul5GDrX3iZ1IHLFXvAk2FDeWqo1aeYD69cXr6Pjy8qYMBP4MuPC+vTIeqkgCrkVN
         L4K4zowCTX1hF0MFzHUvPYzKAppPsDSZpDOBBBqaE08602pEd6bh68YsYC6VrbE//num
         9CZWEw4aHzglWZ+dZ6FRb+IPSPGd+UK2s7Nnu4zlIgAwnb9ontxQqN+psfyycTU5Xusg
         rcoxk5oL9z97yLZGJbRJCko04dcLv6DoIjVk0w/YVmpVERNCliELvHLMK1e0YsLxFgW4
         a4E1+2zSIEXQgzIhlG9vPayBL4hBMVNbhTV6I4KfF/Z84tLWXwfESMNcZl68QihVRqOG
         6+UQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3cXM0OOEcpUaOWJuq8gcVo28dTv7o79nni5pMD3MmES7gIqL9KawXxv3vshVJB8jBT8cUz9Fh+uUD1mgCiA==@vger.kernel.org
X-Gm-Message-State: AFuF++kSZ/tTyfz2lSN/Xydg3jmAFMjPYW2OGkq/W4aXAomwlm4w7VDq
	2FG1/qYFmNU56Zfvwu3e+SviqmiLozB6Xu57JiPfPN9muKZCXOA5BRVW
X-Gm-Gg: AYBFou2GHUlebvnoGyt7mNlwJ232/q18Bzvj9jNHjkZos7o4PJWqfcJRGk7IhItvp6q
	18YTa634cV5CoiIYnhGK5fzxEuQS/fF49POJBbE1McMzrEvhAeodAtq530iQPJ7m3eyROo3tTdu
	LwrbJqEkzyxPHpZQ7VNv8fU/TIccAzaz/ZG5Nu0AfCYDay+rVPuNIKVfRMRu5QIstz18egfv93x
	O9fR5x66oQTWL4qjQxEE9a0q1brw6Eto8CHFcHPR0LLciHLbtQFWzd+mQR+afhaoExyStKjSSQT
	sgjf9NoT1HQrFuJ6g8445SHLtx4Qv1x5E33XY+ZPb3SxfqExkAi50+5jx/VkjII61+bUdWLCZfR
	5qR1rPn+ex8KpCoKomlLTly5dYVF+L2tvtLLrnXhfwudt/M4Ova4D1WtjCMi6QHGl11WL2BzFB3
	qi+pLXdi7KrquuP/Nw/bZK7unHKJP+s2s1xNdCqPyWQqH+a98xV3Der5khY7FFEhYNuMFBaqM/M
	h5BcIuSc/IZhlZNUIzsfAUo/NrcY2kRBtdurc+E5Wp++xoHvwtqpdxXWJEZyNubaOk5Q8yA3/uB
	3pckRAvGOYuMOh5+CJBi+IAoktZ/4A==
X-Received: by 2002:a05:600c:3b1f:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49e60f6955cmr48817515e9.4.1789125464885;
        Fri, 11 Sep 2026 04:17:44 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:3de1:9f21:e874:3931])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5438182f8f.5.2026.09.11.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:17:44 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 1/8] watchdog: rzv2h: Drop enabling clocks in the restart handler
Date: Fri, 11 Sep 2026 12:17:24 +0100
Message-ID: <20260911111731.3404308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The watchdog restart handler runs from do_kernel_restart() with
interrupts disabled and after smp_send_stop() has halted the other CPUs.
Calling clk_enable() from the !watchdog_active() path takes the clock
framework's global enable_lock. If a stopped CPU held this lock, the
CPU executing the restart handler can spin indefinitely and prevent the
watchdog from resetting the system.

Keep pclk and oscclk enabled for the lifetime of the watchdog device by
using devm_clk_get_enabled() and devm_clk_get_optional_enabled().
Remove the conditional clock enable/disable operations from the restart
handler so it does not acquire any clock framework locks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/watchdog/rzv2h_wdt.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 3b6abb66a1da..bd86da71b0eb 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -191,22 +191,9 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 	int ret;
 
 	if (!watchdog_active(wdev)) {
-		ret = clk_enable(priv->pclk);
-		if (ret)
-			return ret;
-
-		ret = clk_enable(priv->oscclk);
-		if (ret) {
-			clk_disable(priv->pclk);
-			return ret;
-		}
-
 		ret = reset_control_deassert(priv->rstc);
-		if (ret) {
-			clk_disable(priv->oscclk);
-			clk_disable(priv->pclk);
+		if (ret)
 			return ret;
-		}
 	} else {
 		/*
 		 * Writing to the WDT Control Register (WDTCR) or WDT Reset
@@ -290,11 +277,11 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->pclk = devm_clk_get_prepared(dev, "pclk");
+	priv->pclk = devm_clk_get_enabled(dev, "pclk");
 	if (IS_ERR(priv->pclk))
 		return dev_err_probe(dev, PTR_ERR(priv->pclk), "Failed to get pclk\n");
 
-	priv->oscclk = devm_clk_get_optional_prepared(dev, "oscclk");
+	priv->oscclk = devm_clk_get_optional_enabled(dev, "oscclk");
 	if (IS_ERR(priv->oscclk))
 		return dev_err_probe(dev, PTR_ERR(priv->oscclk), "Failed to get oscclk\n");
 
-- 
2.55.0

