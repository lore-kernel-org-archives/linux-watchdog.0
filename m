Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1747F2FB
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995497; cv=none; b=m2FDqToGtcKm4L1N29vthBRdBdjAooSa2BFZcdmBRPt6DtakoYMLzAVygfwfv62+pUTrsdkI7w3UguL7USh7TjBa6bXezC+Lv6OfdEvxZAi7wAFiLTfJq30KGEvLZZh1D3686leKjU0EGtcCQjJsNz2He9o5u9y/kXFOzR/pMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995497; c=relaxed/simple;
	bh=PmDTNVsDWfiEJmr+uQTPVzkjhlVGry8IKEMbCyAPdqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDnMPld2KGa4k0PKkfbayv+uSCnz1O1JNTI/svMUZjUctkglcaJ8wufr3os98Tip7okCCbzOglwaEG+pzAqaUKoKnpcctMuLamOSd6E9Qz6fBd/HGk1uPx/CzPert6OfB9uvfGGpok2dQ1joac1WPyLmvGyDHnWXZLrHRvm4wGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofPq5Rk6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofPq5Rk6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4745492ed3aso1147426f8f.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995489; x=1783600289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmlYZPisAM18uLrOj3e2exC6+6sOiuaqyI++DJghzLo=;
        b=ofPq5Rk6tu6Wj6B19gVx3/JogaLKD2UElywLd9RUs4mZWCwU6XqZfIv0mVIagQjHIK
         pSoJN7ztpTHyuc9bq/+9z6kgwMojbs3kHSxmlO6rLYzttyvSdRF59as7rb/LkZPGSK3N
         o3G4Vacy2b6JGgLZ3lSo9e1zblHtKal35lp8pII3u4eBkkEhfgSNq90DpPdgudEt6Dn8
         nIN8rbDc2FE58UbRSsL5PogC0z+5QThuQSOqZK95gfwk9fWIPvONgYwK0MNTKxdJOZf3
         nuS0TmWSBBtPJ5AWk/Dz5Dme622ySxv2OmgYI8LdqIwDxg6xnFnrq6HIRC0H+J7BmgZb
         Oyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995489; x=1783600289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HmlYZPisAM18uLrOj3e2exC6+6sOiuaqyI++DJghzLo=;
        b=fufV9tRR3EC9nR/RHmgXteLzhiBRvGKOQj7+KEr2mXHZj7D8W1hpER1S4RrIlkNlUY
         tutvhDk0FRWpAnHsRIYiWqtNj60l8mLzocMTv/ZtJThrtD7Ly4fYHtQ7ydotfQsYZNi4
         pbkFW6291zmTqt7WAIoCjArD8YvHK67gtEX5z7pFH77eyGXnqLOX6//7MboRuUCABcFQ
         eiES0/Jpa4/WT6F5TGF0VZ/Jk/nFstGyA6My/iW48T0rU/oJzp2aHEINdwpKt+gWKiNL
         3KBDdFHFu4ujg9nFC5GPgIrMCyG+Xu0i/7SoLzgkPosmzbDktlCnDC15hDC+ccaarINb
         xoOw==
X-Forwarded-Encrypted: i=1; AHgh+RpAUsLJzr+Rai9/DK76Fi8C8CeoY0hhKCcGJm/qVaL5yoi2INOYIiMaaYX2uhAbl5VaDRuWQbCFXehzDK9Ucg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWbEuf4L/F3sRy1UFYoH6+SrA+n1Tx9KNM8oO/Mo2rO4iL5B9
	LTYhhvAhI0Q4H4g6m8Y24l/msLS1dT+sW1Jz6MS+Bp7yKxVAIKL9AY3I
X-Gm-Gg: AfdE7cl6Vg30TMab5q+vnaJC1kDgylhog0md0d7ag369r3LuPIZA67qzveEBHXgb8Td
	0PxmKyiYSxlcmW5LaeVj+EDPZKrlA4KktJA0YNblsu1ruxJf4HTPCIlXPzCTwvp88dygNj7jfPk
	N1J5mSQ9VGicxfpidP3W+ZmCCy6UOQETGqV6jXG2Hoj3LijmbKeK4tQw8js7S9i8w3Gx8SW8cvr
	ORSQ5QQdgPgqS1DTOZR4WF20Yu8uwts4o8z0dgm52xjSgQxfbf+3RPRQYsfnWKe9z6cSNx+4llh
	WioKldB2jQJHQmf5Rt79f5vmkwKVi8LuYpsz160LK3O41+zU5Y6/NNhcbbO2+XaE7aFcMcJT0Cq
	ho3EpkPvZ8xelAzMUt3ebFwr9bZdYAwzIdauAkgMmAdJJd04s+VR14tkbWK8LidJU93ndRCSU+1
	kmPNOdFFcDqvsJL8yebLE3qo0BgZ3fzc2ATQNgm79bOcyzXjM2wrQAiuKGSkchF5GfOHzraEEE5
	vNIxTGVzDq/P/+2Yeheuy12jCA=
X-Received: by 2002:a05:6000:200d:b0:475:5454:49f2 with SMTP id ffacd0b85a97d-47757e57dc4mr8804566f8f.24.1782995489181;
        Thu, 02 Jul 2026 05:31:29 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:28 -0700 (PDT)
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
Subject: [PATCH RFC v2 5/9] dt-bindings: watchdog: renesas,r9a09g057-wdt: Add SYS syscon support
Date: Thu,  2 Jul 2026 13:31:08 +0100
Message-ID: <20260702123112.161160-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- No change.
---
 .../watchdog/renesas,r9a09g057-wdt.yaml       | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
index 975c5aa4d747..3fa3044cde6a 100644
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

