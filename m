Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD320336886
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291626; cv=none; b=BnUBoZscTnRPp47jiAeZ4kLZ+vLHV6wFGjdw2v8Qmv8auqzovIBIxcKJMqVB9BmfDBWBSfRo/r7LJaJVZ6aXh0ZGZwUs5rvXTm3lhaMRwqGE4ngOuCJwF7s/dAzmOiH95hHmrkCU4jdDKC6v+qgbGwSy7stOyCGWwjjKUTj03IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291626; c=relaxed/simple;
	bh=YS+2AWHELoIZmaH1G2cjnMm/mdbwgvu6PbnYQhPEibg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8OS8w5sLL7neqfo63Oj8Dm9yNcLrjAMDcXRTIicRpBBibWSPfr9z2omS+Eem7AYdnVUi2N7HlnLz0MUF9Zq/JLAf59wEWJByrUNUvTJbov9CqoD7M76rKfGQFPvRMyNU3FZlAiM6yN8v53O5J4yrtySMS5nWWLJxeTx5EJGH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8cmXfmE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8cmXfmE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955de8797cso6379515e9.3
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291623; x=1786896423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNSsiXJWRtJEnKo3j2+KbnfQcpFMSwgfHd0NV7zL7z0=;
        b=J8cmXfmESgmZf+BGQMoDxsehuBaICaNRoF/DmIU42u1M9zo5OHhVmvzRJWo8kuGvw7
         YFJqisRSddEcf77LXTXF1d6lptD4U+UVLuRgNByqyQeA0K17hxZEtHcJO+8DSW6azXkj
         G6MnLcRTiemO+GB4tRuewVlfScmrWujJIW4rsXCZzHd55idHgfni/YEr7F0os9oUSQ9w
         n/Mb6wG0rqXqAgmV2dWyROqWgf25PsH33OVTTRk/vjBX/LIvhZc648YKRuBXYiLIU8JV
         ZiG+1h5eq3XDV4K070RnBiVM/Keroi1WIRnCVhaS7UchdsjQ8UHMXsWSOOK2zvvVf7Vp
         3IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291623; x=1786896423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNSsiXJWRtJEnKo3j2+KbnfQcpFMSwgfHd0NV7zL7z0=;
        b=o709x5GXHmxmeXoXFcBQS8j5wxkZgmNC8WLnCiT0eBxTs614mPgcMH+OEXuxFRsVtA
         QvJ/gNWDyqdo4TK9cg0IzYJNPJGNY+jCTrmGlYFk7Wm6Ctys0WwHraOjr3l9Dc8/UOuS
         e71qObiJ4maQ5ZXPm83B9/cFVq75RJSXjR5kQ9bo0jSa3Mlybd7mVNM384NNCLCF8+F2
         nt8MGaX7kL/gmBc/gofWwBcI+1hIx2bD+Ficm1UysIVZ4uke36BhBbAvYU0Qizb+GZs1
         F9WQv17xbRSHHkNT26WezY/SzzpZMmgVt+dv18akCEx2Gy3xXIEHV/+qmaFnJ6kOrUW7
         61Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rr671lt0vQen+DMhBRhvzJ5owkc5ZqKOQFoOLBnDEdpmsSTNRnD313rO/+qxlC92o8SZvW1uZnQlolcDwJ13A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF63H5qDozHh5G43XmSnxG8bUqan+xJb5S55CxgAUFTfOHoRix
	alzpJ9f2PffUI6b6dvjym87iFE/jJFW329sFcoDp2OsfHbJlzJPgG1fD
