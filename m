Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957451;
	b=j84S0wd/u7/rnJibZyvlQofUJJO/qhWLMvReuxX6UZVZYhjzyVufbYTmPx+5zxEthj5v
	 CH/YfOKv1JOfliiO/HaYmg2B7fNsEGEZSPFklqtTD+h6x0LZNGDdePVsUqJGBNwOE4BM8
	 LgZx4mxHm1t9qXWYXUHb49ksIS1HWfHfls4CC5BoHjmm9/PkN4vg7r4Al+gTpV4ae3Ik6
	 TLU/KYtEZ910BTXybiD0vYwHAA8p3I6b8tUN08GtZrTd9rxNzVEsy6HTd8b3MAqS2P9Gz
	 JsRjSICf4xmYqdj/Fsqfos8Cg6v2QmcSdtMth0tUqKcAL8hsHEFzXG5yvDTVvMzs6Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957451;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=SHm0AteFxuKOwxOjlVILodPtETBXP7hD3plfwEFTqSQ=;
	b=REXQS5puOCvrc29uU1RzaPJPeI56GyO1mFZQjTKMQAcJQM1Htxpm4ZIyUZFbd3pnJxWl
	 UDj3p+l3gAcztUy3UXQojKiPz0kCiYXbk7AJ/K/FzSAMjU/VIut5amyFycYU75nasmTty
	 4g/EWb16lYOiAhYRXbdQm4CxPjcwfVPabRchq/gvpLkTuL+iQa08qJEkYkEXBd0FFOPMF
	 jGlPTf1G87R7726s+RGg93WmJDfWndFfUUw1IAeJgRZsKYFy4D+by4kBcRTlunLJWHkOn
	 l7obrnn4Wfg8IH7IJBkPr7RA3O97QkXestyOJh83mP9Dd+Xzm2P1YEGJ5wraPgtpHow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S2GzPxSj;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE727606A32E;
	Fri,  6 Nov 2026 09:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE727606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S2GzPxSj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5F6114E413F4;
	Fri,  6 Nov 2026 09:30:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CC8B5FFBC;
	Fri,  6 Nov 2026 09:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D258E1032927D;
	Fri,  6 Nov 2026 10:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SHm0AteFxuKOwxOjlVILodPtETBXP7hD3plfwEFTqSQ=;
	b=S2GzPxSjpvUeXv9HhBo+yI8ELQmXQ1gLJRsLtHsc1gB4qMc2Cg/yer5MpNZINHYd6b9zmX
	nq7LBhAvb2FeUUyUMweM3e69TEuOPH+PSjpqKP8iIBmmnTWtgmZWBLTQKaegy8Dvv3N+rl
	I09tiujlzMrDJcp/I3frt3C8KJ7QmCnR1ULbnEnsF+SgF3g8BFvNWwSifnCe01AGTUaUky
	hMAbU4DWJDyh6+CW5OHyxCAFIocJqTi6rSrx9SnrlMScKXNji3+G8d3dnG6Ha78Gt4fZs6
	iDReX4aecjwx6eI576V4QcUYA9YgMNZ2qUDDnd4ILBtpiIRIgPODLAdE08gwUw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:29:58 +0100
Subject: [PATCH 01/25] dt-bindings: vendor-prefixes: add Metanoia
 Communications
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
Message-Id: <20261106-mt2824-v1-1-86087eaf5af4@bootlin.com>
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

Add the vendor prefix for Metanoia Communications Inc., a fabless
semiconductor company specializing in wireline and 5G radio access
networking chips.

Link: https://metanoia-comm.com/about-us/company-overview/

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..085749fb8a72 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1087,6 +1087,8 @@ patternProperties:
     description: Cisco Meraki, LLC
   "^merrii,.*":
     description: Merrii Technology Co., Ltd.
+  "^metanoia,.*":
+    description: Metanoia Communications Inc.
   "^methode,.*":
     description: Methode Electronics, Inc.
   "^micrel,.*":

-- 
2.56.0

