Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159460;
	b=MLXmIrZJv+om4WJiaIMil4sme51ueQRlJJx12XMUYepZJxGHSnukf0ARaoHrv8aMHkfM
	 FPkeNtaUd/IvGOIGThah/o5gpNGFWEn7aFO0xUI0Ql/V5BP263C/DL7Yb5FY8VqCKIFGh
	 igzi5pVuNbGuXNuzU8sWt4W/J0lKz1TyJ0OcWCwQbSdJDnFpZmR+9nod0JYB/YJbru+Yw
	 c5BMBsvPDtI+ItD5MR3x+V3bFPZToHLwJs5LwRz8bj8cYbjkN5J+ZnGZJKR9vrNdlJx+2
	 tug5nBOsWqVyL5yJKZ5SrjR7EqWPqWS5S1H5HmFe3HgNkD0fajY2IcPKA0HTlImlMPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159460;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=FxLFk5WT5v5BwdlSXsOEEwuC4y+Pw5jgS6YRSkkj0UA=;
	b=rftaqK0DBb+DU3k0Yhli46ltPd/DvVb3Pc1sWGo6oMcPj0iuLO9qpWFgRu/kDky3q5Fe
	 ilyI4cIYV2ELx3WYneKsswSpIDNc05EW6JIEYEWyvqqbKJrgrybR7GgW6tHzVBXM7EAjL
	 6WNaCgWvX7lcVvuspvHXp4ottzJYWH+/L+zntG2B4KT72EdiwET2KPkvMjKFS7EJNsFnR
	 42/myxTuhGzdE0PTh1k22Eqjs2BM4poMoM5ALI3BeC6LwK1+OYvurGoFlEMaMb47UgeGM
	 7hBnxdKYlMz0xWH952HWf/+JihPgvHumSqOsDjX5RCatkWJWbfXm/rdGwzUEqrrvZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k2Y1U1+L;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFA606A33E;
	Fri, 20 Nov 2026 07:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56AFA606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k2Y1U1+L
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0788E4E41681;
	Fri, 20 Nov 2026 07:24:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF6FF6017D;
	Fri, 20 Nov 2026 07:24:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0224C11BC04B5;
	Fri, 20 Nov 2026 08:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795159455; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FxLFk5WT5v5BwdlSXsOEEwuC4y+Pw5jgS6YRSkkj0UA=;
	b=k2Y1U1+LmwyBckAanxxE5y0DxyeKl0CjNx7jume5/nN7ZCkNFEfM337KUkGsSDfYX78nSi
	GG/QPobxQVz3igigaJPdAHIwfirQRBrJo9iD+ZX+mIJSuznDg9OgEr5rZ6a0bEs7D4bWg3
	oMEyPyMo6NNJ+yb61q4bJj1GwaLuRQXMBjLy7yZ5psMKDPVtXDmb38fxypHgOeH/fgjNF8
	VZyV3OyNc3MRWGV3FyXFGQeN3T0jUjaOrL/CAm7eWqz/gD7LZWSJYSZ+SnwDc8i1EBGRsP
	TtvmlxwwyRi6Dj4jgiGQ2so8wADBU/nvPyddvzQTtqg2N1iyMFGVDiuiGYdtFA==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Fri, 20 Nov 2026 08:23:54 +0100
Subject: [PATCH v10 2/5] dt-bindings: mfd: Add AAEON embedded controller
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
Message-Id: <20261120-dev-b4-aaeon-mcu-driver-v10-2-a756687e7997@bootlin.com>
References: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
In-Reply-To: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev, 
 linux-doc@vger.kernel.org, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add device tree binding documentation for the AAEON embedded controller
(MCU). This microcontroller is found on AAEON embedded boards, it is
connected via I2C and provides GPIO control and a watchdog timer.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
---
 .../bindings/mfd/aaeon,srg-imx8p-mcu.yaml          | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
new file mode 100644
index 000000000000..8ad8e4d69e83
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/aaeon,srg-imx8p-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AAEON Embedded Controller
+
+maintainers:
+  - Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+  - Thomas Perrot <thomas.perrot@bootlin.com>
+
+description:
+  AAEON embeds a microcontroller on Standard RISC Gateway with ARM i.MX8M Plus
+  Quad-Core boards providing GPIO control and watchdog timer.
+
+  This MCU is connected via I2C bus.
+
+  Its GPIO controller provides 7 GPOs and 12 GPIOs.
+
+  Its watchdog has a fixed hardware heartbeat of 25 seconds that cannot be
+  changed. Longer timeouts, 240 seconds by default, are supported through
+  automatic pinging by the watchdog core.
+
+properties:
+  compatible:
+    const: aaeon,srg-imx8p-mcu
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 19
+
+  timeout-sec:
+    maxItems: 1
+    description:
+      Watchdog timeout in seconds. It cannot be shorter than the 25 second
+      hardware heartbeat.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@62 {
+        compatible = "aaeon,srg-imx8p-mcu";
+        reg = <0x62>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-line-names = "gpo-1", "gpo-2", "gpo-3", "gpo-4",
+                          "gpo-5", "gpo-6", "gpo-7",
+                          "gpio-1", "gpio-2", "gpio-3", "gpio-4",
+                          "gpio-5", "gpio-6", "gpio-7", "gpio-8",
+                          "gpio-9", "gpio-10", "gpio-11", "gpio-12";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9..8e0027ffa227 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -187,6 +187,12 @@ W:	http://www.adaptec.com/
 F:	Documentation/scsi/aacraid.rst
 F:	drivers/scsi/aacraid/
 
+AAEON SRG-IMX8P CONTROLLER MFD DRIVER
+M:	Thomas Perrot <thomas.perrot@bootlin.com>
+R:	Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
+
 AAEON UPBOARD FPGA MFD DRIVER
 M:	Thomas Richard <thomas.richard@bootlin.com>
 S:	Maintained

-- 
2.56.0