X-Gm-Gg: AR+sD13JpDXcHY3aFzys9Yzxm2eczivr4g2o2NpwkDYSyGb4eUS5H8WiKYvVn22gJmt
	bHPeoDYOaUV22vtlQHcf0pP3n23r2sWld6mh9ec66l2yI2h1JV6A1xQJQjEUyS71RbNOdipdMlA
	jJdSloDRf8qaqOeZPlJQO0UNLbKwmLYhyYhlh492jsrqFX/QJMQJz5nkS0HxD1BkUP7iHXOgECa
	3U4CVVXMckEuuFubC4cmObRiRg8h35Gk0u+zJ9s8PZld/va27pwdrY/oQ2PNmSJvvoFb70h08KH
	Mgb/MDOUUj/Fp/Zf1/CD+lbNT9xoIc6xVQqAXYWSuLZj014Qth9K5BvSyU4clgtx2AjSjJBx+sR
	nlQXh2qyHJzVMIaKNlSVtVGKXheNjZ6uedM+0r6fdHjFwu+arYmpNl4A/L7Kx1YSB79gAU79KtB
	b2PQqg/0yOQcitM7DIQ2wPXVLWFOFjJ2FyAM7mpc933ckpMr8QzHMuFA==
X-Received: by 2002:a05:600c:4fcb:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4995e084875mr196750445e9.7.1786291622542;
        Sun, 09 Aug 2026 09:07:02 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm209832495e9.4.2026.08.09.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:07:02 -0700 (PDT)
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
Subject: [PATCH v3 0/8] Properly describe mt6589 and mt8167 toprgu resets
Date: Sun,  9 Aug 2026 18:03:24 +0200
Message-ID: <20260809160643.33991-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt, which does not support toprgu
resets yet. This series adds support for mt6589 toprgu resets with bit
definitions obtained from Android stock sources.

However, according to its data sheet, mt8167 has 15 sw resets instead of
12, and its reset bits point to different subsystems than the mt6589 ones.
If the number of resets varies between SoCs, the watchdog driver becomes
incompatible.

Therefore in the first three patches we improve the description of the,
resets for mt6589 using the definitions obtained from Android sources.

Then we introduce a dedicated mediatek,mt8167-wdt compatible for the
watchdog driver that describes correctly this SoC's resets. Also while
we're touching the bindings reset header, we add constants for the MMSYS
resets.

In the 7th patch we add a node for the mt8167 watchdog referring to the
new compatible in the SoC dtsi.

In the last patch, we define the mmsys reset table for the SoC. According
to the datasheet, there are 28 mmsys reset bits divided across two
adjacent registers.

Changes in v3 [3]:
- Improved explanations in the commit messages;
- Added the #reset-cells property to mt6589 watchdog node;
- Included the mediatek,mt6589-resets.h file in mt6589.dtsi;
- Included the mediatek,mt8167-resets.h file in mt8167.dtsi;
- Moved the mmsys reset table from the mt8167-mmsys.h header file to
  the mmsys driver implementation.

Changes in v2 [2]:
- Sashiko pointed out correctly a missing entry in the mmsys reset table
  in the last patch.

Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/20260717151134.678839-1-l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/20260717163959.714561-1-l.scorcia@gmail.com/

Luca Leonardo Scorcia (8):
  dt-bindings: reset: Add mt6589 toprgu reset IDs
  watchdog: mediatek: Add wdt/toprgu resets for MT6589
  arm: dts: mediatek: mt6589: Enable toprgu reset controller
  dt-bindings: watchdog: Add compatible for MediaTek mt8167
  dt-bindings: reset: Add reset controller constants for mt8167
  watchdog: mediatek: Add support for mt8167 TOPRGU/WDT
  arm64: dts: mt8167: Properly describe the SoC watchdog
  soc: mediatek: mtk-mmsys: Add resets for mt8167

 .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
 arch/arm/boot/dts/mediatek/mt6589.dtsi        |  2 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |  8 +++
 drivers/soc/mediatek/mt8167-mmsys.h           |  3 ++
 drivers/soc/mediatek/mtk-mmsys.c              | 38 +++++++++++++
 drivers/watchdog/mtk_wdt.c                    | 13 ++++-
 .../reset/mediatek,mt6589-resets.h            | 24 +++++++++
 .../reset/mediatek,mt8167-resets.h            | 53 +++++++++++++++++++
 8 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-resets.h

-- 
2.43.0

