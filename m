Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADBA318ED2
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008314; cv=none; b=FvV+6oNS/nJQqFzJOchFOHk0+xkKHn9a8tw5EZjmO+8IEnCtHQnQOw4N2Olc7rcVNyrXLqttLf/aCMU3lmAKMuMf9wWNRN/JHE6vXf7hK3lAOnZqZY9MD76owMqOgfYyA8KnqKcPTSbfLPOLANBnyE007VJBJQptDOfJU/H9z2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008314; c=relaxed/simple;
	bh=nDJAbJCFuUB7OnJXjKjnKvBkXflAc5qn8SUxoJPyYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwKuxJBbjLkASs0Hv8NvQ3FrKmi88NpJ/f1aZj/3peY64QqovGRBPhEofgO4h9+ldHxTOBzojCkP3dfjHMrPogbqdC0W9RLvTveMxhVYrJVsRD1kqKVoYGb2drjwPvmK3QIyUFcauFFuLRv+YxksZVQ1h/qxSJBsx5CEEmm/FOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwEAZgGo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwEAZgGo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c733f15aso5799235e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783008312; x=1783613112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Av9KMOeHNoLZjJvkQ1HtWMUmgg+DhH4RllPkn9qKDs=;
        b=pwEAZgGo+aJVKaOMSA+BI4DL7U/LgVBrDmWkbU8sQZovQb6Ush0lx/LVr9x56ga4Xi
         +hwyMWunrGoXPa4IdXMWhrBAIIOtgN2qn4URSG/b8sJe1F/2Ux9iw6BEK1P3fzUeXLkG
         PBVVHyXPSzPAF1IZgEPn073HBqWr9EXUlm1CMsz2nTVyEfvbByE5IBD8rrMuCGsG3qCn
         TSJTDB/nVWmVoZc95CmE+8uvkvdrVpPJyVKdnHux/2WhBWe2r/dlJGTg9w/HppENtoYP
         onUPd89pIycPbe+y004uKJdJnbkTz2RcaVKaDGKfAZW8j38iOI2Flm2J677mVf6ShEH4
         IeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783008312; x=1783613112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Av9KMOeHNoLZjJvkQ1HtWMUmgg+DhH4RllPkn9qKDs=;
        b=ChX9P0K72PjRe9QurO/Bpxc1Rrt/20eMX+U93AVng78+e9u8lfqUwIHP7y5Jc8N8nX
         ullXI1BP1L8IyU5Sf9ANduk5rTZNxVLBUl6OVqTRvE4sG4xXW/9eQhfRbx1b8NS0iYuk
         vCzjk87Fvfk9drKJONJIRGUOWhDiHL+n2Ni/a9Wh3DJU1qIWxCFCNOEk+sm36q29AddE
         1cXO5USkQ6T7t/T/5wOqiFBc5xtSIdq68JTnYKLEpNV4iU5SouGZZKP0ii9vfLrY6QwM
         BnUSOg0n27b7oeceKwSjxkEGyRe21Ozbi8oZ3YZbzouxu7QU69bn9BGYdFg4ilGOoyry
         ulxQ==
X-Gm-Message-State: AOJu0YybrhF8kNOkNoZY06C9AnlXVRvOHcsAu5eP6G0vSgKv8Ddw+Bc5
	8kgBL7tt3ZfaBTfFjrwLVxv6W3qwEsIS4Fi7Au5Zk4iY9R6XfR4ij5Tf
X-Gm-Gg: AfdE7clPjyrQRWX4XQduf4o68gCGucD1A+GROuAWPN1yMe6yQrpGj+U+0WStx5ZNRsR
	OPwQiUzKDo7u3pue0X6ORE8a+i9R/0jc2h8/UxhRTTDqUpTCQenoZkRssU31sYAkypp4pHvTDib
	PO5X4kOrPyziLLSaLOySNihfFvaUjmhDsjxOeQlszWgkMNW9B0RXzUSXsV0AirFPScFcTC5Xh5x
	T6gqOdIVjEI0aJmxDLANl6X/l3ZLhFfJ6O5ZIuYp0uvX8k95ZnehpjuGc9OBQ+YRKrhnSncOPG/
	v7Wnd6tN7wdrQy3NQ1nyMyKovYPrte5AL9g9NDMA0LsAeC3goEYPDNaj5lkOtgEjFzPg58joUvI
	rOTiM2jx2oyiKL/tXautL5XP9Byu8XADXYi5jUssFWg/UeEzEJeKUZXeFVd3G4WwG9ExQicIGQt
	KNC0GktGWE+HG5IvsK/AEvaXOTUMDlKumkpGcHSJc4w+CYeM4xBYLGl8clG8TvF5SvS4cBuHDBA
	nKnW54SSxDhCtgc15jf98mjm1I=
X-Received: by 2002:a05:600c:524d:b0:493:c82d:f3fb with SMTP id 5b1f17b1804b1-493c82df4e8mr25197755e9.28.1783008311282;
        Thu, 02 Jul 2026 09:05:11 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm85444715e9.7.2026.07.02.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:05:10 -0700 (PDT)
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
Subject: [PATCH 1/3] watchdog: rzv2h: Refactor WDTDCR start/stop handling
Date: Thu,  2 Jul 2026 17:04:55 +0100
Message-ID: <20260702160457.1884345-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Refactor the WDTDCR start/stop helpers by introducing a common
rzt2h_wdt_wdtdcr_count_ctrl() function that controls the WDTSTOPCTRL
bit based on a boolean parameter.

This is in preparation for switching WDTDCR access to regmap-based
handling, where consolidating the control path simplifies the
conversion.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 3b6abb66a1da..e9545b8f5fd0 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -89,18 +89,26 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
+static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
 {
 	u32 reg = readl(priv->wdtdcr + WDTDCR);
 
-	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+	if (start)
+		reg &= ~WDTDCR_WDTSTOPCTRL;
+	else
+		reg |= WDTDCR_WDTSTOPCTRL;
+
+	writel(reg, priv->wdtdcr + WDTDCR);
 }
 
-static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
+	rzt2h_wdt_wdtdcr_count_ctrl(priv, false);
+}
 
-	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+{
+	rzt2h_wdt_wdtdcr_count_ctrl(priv, true);
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
-- 
2.54.0

