Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528C599A21
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889478; cv=none; b=TZ0uz8OI7oCwqZI4yqtZ/c3WKbjGXzp7aTAEC1AWbZ8BKOpw+e1bkvKsOE1+wUyBPNkYcIAPJONqLcixkoSOXHY1PgB0McXdY3OZAc7lnpYhOs4tKAXlmutK/oRFum1uoO/ycFKlex70AbXil18ohN94f6liWqqX7eGxAkIKVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889478; c=relaxed/simple;
	bh=tExviE9CW/8M7Prprq7bTs/MM5YZtoVL85qQ81yVr/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSmXBm9h/IctoXmEEpNH7BjJAjWJS/0cDXZ80v8eLVZFLRqFWafmYyEcGjr//9F4cpDt1EKDvtFnzTfA+yIPzGd7vGygNlHBTvuaIYd/Meghi7KSHEpT3EwtR85IvPqupS+KkAGde8j8Ye0nprj8PaMSbuualZT+Dwu8YII4jyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZgsv7q1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZgsv7q1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso72974905e9.2
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889474; x=1789494274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fs2XBLRa4Y7GGFVavktwvzQaugjZopUPytcWu2OHTeo=;
        b=fZgsv7q1pEyxq/6KgemB/GBW6fOcVF2sLfDlktxgGQSFWBNL0ZogecbcAOCtlNLxg2
         Fa6md3mqcU5Yusg1qj4OnVpl6BKP2Pn76NW9UJRBvuPj4+hh0MMVbXMBhNBKg1gdRYLU
         XIUMldXUHuC11IN1cB7hodV0YzrmkqyEfqjqzkLDSrlXYUm1k6kZB7cVE/HbuhkiILl4
         Mv6mJjqAvYg0V6eb4Zy1YTTRQRX9l+AfwDiDr06bFZFvCMsieGSapa4xQhYWOxA2xNAq
         tDnWUGwj/FXfpTA6xjKTJY3WabPsGRC8POsuyCUOxSooag/QgeQM5uUjnRqDJVw/+CB/
         nidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889474; x=1789494274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fs2XBLRa4Y7GGFVavktwvzQaugjZopUPytcWu2OHTeo=;
        b=aPfCbzazrhb/OnH4WhvgspoAz0k1hyPAPUyQsCRRI4EOATNjr+ODrf20x8LMHWeYLt
         PdFISiPlqK5yHefY9qG7BtMKlQvbCoK5nC8u+Indi6syvgub9eXZRdTR98sS/a+1VQxp
         qqv+DsOhn7PYhYiLPNc4+Iz/5hm22LwqCGL8yKVvCU3w0fFJsvtK5ravtbirxzjrQXFO
         4te9bOTy32hh3F8AOrUW8AokIWWiKHptJtJDz3g4M4WhKiPvQmet7vFObHcShP7UrSa5
         wPc2TqxJ6pOHif4u1LbaRkdGPNHm9toGEZ9jspkRQ0uObuUujFC56M94HY3oizPz3143
         07dA==
X-Forwarded-Encrypted: i=1; AKwUvByibTwDw6j1XdNullbma89M8Nl+eWvQ0RcUh3btKBSk1W8ghN57DTt4fldRMZkCd1uFPR8NHJO9xe3KLW1jSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lyP81ELLdXr8/CE6busXrQk8x5w8EbULyzLH4tw5qzXopipl3A
	JVvC0sM1+kMewyxvAyA3NxUAdYgAnAAHXpIQLyj2yaF3PzZdvGx6lCaL
X-Gm-Gg: AYBFou3wHEMNnN8NZ+laLRdBJZJBYTHZRlMhoqhGp4pzBdbk2vJLbWigu1126ZI1x14
	2h8Awk3xm1Z6cj8/Y/tu/aj5guXby2zNiN1it/sAgndJYLVJ1/42d+icSkz5I6Lo6XQ0TwGcrla
	Lq/gguDL0BxyND46JNdJavUfES/TiGv86z0wrnEcN7IWdEOBnzc2d16O7NME3jg2og90/1E+qS2
	uFuzOaswC9IHT0G8Nry/t3AN1GBFWFLXF4FLqbs7UgTH4z84eFTo3xRIS0aNe/EU58BwNG1p2BJ
	xE+5f1Iq0HnrJmua1IWw5akpLq+zoaW4XdqXkQYV/su1LsogBmbucmdGIRKGpQIz7tnvbkReYID
	0lqo+3ZjqHXfKZuuoYr3yR++V5JIq6YVNkXC7fKxdhtt+PJYlJtPei+Mc6R7XlGYGJUOvFTEwHB
	qndWsUlCTai8oW1fUGXLdIqgXjYmYyKD643X6W1HPmXaVa128QtWmZHctD
X-Received: by 2002:a05:600c:3e06:b0:49d:99:1d98 with SMTP id 5b1f17b1804b1-49d00991db1mr238844095e9.9.1788889474128;
        Tue, 08 Sep 2026 10:44:34 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:33 -0700 (PDT)
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
Subject: [PATCH v5 5/8] arm64: dts: mt8167: Properly describe the SoC watchdog resets
Date: Tue,  8 Sep 2026 19:38:32 +0200
Message-ID: <20260908174259.9009-6-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908174259.9009-1-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 toprgu is not really compatible with mt6589 (it has 14 sw
resets instead of 12, and the reset IDs are different from mt6589).

Use the dedicated mediatek,mt8167-wdt compatible for the watchdog driver,
as it correctly describes the SoC resets.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 27cf32d7ae35..be215390730b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8167-clk.h>
 #include <dt-bindings/memory/mt8167-larb-port.h>
 #include <dt-bindings/power/mt8167-power.h>
+#include <dt-bindings/reset/mediatek,mt8167-wdt.h>
 
 #include "mt8167-pinfunc.h"
 
@@ -95,6 +96,13 @@ power-domain@MT8167_POWER_DOMAIN_CONN {
 			};
 		};
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8167-wdt";
+			reg = <0 0x10007000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl@1000b000 {
 			compatible = "mediatek,mt8167-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;
-- 
2.43.0

