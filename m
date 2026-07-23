Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F33AFD02
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786907; cv=none; b=HsfnlDnX96rI5vZbDjsaYHp74P6JpASXLHIUpCt8pn5GmuuRyrKY8hHPcC/mA5gMjADfPEPz4Y0r5uDldUbwIDQWtZq3mIKDaR4H4eO4LsrbLilz8OzJcuVpVA73fOnY23lCmBAaiI3PesPJ42ZSDBG1YUFrgcJU2gIQrfG+pkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786907; c=relaxed/simple;
	bh=/xlEVw/KiT9/XEqDjIphDYd3uSSaRu/4jZjjAdQtqd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZQ8JDZBvGRrWrhAJgfp4VzPFvpwkr822bXOSj16NOVPP4a0Pd6QeKNHUiQlv2XV4D/yqTq06GnwiySG3sqbpnycqNGXYeUfqNoltbz3T//5liXpPvDvqikAmebes9f6NBDBChrx/PkiS1LSiv5rdXZyWOuIiXgsMbwKn4z8tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUSgaNRN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUSgaNRN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc73e322dbso3112505ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784786905; x=1785391705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzDl4rio1x0zKV1oZWrhXk8ePWLshifrG/jhvgwjQz8=;
        b=FUSgaNRNYirkB6AxdKLfbyyo9ngZpalOrWH4VoLMWWOc27twogM5Ph9H4sn8gKq9dF
         By9OXunWqTetxjMMHHnKXmTxrlqCmdRhsXir03HwJUHyO6LfDB4H29M3zEbtmke8TypV
         U777+BnVhEo8MxxplOhs+hbTQIB0kTUJ54a1Xd0yR7znrS9hFnOB3CyxtaB170C8QfB/
         2Hk1VQ935c3qISGo8DnNynK/xoqHoujdLKk5JiKuFgGNgFiss3WsppzgUo6AlMTCAFg5
         SZSteA+hFSaOeUeJP3hQLM5J0vjMxFIuR6JdRWOCZhh9m+IRuoYzsj95YFc+Ne/kKPoY
         XN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786905; x=1785391705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzDl4rio1x0zKV1oZWrhXk8ePWLshifrG/jhvgwjQz8=;
        b=fDlyx/gi/ipLXhbsP15CwJ9dJ1qI1Fu22Sfxan8c8CKfjYK2qytXNEMHpkgu2baTnT
         KRLSRbFYVFWPSoRLqoWZIr9sM4aq1PlJv0rd2ks0wMgVAjZF6OPWH8Jz6chrMaca7ODR
         0XQTVKPAKSPDvADDWh9zMyrChk/2K+TO/D4doV1iwm477NcXNZOOfZcRqhhfg4G8CB8+
         pDoqsGP8/kFB8Ygf+8D4LXAagyuBnGqLjCW4aYgZdg9BSUz3GNqhEsWbqNSIY/U+jzzR
         9SqJlyQjGHFEFR80NB5yeuKwyjKvyB84NCR7hXYjPV9oFsY+MrnIY+ilehks98uYIH1q
         m6cQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMVKRvYtCO67qHeSvDi9wQiF/Yfkm/cqrYxlBTM4PbwahFykOkC1UXsagLB6X2EyXUPt33qUTmwtIOmFFsaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVr8Msbp4khbdXiILc6xFjnHHGmzH2hwErGZokr3V1MqTtmFvX
	PeEdPtbCh8IKgEYq8A97gkmwSb6ir8esC69faqdWfiiEKpM2xFctg1cH
X-Gm-Gg: AR+sD10/L/AcfvF00MTIJiiTAKoluCs6z9bO94dvGAxGADeZqETv2ni8f8+nRipZmK8
	1BylT/qg3GhOI7Bx/Fp54Z4bw6BiX7IYcix4om/I9OCDFBJ3Q7QmEqR60LJxabISl/qZo5ShPqw
	YElf63j3LnhbMoRF55s30M5W9PEPbMDlFFkiiNK4laCf/xtyqRHxKS0F2SbK78uTzEnIiZMy1CS
	Egj1yrD5i9MVATrpYKaTDtF9Ga1awIguSPMw67+4cP7KsqNtBF5pA6KyhrEpyByaLsS22DlEi0C
	nfzWSrTbTXTohPeKjf/2IEl3R4cfX3UDyM4apobre5F0AM3gFOyk5QydWbpKtoiTYH7jGrj+Md9
	YdYbGc1mkuQm1AnHatx5C/cE3bdHkq+CViPH1YOyvHjuhZGyAu0Ydb4oMzYPZroBwpNfEcXhSw8
	K/B3KBGMXlwA3GxdnNe1HcWPzCa1vplTOEd+PawQihScGYDdlVZGjrwk7Bfi/7
X-Received: by 2002:a17:902:f68b:b0:2cf:32bc:971e with SMTP id d9443c01a7336-2cfa6c66618mr20561685ad.29.1784786904767;
        Wed, 22 Jul 2026 23:08:24 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f390dd2sm26071285ad.79.2026.07.22.23.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:08:24 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: watchdog: Add MA35D1 Watchdog binding
Date: Thu, 23 Jul 2026 14:07:52 +0800
Message-Id: <20260723060755.1596858-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723060755.1596858-1-zychennvt@gmail.com>
References: <20260723060755.1596858-1-zychennvt@gmail.com>
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

