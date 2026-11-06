Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957476;
	b=xWMg5tCcLNhDwlHDKY1WcZ3NnvAIpx/960hmBirET2nWi6pNFe1frSVJdvbaTnHQ8i1N
	 h91j1i+N6u4Fl4uP5TouMi4npe8vf4epduGKI/py3sN0Uk7QBRDOiYNiJ4lr8H8nXMxD5
	 nMwrQvTyCQFsM1eszpVEm7DjGop9rguCwoag1GOpcMjOzj9wTAY9ErmwwFN3FDkeWH3CK
	 ZDphsDTUqQnkEUxGNB5VZP1DyQk3DDkHvcufTh1bwTAWLsfp3v6mneAb7HGfvgBfFw0hW
	 X5yv84Ta+/r71++16umg+otZP8eQhIWu+G961icojba/JggrKrBG2HuxYIiRzAdWheQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957476;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Rmm2T837u6dJV1SdY4aEJnvjZ90dwHMyQK/XGmxJ8Z0=;
	b=mEdlXYboM/OOHE6tI8TV/e6oyMjJkfzSjHPf0DMVN9djNtkGPUbj+MNK+GDqsHWZ5SD1
	 T16Au+QDOmRHWszj70vqXmDRn1gQVfPNyPUUmuNLjtdxKRmNyVkRHU0QrvzoZ4DCCAXTL
	 bF4DRss0SWun5mfKJ2Qa0jXJ87wSXUFdYyYQx64IF6/3Nbv/4Lf+Qen3n6L7NxylmiVdS
	 OX53impJxDEjBpknk3CWUj9ZE0pNfRzGtlReXNZ6/TIq5ZFdseZJChJq3weCmApN4t9Ns
	 AOqB1LJAvp5pvvI7y6LS1FQpse4z1ergHkgIalAY0FqmPRzdljiPbZ0yrPe02hvYIRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="CnxHq/U2";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B558606A329;
	Fri,  6 Nov 2026 09:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B558606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CnxHq/U2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB0CFC69166;
	Fri,  6 Nov 2026 09:31:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E3A95FFBC;
	Fri,  6 Nov 2026 09:31:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FCCB103292DE;
	Fri,  6 Nov 2026 10:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rmm2T837u6dJV1SdY4aEJnvjZ90dwHMyQK/XGmxJ8Z0=;
	b=CnxHq/U2S7LWHHBVur1CL8xQ66beHxCokAadstTZzGIqQZip3L+k0p1km6vxeiEtmL//ax
	CVYNIoiChcz11k2ixYMfnyX3GUUVl0X0a3zCcTQ5VpEdRwDluYpJM2OuBr8pYhDnBXy6XQ
	QU1+B5b/JCq+TAOWdbtCreuN2iFkbjy/kt+Fa5KMmmm8pp6hBhWDPt9HkXO27O4RfeERzu
	UGo6L1ESUHN3t6LtkpofKpNavxeMt1lXCvz99igo0vE+DNvrhLbqXXlX9M3hhwPrtMlhh6
	J6bWyvlzNth9aayy/7nZEsMKVDBrMO8LxTpCbZCPcmD0whhASwOmgZ9AMWxEjA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:02 +0100
Subject: [PATCH 05/25] dt-bindings: phy: add Metanoia USB2 PHY
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
Message-Id: <20261106-mt2824-v1-5-86087eaf5af4@bootlin.com>
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

Document the USB2 PHY found in Metanoia MT2824 SoC.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 .../devicetree/bindings/phy/metanoia,usb2-phy.yaml | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml
new file mode 100644
index 000000000000..0605e6d0f67d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/metanoia,usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Metanoia USB2 PHY
+
+description: |
+  The Metanoia MT2824 USB2 PHY is controlled solely through a reset line.
+
+maintainers:
+  - Jun Chang <jun.chang@metanoia-comm.com>
+
+properties:
+  compatible:
+    const: metanoia,mt2824-usb2-phy
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: usb2-phy
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb2phy: usb2-phy-reset {
+        compatible = "metanoia,mt2824-usb2-phy";
+        #phy-cells = <0>;
+        resets = <&rst 18>;
+        reset-names = "usb2-phy";
+    };

-- 
2.56.0

