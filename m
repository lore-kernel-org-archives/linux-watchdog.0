Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6F592200
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889466; cv=none; b=eH+Jl593voF/Hnj4cuFyqFufvHj1G7JwkuLx0wfg4PHoufS2EjoXOeFWw2SzrGQm8XdTR4eeuawAe7P7hVtqU7TtLtOv/uSq6HJT11H7kEC814dEp1BC3ASV6xoH9qJJ85lrrZBCd6w4mudPrJmJz1sNelfhq7DM86c5H0pHIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889466; c=relaxed/simple;
	bh=xROL9uV1s+9FtudEW6GBhqvR/gp//2zGioAoIMO8O2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldngiy7z27fOvjj3Yid7bNSIOp0g91gr0OxUArPUZYPGJ8K+BJQvufg4M6dg93VTPh60VbaOyhVbIvHu3pZepSyLl1fZztzRHHTnFZ1OMYuuRfGKhWSjfuLwrKnv/4i0XQKtL1wVjOkFC4DWGvcmi6W7q6zg11KQg87vMijBPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiEddHXk; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiEddHXk"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356256so637417f8f.1
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889462; x=1789494262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1VG1pmcGZNdUQpQRzwwsj0V+0yWbJ5/S21pa91tRek=;
        b=jiEddHXkE0xz8agcQgMyXjfrekRMceS/ikb0dIgCVEXJ7pIAxJ4zReNf4ManZdrs0C
         HoKr7p7ejnG+jeIM8Pm5AmNgB22BD/aQEBz93ZkxOarHnM+4YDnvsU57SXI/xU4sCjN7
         IK2k9RR+qBaa9CED+I9c/FjErdwbj58ops/zVoxWAJFlzPMXPkI4eC7P3nwXT1uqj6Z2
         9HBq0C7hcGeGaRI0N3FvO+H+E1EDqS9gEG+MOxPdtoD2HxT0ZfoMV/beNU8nAkhomOFh
         OagF0HnXEXRu8uLDddC0KM/gP5VtYORFY5ljReXmU36u6uLBmcAgkMsUPiTZc+jtKVq2
         Lg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889462; x=1789494262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1VG1pmcGZNdUQpQRzwwsj0V+0yWbJ5/S21pa91tRek=;
        b=mO9MPTeMojtXi2ku2LYELxCCuaid751oqiFBpTFHu+GstMgzn981Kr8ntLs2O5z9HI
         P9GmOJPjBtgtgGdbYS2zph67+POe73MrkuSBzGRy0k+YWZQtctEDQvE/ytJy9SJNIhoh
         thlS3PmR41XLvBvQeHKUUwpZXPR4IFX+YnyllbPjmN0KIYov6ZtBGNofy3mAUA9jV+uP
         bngVKSAlQzBe+PpLC1lVXdze+4rzhBwHMExeXBCrMm1Cpi0mkVx81N3yCIREytD6w/nl
         PF0qoGIh+jP8vhGIW1CPUNbSHkfzHb3IgiyBAs4EFj0lpnmwS2CwrxnzNvWtIfihydXT
         8wHQ==
X-Forwarded-Encrypted: i=1; AKwUvBydye4LEuYD+81qZcfhuqweCM+yRbKtf/F2f3XTCKckB5mZMJlD91TtPuzxqb2nTirhBdY75GjDp2RBZOtrjg==@vger.kernel.org
X-Gm-Message-State: AFuF++msdNGaD3s5Th74FvWo9MTnffSsVXuZbRLnJHUgulLEcSxqom4M
	djFpHkj4kH2Rp30QzdeMrag/p+ZByhlHAYWftjm4bjleF8JF6XthJzPx
