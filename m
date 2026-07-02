Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5A18DB37
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008315; cv=none; b=fphUrUj094nwCnc5OwgZeTgyJEixS2NaeyIDqyGMW2x3aVVJftxF85/J4dNWayMILazoZmb5/IbMXhjQX32yCf1e1CbpBaCaCvD9kD1ksjGTvxb7DlII/azk+lCU18xO5vOp3Qz+PE2hP7a9rioPmEyV42w/nLvhp5A4709YDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008315; c=relaxed/simple;
	bh=mWao/R6lk2gMSPFtmSwOHAVgJCYAsXgCPY/nPQqmmlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KccZUP5kaNb0e7+9zi4L2CEbJV7FpwNnk+VrSeff0Btr0n9vzjFLvhamJGCT1xYFeQmL05gKWTpzTJMjTrMJZi+IcQ0jRCVlamH6nVS8kLa/vP9BXXg1AdYD2xvLzW3xbkql6JOBNJeCRK7BAPUPY3MkXMpqNmI7vqngNdlhqmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRxEd/97; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRxEd/97"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c1950518so4280155e9.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783008311; x=1783613111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEfiyThLlnYz0JhjUcRCH7/GCcsjcrpS4Fx4utupl0k=;
        b=VRxEd/97GLWUTWwxcr8FNQkNXWjTGQGvTbPtVDHXxRv8D5XV7UTJjNlH7ZToTyWgLc
         Q1+gYlzegPCq25awTWSZQn9PMweANFQiU9gG9Ai4nSpC5EhORVgl+vd67iJW67is/So8
         IsalrDV1SUrj090SRniekr7ZJJSnl8e71zaugXHvYRjTeHrroEfsx8f3sOiURiEPFy1f
         DXbkH3uHvcgo6tiHjupXqX0Rf7uNqtc0O7N6I9pf9fs9X971/zQqHNZCp/1cN9ShZ1Qp
         Am8eXebdD3BNGqtplr1fCjAC4xl6nqGlBg5SN7hJBqzvk6kqkG3DUhm0GAeyBIt0cVUy
         EdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783008311; x=1783613111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEfiyThLlnYz0JhjUcRCH7/GCcsjcrpS4Fx4utupl0k=;
        b=fqBsxxBPYmCpMzUVCCvmzWkiinHeojyuRJuk6IJrG7InLDhBFlnE5n5jGS41lPtjTp
         UHef4wvsrTDZ4b0kDxkHTxpd8uCcjLvav38OTj9KH2HLxiEmkdk8W/a2lprBlWmqEcxc
         /3UfZDL0NJy2ISVEUhDD4i9FPAOZSSMVz94NAwtQHQ4ZcjmbmsW7p9TAXbzlXc6GUhQT
         ETUASk17SMRT4p3zw42iaWc/QwI27WXyfs2nIcbZOe92xaTAxi5v5lxlmSqlOsNj0o+A
         pUT6am6kEEbHwdQf2evNPpVqnRjbjPVMKTlbFHJUJuSPg/VDz5Izy6xcFQOcZApghxtp
         k9xA==
X-Gm-Message-State: AOJu0YxHBwJqvBfMRXhn4HVW0JG8eJaqqdY1JD+hg/AuXyQszCuhC1i5
	UHtwZUE2qPatvijARRxqOLuXNPcvgEeeKzzEpf8HrzgBLmwS1c8bx01o
X-Gm-Gg: AfdE7cn8DlWepfoVGSwuEpQCw7Hnd1XCsh4cGN2ew3UW/2vFr9sb2xOhzU6QaFkJfr7
	iwBC/41lfuKPatP/X1RZeGEwykb+F6FN8/Ii19OXyO5jIsYrvsYDO32l+BJGfGwx5gh7hSQYaKw
	xAY2ZgJT/POLjKCUyyqpm8DnjQLAbTdICgJ6BvNI9ZLP4f/AWoN73ErDhGcjZGOaT1S3ipZdm+8
	osbA4SL+u29w8jRxojr8bBFhQaO3cUYMDmqLwrasTJsZY8QlgfG1D58RhD48MDgvYxGopVLlmfZ
	Q5AxEwybAoNBnJ2ME2LOogTEcS/5sWQ4rKYGWXBu5xMJ7STwCACEVnsNKhoc0Rs7bVfNQkgrG8G
	8NdtC/VQL3DS8EGzhbRYYIwDR42/PB7/6vKKlZCe7d+FzU7+pxXlMvcuMP7ygn8xvzlhHvS49lH
	ZnTju2Vi+a+45luC2/oPOulUSCpy4pj19iwTAGcElvnek4QNXRwPnTn7y4+kvHp7uWv5VO4U5Aa
	/XCxVSii1+HuIBtu5ySiFdzgtQ=
X-Received: by 2002:a05:600c:c4a6:b0:492:714d:8c4 with SMTP id 5b1f17b1804b1-493c9b580dbmr7652015e9.11.1783008310583;
        Thu, 02 Jul 2026 09:05:10 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm85444715e9.7.2026.07.02.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:05:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
Date: Thu,  2 Jul 2026 17:04:54 +0100
Message-ID: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
- Patches are rebased on top of next-20260701

Cheers,
Prabhakar

Lad Prabhakar (3):
  watchdog: rzv2h: Refactor WDTDCR start/stop handling
  watchdog: rzv2h: Convert WDTDCR handling to regmap
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS macro

 drivers/watchdog/rzv2h_wdt.c | 81 ++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 22 deletions(-)

-- 
2.54.0

