Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8644A3E1
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134750; cv=none; b=fRmYORRDPFP1EO+G2spcSfHgFve5Qnv5au+M6J7OTZbkVs1nTmjDnGWJfIKnOBos/5TqJBJZgb5iRgQlYp+hrUyGChN6WOB0LS405CvKjg4NMW9q5cztnmajLKZ4EMNCLK+oEj4zh44mSTVYc88LfMoxD/z5WlMV7FC5d3Fjduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134750; c=relaxed/simple;
	bh=mB2k6fkTEX/X6Ehpuqb3lPl4W7hNy0irUOHAB0TtlS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hc8j0xeEc8/WfkS/f52emd49DwiK0/xOpMmkx44omykIiV74jbhuF+FFfYfcSsQPeOHX98vkr3nP8LP5UGnOKKBhOcPbJeYxvyAmzt4dEH8+IvrJ6VAfiJmBp90fLpwFgx2zFJeGtdxsP/UjiIC7++EgGNSYG0iOlhyDf8vCeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9+qK3Wv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9+qK3Wv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so5455915e9.3
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134747; x=1787739547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fjy7BDi48DK0VY42L1wkEP3ayVKA14OCO7JVfsirlug=;
        b=n9+qK3WvpE48yoN8M6rcPiQeQFm0z8BAQhjLhV629vJIQn7N5pN+NtjfUaaZUYkqeV
         Y3UXw9ic028gMWM4eZQ0sQboWO2Fjuf/SDcRh6u0nFfiw00+chShHS+J/ti4LHvUBuXD
         14I5Oni8Wu8Jhb7PBPgKuX91m4fRLgIl8cGY7EbWeGoN31/bE7/2moFW6Ct+k/Qm0298
         emFZEP5WliTpzojynWh2J+4hObIlwCneGqjYf+1VAO8DerO3ZmWC7g7on5JZL4Q3jT9J
         P1y45AIgV3ib8fLfpRn+3GsvkFOfwsV1NQHbo4Zrycb2pqtN9Ffg5CljfVt7kae+WC91
         /LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134747; x=1787739547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fjy7BDi48DK0VY42L1wkEP3ayVKA14OCO7JVfsirlug=;
        b=mjo8G+//ALRByRvtFnt1x6qL5FrL20EJYD650nYyNHG27Dv1V/qnV6UZAe6gpXS355
         sn6edQd5XJzPwiD19Bgb5p4TpgNDz+1cprnPyIZALtayGhCYsY/uWIC5su74PsR69wXM
         bC0+qAkQgK2XmVxPs7625LPaNcKB7Xk9lIbRFt9sDxUZa8rcV1dukcAGEweFwdSI+fjM
         EOATANjLaMBhCaMy0xQzMqKuRLjMgtCC40VI8Sxj6FJ/QrGYwwvh46QRKcndJ/Zkz0/2
         SPDTJAVsMr+dsePM6CWGHjwrEJNqkrnEHZYYsWueI+ZBHRX7wLNeX/m7xi/5ag6250F7
         gWUg==
X-Forwarded-Encrypted: i=1; AHgh+Rpa+xvG1lialYkLv8aENaGphVJ1nldHhsLa/VwoRckbYZNB+rm1q1smWrrWOAI3xS211kXBEpvhN+5GqXttGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRaQ/d2Hah+6EviLjxCKCgX7LcYpWWnYs//5IZruGE3BK9DCK
	3XicDul+P9rJCjAiEoo9ABFBBxboMnPs2SC3mHnFkvNL/A/Let1jFcIA
