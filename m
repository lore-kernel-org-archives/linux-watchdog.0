Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285324;
	b=Z3WStLpjk6piXafkrs0mwdcKfaTTUoChRW9eaoiIJvX62z3QHuIWiNWt2LnTDloKoAmo
	 CqpwfA0KExjVoUGtpGLkEEBNyFPNwWM4KyC36xWKUESSOjSNOiCoj/c+VN3XL3yxq0s17
	 5MRhw7TFcb7Dr+B2f574nPLCBIrvaNeec3Lol03A5/9h7fi5uWIAv9Phl0oTyQE300Yl5
	 dEWh3c9u0DjGCedqJM/7pwXBlAGrNeN24mcPLqhVbA0GHOnrcslagfIk+PHtd6iv8d3nI
	 qEvux4z+NfkyEEookc3nCwE/LdyrQsXILqqTvIFWH7Hj6c51QCI52kFlCgeNMwKLlXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285324;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=8E1VLqhAS7UqHIEzIz37aMpOSXej67FbbBlMXIbrXec=;
	b=vXI9UhPD+SeegycIZ/KAT4NlMyoCgSLlMhWUJ/xOHi6rovHhzLGYtyvpWHaITJm58W22
	 wBhGidhFgeWtFsPeIV81C+lOoYDaxAlPGHNIvcDDy8j7vPnl4wsjbL09GFLAKKZVBEBLK
	 oe60cUx6qj1y4FiuOsuRDCOZUqlhmQAKuI23RcVK5gH3XvAvHwObtC17XWxCKoAcBzJkc
	 9AwdOnsbOzIkyLS73RdGN7XNFC6oq7Z/eXs0+AaNLTWxqHHiSAAONhXB29xV7TuRQp0ce
	 qrqhaXfYEjdon/58oM+i+IjRpxR8c5w1S3tFpB17vw1OTQMiEzjf+Ky9pSAjNroDADw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="W/dMk/Z2";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2D606A31E;
	Thu, 29 Oct 2026 14:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E2D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=W/dMk/Z2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7EB5E1A13A2;
	Thu, 29 Oct 2026 14:48:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B7F260360;
	Thu, 29 Oct 2026 14:48:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0FEB103290E8;
	Thu, 29 Oct 2026 15:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793285320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8E1VLqhAS7UqHIEzIz37aMpOSXej67FbbBlMXIbrXec=;
	b=W/dMk/Z2dO/gO1bnxS7kOjhLGhXO7lP+diiQIcXY+RUeveg8VkGuNOqWvv3XkpxA1tu+ng
	Ud37YNU7pmN0gyI72sJDoEatHV6tAQMPoLr/fxIvR38X+qRydDYZKzI19Gut0SphGimYem
	nlqCJROTyxxzCuJ6MidwgMjybBiBnPD9JzzwsEf+K1QW15TPO6WiyVuARs/maSYNlX4z2u
	izuyu3r4sHFcjFKJ7VFxZxE/UcHX5FqfAo0jPIHOkUZMVswVdm0TD1zDdMbZyarxkVgsiE
	dCvBHWsSSrzjqiE67HJnMsJx3O3jzLWwFI+3RKvvdvh7+rA8BdCXCO1YIKqtXw==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Thu, 29 Oct 2026 15:48:21 +0100
Subject: [PATCH v9 1/4] dt-bindings: mfd: Add AAEON embedded controller
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
Message-Id: <20261029-dev-b4-aaeon-mcu-driver-v9-1-f9b6d0cc180d@bootlin.com>
References: <20261029-dev-b4-aaeon-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com>
In-Reply-To: <20261029-dev-b4-aaeon-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev, 
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
 .../bindings/mfd/aaeon,srg-imx8p-mcu.yaml          | 69 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
new file mode 100644
index 000000000000..74dccee4310a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
@@ -0,0 +1,69 @@
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
+  timeout-sec: true
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
index 03649f08c7c7..3f85e2a8b192 100644
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

