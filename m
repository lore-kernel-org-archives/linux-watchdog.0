Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395243;
	b=NhADRXTNBVjFNggigQcGZ8uOba+5OYKr36eUJgrLlo1OR5KId7CGLB0IYcGpXWml+fk7
	 41bkJ80pGO4ARxFOKmXnO7VnnjoyZEWfGv034UQA0o51ma/fGy4Qb684IZjwIons28H1i
	 fvc8qhaJaAn2mHagPZU90AXABe1At9S2b8ckZb45cFoFmphQCjiUvAffnTVj8MjQi9zeJ
	 ozRdVfAPE2cprPrymF/Fyh/RNVCTJimTuHhpwq4ubc+6FsR9AtrBjISw7JK7cSsOoOqxh
	 FZATQHBsX+QoDh/Q9OOjrc2tkNgGxWfMlVzXc1GvgcAPlafY7ESr7otnTV1G1D5WD5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Q2NFx7nPmxyH6HT1mTdHW9zn6FjnTMuVSCUO/8QAwg=;
	b=vXJUIyMffdgmL7dWNNWyuZzdg427ErwJNivFJE/g9Vr0DunGzq8VbfKkZbJJFeNrnMPv
	 OXcTfoPiMMl3gkgko4lDVZQNAC4OE/ojpwuaidzL2Xha3pmb1Ujjw5PaN4Eh0FtUgQdUd
	 VDeM5SzfQ+i/HdxgLY6/IBt+84frGlRGNIQM6Mn8Orfzx7RQr/s4Ory0rIoJvMo9SOWAt
	 1F8+xcj1F40QlCgar7SBMsPdc7QO9Y9asxasmKXEgI+PR09r8rDFsT+cYp1zGE7RTpBON
	 chhpVLo4DGU8xcqSq2mUhSxQCjOdgwPgXcqwcK7A6Vg5Ed5/1QUFxeFYdlh6K40VAMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="en/3dGrF";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CD606A327
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 11:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0CD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=en/3dGrF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a208d93758so32625595e9.3
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395241; x=1795000041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Q2NFx7nPmxyH6HT1mTdHW9zn6FjnTMuVSCUO/8QAwg=;
        b=en/3dGrFdvJrBqQhikOW+PJ42oaQqIk3OzHx9RLAfQDkUDn1aTsV7YsOZ0bPdfl4bQ
         pGNdLFmbTpKjWEAow8OWp0470oYPNjsmPTKJO5OttZRd5Hgmpfs+N1lRF21K7PdlkRQe
         xjFDWY2cvDZIIadt6edcvzW42VU4opvLx2F6Lf75Zexq6WKtFVrdD8O2g5SWjQg5f7b7
         rMgTdL09UL8EWI4FsvF9Jg45Wy3hHi0vdp8QKobs4CXFQp0EUyIURJXlBSTMQuEcW2Re
         BiyOeIuI9QRrChoN+zNRxRIDgPX1CpvkfePHqsIxEaQU8W428VzcuqWOVtk61X7cWXH5
         v1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395241; x=1795000041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Q2NFx7nPmxyH6HT1mTdHW9zn6FjnTMuVSCUO/8QAwg=;
        b=jTfs/GIFAy5Dv2rnDd6lg2Dc2PVi7cV0kOT+MapKD6FlwK4woVZdzHiA6sX+dFZcsA
         AhpTfEubFp41lulCj1NOeXcqUs95kgH6WkEdTL8ABImdIzsNcCH5tgcsYaMTJiOPZ/3B
         C7PqWDdgvN/Na0S9wTjY4doKnxF8liudIxKH4dueSJLJVdVstdosMeLXFwnhamSECVos
         uSYACoFRQaNIiclVGydf/FFf73ki1FkHKXxQ9MsqKco5+8P4uIT1Hzu7POTmt1ry/uL8
         a4cVTp3BUP03us29HDJiLLHzm6AyAz05CCWpDbr2X3c5iuA+8ZhQEiQ4F1ff9Cr2+6Qb
         yxhg==
