Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330677;
	b=DSUYwl9pKlFNgKZC6/jkSXScSe8SzLfRHr5Dn9KNvC7UbAD+iwjfClwMHoyPOX4/7NaH
	 q7M5zYkJ2VlbaR9D3yXlxgLyvxrwOh63B1zsW2gXk8xH4qFVUQQ9AFlEYBM/wkRYGlWiz
	 MFh6MjbiAEivmzmMxFfd/pFtljP0kjCJgg2RcitH6DcONOL+34ToaRGv8S9BEvHvsPD7s
	 /f/D/JYfO/7Eh0tjrgULO4bHTwd8ZWeILGKXTs0yTlEKNZmBqEI/B+rGeKEB8xqTasJqc
	 LY1e8jAPgNe5jloE0LnU3VjoSb8ZKDIhyotBQLXevEp9cbwb3SEK8E/5riNRTZ6VhRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G76uwmlV29WfUfEk6u6C04FgzxDoxsMbvwdZwFS9cwM=;
	b=i6G0dLkYyQzzLqStu8Lm39pADxAsrgyyszMTtUktPE3Yc5jOD2unPEQg3YjLGvuXqypR
	 jEcARa4uOh4MJ4SHiuwNyjGGJ8P2y6p4ePnh2SshmQ2uA+H0zuqHatckZwFmovfORZhaH
	 9wsBnE7wn71NXW5ezhwYQu0lRaCvdOhGr+cJ9NxOWG/HxVzOa4jMvpp1WhIQ6ZR9xfonS
	 fwD719u9rh32/CH1cZa1eQpwsL6MnpFo3XraeicoaLHROp56lu1Jbr7mxlLi/Xf7iKEgk
	 Wa0MzqMgP6UzITuS4AglRkQPIgaiVyA38Ntf+uvcsQhfUSnSVtUyCeg7xLUCsYaCh2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dey65QKu;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01F606A32A
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 06:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB01F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dey65QKu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f0426a65e0so14346785ad.3
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 22:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795330676; x=1795935476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G76uwmlV29WfUfEk6u6C04FgzxDoxsMbvwdZwFS9cwM=;
        b=Dey65QKuy1kNbc1nxtFjPImZEDLywOi7eDGPTZGQnoWTb8RdOm0thZ/x8vFm06CiAg
         QCNQE/eW2fdgDzs6TtZUk2xjpEHcWpDraKU9/V9CUgVs8fI45CeFFbBkqo4qfhpEhB9a
         1OZ0/QCfQ6D6SExkJQ3btg0bYDVBpTSOvYvAv6MMFjYM6Q1V1V+RuIUJseVa0ib3yA/j
         Dk+q8wD+2y2P5P6jQ24SUIGIBCG55L4DC92HrWeXIxTZ5On2RlhIPjwBnKCy7nGx0XOk
         BS6BU9JBhsaovZl3V9AsxilSw+sRKk/fdvbRt1sOZtMvnhHobGGYK6aByPSgtDWGergS
         dhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795330676; x=1795935476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G76uwmlV29WfUfEk6u6C04FgzxDoxsMbvwdZwFS9cwM=;
        b=XholQfhSo5zQykSID3kqra1XR/q0Bj0G7glvmrKSACzKzpdkjcLwBzwJGT1TWDIXAH
         f0A5lR52wU0TTZb8ggwRkK05URShVLREO3Y7zXgA+ohC4xO2V820RT6zaOMzICG9fkYw
         UDklu4T6ZkgqIkzIDtoSSJZj6CSi2aUyuDYTs6d9BpjgNty7PmaacCqUfTJY3Ou6t89a
         toF98QRzvmFZAx7QjmkDoyZVh7lX88oq/9VrMYdAcZXIBFu64DDU8tVMUqnQnqZMxjpF
         s3MX3Yc4pOa03CS33v1A1TSvhmxkpgavSLW15GQxHNgJBBhXeb+DuxFgjhOxZ2WzfzeE
         eGOA==
X-Gm-Message-State: APuU4Z9jRfbzIuYkgkZVDzEFJUpAD5oE33pX9JsXG4j3c51GyUKAqszw
	MSfVFwR5jOXucgC9PynwO3C5V+Fi+FPaLGY12KuU8X1wmCs0ZPQtXQr3qpibUw==
X-Gm-Gg: AZFdTZdUbio/8v2o7ISqQg1AwXDzII0fD+5+w3BKsHIK+nVPz3EvhJDByYcxbcdE9Ry
	BowOTrOyGxFnh7b46Lx9J0M5BNBRpj9LyzBhbk8BI1efJ44i1vsri5HKQyWV0TQ2cEsRjQhsThz
	ScqqvOxck9PGDL5n8m4nYb274ItJ1D7HcTp8KXu8xwhsapC72xJJ8gDftAK/xTprCF0Cb8VJkRd
	18fWZXeiklCNN3TJEIzUKXTvpocr5AAAjWF9VjEJXxrJFFhzfGvBIDFs2Pzzs9/MgEqiMIQHuGV
	gC+u3mzroKdWJYNsfI9jnXGKL8vBD+fTgyp9Y0Bo3JThptFG2pblf1M9FSenM00B2TkZLPdH6bw
	hYoQv3GoqlCGb0FQ+mF++UFhhsfyd6AWUQkOZDhFJCru+b8gK7HN4s+IC9z1+bzUhpjw8gOlMdn
	8FfylwGsLMhBhWMIUFoiOL+Yg/Fy5GkE7A6AdqSN970AIZqN5pyN8FsASpAYvGhJpiOib89/OkE
	rbzxElVswKTj7GQwzLWKQoX7WW3EVzxPxqV48zk/bXWkHsEkNFasfezoju3TAjp3w/19fiVuxzD
	n5lLg/ldbj1Aeiwun4X8kQas9zs2GgCpKuZAzKxlAJgsBu+1dBEy
X-Received: by 2002:a17:902:dacb:b0:2e9:95c0:7c50 with SMTP id d9443c01a7336-2f03f271e00mr75498935ad.71.1795330676087;
        Sat, 21 Nov 2026 22:57:56 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm34287345ad.58.2026.11.21.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:57:55 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: watchdog: Add HiSilicon STB watchdog binding
Date: Sun, 22 Nov 2026 14:55:20 +0800
Message-ID: <20261122065549.3265519-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122065549.3265519-1-mmyangfl@gmail.com>
References: <20261122065549.3265519-1-mmyangfl@gmail.com>
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

While sharing the register layout of ARM PrimeCell SP805, this block
does not implement PrimeCell ID registers and has non-standard reload
and lock semantics, requiring a dedicated platform driver binding.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../watchdog/hisilicon,histb-wdt.yaml         | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
new file mode 100644
index 000000000000..c0a8ccdb482a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
@@ -0,0 +1,54 @@
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
+  HiSilicon STB SoCs (Hi3716, Hi3798, Hi3798, etc) integrate a watchdog device,
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
+  clocks:
+    maxItems: 1
+
+  clock-frequency: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@8a2c000 {
+        compatible = "hisilicon,hi3798cv200-wdt", "hisilicon,histb-wdt";
+        reg = <0x8a2c000 0x1000>;
+        interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg 0>;
+    };
-- 
2.53.0

