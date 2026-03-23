Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FB37E308
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255702; cv=none; b=ulTWhD8bltCaTnAD/vQvQ47uMnW7MURT5NYlaNDm6igiOfDZAVQg+XAUcrqkRyBz25WcEjkjFphzmpQ+ACfxbfXbrk/AvwbdFAoGnSGgPx5cu/p8YPplwR6HllXv78XHuH2ZNfOFxCKUIZGqiZ66R2SoCqS+54FYH0HJGP7dUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255702; c=relaxed/simple;
	bh=BnHHgfi+YmfrLHT/dUq69ubD2Rw4c8iZpcGQ9pZBjr8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq+Zw1pIIXkjk/eNyynqniqYXQS9kFYGniZjf/mx1woThn1nnsKSewqG7DJUykVQI4siGKauvnXxfIq8qhc4/0qrtdVeA0/g675OOLg1NqpQw9F3agnHmMu0Tsg6KyHXhNPNSJlQ8jRCTfLvcEzL0DtphD3KEb2ezeGextYmx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo4wS1Zx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo4wS1Zx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so24094665e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774255699; x=1774860499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiFXaq2KynT225qwMSd7jsUuMjJ4J3qIwVeyuIMFqQA=;
        b=Eo4wS1ZxbURSP/MI7ZhJpvpCWHza+sxh+RUjsjrGcvEPt/yVIe+rtGCTt9YQ/4YuK7
         3v2Je1FNonn0BETieh2S+PDAay5ah3FzwfSzxH/jxWynvUkiJm7wsq9n2VJTUorPmAQ3
         cigotWWYGCriS3hdln9WSSmCkKwcvI7vKDU7Hz8JSQfxUCoz70e8nc5+iGW4pIP1GQp4
         xlOLaexErUv2JtEInCHhMkJA/oOlIXG1K2px8LkoGqojvJsxcuRQI2L/KFc/f+xaOMkp
         RhL71RlPlg/Hd4LMyQODBe5z7+3keLlGTHEu6twudimYPICHGFTkczXEDm/fG0FHP9O6
         1NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774255699; x=1774860499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IiFXaq2KynT225qwMSd7jsUuMjJ4J3qIwVeyuIMFqQA=;
        b=h3OM2Zceq7XUnCe2YS19ZVMvbgNMe8qNp8uFQxtIJmEogcpHa1fACmWKhf02gS+df5
         iykgudylTry0K1SP7SwZ9+9c1YLEWco5uIdTHqYQhb/OQgXmy9jg/XR1aLzr0yg6W3qb
         GWNKkznCMtkoyV2YNQe233BaljF9KC82GcJ0DlAUphGKWaQPe5TpLOK2BuzdcxpM6Rmk
         sV7eIjEaiNVEmL29sRV2wMeQCJ1hsO4PPGrYgq4buypTSGpFi71WtDPrriw+g2JEDEw/
         wDvyDXdTg0t7jL/Mi5WduGkreC34yLtjQnSu62Lte5aDAuo2h/Y3du9y/jmd9yxPztSr
         3OzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk7gT8doYHV8n+JqRjkJhMsK25xyHryDxUGB2kb2gP8/z7MGWwNUNxqeI0zCGQLYeDfC2ETJu+d5lj8/MbvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeyaZITT+sqFE5YJkD9IrpS99YijVszS0bbdO355o8+dRLG7e
	BexXqV58vmPmCZhs0YbGhuS36aB3ri44puKq8Y50cdBokmsfC2bMm/Lp
X-Gm-Gg: ATEYQzx8mGVzllQTAHaO37TFzs4dq78ok2RSHrW3zDeHZAK3NFzWensTZGiimw7obsH
	Gx+G9xHAZ4/gOUXSh/bIjctAya4/UxKbLbOcHif8m2OqAkDITFU1q4zPq837hiOzAnrrz9tTPXx
	6SpPDhzlf6EwsOVakQeeUwzD849RJLbThmL0Z1vdFCR1YmlRsCQETUZjNodylEgTv8NRZgYIzta
	+XWhsIZoWWY7xYS2amV6FXc//MscF03p2X6p4HsE1O8PnQ/lL9xPkmyEjwpFcJUeMKt+PuzYQm2
	+TJzXBVVo3G6mHG5v3AUlJSZ6yFiruWJg4jcY5yKhViGjJf7TDOfaFiE7PEpzJA8aPB8V71//95
	kuezRy9xDkZDpTpsJALHbwCBeKtiknT2MQWXYCppSez1Oev27UZpt/RuMQmruVk5z/AnXMEE5s5
	0aZHkRc8vT7xJV
X-Received: by 2002:a05:600c:3f19:b0:483:badb:618e with SMTP id 5b1f17b1804b1-486fedf70a8mr160064695e9.8.1774255698607;
        Mon, 23 Mar 2026 01:48:18 -0700 (PDT)
Received: from fedora ([82.77.79.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe8367d8sm316822715e9.14.2026.03.23.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:48:18 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	egbostina@gmail.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: watchdog: Convert TS-4800 to DT schema
Date: Mon, 23 Mar 2026 10:46:12 +0200
Message-ID: <20260323084616.10469-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323084616.10469-1-egbostina@gmail.com>
References: <20260323084616.10469-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Technologic Systems TS-4800 watchdog timer bindings
to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../watchdog/technologic,ts4800-wdt.yaml      | 46 +++++++++++++++++++
 .../bindings/watchdog/ts4800-wdt.txt          | 25 ----------
 2 files changed, 46 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
new file mode 100644
index 000000000..cb2066b4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/technologic,ts4800-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems TS-4800 Watchdog
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: technologic,ts4800-wdt
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the FPGA's syscon
+          - description: Offset to the watchdog register
+    description: Phandle / integers array that points to the syscon node which
+      describes the FPGA's syscon registers.
+
+required:
+  - compatible
+  - syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    syscon: syscon@b0010000 {
+      compatible = "syscon", "simple-mfd";
+      reg = <0xb0010000 0x3d>;
+      reg-io-width = <2>;
+
+      watchdog {
+        compatible = "technologic,ts4800-wdt";
+        syscon = <&syscon 0xe>;
+        timeout-sec = <10>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
deleted file mode 100644
index 8f6caad42..000000000
--- a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Technologic Systems Watchdog
-
-Required properties:
-- compatible: must be "technologic,ts4800-wdt"
-- syscon: phandle / integer array that points to the syscon node which
-          describes the FPGA's syscon registers.
-          - phandle to FPGA's syscon
-          - offset to the watchdog register
-
-Optional property:
-- timeout-sec: contains the watchdog timeout in seconds.
-
-Example:
-
-syscon: syscon@b0010000 {
-	compatible = "syscon", "simple-mfd";
-	reg = <0xb0010000 0x3d>;
-	reg-io-width = <2>;
-
-	wdt@e {
-		compatible = "technologic,ts4800-wdt";
-		syscon = <&syscon 0xe>;
-		timeout-sec = <10>;
-	};
-}
-- 
2.53.0

