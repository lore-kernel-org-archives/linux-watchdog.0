Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2649DBAF
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160068; cv=none; b=m9zouyTTa5B8YvkjV+u1OmtORvRw8AuNmfmhLH5BqfL3dFs5FDc6jmsmFfjdWev+yhhRyR0NrFt9ehVLTdDGw2sx6XOzHepuzQeKb9PEDAV6B/QNm5+yJEVoMvh+20xWAT34GILQ+CqOWrWNYf2eRUF2SEe255zdZf8pqqeK88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160068; c=relaxed/simple;
	bh=5PxAU3paz52Mtr8Jp7nt7QVnPTjaM1KWEmISoLCTxR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk6yUNbRiUgCpq+pdLocGA6kbFaHmk2aRYv4jAGEJY/Hr/DBvSrxySJs4NHlaHMTtXDgPdVipIpODUQobFbGWWjKtdZuL8Miyx9IV/6I0g5LZD/IOi/1TwwxyVbNZwYYktkFpoNfgDiqNgyyfwAFltdwEwr7BOEvRhqBQPzrixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT5252TO; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT5252TO"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso5048375e9.2
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160059; x=1790764859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXUSqDqmWGsUiKj+kk0gzwU59ohBd+/qcFHp0F2IbXo=;
        b=gT5252TO7b3cbPpVLNSSByHVIfFTHAPa/Hor83BOJw3cjUetXBPDN/KYrgMekO2aGy
         KSHwV0avJ+L7reBPXQqwpVtCcopslvTYpIvhwMh7oGbYBDrqAX0DhP3A4CHEmXpMjxmb
         0j1BVXjjrSISF/iXaVFsXPUv9RwY1X30q0MVKXS763ZwSKWR0Pp0THge2HOr0LdsY67a
         IEdGsqfRRKocB3Y+cx0CKW75aPuXviPPh+O7Kmz1CMgyhbe/V/aiW1LW6VCTm8VgJqK/
         wSIP1xU/5ZkV7joikgLVH9VtAgilA+6O0HHPoSjMrczO1hVVWPiPdFTIRLeBOVHMhPbt
         +xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160059; x=1790764859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXUSqDqmWGsUiKj+kk0gzwU59ohBd+/qcFHp0F2IbXo=;
        b=E4Qall1QP3Ponk75ESlTfvpBWX0tPrbMaeT8lYYNIwfXTYZd0QxOLvi5dyUkQcDg6Q
         ZDbjyV4JoMoAxtMw/SjUEGNfsgiMWXrRvGUlAE/ORAgqdgPTZII4RZXxmI6XurxLLoE5
         ugysshk+qwdhtLYpu71TW3sDM4ux0x/Mx/C2UBEH1IKp1R611Ytna2ivvooWMQOHLkcQ
         12KuAYPFut8YX18OfFTdLHXGQ9TKQDArFcz3xvHPYrcbfg4IBfdEFEfAl+cwIXsch9LH
         1kYf1dE1j7FS6gFRxvuDWI3WYBm/fx/OV2jjjnXu7ZlIKZHe2JEOx9EuYQUHs30z5B92
         RLGw==
X-Forwarded-Encrypted: i=1; AKwUvBwxm5W8/I6GCFKrRwZlaQi/Slg8dBzPtcZDLYD36KPSfKcrALbWH1AujdwlDAtaqUjHnPiUDQcIxOQbMF9epw==@vger.kernel.org
X-Gm-Message-State: AFuF++npGRvlZ/1iU3BEvhNIuufrzjUSFT+uK14qboLzNnWHLcFuwJiQ
	7Jq/8ljocTwmqlNoj2oa3cfi2mtRX53nSKl9PD3xlL0xJV7GDCljjSEi
X-Gm-Gg: AYBFou2RzfvVjR8BO7IadOiTUh1pAmGwQSabA5+0fmfgkald4olNrw8B5cFmMqI+ZL1
	LHFPYU0a+94mQZ6DtfCNQxuBXT7SuVMQJVQgETpHCy0uMptAY2zxaUvbANsUL3DzEZvlBIc69Zc
	Urlfa5nntOYZooNkE09xfIGXY+x40+/+nNHCgm5obeIn4FG8Og0GVNyeH1zeIGNmQCWqIyD95ur
	X0ZCLqNThvGMHX8sO260vs3RSvBzwJj0n/cWnnN96fJz7NXZs4qjTakHfB+5Ntx8x7QmhFQf44w
	EdlDSoUSxV7wkDs0uTX9vjK84KGfNou/8ZHT11u0u6QzfOFWw3lVG21lo4hc4m3M9l5fwVh0J9l
	M75JIm/d52fGP0qpqtJqWS1lE3fLFPshs7IDfz6FX+oY71bn67xz2Vaznlo99VL6ypUNcRUAnDf
	dadBAiclYpuQj/6Yfsq5tQqmT+6LBCBc51XVJkCuk54eLcA5gWopOBhO581wUd9BsRA1+e/PUBm
	6uO2O+HtQhEId7cza0wwDZavG4/yrJKILkSOdQbul2dDeQUvKWGc/4u1qLv1pkPxG+Cehd45B3o
	Uuh+AqLlKMMBV89xBVA=
X-Received: by 2002:a05:600c:8b64:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49fdee0a0ebmr25441525e9.4.1790160059161;
        Wed, 23 Sep 2026 03:40:59 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:885e:6ade:cc5e:a35e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm65170415e9.15.2026.09.23.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:40:58 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 0/8] Add syscon support for Renesas WDT driver
Date: Wed, 23 Sep 2026 11:40:46 +0100
Message-ID: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Merge strategy, as the WDT driver and DTSI changes are interdependent
the driver patches can go via renesas-soc.

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
  watchdog: rzv2h: Use pm_runtime_put_sync()
  watchdog: rzv2h: Drop enabling clocks in the restart handler
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
  watchdog: rzv2h: Propagate WDTDCR access errors
  watchdog: rzv2h: Convert WDTDCR handling to regmap
  watchdog: rzv2h: Add syscon support for WDTDCR
  arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi |  24 ++--
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi |  24 ++--
 drivers/watchdog/Kconfig                   |   1 +
 drivers/watchdog/rzv2h_wdt.c               | 136 +++++++++++++++------
 4 files changed, 123 insertions(+), 62 deletions(-)

-- 
2.55.0

