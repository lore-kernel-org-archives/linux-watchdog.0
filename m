Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F4405C38
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880250; cv=none; b=WC/OtPbyiW6csTlq5j5VLYHwkKp0o6lQcqqbLCKOoApwhy2ABSmZ6bFwt8h6Hjt958Ayf2flcx/IJTxetWAUNQPqmgBOycl7pfhVkzt7M1L42NwJxMzSZUCgePIjLObpVPH5d/m/aA2cw08cWHhS7OUu6sESo8MzDw6v2mWnDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880250; c=relaxed/simple;
	bh=8/k4LvGWtXqJP3ap6ZbatxYu921z0MHKk3ULGKMn3p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVMurgfNfqpmfiIKuW2akBi8Rmw4WazJtQxeet5Gdi1WkGuwUGQv8RaOVn/GCjIMGNMmEWX00HDKq2tXiagYiw8Qv1TlnncNF05ZPl8MZRA4/T55MA5rS7cLuDkg1rZOzkIcKuFwMs1ez0poeaagQBTQJGRcsPBpVAhkrZ/MyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=zCYNGX0/; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="zCYNGX0/"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 97DB578079A;
	Fri, 15 May 2026 23:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778880247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eu1Fda1DifT6lzqabyPPE+gkFEX8x6nvYvh9ThXMs0=;
	b=zCYNGX0/9NeNt1YLpRaS7AtL2Ny3OmC8kE0vsQRnczVnWn9SqNTZG9MJtsiHqetFeeVsmA
	rPKWyS34hhL+LuAJzvNVVfonYqoFFtyAMfbQvsdh84XWURS2cuZYUxF68jVA/ZmolniKka
	cbDUTstkdpq+od9NXJDbEtA3a1cr0b+RZHhYIqh4k7ghWJaMZ+DXyN0dUQG3tgh8aMcbkz
	t9fVLiz2mQ6GtsDwkQ6JFugyuT+zsHlhJyUQKum6S92Jz04QhN0SqvbuEZE7GlIzi75rbX
	vgSNiaZgwEQNnMsvOSSDgwETHNJFHFwbozuq+2epexly1rGcDWIF8T/wkClKGg==
From: Sander Vanheule <sander@svanheule.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rustam Adilov <adilov@disroot.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 2/2] watchdog: realtek-otto: enable clock before using I/O
Date: Fri, 15 May 2026 23:23:51 +0200
Message-ID: <20260515212351.752054-3-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515212351.752054-1-sander@svanheule.net>
References: <20260515212351.752054-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the watchdog is normally on the same bus as the UART peripheral, the
bootloader will have ensured the bus' clock is up and running before the
watchdog driver is probed. Nevertheless, let's do things the right way
and enable the watchdog's clock before performing I/O accesses.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/watchdog/realtek_otto_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 1495e8a8cbb5..01b3ef89bacf 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -296,15 +296,15 @@ static int otto_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
+	ret = otto_wdt_probe_clk(ctrl);
+	if (ret)
+		return ret;
+
 	/* Clear any old interrupts and reset initial state */
 	iowrite32(OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2,
 			ctrl->base + OTTO_WDT_REG_INTR);
 	iowrite32(OTTO_WDT_CTRL_DEFAULT, ctrl->base + OTTO_WDT_REG_CTRL);
 
-	ret = otto_wdt_probe_clk(ctrl);
-	if (ret)
-		return ret;
-
 	ctrl->irq_phase1 = platform_get_irq_byname(pdev, "phase1");
 	if (ctrl->irq_phase1 < 0)
 		return ctrl->irq_phase1;
-- 
2.54.0

