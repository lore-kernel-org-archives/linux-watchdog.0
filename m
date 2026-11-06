Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957525;
	b=JTWYCEmkqG8WnRvhTS+y3esHeBdqR23US1O7gUxWGCOiGyqLrMmzpF76InDN7Zxr0gmW
	 DmFbOTKVrz4bJvAic+tFP2eH8PNAiN0wb+lXFFuX9gPrfngEHcBBSjX9p20TsooVf+mdV
	 6BQcXCw8CgjUCyeOCnBWPDygW4yFqGyRuyqdebK6a7igCv1q9h/Ipt369f0YHmoymD72h
	 BbIh56JTvi28652fClLLMbyI3KwtJtZVu/J/9gHC38afsrdmhRNbQXEi741/fIB9HA0vp
	 R+oVeJ/tOVwrIkZvrcCG2U0RT5qs9J8SlhaaMAg5HLAFNhH/sHj/fYR025rLbbnlofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957525;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=6dIjK3KQyPYo7BGeihqe5v2Q2WzvnIFuvucFmY8UZiM=;
	b=gPAWR4WC0tur97mcVEzEFSHwb+iYX51VI+FQvDab3VHYA9LB3UbSQ4pHatPbky90zbie
	 6FeI9Ede/YuO6jBzvHsG32kEosYHPdUeL0BaTgA/sOe/YuJxZfbX5C2AywJzRW6KbnFXi
	 pA6pKky2LcktxU5+uBwXRGa//9p/uYDbfKxY2/DYnTGEM+whch0ijitR9G/O6jH9MHo0Y
	 HL1qVYdLPmDEHQyi2ZwLbaS9NZHGBWyy1/urREhjRSNe3DROrqz6sCbRcTnFreSyZqQcM
	 K48XqjNS0vbLkmfrbb1g0oNpu2kHswlNTwLPu83YFLChLYd4hqYp2QXaqgWxGoSetlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wzk0AKUh;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337C606EE80
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 09:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9337C606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wzk0AKUh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4D4E24E413E9;
	Fri,  6 Nov 2026 09:32:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 207F95FFBC;
	Fri,  6 Nov 2026 09:32:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC820103292DF;
	Fri,  6 Nov 2026 10:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957519; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6dIjK3KQyPYo7BGeihqe5v2Q2WzvnIFuvucFmY8UZiM=;
	b=wzk0AKUhHtXWvefoMAkphBOjTffVQzMnfddS4ZbG16AEUdu4SGMZCgxM1nEu40Kovb0ZbB
	iiLRa03CunEJO+Gevda0SIEUaPwlx8z9towgjqw1NDpmIbPJZPdFIs6dpV/D0R2jjvZUsY
	6sf+galb57+IV19d56T/C04vO/3WBIGf93TBBVoy1qHZAn57/yK8985rTav7wfm3pB4ew4
	Tyb9hTHbz8Pgu8snCkrUXvWIhuir5xo/wPaNKJg9be66FdvG0Wc1+G9ltqQZ/YHxpb74Gr
	8KVzL7vI6mKbgG14ahBCIhzqaxnuCA440p6LVcxQKW3fJ4nbA10u11XVAvcYlg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:09 +0100
Subject: [PATCH 12/25] dt-bindings: spi: andestech,ae350-spi: add Metanoia
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
Message-Id: <20261106-mt2824-v1-12-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes ATCSPI200 SPI controller. Add
its compatible string, with andestech,ae350-spi as a fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 91e04f5d354a..6e5dd8175aa9 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - andestech,qilai-spi
+              - metanoia,mt2824-spi
           - const: andestech,ae350-spi
       - const: andestech,ae350-spi
 

-- 
2.56.0

