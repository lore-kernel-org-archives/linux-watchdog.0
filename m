Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9C41E6B4
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205286; cv=none; b=EHB84zKCF8yA+T6C96ZXFNXULAN23wK8ePalSTGLUDs3rvvvQcYHOUxp6BWxPlvrHtbMqRsEK0oZuFMUu3Jks/vxvJftrFb1Yo+U5ZSCWGOBRKxKr0+hmjwWnkyU4cSqjsA9JSdJUPnC6MwEp9ubgBg0kn2FH6HY8sBm8vOrA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205286; c=relaxed/simple;
	bh=ZqIWP+AhPURiWzMGMvpsY8KCXG0v5mBRy77w21Oc5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ0zmKj/E+EPmxnx2ETr9sOiJ6Vc6T84iJ6n+x5/vbjAg1Wy/EFVyNlgEdTsBchEzlSjTyrkITOsUIc1wuKNcU+0bDhhszUv0SNwDWm+HZ+WcZwYEIqvyic70uNKUGFG9aXD5tVKDgJhKgpIga5h1OB84vTtxDFro1D57hEZ1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAHlAGDA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAHlAGDA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so5806959f8f.1
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784205283; x=1784810083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdm90W6HWb62Z6VqHGsM8IzSM3ExZORe1y6Jx8qkLJc=;
        b=dAHlAGDADgRYj5QSP4vt/cCDQUnodO3axYjxNm1hySclyZM/vI8dIaKGLZ0R/o+H83
         GeSBQ3LYEATUpv++5fzLFSbEb0bH9JWJgAzTJdgtQKsm4J9Pv6AG+x1sCx86AQxFan+T
         lW/k/0EYsxyJaohc3lQve6i1YE66ixfn+orLk42Xoy5vYs3kzUv/duz/j5XAvgGLMpop
         DRKD9IUh0lew1G4xTsMNPtWivS0+skJGRlpdAxYUjbzuNY70eTVFovUot5Kn2k9Ex3fo
         WOTaX5DaZqRIkVapLsPEKwOyvi9njdUopVSstHwjAfUdWm/0VwePFgh0m7Ev85OJEu6i
         DSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205283; x=1784810083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pdm90W6HWb62Z6VqHGsM8IzSM3ExZORe1y6Jx8qkLJc=;
        b=fIHvLuHyPjaC4fP6iet5xBo7djONlSJnsc73gpC8BbG25HEwe1fa3whn5fJxq5ZqU6
         708Myx3jLoYDTJPwwD2HxAlXUO35VNcb4AeKvtwyrOoMOY4yJuwvubB11kNOWX3bRS1K
         ZtD0PuaeRBhrvfUq0kOwDiFubok51U+yyvCk1aJ0Tajs8uolbOi5Iw/Q+AkTOJRxvhl0
         GSrMPXUJe4GdBdZvkf+i58RW7qpcwEaYpKIUH4IwmX8jbZmJVqgEFtFGKMFQthqJ8ERe
         Z4UikigIeZjNNqFMQdEDFGXoBc90NCZB0KfhlKoV6JaUtVbrpyrCZddGRMYwF/OC/UvX
         Hcrw==
X-Forwarded-Encrypted: i=1; AHgh+RoafrEwvW1J3OQYLgN8uiIcYiMJlAKg0q3X3D3JT/jgvcJ6u6XKOQrvgh78zcbPS2WauR6jlWGR6L+AO2i3sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCTPehgjZZu1cysAEYrkzhJIr8q+6seseNSpEOBJJsJP70GwU
	hm2OtZKEMRqiBPAdlQCkq0uOuRA96/WVOfLImwra87dbOkUwaxBGaFHD
X-Gm-Gg: AfdE7cm31PwKwJZadXKQs9aPKrZ0gMfZIOI1Hr6g/9OL20q8Rd4yDRGhvx31YZcYe8b
	Ojkk1bWeL15fmwIqa8psoL0UdgqT02hABDW6y/rF6jKBYoAK7F6eAnOnwZ6WoMu46+MTpVh5Med
	osJ+x+8eI2isXDuRxvLwjR4UQhJnNo0d7h+juZ3cA1cpU7lGtspT0HI07/PVWllGqoXcQn9N/cS
	ADQUNstkPHMvoZfqKHx+DVH+kLq98Ue/hP107MP7/XGe+AwAlndOkxNJxaAqkCgH1fzGRfKx6M3
	fKKTJwDZCaF/zPXLZhIOOetjlQ99e+rga/FP8hl4ZNGAGSeq80wLHRh0l6s1xzLpO+6/XtxANtS
	lWei22bbUvsN1kxcR0syiCzuatJvSdOP5p+H7fXKs0OLLWYkhklO6Cz6ls0+eoIxGA1/e+m2IV4
	iIxs2457HY4wDzcHPvLpypO/RyALCNhO43TUTEdQw3sdC7ycDg19LKWzxi3olvj2cqa1TTUQw1t
	4RfPa5GUulq3Rfn8C5ekL4i0Zg=
