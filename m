Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504A517BB1
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679049; cv=none; b=d1NfQhiBxipKcurVxpYtOHy/dOVohSLb/Krke/CMULRsPutd/JA86QY2eyxGKo5aJdrbY/QvpaAGFwAkIfk+Z7YYgoQfM3R6IWNGvtvq27N8RyU9wXVJ6y6cEuxlB8YARSqYObHB5Pp8IRwvFlcWsaaD5qQY4ce0ro6KMTDm9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679049; c=relaxed/simple;
	bh=Czj/B4Mu5LtxJXGATAgkhH7zASNuytRpX7bg+4KneUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzWMooglyrnbWqqFGgOHL+lidyXvpEA0Sa8FSVB6tAp4G7T/CwpX/4RB8ey57Lb3xWs0zzKGM+Ui0AWRmEzRH2t/1E25YFZYSaois55x7v9OCVbYn+c7BQIm/qy6yttP7mrMW+X4lsR2TK+xWQvf9kUIhFIQAlH8TfHHXgpEC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTnmHa/e; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTnmHa/e"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so2870889f8f.1
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790679036; x=1791283836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TRGMZhFDi/tQ+Zc9BTj9SvYe/ZMxXrC3DzS398L4YRg=;
        b=nTnmHa/eBfFOvf6XacrikVsOIs6FBNw2K4bofZMiPOBUL50uYJerfeesvA6GCYea3v
         JHCWPWHgJWmynGhru6jBoyzLuEZ0EtLaZUdDsvxBc9wSsDSIzk3nOelckULTokIcKqdp
         6Kfvv4lpXo6L2Key8aiCUyJh2u9ncEoZd5554e1LZnt4dl2UHTNpdqwHR93nyuPq3eV6
         R4R7p/4m7JxPvZdMLXXTyWfxE/Nj9SBX4XHKfBMm7IektRafe7HPx3W5m97z8t2URjDd
         HHqJsGYc7ITDGsFCn3JGEANdXtk+23Tbk2ZAthOszSNdt11jNATh5CnsoIAGSEuI9ASJ
         r7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679036; x=1791283836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRGMZhFDi/tQ+Zc9BTj9SvYe/ZMxXrC3DzS398L4YRg=;
        b=0jpJtyCT3UOzHed8F4+tnXtRoPhy0q9C3/Dve5V+Xgo6/nFehak7sfAwHpv9ZLcSSc
         e63UD3+GsSmFienJOKBSJsmb40NaZJFy9hjIEDaJhfw+gcvvKNwysd/SBLuFttgfBdcS
         Z1prRO/+xwwcEI5NQfqkjV/qSa5RImEOI5C9dOVETgF+a5HYOcbl1DRaiZJNc6rn9ahZ
         wkZKVx657Cu23tdxGruDtp2GAeTRlHNEwtwLYK2WmS+B5TohwfqJcumjQAksIVQgzYtX
         JL/RPcABPEuoEIl7UkMAXMIDEWKPxXRfUHbDfl0nJ05QG3/acgSSAicJdy4Q90g//kgO
         6WsA==
X-Forwarded-Encrypted: i=1; AKwUvByDvpwB5GH3/odQ73yLQo3Jy3CEgGfTC25PlHl9mG34GIULUBqOtDsbMjHBQsV0doD/l47Hx6k7I35ZZj8FdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mL6+lnRV6weY79OAI96GMpEPgCMTqM/T///5tmnzIFHPMJBfyz
	MCurrV7h5yIVfSGADsLHTR+jAnfuSr4o/sjOWPUk3MADkNgCTqkE6OM3
