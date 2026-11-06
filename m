Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957510;
	b=TMORBsL3jUIB57roGVu8hxAL09gtlmYvB+UJIaLbuL1X2qpOlgc1PjmCn26qXGDjx1RJ
	 SW3V8K1SBnaiXCccm3wJf9ziGp7XDOGmJRb2cPdjzmI6X7i3vtr3FYj8gv5PLvcL1CGU6
	 U37jvbMEKkfrCPQqoh2lYj3gLDlKvmMD8+1Jk+Jc81p4L7V6XK9zkDV5pGUEHUNGmf9Zu
	 yqipVw+m5XEc/kHEXgNegTODlZzubUI/RsbTqIbd4CVgfnqeJ46vWw0EU1CY06AdEWzYG
	 0BE9rOShNVG1xdqpUux6b+5qkCjwHZjMpX3T0XxQMCm3q0u57davLZ/yGgfTWijyByg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957510;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=/f+A9Mb+Dr9AA8h+IGk0mm9hM1KIlwRpJwCcjc3IH3E=;
	b=Z2q5/YzGviVZA/biToxcyPYDcO8aC0dLUAMlYRSwn5F8PPGv5xh8V13uYp0jCvgvRuTI
	 fAwY37TeYMO5s1gZdicd/uKMcT8frV9dfGItgz8hth4O910EXwANf9xZhcM/bb72RWXVu
	 vzgFkIYtwpHaK/8sTxi6P9+4iv00vCtuPTYIL2miYqYqKCuXFH6v19L2sN6Wt/qqxfH9l
	 Cv8itEs1ejV2tSYtxH0PA8LcfHlzcIwLiprfubq8can0FuTkIJOj0oS+eko5zmINMEerk
	 NdZKAQiaD6cjOpbaP0LOMBw0l1dMair4bYMtOVmNQt6jmdCdE2ezfpAKDHur+GUUK0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6vvRrWD;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DD606D81E
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 09:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C4DD606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6vvRrWD
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D8754C69166;
	Fri,  6 Nov 2026 09:31:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A1B75FFBC;
	Fri,  6 Nov 2026 09:31:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF23910329258;
	Fri,  6 Nov 2026 10:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/f+A9Mb+Dr9AA8h+IGk0mm9hM1KIlwRpJwCcjc3IH3E=;
	b=X6vvRrWDCBaEUkbIvoytSa35YPFuDIC8UF+uAHCLPrAdeiYysSLWa9DpcOc1UbsOI3f6xE
	nAIdK7YzElV0hpqezo21aqyGgqH9RIy3DuWBwILOnYdjnpoke1PZ1wfSukm657h2Y7irik
	A3EGcqQgODDTbQGvejpsfVNeIFuV9wkUEvZiCKa+Lf5r8LCfuDPM/nmdtyRsmTID9HAg8l
	JJipIhMiUR1xrSgQvdIrn36NfvOk9/5OG9WXS1+WUwDyoT0prQegBOe3htG9kenjvf80RD
	5gxrGzgN6wQM6Z0hm9Fab/I7GRxv7ybOWpN0JO0K2LCa/nabBakNbECFRAfong==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:07 +0100
Subject: [PATCH 10/25] dt-bindings: mmc: snps,dwcmshc-sdhci: add Metanoia
 MT2824
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-10-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Metanoia MT2824 integrates the Synopsys DesignWare Mobile Storage
Host Controller for eMMC/SD. Add its compatible string.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index cd823a3ef213..0ebd0f9c1d62 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -26,6 +26,7 @@ properties:
           - canaan,k230-emmc
           - canaan,k230-sdio
           - hpe,gsc-dwcmshc
+          - metanoia,mt2824-dwcmshc
           - rockchip,rk3568-dwcmshc
           - rockchip,rk3588-dwcmshc
           - snps,dwcmshc-sdhci

-- 
2.56.0

