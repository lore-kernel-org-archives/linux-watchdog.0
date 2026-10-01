Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A104A263A
	for <linux-watchdog@vger.kernel.org>; Thu,  1 Oct 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873534; cv=none; b=rafxU6rXo4H/sxTCkkWiUaVpcGqm+qMKsR18ZZembVkjh4UeoPU9xSqXdCgSRigP7uw1qUZhaaYxuSW6WN5RXJZlh6IB0mdM1Cqq2X/MVC8iZbhuNa0zrxTaCjx9PANnrWBaHmrkDyXqeZB8g35tHn0+m18o0Ia9Cv1XStN4r2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873534; c=relaxed/simple;
	bh=YGepmHEEE28SCic71nixtmEJDhkQEownVeSMq//+6dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf6JxwOdAszztGPqZij8cxkO+WvJsszUd8CQNAUUZNC9Z1PT+tlmb1p54oIQPvRxDp7XD8Q/Ua1inYD0uejAcFlzbDNe+BFYXE8zBlw3BAQAjJRyMeaX2Z3oGP6A1+GPMA3dhNPPwr2uH/53+CYjagYQBbFnHh6sqEzhaGlW7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzmLlBSY; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzmLlBSY"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so38245725e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Oct 2026 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873529; x=1791478329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Xb6lAl/hZdRjzKQnD3UKmfHUlfFp2Vv7i6DL97ttMs=;
        b=RzmLlBSYbAbRVdIOZlIqBWbf3F7NB1jZEzGvpDlNn5Dto02cD++MorCI6FPBDQW5wN
         uU/1fjq3zsJcXWNfx5ZxrymXWREOcmv+Owud/1cTYsNMAlnYITKpLUjSds/eoN0F94Z6
         FaBPMzFVuPflDIkTNlEZ3xDPvJAAgygcAIrbIYlDDcubag7AsknmrzISX5aAxYtvyFtS
         JF+zGiw4BIaIXUD8sAEzI52tU9+vn9lCmlooVmZ85SA+pY7j2hDc9TyCLUuCYHp5EX+u
         3zHdZ+7H4+fJmrA65a91UiuPluVNQfL+6mZmXH0RcpbM1HlZIQoyYLkGJdRwAGxff/CF
         Ivrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873529; x=1791478329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Xb6lAl/hZdRjzKQnD3UKmfHUlfFp2Vv7i6DL97ttMs=;
        b=B+7RiKsdSoiFngP1EMeipTHdlgHhM/MqKBjdHol6426r/SvTmux8y7q9z7rELIQVPE
         +1IDA1XzlhmmbA9JQrzH9vy3k6GGt5ldm6CIY9HV9IJf/FR/3CGS/6C/3IX05l5hbQSE
         Vn9K9E+OGYOZbN+v34Y2aKAD48Et/AByt6T31jJDzHWiaRh7OJiCEUdzcEakevrFn7YZ
         0s3CCd7AZvMQQjjN8JZrpkSpaUK9iUTBA3iRoTZvATGXfb5/0awemGP+uWkMowKUA3OL
         s6cOaOtm/B4plJJ8Jfuugqc+5uuQ7ElS9ipLWf6ia4v4kOjRdrDcMgp90pkLhTa1i4S7
         Rp5A==
X-Forwarded-Encrypted: i=1; AKwUvBzur+bbWeZ8kwYgKdU8UfZfZWbX8GNgN7l54iktI0pR73AgKusE8YPSVMVG8nfpV+YpGkrl+L1eruQp65ixtg==@vger.kernel.org
X-Gm-Message-State: AFuF++nG2+bmudC2ddc/ROJlq2JufAeuwXYiwAzsDAKQ5p9EVWRj8+tP
	jkgVkR6mI3LGsLBdEiCnvHddt6B4xv+I6208wDL6Nh0K1uIz6z8pRkkw
X-Gm-Gg: AYBFou2YzmHeqRk7J5W3Og/firygxSM3X8SFjsGkRi4i+VFCIzyIIm2gG+D86Z6XjVh
	BB7tHdx1eKH+IS1ZdJhNgbB+PHaYvF4OmabLOea2EmHQcG1a4ejSQirNVFyQH4MQtmMAYVnQXGH
	7rzwMbq+zClkCNSapsBjb0Pls9LfG5qfgiKiYe5YYy9VFW/Aui7mSPJoqROa1DCPlbOby3qQgXt
	U62i9ZF18qXmFQK+X0bFp27atX9rUNp5fTSdsPzTfb6/QizI9bClZ5/VTaUEf44ZkQhJrM1lIWF
	ZqKWXrCCCUyWszJmjWTUlLcD+sjB/VVqw0rUL6cJ+5s2yFVu0iqtjGelwp7ac38wiSDwY+huiIf
	6nIxJaYOwYmnzc8UZoGJOOpm/9jMKn/cyuKwWky7sQ5EAUaNOeCjHR7qAlWz+4lmeQ6d8lC5C24
	9Xbpi8zmIdYqBWWwaAuqqL8BqdgYMLPCbnuMVXkC72O+oy2QxCVkn///5/GqD5XXU7miuOu223h
	lBFJ+/AlkSOuxbBXLISIaGMzNBIpzRzK6dzHrokMLlJ6xV/LDwcOeIMDrTYTIsoC97z95UxQGz0
	d9QoNu8w
X-Received: by 2002:a05:600c:3e07:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a027585dfemr4054005e9.12.1790873529179;
        Thu, 01 Oct 2026 09:52:09 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027ae146csm480985e9.11.2026.10.01.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:52:08 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 3/7] watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
Date: Thu,  1 Oct 2026 17:51:57 +0100
Message-ID: <20261001165201.763882-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS is unused, so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v7->v8:
- No change

v6->v7:
- No change

v5->v6:
- No change

v4->v5:
- No change

v2->v3:
- Updated commit message to reflect the change in v3.
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index f247e42d54f5..4beaac44d027 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -40,8 +40,6 @@
 #define WDTCR_RPSS_25		0x00
 #define WDTCR_RPSS_100		0x3000
 
-#define WDTRCR_RSTIRQS		BIT(7)
-
 #define WDTDCR_WDTSTOPCTRL	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT	60U
-- 
2.55.0

