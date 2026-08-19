Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD044BC82
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134770; cv=none; b=mWbERQVvQe946YGzgvyN+ZG6Pkj/VKekGjOqCX1rt53XPFU2Tc+GkcVlc1awP8KOyXSu88bMbN7NyhRak0YWSat6pWEyGTVV+pw37YB/tIJn8vSpHAHABfAqZ0h+o7v4bbghNj/Mmv/ylZMbNepOyfMdasaO6gIQS3E9YhiFLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134770; c=relaxed/simple;
	bh=lV7cn3wHDLCLp1GZjg2LVjd9oT9jGfOPTNvvw0Vnn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCpJNTj4jk5UDl3mYycbYYcQEaZzXvaFVIiWiWvyQKpXi9P2JnfYaUHLLOhnsEgtHDXfiFouAcvhQTyZfkh0xwTD5tAO2gQLDodEhUkqivEPa0I6YXRCvlqpSsygQyo69XgZnp4Ce6bH9xoC4IRWCHXre4ua4ogWCf4aRykpH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC3NOlTN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC3NOlTN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b966dd74so5604875e9.3
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134767; x=1787739567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EnZE7wbRFGJKlrtdBKnnD6qNsCW/P/b4SFhiLIR6sD4=;
        b=BC3NOlTN/NRomvRnd2uMbqLX8Iiij1KQ6L9k8138Wy0XOhupLmGnPYGTKwOILk4qLr
         hOj53xQN+PtAXG2Vwv/H7A76GIKD67M49oyjjENeJRBGHHQgfeNksQmp8NunacgOK2Rs
         6RB6AuPtGJjukzUaAmkd3NsRjq/EHa52UxmYD6nD++AF/7hyMyR/tVkVkdstdpURU2bN
         x9ck7Ld8/1wBO25DHPycyjWqleAf5A1B2DM6b04Kl/Ap56U9SkQ4X2RGEcoRL+bR27nt
         rqTP3cIE4y58DyPjYn448Z9nlwuNh5zQrugnFpuPuV96+GV5b1C7K3Ku00HEXXO9lfzM
         Rlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134767; x=1787739567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EnZE7wbRFGJKlrtdBKnnD6qNsCW/P/b4SFhiLIR6sD4=;
        b=jOlOWc2cdr3u0xe/gGP9mG2l58tj7/pe+XE2SttrDZXtJVT+8Ky+lGWdxDJ73dNhb5
         IzYBVeggtRC7zMMfBelMLZyOqc92nakYQibaC6ZbiuIe6c9bDmvl5yEhLREP4mi43qRR
         SrYGsSPQYGd8/MXqB4V3Gg3l1M2/AjWg/4HajQdwLcyUOJEwM2YGxG4Vq7KShYnHHgWO
         HEScuxSbKag9Is2H86pwOjVlXNHzaOpE9TwdRvd6ReUGzGDFLOIaAqiG5NOq3TRFZ43j
         MkI/eeNwTc7RkZ67AwHnkPv4iMHjRHjuA9r8gAVoaKz6Xz//YOyVlMC2sJK97RFhGeoh
         ftnA==
X-Forwarded-Encrypted: i=1; AHgh+Rorv/GjQimv3saMXdrAoGTiIPxSewhyLC42ZlrA8dVSf0YEe0JffKQabZx5cFKQR/tcyprMbz7ab/al826dcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzczZHX4vJTJk5zktlXKRRxjC0cNj5pulCK5bH9vUUPgPRyg6CS
	WoV2JkAg9UQ1mFoM1+ZI/kPVIVfYuep+Coj79M9oZHj1tkUaXlfgqyyp
X-Gm-Gg: AR+sD10mMZ1SS7yHySAzwgZRoyjnvSZHPnP2+T+2Xrp2T5JlPiBT2VctiHfbDq5PsrE
	TGSDcrfxBsjHi3UokKud4tToI1WPFVal3kYnU/XG6vmZ3k99N8DUdMC/hI+2n+4LdUy1I0uxSar
	OtOahwrWZ6QRBHyRe9F1uSYZ23AAl1+E4mYQWqIG4Pap6E9SK2uiFgqTvwW2dGaZeN1htCBwMIW
	sqnUFcweMF/pJuNk8mypIJrstBG4Udos4Zokwfbb//mZKSKdYucfCHVDQlj8ordwixveXeZTjaw
	p6hZp8QFyGyPZH0IpAiXldlLpm3Ned3QMcWXbYdlJ+flrWoE50+4sICGnLtrJ7RLUJ6niO8V7wF
	f0jzlzX9ScbxyRjuPaXn9znvIsUVno0GNZRhiCprwD492Kiil2E8jLGv61lg6fSHEkibRoe16F0
	kbuR/RHQrxQe0B5/Tc9udelazi5xIbNnWrwjCtTM+PNXKNtsgp1b1cM9/n6GrGtIKS
X-Received: by 2002:a05:600c:1d1a:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-499aa1dde53mr59985075e9.10.1787134766581;
        Wed, 19 Aug 2026 03:19:26 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9b7c987sm27316965e9.1.2026.08.19.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:19:26 -0700 (PDT)
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
Subject: [PATCH v4 7/7] arm64: dts: mt8167: Properly describe the SoC watchdog and mmsys resets
Date: Wed, 19 Aug 2026 12:16:28 +0200
Message-ID: <20260819101853.44681-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819101853.44681-1-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
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

Also add support for mmsys resets by declaring the reset-cells property.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 27cf32d7ae35..cccc487086a1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/clock/mt8167-clk.h>
 #include <dt-bindings/memory/mt8167-larb-port.h>
 #include <dt-bindings/power/mt8167-power.h>
+#include <dt-bindings/reset/mediatek,mt8167-mmsys.h>
+#include <dt-bindings/reset/mediatek,mt8167-wdt.h>
 
 #include "mt8167-pinfunc.h"
 
@@ -95,6 +97,13 @@ power-domain@MT8167_POWER_DOMAIN_CONN {
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
@@ -124,6 +133,7 @@ mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8167-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		larb0: larb@14016000 {
-- 
2.43.0

