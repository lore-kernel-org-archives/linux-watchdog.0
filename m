Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3537CD3E
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218804; cv=none; b=mDc4CV9FtIeJojCjNl/HOfJpVF6QTC3X6G4akN/JLjzEpqx9pPaNPLl4wkDLKyQ9zOvL4cQjWsSHCb+pStnsvTVv6tLTKQmVaf7eqch7+638wN+2zPvEtfyY2mOXCjQY1WzdaFleusCFgdSuXjwqgDs74zcQL/08B7Joq7UVMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218804; c=relaxed/simple;
	bh=4daVTrSjSfN+ddZbT68UXgJEAvj9+FvfkJvj7Q7oQzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rikjQjC3Zijud6dxSFEfxLnKo6cjPWGGTs003X/wG+ctqhcKyRWe1PZr6uMb8GSx+qZT/qZvR1bQ+oy3IfTvtKVa05/Cb00/4Q1tQydINhQq+7UrbojOmoia57YVfGB7l/BwRz/r7YvzrUPOCjDOS+R5aeosoDzSU/zogihexRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrX6D+Cl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrX6D+Cl"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b4066so7051847b3a.1
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218790; x=1784823590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v07hhIYgCpv/xDn5L0MGVWF5jtYyj0RekFw4y7lgqkQ=;
        b=CrX6D+ClqzdTTCENHIRT7NW4L6+x++/c61jSYfCjjCiIbcV444oLhv8AKdjm5nFXCT
         PH/pnu1rEKd20hHLMueQejnRcZ/TOsMKbPvfN9ao7g4uHRdmDb+Y4+e46XlFBPb9nlvh
         Pw4KCJpiC69Dag5HJTw4NpH8e59PNF53bf/I6b9gUnt2Tj5hqqAfbImpkb7+UKdZpQUk
         SHi12p/5k83H/L+/FR3IMQH7eknrFk8nbbSn9ZOaB0f1Ax/tDqh67A6D7QA4sdIuw/sS
         gD5E5SN98Ea3Re3b5Odt0RVGkDKbmbxqGJD5sL1nn+dvqh+iwQwSBvZs88x/tRwL6JMe
         7S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218790; x=1784823590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v07hhIYgCpv/xDn5L0MGVWF5jtYyj0RekFw4y7lgqkQ=;
        b=QiIAYa2JvxoIzWRc675vA/zvt2u1/Fm/mLNOm5cKDxOJRB6+7IMua9jRsPBeG/DCnP
         uH0O9w30zu3YwXUIM9vxb9DUA3fWBoteFgJpGvuOmSwHWm+OPhlKNGuaj6xysN2zZWQU
         eY7OqImdgWP8+ip/jrTU6Sv7gyoa+lFD/SU+GutW+bLTYbpH6T/hjUqZIV5MAJ1t2Qx3
         TZ7cmiv0eaOwfopSMW7nmqMI5C2ONfsLHhreOhNI3Wu0WvtHcoxwIYFfQ46l+85XhqEi
         HTmItlKK3Tjb/owYZCq6ATY3plVu9K2KQZdvgR/C7M7mo7ZTG26MNHFhxkpLZT4CEQRN
         sHVQ==
X-Gm-Message-State: AOJu0YzzkdMnoP9eMc2lqtKLZvlbvgakPyDijB8bce+jPx7QylCqUXEh
	pzhAaRHwUl7t6Qtnb7W+7by9B1CC2W1+tU2to3QpG8Ny6me5ThOEQ9qt
X-Gm-Gg: AfdE7cm7QrqARVDpBU09y4Q6ydHZuyiPewalz9Cl1/dh9l6eNhYV+arSE9I28H/W1QO
	EG3hq+ut1SSheDPQgVodI0OyyzCOXHjsgTmTbVH+3G4jZn/Hi1RVh7JNiEeg3hYj1aGrNPXWgya
	DbkmTysL78zeH2MicD2L+dnz4nbyMMbU1C8fYklE6CPMj8qtgq6PbO3cUg7cLB8upCo73U3zWly
	Wbc7sN/Vo4mU5ROW+h31iMmtGCmjxzz3aIveNdjlXYl4gZBnxG+06j9JR+7wKzl/w55cca96rS+
	PzZqVn7KWCrLAfgbboDcJ82ADtlAh9M8knjkHF/jTaN4TCwN1ZuU7nU85G14GVeJm+nQAeZJH6u
	87mE6GpvDOb26twx9UGvfETpBL+KBut+UmiEAcZPEX6Uuo7Yx1ycRmWHkPpYH3wTAzZaIWqCVzX
	wx2zh/8YYVN2AOpsz1xupCmhC3tSF0qWEDjw==
X-Received: by 2002:a05:6a00:4f8f:b0:848:2f7a:2e50 with SMTP id d2e1a72fcca58-84a67308928mr7306361b3a.63.1784218789947;
        Thu, 16 Jul 2026 09:19:49 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm5092661b3a.6.2026.07.16.09.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:19:49 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Roman Vivchar <rva333@protonmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH 2/7] dt-bindings: watchdog: mediatek,mtk-wdt: add compatibles for all SoCs
Date: Fri, 17 Jul 2026 01:19:18 +0900
Message-ID: <20260716161923.266315-3-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver recognizes each SoC-specific compatible, update the binding
to list them in the top-level enum alongside the existing ones. Keep
the fallback items definition so that old DTS continue to validate.

Affected SoCs: mt2701, mt6572, mt6582, mt6797, mt7622, mt7623,
mt7629, mt8173, mt8189, mt8365, mt8516.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml           | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 953629cb9558..f4eaa5f7c5bc 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -20,17 +20,28 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - mediatek,mt2701-wdt
           - mediatek,mt2712-wdt
+          - mediatek,mt6572-wdt
+          - mediatek,mt6582-wdt
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
+          - mediatek,mt6797-wdt
+          - mediatek,mt7622-wdt
+          - mediatek,mt7623-wdt
+          - mediatek,mt7629-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
+          - mediatek,mt8173-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
           - mediatek,mt8188-wdt
+          - mediatek,mt8189-wdt
           - mediatek,mt8192-wdt
           - mediatek,mt8195-wdt
+          - mediatek,mt8365-wdt
+          - mediatek,mt8516-wdt
       - items:
           - enum:
               - mediatek,mt2701-wdt
-- 
2.54.0