X-Gm-Gg: AR+sD13zZVWHtkQpDtBzOdH/Nh9S9W0q03tKaQUJGOVjfAAYRJL+Gs/m4PMD6vobYOA
	wpS7n9WsRMdzdmcCg4H3EtQaONjeYbb6nGc1xsQM4Zs2RHErhYE1blpAKAy0Wx3a6RwelBLc/q0
	flYrIC54zHrIlbOMgGzIx9RtAoWFtmV3nXYS9uRNu5f7u84av5RdYVlND7AkRaxZDDF6gPR7WKR
	pa+/FuSeeTbjWiRatDZPjzrPb7FCeLEmaxbQKyAIAC7FlcyU1B09UT67uRamex0FOFmABDs3HMD
	J2xr6TbpWkM5Ag++xl9Q4d9CmlgHoTX7Gplrr7VYMyyB9eLVG9y36mmkXRE8WZf3llh4FrmSHfs
	YqGpwWJrtvIOKrrLgDzQCHVMErPGtuPxu42Vj+aCYltgDukETwU68ccqJG0Wtp7QF2GKqFyyWI6
	5SiLssKu2k3/4iqnG8SHPjPmD3IIHYWX/a19Jb/XI28ZRO28edLxmTpw==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499aa20c7b1mr56722905e9.15.1787134746695;
        Wed, 19 Aug 2026 03:19:06 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9b7c987sm27316965e9.1.2026.08.19.03.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:19:06 -0700 (PDT)
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
Subject: [PATCH v4 0/7] Properly describe mt6589 and mt8167 toprgu resets
Date: Wed, 19 Aug 2026 12:16:21 +0200
Message-ID: <20260819101853.44681-1-l.scorcia@gmail.com>
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

However, according to its data sheet, mt8167 has 14 sw resets instead of
12, and the reset bits are non-contiguous. This is currently unsupported
by the mtk-wtd driver, and it caused confusion between reset IDs and reset
bits in device tree includes.

Therefore in the first three patches we improve the description of the,
resets for mt6589 using the definitions obtained from Android sources.

Then we introduce a dedicated mediatek,mt8167-wdt compatible for the
watchdog driver that describes correctly this SoC's resets. Also while
we're touching the bindings reset includes, we add IDs for the MMSYS
resets.

In the 5th patch we add support for a watchdog reset table to accommodate
the distinction between device tree reset IDs and the actual bits in the
registers. Code is inspired by the reset table currently implemented in the
mmsys driver. There should be no effect on existing sequential wdt resets.

In the 6th patch, we define the mmsys reset table for the SoC. According
to the datasheet, there are 28 mmsys reset bits divided across two
adjacent registers.

In the last patch we actually enable the watchdog driver for mt8167 by
adding a node for the mt8167 watchdog referring to the new compatible in
the SoC dtsi.

The series has been tested on a Sony PlayStation Classic Mini and on a
Lenovo Smart Clock 2.

Changes in v4:
- Squashed the reset IDs includes together with the bindings change;
- Added support for a reset table to the mtk-wdt driver. This allows us
  to decouple reset IDs from device trees from reset bits and lets us
  describe correctly the non-contiguous reset bits of mt8167;
- Improved explanations in commit messages.

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


Luca Leonardo Scorcia (7):
  dt-bindings: reset: Add mt6589 toprgu reset IDs
  watchdog: mediatek: Add wdt/toprgu resets for mt6589
  arm: dts: mediatek: mt6589: Enable toprgu reset controller
  dt-bindings: watchdog: Add compatible for MediaTek mt8167
  watchdog: mediatek: Add support for mt8167 toprgu/watchdog
  soc: mediatek: mtk-mmsys: Add resets for mt8167
  arm64: dts: mt8167: Properly describe the SoC watchdog and mmsys
    resets

 .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
 arch/arm/boot/dts/mediatek/mt6589.dtsi        |  2 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      | 10 ++++
 drivers/soc/mediatek/mt8167-mmsys.h           |  3 ++
 drivers/soc/mediatek/mtk-mmsys.c              | 38 +++++++++++++
 drivers/watchdog/mtk_wdt.c                    | 54 +++++++++++++++++--
 .../dt-bindings/reset/mediatek,mt6589-wdt.h   | 20 +++++++
 .../dt-bindings/reset/mediatek,mt8167-mmsys.h | 35 ++++++++++++
 .../dt-bindings/reset/mediatek,mt8167-wdt.h   | 21 ++++++++
 9 files changed, 179 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-wdt.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-mmsys.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-wdt.h

-- 
2.43.0

