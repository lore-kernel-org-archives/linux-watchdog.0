Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61E3C9438;
	Fri, 31 Jul 2026 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491537; cv=none; b=mnkFq+56lE1TzqZaHY+xn9NDWS5+yAfo+uRtVhmKAC6oPCeldcsW7qiMuqrn/hPFXGGyz6Id4TvPLguvrhJTj1qXqkDfG4DycrpLjMMSOA6z34aRYaIS8Hd8byKCH4Xa0ubFZY56eqKG7wCW5Dj8I6ELWYC5uHwDi1w9p0lgWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491537; c=relaxed/simple;
	bh=1XSlkopDD8hgacc2fQinF3x7ZXQZ7mJqQB/vEJrEaWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcsSWArGXwGNmq0rfTOXXhHWdK1jlPgNTO9q1ReGTUmqv/1G3YVgpSdEemr1AWKg9DPg52Il4e2NdNAbRrjoMkApijr1qJPR5OnzJlNf/hjwIYNkv2SSBE7jvSLSgBVc8JZisfgo6UKozbW5qS/sABxJDbgwmN02fE41BPIJiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UgPbg4LV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UgPbg4LV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5F2DF1A1359;
	Fri, 31 Jul 2026 09:52:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3237E6039A;
	Fri, 31 Jul 2026 09:52:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B85EF11C1664B;
	Fri, 31 Jul 2026 11:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785491525; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cGECx7XBlb4XEZT9olLrpyfAunE/XtJfgEve/LPx17Q=;
	b=UgPbg4LVCVrSjUNFutD2s7D6Ma6TpQYzsZMoMV9W8h5grJXoM6XijykAO9iS+r+WXA7Ndw
	c3G/zZOxJQ4ncpTcsM9667zgounkAlXbZ2qpq5nk4TcXP8V85KZDEVuIouxmIQkVt9aQ/C
	ppG6BEIamzCsDCjV5hLwETBvXjLlNs9GpsiFQPYfrD3RFw/u6ofpYbwn5XtM7VrsnWDuaS
	Wnt9IY7pp2abZc/2jBHv2WLvv45HWmLAzKoqeeMlMrw8oIUEq/ELDE8TUzLZ7n7fqWjYAw
	u+rUY78nmco6LFRXiARGyHeeKOyNGyachRozU+RIFpWqbVWHta2hyTYcGT0TKw==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Fri, 31 Jul 2026 11:51:42 +0200
Subject: [PATCH v8 2/5] dt-bindings: mfd: Add AAEON embedded controller
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-dev-b4-aaeon-mcu-driver-v8-2-9ab00e80df2a@bootlin.com>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
In-Reply-To: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
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
2.55.0

