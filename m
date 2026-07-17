Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA863B995D
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301300; cv=none; b=UAwidJ3usexn6J7k+TwSQ0o655v3Ifb+dmzPWxdoIcsi6Opx3VqmR7H/47c/l8tcGqGcgLkbxhLiCQuBbz+sJDXLv5/THqVj94+6KjpJd4iehKTv4QztAwxUnDWUjWVCFUkh7IyIl94NKbTLdjH9Syot5rIXHhZqMjJONzGoq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301300; c=relaxed/simple;
	bh=5H6KlYQ25zCbLTb/PiGglHhuy/CNYCwLIU2em8DjnEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDNn/aqlixBiD0njvfuwvMumZyYLnyPTXCpZwy0SXUzPAaapOWqhvRLBthA7wdYxdwVtQhrbToAbZbTZN7aMfwfmzuMespZYb9d0yGmKdA+/BfWRJ13Ld9k6xeN54SDQWREjB6wzMwiaoUzPzsG1niM2Ez8c9CJWN3NphLF41mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl5UVuPs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl5UVuPs"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso11288168a12.1
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301296; x=1784906096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4iCdgU2Mi1ltlF6Zu07ake4LF21lMQp6/uBwdAs/1H8=;
        b=bl5UVuPsJQZykHDrC0vSuH6es+lL9gS0CYQwL8FWrORzle+xxzxwJq6O68P4ZlOuSD
         t2NZxX+tAxpPzmNfH1fQiNyKLJXQHpOO7m9J4Id74IOWjAEPtl1oWBbOgIruWAGhwOHV
         jomC55Pcmsyu5S8B2BfceLuIKZOOkL/osXCsiE9oLyKPBbFmVhVk/wonnD4N2lJLNTLy
         c8hftbYj3qdV972OXMu66ZL3Q0mC6o1sXlfJcNxiM42W2NDsENp1X5VWDJLCU2e9OksL
         Nl4nFdHdL67fR50N+CteBy1IkLKfrqqmuOuZbYe11UNazP7Do4CRRG1sn9imm5QYb8jt
         o3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301296; x=1784906096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4iCdgU2Mi1ltlF6Zu07ake4LF21lMQp6/uBwdAs/1H8=;
        b=Z//PlfT+6CnNJ8yJxyHQVjEDDe39su9sJUwF253eF54/8bszrNSo/M9Jx7tug2vJ70
         gYt0LzHmOItBhSxECDFVUXoYkrxx0t6IcV+RSYPrkNfnbJGYQHBfp7YiNnty8eyoY6XJ
         s4AbGFWx4yO7zgFV8bHtmsC3lZcr2x+/GKMsWUh5wmxkhXM6gpo74JoMrhtYPg9iI9c+
         6ovL+8n5a9USFveBGIClYMmR4psC9Nn9Fbq745Ux50WlM4B4B0u+B1Iunel1Ky2GxJZf
         jjzgXN+uD1Z70k/UibpqtWaoYfuQmwqzvUZvlybxR5yVK38uksGOvm01PuTtaX4G9MkA
         Ya7A==
X-Forwarded-Encrypted: i=1; AHgh+RqENpxa0X6AkNwYZgOhgTfswoS1m84UuJBEVIT1U4g9dTELa8H3af5dJD4K5m/KkGwZuk3L6QF68j9biH44ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxMsTjyryHFNz0gYXM55hrGEmaIgfnCtbCqd14mGm6n7Iopk5
	jdXR8KRUf65ej1di7Qs2HWlTD6X1MpBDWOsbq3lCx+Z2Xtks+og/VkHi
X-Gm-Gg: AfdE7cmNH784YCCu5hAKBBSRY6bhze9ik0G6dHJy8XBhdiQ45JRLIBy2WD8mIAH0Vh/
	+/w47yJbuJ/c3+VtID5WB6II23hA/JSWy33BMj10RI9X6YkKrXTsbmkRjEEYRQwHvA9iyDfDIUy
	cRSoAks7dk/znZxcuu29/00xzo//v74iMrxISvFzYPaOXN8Jbiy0eNNWwGSaGDDKaAtQbN9KSCq
	T/spikWLzj/tqFXx4YSEHIc/fAXJxMIPDXnwCe8BEZyV4qGddXoWJirD7bacj9veRVpbFYW+Icf
	Xh0t4MbpRQq0vNfcxK+/tAicnF75mYX61sH1XsssfoLnQheKSN6bPpp/SebeVOCSd2KE9/fzR6M
	3flm+eaQhyURnyqxZ3IrsD7WpgTZHLoHRO6VwsLq/oiEf4XC7LboZ3OENrROlKGMEmqZleKiAAA
	==
X-Received: by 2002:a05:6402:4555:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-69e6528189bmr963155a12.15.1784301295646;
        Fri, 17 Jul 2026 08:14:55 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:14:55 -0700 (PDT)
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
Subject: [PATCH 0/7] Properly describe mt8167 watchdog and mmsys resets
Date: Fri, 17 Jul 2026 17:11:07 +0200
Message-ID: <20260717151134.678839-1-l.scorcia@gmail.com>
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
 drivers/soc/mediatek/mt8167-mmsys.h           | 40 ++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  3 ++
 drivers/watchdog/mtk_wdt.c                    | 13 ++++-
 .../reset/mediatek,mt6589-resets.h            | 24 +++++++++
 .../reset/mediatek,mt8167-resets.h            | 53 +++++++++++++++++++
 7 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-resets.h

-- 
2.43.0

