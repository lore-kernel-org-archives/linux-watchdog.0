Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF8429CD1
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827116; cv=none; b=CtTMYE7U/ho19buGaPq73PLLZsOv15gOowXGgaHxye028kCl73fPduyw0U2j859XSj79eu9XESiancdgtsblBzZ7tIVzm+opE2J+oRPi8o+OF/WPuG3jVQYqTInwdZEqovG2HRowgZjt/p823NkiU4llf10mpT9wDLpHRoHqZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827116; c=relaxed/simple;
	bh=MKjq23mwbHabkMkKyl1pk/U2S7bpmtBZr4AcT9DgqNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmFVCSxCC2pJ0iH4VFUHVZZ+rSy1Hf2jnFDw4Expad3nyDrLTR9xRfp7fMn5cgdTicvVJ9IS9KeYo038qQVkvHy7XflGpspHTsmL7FBlyeMqiIiv2Bg5RcO/OFDfuGZwwaOWZfm4lrAwn6ZcaJPogIAGcLUrNx3B9EJ2k/hO/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTv0XHcX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTv0XHcX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381b831d535so4749542a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Aug 2026 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827113; x=1786431913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYle3ok/ZHpbCa/gvJJfuJ/kdU7yLL+dRoi+qfcwl8E=;
        b=TTv0XHcXUHCxcof6iEz/59xWEC0/WfiqQvyMed6DlO3mfnqZYfM63ZpM15MsXMGGzu
         kiU3F+1bk9KS1bHmcYryNxzWBPMY5RYW8fN2YCb5NtASoELmS/t7uNrdFIEGgnjw0bFn
         M9GTt2vQdGbHiixeaYVpiySx07CB5JLFDLBUaeqL9YulPK+wCoE+zBT2tiEIneBQj/Zz
         Y5POnsp7a4VDfcBxe0GFJxQu6riQHAR8WvIc/uaNzH29xjFQPAtAnLJFIFfu9tXgEycb
         4LQ6m9xctoB5XHZIPUEBYuVqpGN5AGCPpRELNb9uSQoKJPzjnUjmoVy5buLbV7xJc1Dk
         8Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827113; x=1786431913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYle3ok/ZHpbCa/gvJJfuJ/kdU7yLL+dRoi+qfcwl8E=;
        b=YMAwsSvnixEY71L/1wwckaYU68+AoAR4W3klf1M7Yn7T3h1pooOsFUqhjCds8RDuz6
         nCNMSzrVsMNekDazLfDxS0TonrfGoV4Od2/RsE1NzlHqOwBkCSlszRhnz97uXNdG5BoE
         cfYcG+QDNqiSvasXP5Mymm925FXzB+DxS79aEO8NnfXILZYzUObcs40dPrDfygM9wVJu
         KAclQ3zwNBYA+Y/OqXODnfra7N2VbYbTL4b8fG+XymJshlXX5VjMqBgC5MTaQAOeNf7j
         emO1/g4bttYsV4ybxH1GwdlgAC7r/rnbehLjayr2ixMfAsuhxdDJg4yrdGC/dWxoSy+g
         lHiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrf/W9V7K7bWPo5z+oIf/jYSQY6SSYrDc+fqRTYJ6B1LfBIGEh6U5TIcf4XZVXvXtWBfvIBcbOhIWVyYeEIBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36xLM62uSkIP8rEldK5l+E119Slijo1PwpAijdGW4peV+Sfeg
	kz9fneoEAkFBAx8i02Cj7ZV5SxAwst97HmQVc7z4d2Mo7+S+hi+ZecW2
X-Gm-Gg: AR+sD12+AxmsPgz0MF5iy4fz7qien7/LKn8vYsyEAgGN1I8LbdwtxfZcHqPAIDK+xDT
	EQuDnxs9RYPQby3XANQbG4qE0K0QvWKiaG7vC1jmYGYZoFQgAx1Q4ZhxDYtVXuUcKaMxazSDmXr
	oY95osK7RkBnABqApJoUt2K2ROnpVVlqtiLyvaL3RW6IMljsByxEuyfyMGnG8K3uOiWeafHJbeS
	sgsFccGZlCKvm1z3R8ET3/UZCbOnRwfexrF/dVsKcefL3wfk8XtjFg40bGARLwhzKrsNnN0Bw1r
	V/5Uu/QZbq/QptjPTbj/Tz4UnJ7SsaNAg/EuRs++uQCobSpy0U2hGjPJkQeqUl5YSrRdLnzfe3A
	o6oSI+hyaGUNiIKo7YlhL19qXZYQPhGphho3FpUNkbIhFtxudwqGupH9sdEifCQ1hdC8WEBQmq8
	THT8sxrhOzvsc6oj0iBHSstGtEebBqv2/dHNsvkm5A2InPLsJy0oulSaCRhPoSCzjgAlwnOQ8Xm
	+H3lY5icB/4N6H5iJjkXOObxpBelwKVxVaQ5pGzed3ahpY=
X-Received: by 2002:a17:90b:5403:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38fbc4835fcmr12263384a91.17.1785827113305;
        Tue, 04 Aug 2026 00:05:13 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfd8ff8sm859815a91.4.2026.08.04.00.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:05:12 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/3] dt-bindings: watchdog: Add MA35D1 Watchdog
Date: Tue,  4 Aug 2026 15:03:49 +0800
Message-Id: <20260804070351.1846165-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804070351.1846165-1-zychennvt@gmail.com>
References: <20260804070351.1846165-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the watchdog timer (WDT)
controller found on Nuvoton MA35D1 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

