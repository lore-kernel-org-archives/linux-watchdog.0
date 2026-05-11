Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABA4C956D
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525473; cv=none; b=WNA8Nok3Dq1eJDMPwnODTX2QCbb+N1Cw3ZsTg+tT6eusyMPFemZuO16S2Sg3hp+LomdXixrd4wgSYWzULfO5GLo/rTnjMwaKVJQ67YRNn9D4aaBEKtz2AeVPoKCylsD58aFIMC8ceL8EVhy52TUmgW37SRlow922n8VMp/Q9zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525473; c=relaxed/simple;
	bh=ScuSn2Eo3m8qfkPkxLxCk22qONfBuFmTXHK4TsFSyPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkT+hDMH4H0jC6AWD8G/m9sFiNH2Krn/lDWhh5SIE738YNUH4N6HyehA27JHT0SVgAwnm3EZo4dByZxGBKJ/bI5Klt3u6aCe6qWEYuEoNn4TvNSRYsk/jPLv5NVk/mivoMNiNi4F7xDrN3JAchCBvJXu5EBKIuoXsqff9MLCqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnt+S7ZL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnt+S7ZL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso42852265e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525470; x=1779130270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxgQ/0UOwKXQVRrJFbE40xkB8Pb4iPrDGhrh4gosHyY=;
        b=Wnt+S7ZL9X+xAvlHP4H+8MAKgLKz0gbfGWFbhblcaB/V/wPgIjD5dyWDlrt+udAPXl
         5mSiBNhu0IGG/hn1dl3KaPlIkfHgGqIYKNK/C3dq4Ko4vedapcpSc3z0Frj4aUELQaSU
         rwyi2GE9qjvfdzscIvURQCBXB+4xiRVyUNW7CuSyYrVgijg0Bj8rQ106OXL7555R2BSs
         +Q6JXiceye9oZvmmEOGdHEPQnRJN2SjyaOO5AEUOFTpJhciggJdO2E36qxRI8yuY/8AZ
         wMCKqE8XjSS4x7j3oQuSRd1FmpFoVCP7a4Qm4iDdBbzDuc1zg8iffnXTi+E1hsKz5WXW
         HAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525470; x=1779130270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxgQ/0UOwKXQVRrJFbE40xkB8Pb4iPrDGhrh4gosHyY=;
        b=s46JHVE5DFgz9Efcz5QcyhTkeGlWcENJENcvdsb7VYDFgBonnJ0qaSKpN6vTXCbzv+
         j94oFWP7BDRgF4e1+NOph2GR41V6DshCovNv/Vgijq1q3OlOnukESIU0uiZBcCxm6znn
         5WVTPpcqcwCsLHj+ywC6Kl5RkPaKYUm4Ap63/SqUea9S31sPNNrsCibXBfLW/xJw/QN9
         SF9HUhR7I4yU0LkPYMDllv3HVXnuzHY6Jyb/keYlk9XQKsZIHF8eI2QEpu3imrVRikNc
         H9lvNmlWLpe2d/jeIWsUuA+foPTQykR2nowgZq2E/DvTQqsH0fv9bX1cMdCcFWIRfb/V
         K14A==
X-Forwarded-Encrypted: i=1; AFNElJ+4t+Py2F4VI7kXYkpjVh341Is7aPIm7BbBvcSgtZyyKokV7pxHS5wS0B+qlCbXJbhmL02CaFos9gaazp7AgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQRme+0BsK4mvLvO/FNnVgJqoK8nIUJNyFtiA2A0YSYdjvfnQQ
	d4SlWA97KizDncq1cXvIN1vO1mMPtkvDoadmo87VD4piTuZ7P0Jwm9/B
X-Gm-Gg: Acq92OHcT3M12kH8tSjC7puLemQJmfa2HP1n0LdjtvM07bL2kO2CQVhd54Y/oN3J0wQ
	G6gWe4Mki6EgTcZcvSqzls6lxALJQOjP2wOjq7mp8T27nisfUkDaW/dbR9YA4e7OeLfCVrV3KXY
	at7HiIBKtBw6zGnvoiUHf2EOkd3zlYjVVWx0/oo5Ia4lvRdMHUtCyjPqXhMWeOC+wNFNh243nEq
	EnY+zWE1ioJ5tDbfK5ygDsVgzz7r7lqUBCZq3uH5e/U4pNHzWTC1qngAuOXqVGOpWv2tkZcHEcx
	sfxKygbV3Gslutg5gZQ9jQpH4wk3V+3oX22a6DPooGWdMTqTtcrp4y8h0T1bUy4lwQDkzGox/Jj
	6RbGOT6vmB2BYyPQEVxtMZJiZ5ikPhbqx6xa9mSqBVKj5/MQQzvJkvmtHWpLmOmz5OZtGJKqDBR
	3ag94UIYoZEpp5LzIlkb4IgRguuoRXfpxAuHkL1A6hGTqGMyQnyKDUR1KWFWimrfQaNpR2+mcuT
	TCPoVeQzcAfwqkqntdKqGEkguSbMB5S2oBfvA==
X-Received: by 2002:a05:600c:4449:b0:48a:89d9:a419 with SMTP id 5b1f17b1804b1-48e51f2e67fmr395335165e9.11.1778525469670;
        Mon, 11 May 2026 11:51:09 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:09 -0700 (PDT)
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
Subject: [RFC PATCH 5/9] dt-bindings: watchdog: renesas,r9a09g057-wdt: Add SYS syscon support
Date: Mon, 11 May 2026 19:50:54 +0100
Message-ID: <20260511185058.1926869-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR)
resides within the System Controller (SYS) block rather than the WDT
address space itself.

Previously, this was handled by including a second register range in the
"reg" property. However, this is architecturally incorrect as the SYS
block consists of two distinct regions (0x80290000 and 0x81290000) that
contain registers for multiple peripheral blocks.

Now that the SYS driver provides a unified syscon regmap, introduce the
"renesas,sys" phandle-array property to allow the WDT driver to
access its control register via the system controller.

Mark the use of a second "reg" entry as deprecated in favor of the
new phandle-array approach for SoCs that require WDTDCR access.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../watchdog/renesas,r9a09g057-wdt.yaml       | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
index 099200c4f136..2f32c7401def 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
@@ -48,6 +48,17 @@ properties:
   resets:
     maxItems: 1
 
+  renesas,sys:
+    description:
+      System controller registers control the start/stop of the WDT, and halt debug.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to system controller
+          - description: watchdog IP instance index
+            minimum: 0
+            maximum: 5
+
   timeout-sec: true
 
 required:
@@ -73,15 +84,29 @@ allOf:
           minItems: 2
         clock-names:
           minItems: 2
+        renesas,sys: false
     else:
       properties:
         clocks:
           maxItems: 1
         clock-names:
           maxItems: 1
-        reg:
-          minItems: 2
         resets: false
+      allOf:
+        - if:
+            required:
+              - renesas,sys
+          then:
+            properties:
+              reg:
+                maxItems: 1
+          else:
+            properties:
+              reg:
+                description: Deprecated. Use renesas,sys to pass the offset
+                             of WDTDCR register instead.
+                minItems: 2
+                deprecated: true
 
 additionalProperties: false
 
-- 
2.54.0