X-Received: by 2002:a05:600c:1f91:b0:495:3f84:a792 with SMTP id 5b1f17b1804b1-4953f84a866mr52933995e9.12.1784205282702;
        Thu, 16 Jul 2026 05:34:42 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4150:a2d7:2b6b:840e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm48582645e9.6.2026.07.16.05.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:34:42 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/8] dt-bindings: clock: renesas: Split out RZ/T2H CPG binding
Date: Thu, 16 Jul 2026 13:34:27 +0100
Message-ID: <20260716123434.2576253-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Move the RZ/T2H and RZ/N2H clock controller bindings from the generic
renesas,cpg-mssr.yaml schema into a dedicated binding.

Unlike the traditional Renesas CPG/MSSR block, the RZ/T2H and RZ/N2H
system controller integrates additional functionality beyond clock and
module-stop control, including reset control, clock monitor support,
write-protection registers and other system management features.

Split the binding into a dedicated schema to describe these SoC-specific
features and requirements without complicating the generic CPG/MSSR
binding.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- new patch
---
 .../bindings/clock/renesas,cpg-mssr.yaml      | 27 +-----
 .../clock/renesas,rzt2h-cpg-mssr.yaml         | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzt2h-cpg-mssr.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
index 655154534c0f..933316c34372 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
@@ -52,16 +52,9 @@ properties:
       - renesas,r8a779f0-cpg-mssr # R-Car S4-8
       - renesas,r8a779g0-cpg-mssr # R-Car V4H
       - renesas,r8a779h0-cpg-mssr # R-Car V4M
-      - renesas,r9a09g077-cpg-mssr # RZ/T2H
-      - renesas,r9a09g087-cpg-mssr # RZ/N2H
 
   reg:
-    minItems: 1
-    items:
-      - description: base address of register block 0
-      - description: base address of register block 1
-    description: base addresses of clock controller. Some controllers
-      (like r9a09g077) use two blocks instead of a single one.
+    maxItems: 1
 
   clocks:
     minItems: 1
@@ -108,24 +101,6 @@ required:
   - '#power-domain-cells'
 
 allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - renesas,r9a09g077-cpg-mssr
-              - renesas,r9a09g087-cpg-mssr
-    then:
-      properties:
-        reg:
-          minItems: 2
-        clock-names:
-          items:
-            - const: extal
-    else:
-      properties:
-        reg:
-          maxItems: 1
   - if:
       not:
         properties:
diff --git a/Documentation/devicetree/bindings/clock/renesas,rzt2h-cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,rzt2h-cpg-mssr.yaml
new file mode 100644
index 000000000000..1b90289d61a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,rzt2h-cpg-mssr.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,rzt2h-cpg-mssr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/T2H and RZ/N2H CPG/MSSR Block
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description: |
+  The Renesas RZ/T2H and RZ/N2H CPG/MSSR block is a multi-function block
+  where apart from clock and reset handling it supports other features.
+
+  These additional features include:
+    - Coordination with the Clock Monitor Array (CLMA) circuits to supervise frequency
+      integrity and initiate safe backup clock switching under fault conditions.
+    - Low-power state control registers (MSTPCR) that dictate module standby and core
+      sleep state transitions.
+    - Hardware write-protection logic (PRCRN/PRCRS registers).
+    - System-wide reset generation routing, debug counter halting, and module
+      configuration setups for PCIe and WDT IPs.
+
+properties:
+  compatible:
+    enum:
+      - renesas,r9a09g077-cpg-mssr # RZ/T2H
+      - renesas,r9a09g087-cpg-mssr # RZ/N2H
+
+  reg:
+    items:
+      - description: base address of register block in Non-Safety area
+      - description: base address of register block in Safety area
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: extal
+
+  '#clock-cells':
+    description: |
+      - For CPG core clocks, the two clock specifier cells must be "CPG_CORE"
+        and a core clock reference, as defined in
+        <dt-bindings/clock/*-cpg-mssr.h>
+      - For module clocks, the two clock specifier cells must be "CPG_MOD" and
+        a module number, as defined in the datasheet.
+    const: 2
+
+  '#power-domain-cells':
+    description:
+      SoC devices that are part of the CPG/MSSR Clock Domain and can be
+      power-managed through Module Standby should refer to the CPG device node
+      in their "power-domains" property, as documented by the generic PM Domain
+      bindings in Documentation/devicetree/bindings/power/power-domain.yaml.
+    const: 0
+
+  '#reset-cells':
+    description:
+      The single reset specifier cell must be the module number, as defined in
+      the datasheet.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#power-domain-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@80280000 {
+        compatible = "renesas,r9a09g077-cpg-mssr";
+        reg = <0x80280000 0x20000>,
+              <0x81280000 0x20000>;
+        clocks = <&extal_clk>;
+        clock-names = "extal";
+        #clock-cells = <2>;
+        #power-domain-cells = <0>;
+        #reset-cells = <1>;
+    };
-- 
2.54.0

