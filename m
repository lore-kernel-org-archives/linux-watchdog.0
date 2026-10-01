Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF640682A
	for <linux-watchdog@vger.kernel.org>; Thu,  1 Oct 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873534; cv=none; b=KUoI0UxWuMZiG4oLD+P4YcO4xNKsuUpojqgJNHEyRdw39R0OZZxiRB/QyB5cCg0bhzSpm3svgZIyIROetc1p5SSjS/2pwmsGwvJ1XWqZ1uACitkzr0TZXT4lDPZ9jpmS2sSnJxohQsW6tXUEl5Mjx97M28Rzz2X5cP44ZCa/r5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873534; c=relaxed/simple;
	bh=HmiTbJPGI8CBAuIpsu2zSxuujJRT/UJ6KLePj6Bmmcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihPH/kBCd4JlRsOQMyD/a3qD2Ugx7uXScLyTL3sAT1CMnxhIUPwOPZIGbB0Pt1Pmaqpy/lW5BV6gt3+9NAbB3p38enpQZbcEANhUt0mkbr1WC1sxEGzIW9hDJgJABZ6z046Ivxe9D2bhFZQSWz+aU3+IOdEe2PJRAsC5HvIZJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxQULVV+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxQULVV+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so26369505e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Oct 2026 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873527; x=1791478327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Va84SLTBXZf2YB8nUhTLf5Wd3WMjClFg5JEaqlH/ubY=;
        b=bxQULVV+Ds0vSGLyTYZphff/CgHg/O9NoRvQ34Xx4bP/NhXS7ELVsgg4tx6ddLU9tV
         iFOVYpqI2LOYJI2BYQCqYgpIwbBy4ioEvVBFlO5TYglkg3wXvispil9DGJNpkZotR7zE
         k9ai01SSZV+8Pl6EEqKWrz4CtAkLvskZxdTr7u4IiGXeuX/7dSVG9M1lZAHJWM2qU0J2
         5OlORQsgKPsPobNHO4IEJ9mzISmqN5atg9Bxm6ilNKJzIprSkwOjjPYsKyh4d/QMiFeY
         JycwZHJ6kXTvrg+A9rWLoYNVyNpWTvGcXaWjJdftKul3Fnm8KXnmsQNhQMfoRjYMaHuX
         3Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873527; x=1791478327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Va84SLTBXZf2YB8nUhTLf5Wd3WMjClFg5JEaqlH/ubY=;
        b=BjJYIa9KVnGqH2AjlJ0gMBk6Y6VOidnX06Ot0lx5JZOnWKio1OF/VB0SGcOuOmEu7c
         LqexFet2y9ekF7Qknml1GXmG3I5g/DtTzzHb+aBF27trkFYaKRWhos2S8uE30qiQ6jFl
         ruMyE1lJUBGVSL7H6fwTT2h/VmEvdSfOw9wtmKAmLHi4781xyzRRPzGBE0+Qy22eVDK6
         1cpx2JUiFlt0IfIZ6+fzMssRsSqBIes/ydHDNZX7PX6sPVegxY+EsweGpOyRGmd4ELJk
         V+OnylJ2HXc8ixk1SMut7yS9+H5FD5FQsWrmprDRGKHAW7mZRsypvd3xSxgJKTwyMM2E
         YlNQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7FtbxO20pXlSHjGk4kjMGJhQn/nBtUGh9gZpKhoSe0Skq4kvUOVFrDMY9DCbcYFbq5FmmD2tKBgyvAWwTRg==@vger.kernel.org
X-Gm-Message-State: AFuF++luqqo+oNvxH+sWP+8mwC72LIxSHqib4m5rtKbWpPXMESOQzwVz
	XJEbsvfpnqvTRXJVogrGmAAxMxvV9lghMiYB1BUcInQ02fNh4lzFCRVi
X-Gm-Gg: AYBFou1vwNYr/1xt/TQ2PsDwzL2/kU016iXGzyLsDfkp6gMmWSURP/COCj2DFrBxym6
	7pJorQlXrvtNXsc2h+yO3semCrO41GUb4P0o8p4ZYWkUsZVa/Yj+emXGOJb3JByoVraU4xB+fFf
	yduZicpfoFKTY/5nn727V+VMFXvnAB4/j20ZD8OUATRI6c8HqeyiEoi/SvvsW4Ec2YNS4sYxijr
	eOXLTk8OYIv+75RZbKOXO2zCtX7rlP8CdGP76M73eONtg9vSsGqa8ARbsK3RBDUaMAEZplp7A3a
	VNGLNQ3n9YrPisTq42rVPIvTshNxFm7LTqXyDyp6P09AlXdbJWUXVnTe3QiMrcKhPhLpWSjZPSf
	0TdBSpIkeEKrJ56ZL8AhmeX+GUrQAKH4+j4PQYnEUxqnTLreljygGR2lT2+dRRC5dGavJ/9Tx6K
	S5aIKzYm1IDMwuU1CDf7MN+Yu25yrVLkEyZcyHpUmbBp6C8MVMwXb7LtMlQ9Ot48FdfrqeZ5nSV
	FjJE7ArwGs3BaybgvZdELn0bbLcsCjX+PqyCG9SUxGwTdpalmZ0g5M0alAxkLRxntHM2aqcF19i
	ILh5tzca
X-Received: by 2002:a05:600c:1d20:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a0276affa3mr4130515e9.30.1790873526910;
        Thu, 01 Oct 2026 09:52:06 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027ae146csm480985e9.11.2026.10.01.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:52:06 -0700 (PDT)
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
Subject: [PATCH v8 0/7] Add syscon support for Renesas WDT driver 
Date: Thu,  1 Oct 2026 17:51:54 +0100
Message-ID: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Note, patches have been rebased on top of next-20260930.

v7->v8:
- Dropped patch "watchdog: rzv2h: Drop enabling clocks in the
  restart handler" addressing Sashiko's comments

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

Lad Prabhakar (7):
  clk: renesas: r9a09g077: Add helper to start WDTDCR counter
  watchdog: rzv2h: Use pm_runtime_put_sync()
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
  watchdog: rzv2h: Drop runtime PM handling from WDTDCR init
  watchdog: rzv2h_wdt: Add syscon based WDTDCR access
  arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 +++---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++---
 drivers/clk/renesas/r9a09g077-cpg.c        | 35 +++++++--
 drivers/watchdog/rzv2h_wdt.c               | 85 ++++++++++++++++++----
 include/linux/clk/renesas.h                |  6 ++
 5 files changed, 129 insertions(+), 45 deletions(-)

-- 
2.55.0

