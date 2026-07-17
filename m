Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568439A7FA
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306520; cv=none; b=iurwcdJLG/5M7sdos7NvoGpbKd6NBh9EN81Ny3sdIMSHtT35kB2uD5JLE1O4jJhILJhVIpgSHMPEDWMTCAxXDjvWIN8SkIE4RlwGAwL5jDrJFqAYhLAHr7FRdFaQVRHH6nA9XvqpHKc2T2hhPCMvZchViRVxQhHdbqRyd0HWW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306520; c=relaxed/simple;
	bh=FU6qDeHF6G2wnG84JcolMJ3imCNMGWHDGr+KH2C0qSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq1KqYIqSN3C9P9hsGWf1e5aDfegMWfi+toEFoQGoRa7nHOOPg2uYGy+HCVuAfOCHCxcqfxuoSbCPfEXrVaHaCpSIFblueHaMbhGcLIy/agUK9vBRjcXT8uyCV52HZnmQoRuIlgyjpiihZ9GRicmqbtZ12cSMOIfFj0ThG5/o7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMHMEI79; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMHMEI79"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ba5b151dso630774866b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306517; x=1784911317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCSbtpTfn0tjI5mWiKnAehObxNB5ridQJcKUxITI8TU=;
        b=lMHMEI79xtiZMjzJUUD7A7zwZz/fLtVIimnESYUCO66V9bjuBLOmsspeyO4wFEGbWZ
         0+sJyFfTOvm/tCL2NRF9+3nkVGQkqBcChlddMiF3RuKyVX0RQE4aX3CiYWeo2NG5ZcF+
         hqKCdDaRxyVU6FJclYN3a3arOr+AICbMCc7b+vpEuItSqpfPYTlW4CqyiV8KB1U9iosp
         2gcAa5i5LgCTIaP117b9TgAjGsS24sUAuw5IPBFeE3GUkDEBM7dXHlQ1Uk8HEbu/6iIv
         hC1RXWq0XUtfmAW4j/iWyYZnziB8iC4VwJFxwG/XlItSBn0f8xptgBAMC6FVq9OwaDOv
         /gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306517; x=1784911317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCSbtpTfn0tjI5mWiKnAehObxNB5ridQJcKUxITI8TU=;
        b=J5RPJrsUa2LdoWYfdLWb3oAbTZNjQlG8xy7UQTgeGZJELO7EZQdz/Wc7Re4z0GH8XG
         56Y8rPthbNXyE+pNuLOlqkVRpxHABNpIZlPgErh+zkMKjnetEpfNIl1Rgbe81CQ1i55e
         IcFHI6fvtQGEUFpX0sPG+oE8kjctL2/3jH+aByuWUWfrWMIkUjIMN5uwswkz44p3s8HN
         4Xc2MGfFXXUAIbAneXzuLfUGpTkcQoXst/FfpdqunIhzppSI0K6mRk3MKqPxQXRyvYC9
         Mjgh48X8e6WBznAxdYr6VfM67F3nK/t+ImSMWGNTozyFIqRt2MLpbnQFo+iTYgd6xqMQ
         ME9A==
X-Forwarded-Encrypted: i=1; AHgh+RqhUXhGwNimG+4icFqE+5UCLbZwFMVUbM+akuXmVndq4w9JEIwkQZGlCAFkmN+WWLgropI6BCPfjsvGy5a9+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7rUP5ohcGAHGWmSc592OM/9KPThwWetjjg6jT0eSfcdch1M/
	8KGj8cLvZm7jXQr2/6earzsP5Ao+by38JaL5C0/1uQ6jjtfCBD5yjbzy
X-Gm-Gg: AfdE7clbxz1ia10VP7rpeCyYnCcDPNPzie4eSQzAxtfRhpr6MPU9ypuVjdeZEI16UyV
	MfetZvXBXpRRgg7pjX2DQFgMAXpWRA9k9awnCbUO35hKxqFH77CQqsZy9SY/MElvHf7Bi7Cgz6t
	xfzD7gWDuR7MyXex5cplSFVIJnMz+qYGEhJq8K6igDi8C+qsbjesmePqIO4+SgHgjy4Nm6l3e/F
	ADvPnm1a3jRRv+nXA4O9Okj/1/5izti/2gOoeUSvtm5g0qZDGtFfUI1LDrD8n6cGJfAQh/EzlMp
	mLQh4E/e8SWOzC8yJvrdnaYUY1wu5veb57KOvuwYwm3J3jF+izfi9obNU+7nS60opQOzlCOakW2
	OL2NVf/9WLKSReuiHrYRlNqIES/ClcoGVBLA+ZA2YbLBEWjzFT334igQb1nQG4ayUwqzdPzGDDA
	==
X-Received: by 2002:a17:906:eec1:b0:c16:2a6d:86da with SMTP id a640c23a62f3a-c16b48533ddmr153955566b.54.1784306516701;
        Fri, 17 Jul 2026 09:41:56 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:41:56 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] dt-bindings: watchdog: Add compatible for MediaTek mt8167
Date: Fri, 17 Jul 2026 18:39:14 +0200
Message-ID: <20260717163959.714561-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717163959.714561-1-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 has 15 sw resets instead of 12, and their order is different
from mt6589. Update the wdt binding to add a dedicated compatible for
mt8167.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 953629cb9558..f514be8a5851 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
+          - mediatek,mt8167-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
           - mediatek,mt8188-wdt
-- 
2.43.0