X-Forwarded-Encrypted: i=1; AL+hErEQs1uQSsw8JIYtKujJ/Lth9MuMhRBmoSz02aOSryI7TQhrXNZ3xWYD47NOo3SxpLzAYiRjtMBE+ZNrqE22yg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nRP76Y1RXMQ2OouaDzgI7DklvbtesQtwEjUZnqsZqojCq24+L
	rW68AUKAL48/kLRJ+gJBMt1sO8Ieblyz31Ca2xtPLyQIVaiML93UXxNe
X-Gm-Gg: AYBFou1Up0fd227o0i7XhksqGF4pNEEoH6+ZoBKh1202qcm2/oUHiL5spR26jUv59W5
	SxCwu7p92xdsuB0fRhfHnheHUb4UcupdR0YBeIhrJGA7ZcS50CM1FnukAPKUIymONLG7MQ7vQfL
	ZqUeE4VULfhIedJoTebe1o+PXOt7CC9bQggs7QqpByyuijpgEdAkzOB/S7Ttldh2n3LPu1Fu7x/
	IM6YcJ/Ql7a/aZzMQMWOouCk1Kb7DjAWGKhsE8vojsGBUd5EAV2pAgtqC+l/DDZWhKK9SzDQtke
	4QCL52dkEM/1bOJnbQ/XoaDwAWAFO5l2k5JWtpAnU7zD8l4NYTo3uzHnJfkP8nPJiv+NR6Kb3At
	RUEkMbKQBZDCeBP4R7LwalRbdbQRlkxTomFpVOiMGQVelVHiMefBKWswlJ5cbO9WlyzxiyMRWqd
	4iDCeM7xem/NnsWA/x2t0v37hs5WvYhVO1b88KowJe6XXF8m2+nnE6rfwoVcMeYzqf+A/kDSejJ
	57e2TGhdX/G4tW4ZHQpgj+7qKd3vg5Um63gA7TV3zn3oB1KF+aZnXPTcP1zvTVadbsuyE26Dr3a
	xWnJ7lWvhasOpS5iSrR+gWYUjhJeEwIGNjmpSd+PcTVpopQmnJNMitaQ4HYt+vcRsK88ekYKo2E
	cbLQcMOmfPJp81YHzUfw1ZZl2f1fsxkJP17lKViEjs8onJmP6+v1eGO2/HZVRYE8IYcturAbI16
	PltdKkxoBY
X-Received: by 2002:a05:600c:5247:b0:4a5:5fb9:5d35 with SMTP id 5b1f17b1804b1-4ba0937f143mr36040755e9.21.1794395240926;
        Wed, 11 Nov 2026 03:07:20 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:783d:786e:fe55:f40d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm146727295e9.5.2026.11.11.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:07:19 -0800 (PST)
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
	Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 0/4] watchdog: rzv2h_wdt: Access WDTDCR through CPG/MSSR syscon
Date: Wed, 11 Nov 2026 11:06:56 +0000
Message-ID: <20261111110700.3331225-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

On RZ/T2H and RZ/N2H, the watchdog debug control registers (WDTDCR) are
located in the CPG/MSSR SYS block rather than the watchdog register space.
This series exposes those registers through the CPG/MSSR syscon and updates
the watchdog driver and device trees to use that interface.

Normal start and stop operations use the syscon regmap. Since the watchdog
restart handler runs in atomic context, the series also adds a lockless CPG
helper for restarting the counter. Existing device trees using the separate
WDTDCR register region remain supported.

The device trees for R9A09G077 and R9A09G087 are updated to identify each
watchdog's WDTDCR through a `renesas,sysc` phandle.

v8->v9:
- Rebased on -next due to devm_kzalloc_obj change
- Added RB tag from Guenter for patch #2
- Dropped WDT driver patches as they are now queued in WDT branch

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

Lad Prabhakar (4):
  clk: renesas: r9a09g077: Add helper to start WDTDCR counter
  watchdog: rzv2h_wdt: Add syscon based WDTDCR access
  arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 +++----
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++----
 drivers/clk/renesas/r9a09g077-cpg.c        | 35 ++++++++--
 drivers/watchdog/rzv2h_wdt.c               | 77 ++++++++++++++++++++--
 include/linux/clk/renesas.h                |  6 ++
 5 files changed, 130 insertions(+), 36 deletions(-)

-- 
2.56.1

