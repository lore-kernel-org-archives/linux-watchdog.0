Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF22EEE65
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122772; cv=none; b=ROZ6Wh29jOHE6JzjUl6XXZVgK8nQjmA+OvsqkRjYJAQcQhnhvNQdbQnzsv9j4s4y6UOkr7qkH8RuJNUUPJxqbaNOb1s8qM0qBj1hS+c5k+jww6xB9E9+xkyQtkseK3wCuFrHzB3st3mcRLKF4u5trWajjyqM7znu1AHT14qx+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122772; c=relaxed/simple;
	bh=0mTF0HeekyGGYC4JPA4QUcc5bVo9wdGVAb6Ff+VtFAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2NPFTR6wGsKJbp23ZVCunV4bggVZGxDqkHMIIUKBtAdlihCEuSWk6hi/R+YMhTVRZ1JOxrLWNhRSf4qF957M3w9vnzHxE52o61Mn1jTik+Ma7LboscDbUROCmAj8HcdSd/V3NBo5g3wYQmkWG15rQIJGP7LrS5XHJ3pxQay5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUG24UOw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUG24UOw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b7612475so41395655e9.3
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122768; x=1784727568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8db6f/b29rlspzEm6qOKfHn59Vtz9L/QmnkbFCJSt8s=;
        b=WUG24UOwdsSvjeTuwyTiXR6zojEB9QyY36JtnL4dvrhHCKRawmRfrcI7CvuJ7Qxf1a
         9PX2C4zn9JBjOXnrBj+GidXwF3wsHIif3ygu5zPbkDE1oms2n+wVzvUHYU5+wm1AkjVe
         T4+3FP9fJghKgRpluoRHYimFeGUQjLm+2s7Zp3/0B37Qi9T5CdS1/0K0HEyyqIBJAcCl
         /gHOrrDOS2A8yJwts9iFySqP45gDtCT8HSEuiAEL8Z5285BwFFPU9tCPtXlGOiASPJXU
         jG7fnSRXJzeTFL+u1De2ao8xdVxxdUDzRSCrec6fyjimOwocjipcnqmh5tL+EIskwdSn
         aPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122768; x=1784727568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8db6f/b29rlspzEm6qOKfHn59Vtz9L/QmnkbFCJSt8s=;
        b=L1wH+MLfKbcRZBzY568/1wTvtqRV8hH4fbzYKcN0YhPilmZJIo6pKWQU9zHMptJ6u2
         7szW5mO78pOtKoyHI/pbvuBr65P2ZwPO7Qi958OhC1S+/MeCWe6Y+P92HMztC3CE1/zH
         hCVcb5gXYHFUMMaiSKwkSCwbzwxfVEDGPjK20HNc46gVbw0eo0HDRfghHOadsnzC5TCE
         VMIjpae4oH8PJks5iLcpdYS1Zc6MRQv3WZo2wjR5PJhI+1dRLaqkg8xpoyu+sMIgHi9z
         YDFYjrf3dFR9lTNnEQiYsvvZxiWGcFtDuv9uqSqz27vfe5bhpDxjU0c0FBbfoF94Wpbw
         FV3A==
X-Gm-Message-State: AOJu0YxVTX/FLPyNn0VUb2uWSso8UnQP6OhgFPbrsLsZMnrQLswimNnR
	q7kvV2w7+eGD+JCVym+Pu+3WDS57cS4qAd6ZUvnJ/TeI27IY8VUzNUKU
X-Gm-Gg: AfdE7cl5HjMge3dNa0P9pio+QRkR7QRpVHlARok/o11PMCIeEVmt7OlrOCfARpMSZkt
	hEc7RlIfU+f1q4p1K+f93fYgnA+XvHdtoiqdcEL3Kz1ShFHB+t8m6EFHhORWa+wBBgxG4qOXbbu
	KOA31MFH6DKWsD6ejrsVXw93uVvbP/0o0kL3+g//BMUY1JpAtAMpwvxSZr5/3A849El3KvJMRaw
	i7y2VZg4OC7cA5Kw0hzR2EnUdMbKhwEE1MIjeyzvTELshzTgU1nTXh+mKY96nHO5B/a38+n5u+Z
	baAY7BGKu2ZHXCZRuY4TV6e5AOmt32faxX+mzEvvfUS6pXiF1FYhQpH5dVDuoIXHVV0YkfK7JVd
	+SbLjBZjTfLy23EyWxAmINC+wqjYE72NSGwIYQNN1q2RuHTqbzNl/08CVc6V2Y3FX/XLuf48x/r
	GJRZ6/MZbAbYI5NjyyHhz9eTgIf+bTrKB7tvNhkd+y3eXBvrCJ8rE5SXgqIF77MF7r3+khUVS9S
	fjQlFyOa3WNulQxXeLVZNwcIVk=
X-Received: by 2002:a05:600c:c87:b0:493:fd5b:2d5c with SMTP id 5b1f17b1804b1-49515904a8dmr86490105e9.22.1784122767750;
        Wed, 15 Jul 2026 06:39:27 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953b35105esm79420195e9.9.2026.07.15.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:39:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] watchdog: rzv2h: Convert WDTDCR handling to regmap
Date: Wed, 15 Jul 2026 14:39:20 +0100
Message-ID: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series converts the WDTDCR register access from raw
readl/writel variants over to the regmap framework using
devm_regmap_init_mmio(). This conversion serves as a preparatory
refactoring step. It allows the driver to subsequently support
syscon-based system controllers natively by passing along alternative
regmap handles without forcing messy architectural branching at runtime.

Note,
 - This change was suggested [0]
   [0] https://lore.kernel.org/all/c3ef312a-4c26-498c-90c8-118c6dc035a0@roeck-us.net/ 
- Patches are rebased on top of next-20260714

v1->v2:
 - Dropped patch #1 from v1 series.
 - Switched to use regmap_set/clear_bits()

v1: https://lore.kernel.org/all/20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  watchdog: rzv2h: Convert WDTDCR handling to regmap
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS macro

 drivers/watchdog/rzv2h_wdt.c | 77 +++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 23 deletions(-)

-- 
2.54.0

