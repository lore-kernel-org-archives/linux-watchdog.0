Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB03FC5BD
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884510; cv=none; b=OYc5ci9Cw64/YrwvfG4s34FOQuZtBbjCpksgXjXss+1Dm78ZE6YYxyUJBfbYzYXU00cX3u1c6IKM30wZBm8ni5t6vDItzBiFe3kotmQK8mUYv2Qc6GTr6z7UeJz9ViHyYuUIVGxJR+nsIED8tiPfep+smBvVpXpBKdm6iDnSiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884510; c=relaxed/simple;
	bh=/xlEVw/KiT9/XEqDjIphDYd3uSSaRu/4jZjjAdQtqd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejdBhxrEn0EoROKoTunlruy12tEDciSZJScX29oqZ73AhLc4LxLHrpGEslnKU5DlBBH1Epl4y5KtE1ZZwuaY1GzgFWaCuc0eqXQUI302a90yXKnsjg7LZ9M57rvQKtrRFfasrEYLc/ctoMlPd9D4QNENJw4o4UbBbNTSgU99K3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BupgRjk5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BupgRjk5"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848d21bbaffso208117b3a.0
        for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884508; x=1785489308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzDl4rio1x0zKV1oZWrhXk8ePWLshifrG/jhvgwjQz8=;
        b=BupgRjk5l+MuL8KBKi23Gt3MpvYB0x7coU0qrABpDmXZ1XssBcDK8qciftVlY//eim
         IpEGTEVA654bpx75ClSPUcjHMbHsCtKMEigbaUnUtAO/gRCYqPVNMENZrw07Vk2jVnOx
         TfFcnSsqqmM0gWPjB4gUtpP3LqLWuX6T0XPRaebrM0ZWvdo25sFVUEhBJ0VLeFUD6er8
         eMunqFN4mDOEtQUhRdohFbz96Errb2bJg5w/Tnyf/epZthN9+hTFH1/3qNp0YYdKQq/s
         yh+O1HHeGlsJoxx726LWGSq6N0d/hmgU6FmNNQIpqQInRk5UqwlKpqes0ru05ZO2W4HS
         L73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884508; x=1785489308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzDl4rio1x0zKV1oZWrhXk8ePWLshifrG/jhvgwjQz8=;
        b=Nr3+eXSDsVDrn2GZMO6PWby4UC5OjuUnfVQHKpmaHbjZIWEicn6qGrOIwz7ED7DrH9
         BJKO7YWzxZfnVKOvBRK0Mpac2mGxDAnoTv1E+jAmU7w+5kAJpqKjwcdmLXJH6UZqrVop
         d6OPN0ynA8k+apwXw9r0PKhrV/xvJDIcovfN3W+0Z00I1dYg5/WBxraD5dsrQ2diVjpB
         s5TAZETiZmrxuOiXg/O4P/Vg6TDS2h4AOAWeawNd3L+b6sHcb6xw1wPfcw6BfetH+hKx
         3eJwuQV0ka0eTSNlsziMe+e0fBuYHZaFdnqBxdNGR3jsF2oTYJVf6fS3nKtCdH0Z/kUq
         UJiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpw+/jlJ5Rfs+Y6xQWqQocbthBli16cH9lGaJ6+rdy+GygEgC7qQIzpv3p8xrXMwq6MKhRz5763ZT32HDHEFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwObx25k9f9OGQosjxFsmlddq8x78IgNf5tDrJmrOBh67AczUuR
	Fpqaji8AO3GzzlJSk31AAdf9Z+pqcpUbOy0vYh+q1ciCJjAinL+3F2IY
X-Gm-Gg: AR+sD11kFXgf9YVwhqrMgjru1IiAKYrBXha8+j32smTCLUsbvHTSKXoLUR9PnFDcvOA
	IUcy7XbR0Zvty/SlF1f27Z42iYZm8iM+N3oGpkC1DBl4/3F+U8ZbaA27T+iGK0Wu5wY+kykJFqB
	pEQa26ifXgZPpjB7+1D3AECw3CBx88DDDqescearz/sbPe2I2S3b0KIH5qQJPl3Rcv4cWPDqr9v
	3dYbgRzkJ2N784taICLwiyZxnyUHjd2LYvBehlUT1gLuQYpvJMVO6C7kZUys9EFzkVQQYxU62BA
	5bZUH0gpkbTXlXgl7zFb0+nU4oWR2MbPizJS3eFwmnfhaAkGsCh6gxkJc8HHPbQAXo0/snOR4cy
	lyWxV2bvUY5QEZqea7meaCJlUNnDO4E/8Mj1gcrUX3SsJUupN1uUBpqe/6LLfKdfBpPxc8GtjL2
	wHSHJCJTezaGtLrlZO7BojCu8goiuoYahwlP8SZ7gjCvy5yWkHVPLDzTiR1XGt
X-Received: by 2002:a05:6a00:1797:b0:847:968c:a0f1 with SMTP id d2e1a72fcca58-84e2c1aa5dfmr7625153b3a.43.1784884507987;
        Fri, 24 Jul 2026 02:15:07 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm4410519b3a.9.2026.07.24.02.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:15:07 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: watchdog: Add MA35D1 Watchdog binding
Date: Fri, 24 Jul 2026 17:14:25 +0800
Message-Id: <20260724091427.1689980-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724091427.1689980-1-zychennvt@gmail.com>
References: <20260724091427.1689980-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the watchdog timer (WDT)
controller found on Nuvoton MA35D1 SoC.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 .../bindings/watchdog/nuvoton,ma35d1-wdt.yaml | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml
new file mode 100644
index 000000000000..aced7d77a7d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/nuvoton,ma35d1-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Watchdog Timer
+
+maintainers:
+  - Zi-Yu Chen <zychennvt@gmail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-wdt
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
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        wdt1: watchdog@40440000 {
+          compatible = "nuvoton,ma35d1-wdt";
+          reg = <0x0 0x40440000 0x0 0x100>;
+          interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+          clocks = <&clk WDT1_GATE>;
+        };
+    };
+...
-- 
2.34.1

