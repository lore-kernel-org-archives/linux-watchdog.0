Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C8426EA6
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525468; cv=none; b=gO7KRVFVmc5ew7JAAE6BBNS258uIN378B7AvAtELO7CdJeJDcnzUeQlkGUlCGgbrkQra/nIaDd3RK6RzmE0N5ysetAEgyhOCXXWDIiP4w41hff73DZMS0M9vdEpS5KWuNxC7KyrMPjFCxFPSdM7ujibBtDPwTH3LDDvNjQEm1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525468; c=relaxed/simple;
	bh=L8qSGL7/R0cKnVz8Ctv0uV4rXSfX+m9YTi5M5pJ9WS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqNlGWf5peEgcWW9O4osj97UYDBwGF3s32bITQlHV7PsGzdWu/qfdJ/qugbCi1FkwSdI7DIj/FR+j5QAEJzf9cApLQGPg/EcySqe3YiVA3Z4aqiJFS9ei0YnU1hNtHIS9ribjWUQ+ulopMhFK0dYoXjA/mSJ+ELuNkbfts6ws9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wppg+EpM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wppg+EpM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso28508195e9.3
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525466; x=1779130266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMjDPGDJ+8xslo2jimMn/IGPGbD0V+wq+ySKoQFnLIE=;
        b=Wppg+EpMpINu+lnhR4ET1GHIseBJKvpjE1Y0ron5Lu4tUfBE4MM6673SqBCAJLkKPT
         9vxTuffieziEhwRvWvmKWYj3n5A1N6aw5MlqmzftKk7t0G5ZoyKqt1POqPkIev5eWQyr
         7i155bC7JD29tF/WamggHcPqDY4VKpU8SrIS9BeooQA0BXvJNR50o3Zij6T+pJAwDZpM
         veUZaseS2NAZdAnDcYwOtILYT3oXsvBRFIK4jsxR+bjuSZx1w7FbAvVDFMHXx5Ph4UTq
         zXj5hNsvFq4K8hAOKxEJIlZokofB88ydAHj05/k1Xf5Fy/Zp0VdnwIrlDQhX/pMVb8aJ
         4evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525466; x=1779130266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMjDPGDJ+8xslo2jimMn/IGPGbD0V+wq+ySKoQFnLIE=;
        b=mkG/mQnz838XNqyADUQyDVCORYdwAQSha0KEKORBcSYjVfOIkJA/hnjymPNMj4q98h
         u6ODseN7Msy4k4EVeFSw7a1ef8dt9GI6DUkvCOZTlbQA5DhZy3dextYfn1/AbJKrQL6X
         oh8sVtJsN/dry6GDrpOQHH+MDU7KJwzc/zCb7K+dtVaI8i0Ke1r8ou+h9aceIHBYnS79
         AbI+D8DT2I9l3w0nXUG8iiQaC7HtcErsg8E8uGif8aDidHZh0ubN6kvvhimRBr4acXnw
         7DWzTcFeV4jyZm6aUGh1nKF3v2xahotKLP/TTCEohhEzdjQ4K+7kj0YMBPcCr5l7EH95
         9fJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MXlsDIQcwaNlyG1i45QA4si/v0OL1t/rbwZwsY5m2RePZSfjRTdmi4kSPQkFWM/MsftCGAgL8dS7F3M40iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFr+Lw2/HN9gLxpxdK7KIH1hn0ptqMEKi2KfRGvXetcCHWRjP+
	z2J+BVQRhUN6gfFBijv0fnDeTLVPNPwGaJjnFluPUZUK2AU2DTEDxhln
X-Gm-Gg: Acq92OFdlDTI1rZRAXu6RgA1RDOZyN1K+PqznrrbETBAvSsvI22zA2nma6YMmWzvMyT
	iYPlVIR6XuuKZ287IoWB+Di3Kq4R27fqvKc/+fkHq5vYkWBAR89AUGCeunStYJBEb69jLQcjntw
	GY2rHqEV1cErWGouDZKg3kJSLKcTWSTpzMlBJa2io72ba7bQIWO/eKGdCICVgbOBVAM8Q/M37Wl
	caBFu3YOiuXzaoGIFmFJscmIcTHGYaY7stpL/hOc76mqhbsiJXJEn9nxrPaKKrs4YOO8LYHrlPC
	OgX1WzNFwfUI9IW+cGuewLLN3OaMv5+8KGV31gXo9ZXomSo0Tcaqgw7T+BzP6WARqd+/FpyE/C1
	7HE1JdqWFi56TLcI0kcYJltFAzy7H93W2hMEPNRI8El5LQlqRhUtFc8357Gg3bCKz29zGUckhNB
	6IxvePXF+39dEsQwTn5QMRQnk8WBMKwlmveYY/4uj08Jd36yLqu5RS0MqiL0hPtQqsyLb6aXbLX
	lJp0c43+je4Vnxm1ueZks4GJbagXn9BEFksIQ==
X-Received: by 2002:a05:600c:4355:b0:48e:85b4:ac7b with SMTP id 5b1f17b1804b1-48e85b4ad2dmr36220615e9.18.1778525465458;
        Mon, 11 May 2026 11:51:05 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:05 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 1/9] dt-bindings: clock: renesas,cpg-mssr: Support RZ/T2H system controllers
Date: Mon, 11 May 2026 19:50:50 +0100
Message-ID: <20260511185058.1926869-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/T2H SoC features system controller blocks for low-power management
and access control that reside within the CPG/MSSR address space. To
properly represent these hardware modules, allow them to be defined as
child nodes of the CPG/MSSR controller.

Update the CPG/MSSR binding to support child nodes by adding
system-controller child nodes using a patternProperty, requiring a reg
property and a renesas,sys-block property to identify the controller
instance.

Restrict these new properties to the RZ/T2H SoC to ensure existing
bindings for other Renesas SoCs remain unaffected.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