X-Gm-Gg: AYBFou3nVV1cwK7KJt6SolqL5vbqPTBKl5Nmzz8jXeaKS5NoaS/1wtkyumFMCWaxoxx
	aBV46YzLHuwmC6LBLgrHPaMYyzesV9giC/bxrsM+Y7+5QkdvOi3ZRWm1wyLuQLiquBt3B9UzAZP
	sq7zqc2mk53ME72D/bVArjJQKA6Xn96xFp/qJW1PMZspOEjplwq+KnRmxn3aSQCmaPqZ5uFjrgQ
	XdA0lVSSYhePIFCJ51wMXPvGuW+bLO0gEtC8BswAp7lGIsmHE/A600FN3GSvk675lG0CwVtBLxe
	x1pKK5txc6aiZL5DMKCtXaUn+TfR5ap0M5Kt4BRtO2WIos1z4taQvLhv62c62h0HTH0gM2tpP4v
	5pDVVILyRrFzPQoi2qVLQivweeQrpFZ3IVD7MxJiMrbKnFWToagqECxmOUAxGb2TIPgUqIB/iU5
	xx45vXOf5qQb3rIjZHGQ5OzlO3XG49ILJJfce0CLBS3E1JcGZIGrITMIQGx0/ozfLMajpuIiYL+
	hB3Gfjx9X/U42LZ5w1oNEM9r213SwXdM9nqbT8Wb2URsymbuH8IF8lH2jTaLyclhGWY3rcO3T49
	+JyC6Jdh/W7wnJWfuw==
X-Received: by 2002:a05:600c:348a:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-49fe6705942mr261862305e9.30.1790679035808;
        Tue, 29 Sep 2026 03:50:35 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:10d5:21e1:1aae:c9d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5058c52sm3516303f8f.19.2026.09.29.03.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:50:35 -0700 (PDT)
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
Subject: [PATCH v7 0/8] Add syscon support for Renesas WDT driver
Date: Tue, 29 Sep 2026 11:50:13 +0100
Message-ID: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series adds syscon support for the Renesas RZ/T2H and RZ/N2H SoCs in
the WDT driver. The WDTDCR register is part of the CPG/MSSR block for
which the CPG driver registers SYSC regmap. WDT driver now uses this
syscon to access the WDTDCR register.

These patches were part of two seprate series [0] and [1], out of which
certain patches have been queued separately, so I have included rest of
the patches into this single series.

Merge strategy, as the WDT driver now includes renesas.h header file,
the driver patches can go via renesas-soc.

Note, patches have been rebased on top of next-20260928.

v6->v7:
- Added a new patch to introduce rzt2h_cpg_wdtdcr_count_start() function
- Added new patch to drop pm_runtime_resume_and_get() &
  pm_runtime_put_sync() calls while accessing the WDTDCR register.
- Dropped propagating WDTDCR access errors.
- Dropped converting WDTDCR handling to regmap as this would require
  resource address comparison to get WDT index to call
  rzt2h_cpg_wdtdcr_count_start().
- Made use of rzt2h_cpg_wdtdcr_count_start() in restart handler
- Added if regmap is available, use it for WDTDCR access
- Updated commit message

v5->v6:
- Used pm_runtime_put_sync() in rzv2h_wdt_stop() function.
- rebased on top of next-20260922

v4->v5:
- patch #1 is new addressing Sashiko's comments to avoid potential deadlock
- patch #4 is new addressing Sashiko's comments
- Dropped checking rzt2h_wdt_wdtdcr_count_start() return value in
  restart path.
- Handled the regmap locking in the driver and introduced nolock
  version to be used in the restart path.
- Added review-by tag.

[0] https://lore.kernel.org/all/20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://lore.kernel.org/all/20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (8):
  clk: renesas: r9a09g077: Add helper to start WDTDCR counter
  watchdog: rzv2h: Use pm_runtime_put_sync()
  watchdog: rzv2h: Drop enabling clocks in the restart handler
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
  watchdog: rzv2h: Drop runtime PM handling from WDTDCR init
  watchdog: rzv2h_wdt: Add syscon based WDTDCR access
  arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi |  24 ++---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi |  24 ++---
 drivers/clk/renesas/r9a09g077-cpg.c        |  35 +++++--
 drivers/watchdog/rzv2h_wdt.c               | 104 +++++++++++++++------
 include/linux/clk/renesas.h                |   6 ++
 5 files changed, 132 insertions(+), 61 deletions(-)

-- 
2.55.0

