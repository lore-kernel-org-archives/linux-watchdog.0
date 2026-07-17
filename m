Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A02377000
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306511; cv=none; b=DOPFy3kxtbKs9s9JbjJ+4feXnZhtHU6kfhFacNz/jLIlCdggFCi3tnjGwr0GBHUrojPlraPigMfpAhqylxSO2ONNwr6VWV5WKwCoTzMHB3+SYjas+NrBeBAeHL/47PGfuB0DL3BaYUXuzfQeOrjeKIf5uaVegBh2wBxc1H4A+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306511; c=relaxed/simple;
	bh=YoSkvKhLIDEZRtgz0gCZBHnLnjY7Arw0eRwzeYXJ1Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3giqTh+HFs486ote3ACR8UyBV8WpMjr2au235ts6dazJcCzkRhGMrYINMo3qsyTUKA8E1VIY+MB6bRete+uKLFi96nYiWxerDzg5ej62Ek+aEl5XnD07oxrAWOcIknFlpDmCX8Q+tmdCZVWUz/eXq3lTFIs2QADD4AWfJZJCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYiv7x1L; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYiv7x1L"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1670dad7a8so637017466b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306509; x=1784911309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Upsuqa7VWRcDlZ5pIPK+Qqnf3tlxThPfy/sKdzeNaMI=;
        b=VYiv7x1LMUcbaJFZhDYwVPB6zB9yTKzlxh22OEgo22w570WkeQBBo5QVKTusIFLvMF
         x8GInwN2TxMF9WD0m9Ot5KuigHpH+2rJzu6OGXNClGNWEe1GSk7DOhV6VIZTbNU6WmP7
         9LYcuQtO1FilG4cNJXFNkprxWfuc2ct0X7lLw0fgLU0lNXx191AhErkVnKrG/ok6mEZS
         BkEoGNUzH/3+EqM7/wAZvl2dWtQsdx3axhsqsP+jySFLBHSVbjcPrdq0jySqvv6BAuDj
         M9lpIhjlKdxwjtFIz4S2HCAeXauqLhmf48jbQ7skNaG3gMdDD5o9A9+yPZUDy7iuqA0C
         XZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306509; x=1784911309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Upsuqa7VWRcDlZ5pIPK+Qqnf3tlxThPfy/sKdzeNaMI=;
        b=TmKZSDmkrTZuUWVbwcf21rdEsOexgl7FUsIPKxlRDgaiwPh7GJkbcorqmP6ybFQVLE
         JplxbmTBeJ5tiqyI0F5gbzGrzcFBTy2hvE/Ddr/mdvWiJKJz23xVfypRfiQqsS+VexIz
         NGrXhhoJeZhPL8SnrEdL9pDN45/IvC8wy/tG9Uw3qM8BNg1mTC+1w3wNWKwu+utVWBvd
         Qh9uUAGxw6f0VyoCKtyao+921lgiszY836JS7IsQNwXqjwVou91hT2BWYKOmL6fKyc6G
         aJ5smFxIMvYr21QWe1P0Jo12lywHbLOlq2r+kMtS9ahI8FBoO38lGOc7FRwsmEUqt1xW
         Bkug==
X-Forwarded-Encrypted: i=1; AHgh+Rq+S0KET9ZwAmCWRWZSBk6CoaI77B5jDlsS/wJVnYKoxl/H0aV7Pm6ZWOeoCwmZUFnXBAumADp1NSiLKUH5rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63c1APKR25tafbKQyrZzIKMhCyTqYt1fjjkyvGUTODXNvoAK0
	Pg1B+ni/PAETNn3YEeo4phxD+RXzhgWZm91RvWFA/QbTOAWwxPgcJg15
X-Gm-Gg: AfdE7cmIUCC6Gi9yCeyev9MEro33FAX/yv0uvYNCv8ZyqTaN46KSUpGBsnl5UNHjvHp
	s9Oe4p3VFmxgO9e+Mk78YWmYtC7kIOS6SAW53RuctITAWYS4puRdPbsnABtLtw0podlPtP3WCta
	M0L25japo2PX+Gob+vLChS0A7rWauO+NkIYGgYhKbIC/gHPoZtw5tLtqvz9LU/3sLrOmiUmXljh
	3g4apCI4fUT/QyqIypsjTfqAH3yBzwOeVHLG0kzkNKUFhWIUddsNwKdNks5GgrRSaBaWLDX1zZA
	jcKjN1aAYlX6wGp0ZW+GZ63ih+jB3rH0/uYdIY8kUEcW1pawoPIDSMuguv4LpR+NagN6WRI3m+l
	tzYqNLdTC7QpCBVkGVl3jWIEJm6IJzsss+/GDQiOLbD37lUHXYmXwFRP9H7JPLbxEehDlKybU3g
	==
X-Received: by 2002:a17:907:7a89:b0:c16:1df9:6eda with SMTP id a640c23a62f3a-c16b48d373emr163696066b.49.1784306508409;
        Fri, 17 Jul 2026 09:41:48 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:41:48 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Properly describe mt8167 watchdog and mmsys resets
Date: Fri, 17 Jul 2026 18:39:11 +0200
Message-ID: <20260717163959.714561-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 has 15 sw resets instead of 12, and the reset bits are
different from mt6589.

In the first two patches we improve the description of the resets for
mt6589 with values obtained from Android sources.

Then we introduce a dedicated mediatek,mt8167-wdt compatible for the
watchdog driver that describes correctly this SoC's resets. Also while
we're touching the bindings reset header, we add constants for the MMSYS
resets.

In the 6th patch we add a node for the mt8167 watchdog referring to the
new compatible in the SoC dtsi.

In the last patch, we define the mmsys reset table for the SoC. According
to the datasheet, there are 28 mmsys reset bits divided across two
adjacent registers.

Changes in v2:
- Sashiko pointed out correctly a missing entry in the mmsys reset table
  in the last patch.

Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/20260717151134.678839-1-l.scorcia@gmail.com/

Luca Leonardo Scorcia (7):
  dt-bindings: reset: Add MT6589 toprgu reset IDs
  watchdog: mediatek: Add wdt/toprgu resets for MT6589
  dt-bindings: watchdog: Add compatible for MediaTek mt8167
  dt-bindings: reset: Add reset controller constants for mt8167
  watchdog: mediatek: Add support for mt8167 TOPRGU/WDT
  arm64: dts: mt8167: Properly describe the SoC watchdog
  soc: mediatek: mtk-mmsys: Add resets for mt8167

 .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |  7 +++
 drivers/soc/mediatek/mt8167-mmsys.h           | 41 ++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  3 ++
 drivers/watchdog/mtk_wdt.c                    | 13 ++++-
 .../reset/mediatek,mt6589-resets.h            | 24 +++++++++
 .../reset/mediatek,mt8167-resets.h            | 53 +++++++++++++++++++
 7 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-resets.h

-- 
2.43.0

