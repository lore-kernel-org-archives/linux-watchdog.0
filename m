Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB03F7AAC
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Mar 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352954; cv=none; b=b7VPf6z7LZk5v/UoEMvOH1GsisI3/AeA0JBvKbN6/rA2X8hJuiaPErEK7C/v9hUOENdcAu2VdTzjG7Aat+NSknDfnL24xqNYRLQnK1m+5ZQQo88nMci3U3y15t+jXwcG6XqVQnxCMsZ2uEVV8pNvtccvUX42ZfmAyG2ePvVvcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352954; c=relaxed/simple;
	bh=cnlyyAE0hKJh44VrBo3wLRg1/bJ/z8lV9SX/IznzyPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUa044zd+qyJLEzGckvQSRnrZH7BDxs07avymclZmNR0GJL1iRSU42xnbsFRh6BfbG5hXpIbzpdFzjq6Zg9lIn4BBw4H1ciaGDejQrTIe7H8c3/Q9QKmquz0YS/347YmLJI4zLWgY8S/CorBPxcroHvoNVc9rn4hQT1GmRM0Z14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EH60VlCb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EH60VlCb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4BAB81A2FC5;
	Tue, 24 Mar 2026 11:49:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2161B6011D;
	Tue, 24 Mar 2026 11:49:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71CC810451126;
	Tue, 24 Mar 2026 12:49:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774352948; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+ZO+ja/wZQnveqYe42ml5vWLXL8y3cUnpi0huNlQkmM=;
	b=EH60VlCb7Awj/fLHNoFZlhIL0+MOuFLtQ7ZCiRx0A2THUYQnAmK978bwzQF3GDLLFmB+5G
	b5H2zbyMgWQynXXLN4slzgAiXUYWYb5cEHmTRz3vGMaJVp/JVq0VKu3ZZlgBRzDjx1W1oa
	0srkEPZgDe9FuiJmGY2E69Faevidnj1zyTTtqxN+H1Cdwg6wgfU7u/HpFAmTVhkpJEVDTQ
	zm427idnbTPjDE6I3hIQ5RpBrY0kjzmGq0sviFl48HskA7Qk9k5L2WgZwlp8gNc8p9Hizr
	LWuCBwmh7qi0c5FvPJxy+XvtT5J+U5MmmJk3Dyp0CG/PB0ZfrcP6q6R7i4WQwQ==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH v3 2/2] watchdog: rzn1: Use dev_err_probe()
Date: Tue, 24 Mar 2026 12:48:45 +0100
Message-ID: <20260324114849.242755-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324114849.242755-1-herve.codina@bootlin.com>
References: <20260324114849.242755-1-herve.codina@bootlin.com>
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
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/rzn1_wdt.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
index b7034eac91d0..48d5afef62a5 100644
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
+		return dev_err_probe(dev, -EINVAL, "failed to get the clock rate\n");
 
 	wdt->clk_rate_khz = clk_rate / 1000;
 	wdt->wdtdev.info = &rzn1_wdt_info;
-- 
2.53.0

