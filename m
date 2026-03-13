Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8F388365;
	Fri, 13 Mar 2026 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393887; cv=none; b=ogfi0mB8OV/92akfhuycnUmCVa1ciIvSvHG+9zpth7/+I3DaEwNrG9gPqEUptt0lOQ+4GDOrzXYZY64iBfcGOTH+ZCj1gYSILZ4TZ0HAHxS7OCn0G2tGLAXZb6XprXM32EQO1XtEker0vlTaL9anw4zeBtR75GpZbNa9ILRNaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393887; c=relaxed/simple;
	bh=r4MRcQQ5fLzSlLSMWtmjAFlFGJfP1WaE9lWedeWl40E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCC4Mr0rXuBo4s8jU4N+e+HI2SX8cUGSsJ7vPw/oF8ZegAcZaohSy5ENvxf+MLGaTBiQj+NTOCAhTPhRED7sjnPVOq4HwCUh6RRnxBYhYaBWQgugkAbdleqJvin+VNMunQa9u6T29xlhLS2CkxCGTWHMjGREpPueSdxere3m+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qHi0jlhX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qHi0jlhX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D2765C40435;
	Fri, 13 Mar 2026 09:25:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9B3F60027;
	Fri, 13 Mar 2026 09:24:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA4FC10369E63;
	Fri, 13 Mar 2026 10:24:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773393884; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2m01zqv2yjjJhgTpMDzF0wiCkkyg/bS6uB02evTAf9A=;
	b=qHi0jlhXeqoBjKFwCYdZp1XsCDnEhcQreVcyZ5vuXIIZGCb8MXzoq9oQh61vrZS1xKvpms
	T5xNKLYRN2zJZTfcMW1vFZ1a67TVVhD464n3lUdPHdZXtv1hd9gwPHqKvZ1k3ACMHmmMoa
	ISz9ULzXEGJuhIKHTzoXkHalO84Onmult9UKK4C5fLAKT1ypblvHUBxhzjTKGKymgkms+y
	oaBuUNZCywCGPLCp8MFtySEYQBHOyODwgxGlXyos6ZMfhlhCqvdzAG7f07zIMqcu2QWG16
	zwggGiiAU0Uif+NE4l3Ix79/b6Ey9+1u+0cXh0Up7doO+sfgCJCM9Dzr6Gsn1Q==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH v2 3/3] clk: renesas: r9a06g032: Enable watchdog reset sources
Date: Fri, 13 Mar 2026 10:24:16 +0100
Message-ID: <20260313092417.294356-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313092417.294356-1-herve.codina@bootlin.com>
References: <20260313092417.294356-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The watchdog timeout is signaled using an interrupt and, on this
interrupt, a software initiated reset is performed.

This software initiated reset performs, in the end, a hardware system
reset using SWRST_REQ of RSTCTRL register.

The watchdog itself is able to control directly the hardware system
reset without any operation done by the interrupt handler. This feature
allows the watchdog to not depend on the software to reset the system
when a watchdog timeout occurs.

Indeed, when the watchdog timeout occurs, the watchdog requests a system
reset using its own hardware dedicated line but this reset source is
disabled at the reset controller level.

To benefit of this feature and be robust against software issues, enable
watchdogs reset sources.

Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 7407a4183a6c..a0734182d112 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -1342,8 +1342,9 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	/* Clear potentially pending resets */
 	writel(R9A06G032_SYSCTRL_WDA7RST_0 | R9A06G032_SYSCTRL_WDA7RST_1,
 	       clocks->reg + R9A06G032_SYSCTRL_RSTCTRL);
-	/* Allow software reset */
-	writel(R9A06G032_SYSCTRL_SWRST | R9A06G032_SYSCTRL_RSTEN_MRESET_EN,
+	/* Allow software reset and watchdog resets */
+	writel(R9A06G032_SYSCTRL_SWRST | R9A06G032_SYSCTRL_RSTEN_MRESET_EN |
+	       R9A06G032_SYSCTRL_WDA7RST_0 | R9A06G032_SYSCTRL_WDA7RST_1,
 	       clocks->reg + R9A06G032_SYSCTRL_RSTEN);
 
 	error = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
-- 
2.53.0

