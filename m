Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90A3D75AD
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668947; cv=none; b=GMkjI4PdvTB1ihlrmTYeurJPyXy8Vkez+Vi1rkdVlqy7Mn0HCKvRWurqeph6lpYqQBsbH1KLo3F11zB4cvcZFNV+LGb0iT1ydrrKR+DvXt6HMKo+VJzBdguXZULx8wBHsQffMHLx5vAGggrlhhMGozGj1xj4gB8XoQjpcoNYX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668947; c=relaxed/simple;
	bh=b+kaB6A7OKVr7kDI5Hc2pF93x+v4znCDL+JlTKBr58g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltPtCrxyLmHTtvSRjETmNw40j8M9WgiLeNvFvN5Qo8v1msEmJYbBoTMFS4pBmMTEytwHv0nq1qJUSyMCGN16g2zUxML+FmlvxYJUvSsEGCmgDtCPkIjySy672Jk51ra3VPdiVB1LcpHRW8l46/oY5QFpkBJ4OgCH7aWRLiNT2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uscjZH8B; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uscjZH8B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 17936C5AAA9;
	Wed,  8 Apr 2026 17:22:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF9C7603CE;
	Wed,  8 Apr 2026 17:22:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06F2D1045019B;
	Wed,  8 Apr 2026 19:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775668943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dUsa3nTYTD0LWuue8QGSHk7Sdq3D98Q/HNY3FHbk8Ww=;
	b=uscjZH8BRgy+EwbKNKS6a1tbblQeMJ3O87AMzDWbdul8aFeUJr62tW+3jO84NKpuWDz86H
	3GhxSMYT9SJC+56HsNgT90B2fpr8ogjzmQqnbjqsTAUKnUtOcaLBhdx4ngzWpHf0lwCsMv
	kGBICL2caNjuSqXh3Hsqv3tdC8feYtX5zE01b0RVdcvR6bM9bpeKw79jyI5lDa37O3hpaM
	ADVOrQAWH3tPC99HHTyaE4m4e+VTS4zNYxqAmsZiBOj9gXOYzfBvbZ4l2BbGOoeI3UHKF+
	vqw9fI4ijUDIiAhj+BwVkMKHkdAZhLPB4iLN6LnoxNWr6JP6LMo9ZzEg+hgL0g==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Wed, 08 Apr 2026 19:21:55 +0200
Subject: [PATCH v5 2/5] dt-bindings: mfd: Add AAEON embedded controller
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-dev-b4-aaeon-mcu-driver-v5-2-ad98bd481668@bootlin.com>
References: <20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com>
In-Reply-To: <20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215;
 i=thomas.perrot@bootlin.com; h=from:subject:message-id;
 bh=b+kaB6A7OKVr7kDI5Hc2pF93x+v4znCDL+JlTKBr58g=;
 b=owEB7QES/pANAwAKAZ/ACwVx/grtAcsmYgBp1o7DtENEBUguLuW/CfIbnsT7cDlXsBMx/Mk2k
 GyB/DWIYtOJAbMEAAEKAB0WIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCadaOwwAKCRCfwAsFcf4K
 7Z7fC/0ZIuoakYcXNWKWyxc8zitQ9SkUvzQtwRZJRFHvUSmSeN81bZq+qWMTTmCv6whCjkf+TAn
 YRFoskIsuwPR1Jh0OMx/ZvuU6DNgr0FDEzXriJDTjkh7w5YI87a0HAdWs3YPGyoSxS3OyfvVw1G
 0lNEn6RkRIyYkE1SDG0M6VVzezWP0+kVVGJ7OfsRaKEcowhH6v2i+aeoDCSvTxSsmCuwidvupuF
 i7hdIxrd77h7KgeMwBZoRrElityY/LMmWpZjhkwj3oGBFxx3e7lr2vnBsQ/f3Yb8kjM/g01WaFZ
 Dt7GHeymFOdIi291yIcHWusIFn2iuaO+IFhrhebogdcG9J5KIovyI9VglI7qdsR9/lkFF9ZW2km
 zzBMPqCtBy3MdI6Rjl81PO4g/P/LLSwVZFe1i9cfvqeNuoCqssoL0/5L8sB40y1566VEsv7QuB+
 2BejNbbGvHXh9K+sbwDYUEXJbxE3AHUKRjs+AFeQDgVRKNrTBB0Zn8/vEw5/KhpBqaR0o=
X-Developer-Key: i=thomas.perrot@bootlin.com; a=openpgp;
 fpr=874077C6A6A30A2303A812219FC00B0571FE0AED
X-Last-TLS-Session-Version: TLSv1.3

Add device tree binding documentation for the AAEON embedded controller
(MCU). This microcontroller is found on AAEON embedded boards, it is
connected via I2C and provides GPIO control and a watchdog timer.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
---
 .../bindings/mfd/aaeon,srg-imx8p-mcu.yaml          | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
new file mode 100644
index 000000000000..034fb7b42551
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
@@ -0,0 +1,67 @@
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
+  Its watchdog has a fixed maximum hardware heartbeat of 25 seconds and supports
+  a timeout of 240 seconds through automatic pinging.
+  The timeout is not programmable and cannot be changed via device tree properties.
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
index c9e416ba74c6..ea9d55f76f35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -186,6 +186,12 @@ W:	http://www.adaptec.com/
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
2.53.0