X-Gm-Gg: AYBFou0qfPMUxkWhU0JaclfzfG3uHHvzSFUEuFVKiz2IbMQoXOhqrcSQImeknX4CVz8
	IwMzEVjx4nF+BBFq6z/DGoRPA9Ss2TStmCk/l5NgiTobvGq+JA+Qzxp0OxpcYReRzj9SKV6fsxZ
	A8N09Xpt/h+dXg8NPqNbgzvvjtgrR7czubxvnsWdOQq+PUTAToFuwvD0ddM/XWhTC4hxHDMOMZn
	xxQco0+VA1mJdGwJKBZfreHyD3//au0CZE4imLaWddhhYKp4+MPrIOxvwKdbe/OVIgFfpHaVU92
	ZkUjBYKxIctAVLJfyTSI6Dvis+Crhd+eQnJiZyG7IfmDV1+LrkwT1kQ7M0v0hQQL5gXa3In34JZ
	uQp8KJCCiK/L/20ZadAuXCzG2WzEjVjQ4iMnwVQt6FfCs6s7H5+9xkgKlvq0GJIBssut2PJH9Sc
	kI8tMapKYfNjdjvN+gX7M5A9+qGJJ7rtmcOuP+DgYJZT03+PLAYWPTqa0S
X-Received: by 2002:a05:600c:4ece:b0:49c:eded:44e with SMTP id 5b1f17b1804b1-49d175561bbmr82285015e9.7.1788889462025;
        Tue, 08 Sep 2026 10:44:22 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:21 -0700 (PDT)
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
Subject: [PATCH v5 0/8] Add support for mt8167 toprgu and mmsys resets
Date: Tue,  8 Sep 2026 19:38:27 +0200
Message-ID: <20260908174259.9009-1-l.scorcia@gmail.com>
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
resets yet. In the first two patches we add support for the 12 mt6589
toprgu resets.

However, according to its data sheet, mt8167 has 14 sw resets instead of
12, and its reset bits are non-contiguous. This is currently unsupported
by the mtk-wdt driver and it caused confusion between reset IDs and reset
bits in other mtk SoCs device tree includes.

Therefore we introduce a dedicated mediatek,mt8167-wdt compatible for the
watchdog driver that describes correctly this SoC's resets. Since its
reset bits are non-contiguous, we add support for a watchdog reset table
to accommodate the distinction between device tree reset IDs and the
actual bits in the registers. Code is inspired by the reset table
currently implemented in the mmsys driver. There should be no effect
on existing sequential wdt resets.

In the last three patches we describe the mmsys reset table for the SoC.
According to the datasheet there are 28 mmsys reset bits divided across
two adjacent registers.

The series has been tested on a Sony PlayStation Classic Mini, on a Xiaomi
Mi Smart Clock and on a Lenovo Smart Clock 2.

Changes in v5:
- Dropped the binding header for mt6589 reset IDs;
- Moved the definition of the number of resets for mt6589 inside
  mtk-wdt driver;
- Separated the mmsys related changes to the last three commits.

Changes in v4 [4]:
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
[3] https://lore.kernel.org/linux-mediatek/20260809160643.33991-1-l.scorcia@gmail.com/
[4] https://lore.kernel.org/linux-mediatek/20260819101853.44681-1-l.scorcia@gmail.com/

Luca Leonardo Scorcia (8):
  watchdog: mediatek: Add wdt/toprgu resets for mt6589
  arm: dts: mediatek: mt6589: Enable toprgu reset controller
  dt-bindings: watchdog: Add compatible for MediaTek mt8167
  watchdog: mediatek: Add support for mt8167 toprgu/watchdog
  arm64: dts: mt8167: Properly describe the SoC watchdog resets
  dt-bindings: reset: Add mmsys reset ids for mt8167
  soc: mediatek: mtk-mmsys: Add resets for mt8167
  arm64: dts: mt8167: Add support for mmsys resets

 .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
 arch/arm/boot/dts/mediatek/mt6589.dtsi        |  1 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |  9 ++++
 drivers/soc/mediatek/mt8167-mmsys.h           |  3 ++
 drivers/soc/mediatek/mtk-mmsys.c              | 38 +++++++++++++
 drivers/watchdog/mtk_wdt.c                    | 54 +++++++++++++++++--
 .../dt-bindings/reset/mediatek,mt8167-mmsys.h | 35 ++++++++++++
 .../dt-bindings/reset/mediatek,mt8167-wdt.h   | 21 ++++++++
 8 files changed, 157 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-mmsys.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-wdt.h

-- 
2.43.0

