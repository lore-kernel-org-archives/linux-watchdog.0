Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483715;
	b=0A9+nEOlssJDYqjtsLw7u3la12xLSviME7J4Ip/fVJjKDlDbPvbB4bGejPlcXNr3tRgh
	 VUXAGC37SPOFphUurfWys8GRd0DjAMNranOlXLbeWQrFeeD9EyamYvcoXZp+qSb3avMdh
	 kV+TT4FlhPdYysU7C/Rc6I/P4a+Sy2Z9HZd+3ehcoxWUX3QP9IbjLVobEHW0yicePPHQX
	 MWxZb9Uo6gYEEeYQ2WghvJtjCdaKPZ6Pgw6VO7Hn/geDEq7iHaUVAHpZmRTct4Qc0MUpO
	 Z6d7afNpRQ6p3mAHC5j0o1WLIGtvelvPnwd8K7xmoJ3DpUkZGFP3mZj7ZikHxVWylCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vdOLga9Vo4Xp9js0CC/DhzZs7tFM2odH8QHKwA4/WTk=;
	b=T7mkul2I46ofWyr55qwM1P5MDQhk25Ixv5uQmPyJwt2a3tH0TK9euPmCNjyQgSveaMmy
	 I2tZsIbBOECG2nz7A0Xnu6MTf9HHmIzRCsofvv7ucHRFb8vR/0TwV8HL+IVYKG9NboFOX
	 LDW1P3SKF6qUDBlf5yijTCv4/uK9GaIOBjVzZebiwqk4OVTI+oa5yfVf+FddcpYm52UMj
	 MC+fvOG7vi4WOVKZEYMx3w6+l1/s2RrsD9x5L4o71Fi4CfnTu00lsfkL9sS4As5FDmhSB
	 FXenSBSQ1Co1TYFQaduvTf/Me2tO3uINDEWECd8ulufIeSJkYXxaHvyOjLRWVAgbDDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lg0Vprb4;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE8606A33F
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 01:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BE8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lg0Vprb4
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so1834630b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483714; x=1796088514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdOLga9Vo4Xp9js0CC/DhzZs7tFM2odH8QHKwA4/WTk=;
        b=lg0Vprb4kIAFuRBvNSY84P66mAbVUF4MdzhoJEatmAcGWTe6aVLq3UppqjGFNRNnDc
         tuZUASr3B7ypno172TT9ZXiWdrL/+H83Z4TPYoBg+2bgsKXBX8uV74Sntdj0Aq/zsKet
         XsEzDUuul4qEYvPSw8fgbD6qM9XlF8Y7vE8suEmPpcJX1d29uPQFTmrVcRXCrKo+5hp8
         zAT4TfmVT3GI4sIl63vtD+tPTL3Q+mlZsiGvpbpVIlM0mSaV3beH0tmP5IP9ai0gwLma
         7Z1iqB6qu4lUJIJNEEQssKFlWpi6YlBZ3sGC5/FnfsaSroIFgkRmlXXp8MHY1CD46W/P
         ImNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483714; x=1796088514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdOLga9Vo4Xp9js0CC/DhzZs7tFM2odH8QHKwA4/WTk=;
        b=JEOro9EZEkW/RkyCy8AiBBicQx02R/40BtjbodiSDxurDvtS8CrHjDbfYFM3SeHgDh
         3LSdJmDGd+4PfQqVlYBdZZqPYXn7idblo04T886JSIohkTRRHbsXKG1/MtWt8AqGIRqx
         rGcbVqMz5sC7rZpX9hmD4ejCZyOTERIpNgDnjhq5zrg68A5uHHPzJlYAJb3f3aNrAqXG
         l94py65i4swhBuAtxgq3Nxl62ma2U/KVQEB1to1KCE6ViKfzkREkp0LdLYkfR/Vm1MAd
         YdGovQ6iqDn3Y0Odvt3fJal6gOnWgISPoEEAUiynxohTzPWOU78VcOBjdpSmRNOh0qvs
         ClPg==
X-Gm-Message-State: APuU4Z9MteJDcrKef371afOGEfuQjW4NaYk2CJskCRJsT0DIwfJ8UhLy
	qPgMqfqClTx9qGfpGaGg95AEC4FgxtMM07PKuFn3Lj6jNzBROnO0ki24LOFyPmdr
X-Gm-Gg: AZFdTZeUf61aPItbxlhjzp5fOf0YTEDJ/r2bQsYqDGIK7SkP1jgyV07jDoRWsVCCRy7
	BlpXqpgN9l/5/NsnYdrAh+mJzzg6xuh11JqvEQlkye0lTsq8+C+AZIV3haGPFAYn5meBlzNjAf0
	dlcnJqjRxLOm6/6rdRt1iqJB1XgIi25Itdp+0GRRCROWj/hRss0pWezYW3YOhVgchoMrfqPDzQY
	zDQ5Tj4bGjqbMJzPZCnlzWObmwwLsAXzYzSv6Cm2MSDiDKy7pqMgdBwsQRCFOHel9BbXJsHPgqB
	Zd7JXDqmDAYg+NBjtCLAURhlYkloNVoS2PUKU3l4gJtN1mlRuOx/vbPOaNmy3yAJJRYRCCbpuVy
	y/T4HG4wa2XNfbc3S3fi+W5yMxcON30AThxOpxXLJCZxFS1hX0HG0dXJfZoFe6/ro4EwFlb53q/
	FxnO6rnG5BbBB6/Mu5wmC8rUuD/Dh6KxGA25AkTayjGf78oMg7jjEbelkSK95sCjYwx71Hj0Y5c
	bs75hVACof4s+zOYRYmOirERtLdQztaG3Anr6koknjOi8CYpueWFy0BrlZ0B0o2MhSj7/+z8ufo
	eL5iyfSG2Wcbz7iyielVZcIG1E9tPZ7ZeuJheVfWbZkc41e6/MKv+Ok=
X-Received: by 2002:a05:6a20:1bc6:b0:3f4:79fa:414 with SMTP id adf61e73a8af0-401bb21187fmr9289912637.13.1795483713931;
        Mon, 23 Nov 2026 17:28:33 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4d0:8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm6115243b3a.30.2026.11.23.17.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:28:33 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] dt-bindings: watchdog: hisilicon,histb-wdt: Add HiSilicon STB watchdog
Date: Tue, 24 Nov 2026 09:27:35 +0800
Message-ID: <20261124012755.328774-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124012755.328774-1-mmyangfl@gmail.com>
References: <20261124012755.328774-1-mmyangfl@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding schema for the watchdog controller found on
HiSilicon STB SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../watchdog/hisilicon,histb-wdt.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
new file mode 100644
index 000000000000..427225c9aa46
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/hisilicon,histb-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon STB SoC Watchdog
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description:
+  HiSilicon STB SoCs (Hi3716, Hi3796, Hi3798, etc.) integrate a watchdog device,
+  which triggers an interrupt after a configurable time period. If that
+  interrupt has not been serviced when the next interrupt would be triggered,
+  the reset signal is asserted.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hisilicon,hi3798cv200-wdt
+      - const: hisilicon,histb-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    description: Frequency of clock in Hz
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@8a2c000 {
+        compatible = "hisilicon,hi3798cv200-wdt", "hisilicon,histb-wdt";
+        reg = <0x8a2c000 0x1000>;
+        interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg HISTB_OSC_CLK>;
+    };
-- 
2.53.0

