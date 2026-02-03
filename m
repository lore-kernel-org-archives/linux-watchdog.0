Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAC3AA1B1
	for <linux-watchdog@vger.kernel.org>; Tue,  3 Feb 2026 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135701; cv=none; b=hHKtoWjCql/VO6re7GsD1T37EsC3UMct48s1jbAT6hEuGvvAKvYO5aTIquZWIwDUGHM7/JsSXeRO7Qh9L6SDyV3uzOLI3SZkzhmNtMePeioxuZZTRHjLod0pW60kJVmElGS6lgBTIPX8QVQkfgxWQKqufzZKZZ/LzBvkH4IbuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135701; c=relaxed/simple;
	bh=4Dhsmu7xEnUrLuIeetswX3iSlvyg+tPOldHEohviWxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WI51swkCxHV7X8EfzQcUqasp56e1okYtWaYHcoShjch2eTgVD1aanhl0nMqnD1dA7JWs0t+7zVyGXYTpAXt8kxgWOXjdI62VMO4QHLiark4mZFTX2s/jsVBKTemWErcH+X2v68B/hYx1F/92xlQdtWUSnQmt5eEuJZ4rrlTYEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dX9kiVdq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dX9kiVdq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 513151A2BBF;
	Tue,  3 Feb 2026 16:21:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2656B60728;
	Tue,  3 Feb 2026 16:21:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D7D2119A8891;
	Tue,  3 Feb 2026 17:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770135697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vx0inxEGPD8evkjWNjlTSWCY3thhzOffsgPlVfuEcmY=;
	b=dX9kiVdq+aWLvUkx8fsE/7T41jWA6qO4t/sAbyz/1IlZrLeLIMMrgGiWCoTLSdr1wLYwiC
	HRIBT+6PQ+2RZY7kB3irZ9mWpkK0iuOkfXvNc/hmoXHfC8RE5bJdfer467GOMDl3tPqeol
	C/iMU4/ieqU7bfukipsZdTiN1BsnifsbZt+/8uRkIsOExlQM6RNwchG1SFcKMAZBBTqDtR
	rdyOsvj9N5Mxi2dSk3pIBzrTBftO1Wt+l02hGSrRAUaVfNnkB54Uo50V5Df9tE4kjYqyHt
	EnU9Kw6xJxtvLNKI63fq/g+x7qEH0YpmSV6L/+4vSYAl6kwjRYNQ6CNZYtB8BQ==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Tue, 03 Feb 2026 17:21:11 +0100
Subject: [PATCH v3 2/5] dt-bindings: mfd: Add AAEON embedded controller
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260203-dev-b4-aaeon-mcu-driver-v3-2-0a19432076ac@bootlin.com>
References: <20260203-dev-b4-aaeon-mcu-driver-v3-0-0a19432076ac@bootlin.com>
In-Reply-To: <20260203-dev-b4-aaeon-mcu-driver-v3-0-0a19432076ac@bootlin.com>
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
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255;
 i=thomas.perrot@bootlin.com; h=from:subject:message-id;
 bh=4Dhsmu7xEnUrLuIeetswX3iSlvyg+tPOldHEohviWxU=;
 b=owEB7QES/pANAwAKAZ/ACwVx/grtAcsmYgBpgiCHuU96qMmkkM2ryyA5eim68NuG1vTDtsyPA
 CykoJA7A9SJAbMEAAEKAB0WIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCaYIghwAKCRCfwAsFcf4K
 7R62DACHedEiSyd51nB0oZMnPYj5HO2Pw9FcbvDWWM7h/WVHYFumX3VzAZxWe8GuFRGpi4wobjQ
 6ULdMR+OeRVfUTZIfq8XB8WWwxvhQjXnBBPoQcsI7BepxrzY4HUonXil7CrvrexvDS8+ofnsDTC
 iCAoYl9FfVnLXxt4XyGkfU6wd+DjoUXLbbIgn0Fojs5wVJ0AjzPg1oiL+Ica9yFBixsJczVyesi
 kR++WMZDXMvahw7rs9vpReiqONC0ojRaYuICzdRlG5S0PAPM01gXB24ZHlvQud1w2FjDx0cYHYn
 N7r9jOjd+pWsdEyO9znNuGNpnrFbkk0URAOu0MjHirXyS1h7tLHdHirkjWzCLddfzM4k3q8YICH
 Wi7AsQ9nyS8iZlnf0dl+Gv+GmOh4gVi7TlOm6Mpghh602sv7IyKBcMFJci5C78a3y5ZQt9gwxhy
 dvvtShqYwAK1l66FRWAhC1Rlsflq4BhXdh2Ckv48xYXj6q5c3zImtrXHhw/GZvcFz49Bg=
X-Developer-Key: i=thomas.perrot@bootlin.com; a=openpgp;
 fpr=874077C6A6A30A2303A812219FC00B0571FE0AED
X-Last-TLS-Session-Version: TLSv1.3

Add device tree binding documentation for the AAEON embedded controller
(MCU). This microcontroller is found on AAEON embedded boards, it is
connected via I2C and  and provides a GPIO control and watchdog timer.

Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
---
 .../bindings/mfd/aaeon,srg-imx8p-mcu.yaml          | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..9d109fb0d53cb2a859f5a908a35611394eb87807
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
+      aaeon_mcu: embedded-controller@62 {
+        compatible = "aaeon,srg-imx8p-mcu";
+        reg = <0x62>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-line-names = "gpo-1", "gpo-2", "gpo-3", "gpo-4",
+                  "gpo-5", "gpo-6", "gpo-7",
+                  "gpio-1", "gpio-2", "gpio-3", "gpio-4",
+                  "gpio-5", "gpio-6", "gpio-7", "gpio-8",
+                  "gpio-9", "gpio-10", "gpio-11", "gpio-12";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c9e416ba74c64e90629c0b7d7941f879c9ac589e..ea9d55f76f3509c7f6ba6d1bc86ca2e2e71aa954 100644
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
2.52.0

