Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4953D47C0
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163996; cv=none; b=tflTwrwLOj5l0C8OPZso4HHFRkYZQ/pMx80HhHKz4EL+YYRlb8iWDMDxOOGoUGESAQNyVWqkJb3//BTAh4KQKoULJ7xYLga2MyMwSkALbxf1agSkBqvwb48apLJbFL9LxHnZ8501Bs+7ZABdZsVxibXfSzvWIwTbEeqk+352U1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163996; c=relaxed/simple;
	bh=Qt3ZDT/2XZ2Gk5tU2c5HYGzHYX+19Rtxn+0VOyRn2mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elEfJdihSQ9s7uuTXahEke6vI1e1N5euo5VFVk8KzJbAKgxyHnhPyuxFOqhyR1oCrG9Ljvz8k39KUkyT2VzILvzE6GlOPg4oQJPY8QMMFqZ6Rh8Pu5KbJayTtOP4Sj4bQYFzknFoLV8W6gkL23kgJw/t+qq8U9Y7yoXJf0xpcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JHHCNXwP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JHHCNXwP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 511831A2E01;
	Tue, 10 Mar 2026 17:33:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2799E60002;
	Tue, 10 Mar 2026 17:33:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C72A71036983C;
	Tue, 10 Mar 2026 18:33:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773163992; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMW5EU8HgoMFqKlp2Z2bzKPzG2PRYsuDMfOvCVxf+io=;
	b=JHHCNXwPvRVQqFET52VaxN6WmFGZh2Tfg/X0rkNp9sF3d96OMxg6XSLClEKp3e5Goeklrb
	XhD18V430qhJAOJk4Ms5+zjme3zyl4wNFl5UiKr91YhcwZT8dlVWSmEaX24t+LKBO4euXM
	JaheL5MoCEAN6cwaPgV2DY9xV1repbq6eXLv95zAElwmkxKiHxO5giLwJds1VPZkg+wJvO
	Iiv2jZBYAaqywOdyjmuScscQ9SUlBjZXRYn7KF0yaZbapJY3c5kTIUG6lBCmNXf70dHZXy
	ICQnVeUpEqmhbIMU4xjgApjawK96MFi/dN1XGDkCha3TYRG6KkdE9oNAKkz/zA==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH 2/5] watchdog: rzn1: Use dev_err_probe()
Date: Tue, 10 Mar 2026 18:32:43 +0100
Message-ID: <20260310173249.161354-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310173249.161354-1-herve.codina@bootlin.com>
References: <20260310173249.161354-1-herve.codina@bootlin.com>
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

