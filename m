Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DC49892D
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160078; cv=none; b=spI5lSxzST5AAVvk5G1V6yINDkBHV4mNVjg9Cxq4UezepHcXNNH6eRkuV8bIaFw4dkJcdOerEw5UVULgFavS1+awElTRXVm3SZtvcI8vwtn++PadQtyqzYPnkNdlWsLIl0r+j9AZw9vovBBdWlpNqOiKPmEzXHZXJPQoaSls3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160078; c=relaxed/simple;
	bh=zrebjrYHLxlkcLbOWhLADCVn448m5K5z0EZUcGG0+0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0NTXOD5LnNWPabdPVx+b01241ILZeJ3HMCGjQ5Ys6K1R19MLLYdsMXMLwEnhHa3VlidKMfiJRJ877QM/L0WgR2ZUgPhfJLlFdNe4GlVel8b1ZNCDeC5te4AdPRIpEh+FYMCVHEakao6zKc5tEMS59u0nGQfu3ejqAaXeFZGOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj9mLHOT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj9mLHOT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so4389215e9.1
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160061; x=1790764861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ix3tO+d9OZKaRLRpGMWc7HAXEvurMPfFvhpnn2QHvZs=;
        b=Bj9mLHOTsWcq1mlqYhEDwsulSgdRbgCRu8/8iaA1wliFOoVt2mziwustNaO0W9CNdc
         UyjvOofDNHi2b31xFLrYTe5wraaZnpUayJRwdGFZeuDt1b6hSYlr+vNkBTPoHXbMqZsh
         8HR4s9eLKSsnELfJvPz2/AzX7vEv8o0/IyKHI/p5xqaUzKYNb/RE5Gkv29cnMafZBhf7
         S2jAZZPFa5JKEmo8d0VAq9WkgvkBJncpMCZD0oJfcpKvuW3MuoHkGLUACTc4GSS4y+BA
         ylzynqK36LXH5o61vadQtu3LVhfpKdqDCXY20WQU7JckqAxIijZCEVdnhEpZpekSOpzm
         fc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160061; x=1790764861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ix3tO+d9OZKaRLRpGMWc7HAXEvurMPfFvhpnn2QHvZs=;
        b=xGApX+dcrYVZnlvGIi3JOzIjVxTSWb0BVnq8Fh/kf+ByE0lbZK40fIFu2yFyYiRN97
         VM2bp9R/x32ViMbkUovckcB9GMrgiK+JHIR/yTNej+FTS58gyk9D45MOfIK7PfM1uwHi
         K0OvdPINCR7WjiAsTT49m5lD/xUN7kkOR8dgdK5G+ml8MLZEod6JlCxcCqsHMt0EthKM
         xAEPBY+CgQkq69mkUD4tBAwZzHYPRJ6PipuGTM3yyh0xmcvJMPY1wVFhRNiwhrreh0lX
         TSZxQ6+I954a1plaNrkKJ9IiLcyOLdg2jcpak3UYrQ2qBahCFCB+rtO+vXCmHXsSO6oA
         rs6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTUsun4HhxbzSeJcL4yBV0CJSZBicoPxpW/sslPSKNjVVn6julnFK2vcxix35uFlDNG2rV2GKDxm2X5OaC8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mA1VDa5KEo6lOiNZKGGUJ9koKarZvnto58JLYyPvdjpnasG7jF
	ZW7ALVdRntvKXMe+8saExouMTpR1s+9VmF84b7KidX7fCLX7kVHLFeRt
X-Gm-Gg: AYBFou3ZeXQpXOZj+FKhSFFD8XiEqB/JoPvdqx75Ax6clTF6H7ppZOYTkp7G8q1EIgD
	ZdB/zYp+iamtc98k1rVEvPwCOsL5KTwanVw2JG2ajLe6qoN/Fv+g+0nkbCEU3rWRf8SyHfpQML6
	Rc4f43YKMIfr6s04yH1oUAm/tMNW9JTfaT9FN6Xmgro4jrJ7pcUdqNc9Qb+gsgYROtEuX8cXaT3
	o6xElCkwfa4ajr6XC22eQjMKW7rdBfg5rpunGml17aA/HEVtSN25GYjic2RU1k5HXQ6i5u6gYGq
	cahEp7qsXUUKk+zHPOrOtupFBGnYyLOcZre1B2MbX1D+3Q+82SvGaFRYeX+4W71d2lLvCBklC6+
	CCNSq/KyAze3UfBr/MhOa7Gh4vU3vYa0ZdwgsUavdNGhNjm7QWIyvVN+5tvKbasQXulZvUaHqZI
	R6KqnA/eJVAbt5EhR5dauIKqvqiJi0cyS1Z6ibfeHeQfmzswKeGBSYQ/c4TVk4dtdttO/pX538F
	jNY7ti9RhgnuSI/4ZHCIR58vrVIYxluFHPLRIesS5LUyqE+uiO6gTga5QtwcAV3ASVzGceUID0e
	0HXeo18+
X-Received: by 2002:a05:600c:1396:b0:49d:93c:d903 with SMTP id 5b1f17b1804b1-49fdf135413mr28275625e9.20.1790160060973;
        Wed, 23 Sep 2026 03:41:00 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:885e:6ade:cc5e:a35e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm65170415e9.15.2026.09.23.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:41:00 -0700 (PDT)
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
Subject: [PATCH v6 2/8] watchdog: rzv2h: Drop enabling clocks in the restart handler
Date: Wed, 23 Sep 2026 11:40:48 +0100
Message-ID: <20260923104054.3324830-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v5->v6:
- No change

v4->v5:
- New patch
---
 drivers/watchdog/rzv2h_wdt.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 057b890de0b0..ee1649e0edae 100644
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
@@ -291,11 +278,11 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
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

