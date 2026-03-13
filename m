Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B9377021
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393885; cv=none; b=R0s14U/tHqMUezmz4bEKwbLU4fFnlZZ6O+L0c6LcbdE/8ENVglVFd/A3zZBpJGz8qLbRDitGI1EtNuc3Sls6bwk3Wq0LWFvprb2urDN3yXV+Pi2FjM+GIdp3OKl7ktb2x6F84Es6TQxHHoY64Je+hswcTqXGsRroD7ohaEQEY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393885; c=relaxed/simple;
	bh=Qt3ZDT/2XZ2Gk5tU2c5HYGzHYX+19Rtxn+0VOyRn2mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppGKQNfrCtjJoK85NdBB9S29g6GeNUdGTHtYEiMPFpij95HKntcvOvLNknp1YOFuoyPWKxyww4xJAp/9Ko6EflEaebsiUX1mdgR4iLr8Zrnjq/gPIU1I806aBKKWz1WEjiEYP8iR07A2ch0juIGJoGAgoSy92xbsARlFNIn7CaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T3u4VVtA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T3u4VVtA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4C306C40436;
	Fri, 13 Mar 2026 09:25:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3229860027;
	Fri, 13 Mar 2026 09:24:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92EA810368C86;
	Fri, 13 Mar 2026 10:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773393882; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMW5EU8HgoMFqKlp2Z2bzKPzG2PRYsuDMfOvCVxf+io=;
	b=T3u4VVtAIACiXGv55nf2loYkBr9Bl2Vfa1xH3gDKoTOROgTDvG8E2AHUIBVENv1PKkY4aP
	gJT/P9Pd/0nFy9kUdaiTDzBkWtGG8NH2XdeQbXD2mHFuIDH0AeD03y5ktrjJ/bfcW5lgH/
	NTin9T9q0TSjTOVYwGi4A4+scAHJmKBL4dkwfWz6HXOZxKNkASqqEQZNYmH3Ue0I+OBKCK
	smZMF/yzgrGaI2e+l3ReI4Wm2yCE6JJ26xq+58FHdjYbyV4ATzrNq5kcCBkiukooxm7DiO
	zqf78p79ql/A0cKXmKb+3HnApFCEYx1FBqT4OaosKNe8hNIEFaD3MC+sCFNkZA==
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
Subject: [PATCH v2 2/3] watchdog: rzn1: Use dev_err_probe()
Date: Fri, 13 Mar 2026 10:24:15 +0100
Message-ID: <20260313092417.294356-3-herve.codina@bootlin.com>
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

In the probe() function the following pattern is present several times:
	if (err) {
		dev_err(dev, ...);
		return err;
	}

Replace them by dev_err_probe() calls.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 drivers/watchdog/rzn1_wdt.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
index b7034eac91d0..98978b5cc5b4 100644
--- a/drivers/watchdog/rzn1_wdt.c
+++ b/drivers/watchdog/rzn1_wdt.c
@@ -122,22 +122,16 @@ static int rzn1_wdt_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
 			       np->name, wdt);
-	if (ret) {
-		dev_err(dev, "failed to request irq %d\n", irq);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq %d\n", irq);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get the clock\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get the clock\n");
 
 	clk_rate = clk_get_rate(clk);
-	if (!clk_rate) {
-		dev_err(dev, "failed to get the clock rate\n");
-		return -EINVAL;
-	}
+	if (!clk_rate)
+		return dev_err_probe(dev, -EINVAL, "failed to get the clock\n");
 
 	wdt->clk_rate_khz = clk_rate / 1000;
 	wdt->wdtdev.info = &rzn1_wdt_info;
-- 
2.53.0

