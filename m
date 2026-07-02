Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B6480DC5
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995492; cv=none; b=AWYh22DEmVMxdsmk46RmBGRecmIL5sDXov52tgKmzbhCNeozzweXbxj8AiXXtdgAg3PHSk46kCp5Q+yMNowigYQmQwopVXdV3LQy0RgBvSL/+NLG4Tl67UaGRq6MLx95w0PshfV4DOmmmz/+k8Id5RF0O2CbyM3vLvihXW2PcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995492; c=relaxed/simple;
	bh=u4hTc5blzEHReAE+9qeOwTXdBKyWPW//pATNVCNoHq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OV2KYWFUgIkNKjDVsNW927TiDciqitu6kpRGbomW1Mgq/IApJRZDUu0wB002njWM9YVI6PU8ocphwVuzyWflXGGhZ+FT7rqPPkACMTvfKQjRTZbE44E5VrY3X0/KJvXzN+RTqtGdeK3wBHLvdca+vZYwkhd7z5FvgVMRngszV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9zl4OfQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9zl4OfQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so11767675e9.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995486; x=1783600286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V51M+/oe04vuF+Mphkpe8n8kxFz5uYaP4IST+R1jshs=;
        b=d9zl4OfQp669HfmYnbtf5eUG198nf6KGD8ksasOVfxgf/34/1tjQwPSr8VX3KoYpDw
         NXFz8YWt4ODikc8MwbL7VarA2YBtwuo9I2n+FrcYMB1c/mtGMd7bQYN7Fn5gy/f0l2MJ
         B95BcrBMQUkdPgjBLwQ4pWAlssngLFtqkPD3Vwr/WAYRL6CtyJVPvYF7K4DtQ3JYEOPQ
         PR1LHxYgzd1DQn5pdvAyCUYvjgJLWmk0nw8mzr9Ft2woyvKs+IvxrndK06UJl2xwngBZ
         Su1ud2rJai3ZTGIzZgW7cSIu/51N5sqXe7N5kUMAWM6pE0dGPEiy7JMtLeHZYV7ajxzh
         pq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995486; x=1783600286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V51M+/oe04vuF+Mphkpe8n8kxFz5uYaP4IST+R1jshs=;
        b=lJ4RXjJyNrCPrsoMfJ3I/kmh5XLlPVZ5P5r4pLYz4CL5dnrLKiWYMnfjwpGx6Nut8p
         91feIwbSYLxeemVLcvaCBu6N6rJAmi6x5rysqnakE/ebxf6U6h4LcmXuKGrCP9n4iFXS
         hj8vC6JoGK15c09kzRI4riSztsRaHrfKSt0vM7n4thgA4xfdGlDbMZU/3wwZuJK9LcEM
         VaTV38cbpjg9oZ7janU9nXrdtCvYyKwTNzCPA+MAKM4bZck+eiU0C6LSPT1UzKFyBaH4
         zm+OjQxdC57PCGfdhQFSUs12aHMW/lmfFHmgTvISJOJDQ616Ti6U/z/ndrLu7InTt2+a
         Nk2A==
X-Forwarded-Encrypted: i=1; AFNElJ8JdY35QnYEk0QDoeJYGheNZ4FqXNy12/OBMoNLJVOfiVwR0bv8HIAZPLzi9uj4RJL8vPo1P6y2VjjG6EXjlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAuBnOEAANIpgmf726FojyPzdPbGxZqpI9I7Fr2DZsONHXBHo
	AE289FOZV1WMx/zTocVaq1kLgMra1Wj47/PEJb7feurROWgYbrsoWoG4
X-Gm-Gg: AfdE7ckdy+6a+fGGDrpA1qndKJgDeEHPI+52+wIHxMYSQg/pSo3adRSkWL5/WG1nbeq
	J/25huQ1whkGvVCnapadJwF8eKSqjRAOvjXJ1r7vzgKxIbDJ6Hk7+3bmBR2ImaEnvDGQOLr7BL6
	SNL2DNZvZsT/YqkiQR8xnCFq3PsFFmPXJ5idgOHpNCiREGocJyMphGAn9Ljwx5az5Sqx8EExWaX
	5Q6B6DYnHG+RhijXABMlUDIfOBb+MpNqed4Rf42VQVJENgLeLfzpxJb0a3LzS7+G9PCmAqkFYh1
	vBrbEOpfnAOaFfOaIYugIlzHSlgyTWnkqdga1/FuQU9GahxibQL7SuGXdzEplcTTkP4UKE6UfUx
	qfUdlIibGq7nNSA9OuvkXpbkwHfPo2r7cukf/6dptTeCFtfEjnaBmD1+PM9ziXl7ZQ4n2sai8RY
	+LAE7oNmduqDV/xcsrEKJyvD2SCpAum4s2UXqvZ0mHy2hvmX7qUBOJneZ/uy5RZrvl/ZA/JV+/7
	yih0m1JYxgvB0d5wX5vv9ajkjI=
X-Received: by 2002:a05:600c:19c8:b0:493:c1bc:79c4 with SMTP id 5b1f17b1804b1-493c3cd494fmr75775095e9.7.1782995485918;
        Thu, 02 Jul 2026 05:31:25 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:25 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC v2 1/9] dt-bindings: clock: renesas,cpg-mssr: Support RZ/T2H system controllers
Date: Thu,  2 Jul 2026 13:31:04 +0100
Message-ID: <20260702123112.161160-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/T2H and RZ/N2H SoCs features system controller blocks for low-power
management and access control that reside within the CPG/MSSR address
space. To properly represent these hardware modules, allow them to be
defined as child nodes of the CPG/MSSR controller.

Update the CPG/MSSR binding to support child nodes by adding
system-controller child nodes using a patternProperty, requiring a reg
property and a renesas,sys-block property to identify the controller
instance.

Restrict these new properties to the RZ/T2H and RZ/N2H SoCs to ensure
existing bindings for other Renesas SoCs remain unaffected.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Updated commit message.
---
 .../bindings/clock/renesas,cpg-mssr.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
index 655154534c0f..ec13fcaf763e 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
@@ -99,6 +99,41 @@ properties:
       the datasheet.
     const: 1
 
+  '#address-cells':
+    description:
+      Required for the RZ/T2H SoC to define the address space for child
+      system-controller nodes.
+    const: 2
+
+  '#size-cells':
+    description:
+      Required for the RZ/T2H SoC to define the size of the register
+      blocks for child system-controller nodes.
+    const: 2
+
+  ranges:
+    description:
+      Required for the RZ/T2H SoC to provide 1:1 address translation
+      from the child system-controller nodes to the CPU address space.
+
+patternProperties:
+  "^system-controller@[0-9a-f]+$":
+    type: object
+    description:
+      System controller child nodes representing sub-blocks for
+      Low Power Management (LPM) and Access Control.
+    properties:
+      reg:
+        maxItems: 1
+      renesas,sys-block:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Index of the system controller instance.
+        enum: [0, 1]
+    required:
+      - reg
+      - renesas,sys-block
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -126,6 +161,10 @@ allOf:
       properties:
         reg:
           maxItems: 1
+        '#address-cells': false
+        '#size-cells': false
+      patternProperties:
+        "^system-controller@[0-9a-f]+$": false
   - if:
       not:
         properties:
-- 
2.54.0

