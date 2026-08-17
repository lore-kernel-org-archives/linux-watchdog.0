Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9723BE162
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994754; cv=none; b=lgxg94K802ngaRd7IKHXmphHFqKCV7qKZG8DqSQZ2sPSjHlkRGyXfoygZRoJweWplyzbimttvcqLzwcgcrhLKPHP98+9/iC5v3okMhhKyEDDDFo6CiFxNtiQ6HN/54ROovrJAIk7bBnvaJ8aDAEPFqpG4LZz0S6O8oDNPhURda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994754; c=relaxed/simple;
	bh=z4DT6dN/jk9zq+6dKLH26w7v70HEmqs7syBrbJ8So2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezTfAAqVx+J363eNflMH+Bg7W+RhDmuQHbP4DJH8JQhVXtPWOrQPQTvwnPe2UNhWIiTRKshEHKE4Dr4jhA2PTmLPBCIowy9kppsAQUQLJmjlmRB4tq5GaCVHiuNslcwSWyhAQ3Kt+/ahJ8ph9uGGpvG4qO9huFoNijvYdhXc8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtswwQEZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtswwQEZ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3641358a91.1
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994753; x=1787599553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mcvMe3XH85aCVxTOzu3XLPa8g4zrrCk8XeaSRvsHMk=;
        b=RtswwQEZ98Nfq/BlwLuk3U5MYmPlGUyKdqlruyRyo2NIBoKJpaGihvUfTtZyFhpiD0
         4lHhJejnGVmIQcL8hjgOR89ErQfdpChDDrE+WDQ0Z8do9dunwrl4xuXM/S36mIsYp1ui
         klCqAXax0fBF/ZdBMaL2PrmOAjKvGotuSqFdK3G4auJLUZCvEs21ecdNgM1TM4mr30lw
         LLBith5oqkYt097uTXCrgn0aAtPxIeL5uKljhnvq556nwTl2SUOKI4uLqzbSUFrtKOmp
         fn80WVhcXMVvF/fbL7w1MpzNqcFP+ZKWAesVhuYoW9YttSf13Khz5LJeZ0JhxCZKUGtW
         AB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994753; x=1787599553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mcvMe3XH85aCVxTOzu3XLPa8g4zrrCk8XeaSRvsHMk=;
        b=ZjmMPJysi0VHCOmzdMpDjcT2DjlNfnmVtn4HVONcnYy2ozZHknMTHnO89z6h7oACI0
         UkaRnKZPdk5Y6uO5qbVW+cmsphPtuN8bEbF6EQ8b+PUcNSA78zJIPpByAS0Dx+PzdiPE
         JBIm36YFCy0wFTFu9DrHIpe8GKcRyw8tK90OBJz9GkXX7+vW47n/uKiyEYtfURRXPZqM
         YAKKkzjDvzWkvWlol+WaFMrXE7GW3qxwPaxTy6/JRea42Q1l/QLn6wQfbeKQYQIa9aQx
         0XjTgqB09HrJaU/JSb6io6RtXYTvYxoWMscuoWrbU0MJqXCiZChln86BxgnGIgrjzsHi
         HsDQ==
X-Gm-Message-State: AOJu0Yz5U9pbJN7u8npy6hw/sFU2dcrA6AK0fOAXy4tqDFVPS5Vinyj8
	O8akBZhkJWgg6e9PCbCx6vigeNFJTUD7zCAtPDZbkxT5y11yvwx7WFeW
X-Gm-Gg: AR+sD11HJe7YEC3CerdrtTXJMuvVLdpK3SnQ1oPVfCdb9l/5p0KpLI/4pS/1W1BYFLL
	E2Aw4gIV5XDUcWj9hpLCdELo+F+uHT28veTashkTYXtKRP1vQtgT9vG2Qqsynw5QaeLRfAlj4/P
	2i8KXr7k9UlGQJEnibupKeOzk8i89lPVFWR/oB7EcZNgMBDhzKiNrJ/GruLW071gUDW4DYTLCRz
	3H0Z4Mj196TcPEMc5B3WPrmhXTWLTi3FGPZHr1sc3Ru15bCrvprIlFH5MnZ9rLAo3HH9kcMahQa
	HQaxVKBfzqzz/dcygKz3PbDkyF1RaCAtTiDiPbi+fckqvrxqsBhZLZvmCaUdq3LdCk77paws3Zj
	FSUyu+UOHqvrzB89E6RNwcTIhWPvkxVQbcMIH/HbpegmpzWbuE7YswsEp0t8ZUXrv/MI1Z2QZzZ
	PjYxgRFPcjbFc0jAjKl1YK1YTsU9Ml29zfMbmA67leVRmSGPCeoATeJGzIYkbcNalHtaLcG3e4D
	WRav3ddRZYrpdVmzf56eYbbahhIwTsRluNd5pBU1rgYPCDlUWpsIsdphHBR92zc/uGUkU1JAHOA
	yf2i1233ng1x7JfsK3Z/
X-Received: by 2002:a17:90b:3908:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3933e74e1bbmr25944829a91.18.1786994752447;
        Mon, 17 Aug 2026 12:25:52 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:f886:32ae:1e17:ec13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10218757eec.13.2026.08.17.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:25:51 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/7] Add syscon support for Renesas RZ/T2H & RZ/N2H in CPG/MSSR driver
Date: Mon, 17 Aug 2026 20:25:33 +0100
Message-ID: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series adds syscon support for the Renesas RZ/T2H and RZ/N2H SoCs
in the CPG/MSSR driver. The CPG/MSSR block on these SoCs is a
multi-function block that integrates several system-level features beyond
clock and reset control, including clock monitoring, write protection,
and peripheral configuration registers.

For the other IP blocks to be configured a syscon support is provided in
the CPG/MSSR driver. This allows other drivers to access the CPG/MSSR
registers via a regmap interface.

Note:
- Patches have been rebased on top of next-20260817 + renesas-dts-for-v7.4 +
  renesas-clk-for-v7.4.
- The WDT driver patches apply on top of series [0].

[0] https://lore.kernel.org/all/20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/


v3->v4:
- Dropped DT binding patch that split up the renesas,cpg-mssr.yaml file
- Dropped RZT2H_SYSC_BASE macro
- Added array of base pointers to the r9a09g077_sysc_reg struct to
  support multiple SYSC regions
- Merged r9a09g077_writeable_readable_sysc0 and
  r9a09g077_writeable_readable_sysc1 into a single function
  that checks the SYSC block and offset to determine if the register is
  readable/writable.
- Added RZT2H_CPG_REG_SIZE macro
- Updated r9a09g077_post_init() to call of_address_to_resource() to check
  the size of the mapped CPG register regions
- Dropped changes from cpg_mssr_common_init

v2->v3:
- Switched to non-RFC patches for the series.
- Added new patch to split out the RZ/T2H CPG binding from the generic
  Renesas CPG/MSSR binding.
- Dropped WDT driver refactor changes from this series. These has be
  submitted in a separate series which makes use of regmap.
- Dropped registers from writeable_readable list.
- Renamed sysc_init to post_init and updated signature to take
  cpg_mssr_pub struct.
- Created a single regmap covering both SYSC register regions
  instead of two separate regmaps.
- Updated commit messages

v1->v2:
https://lore.kernel.org/all/20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
- Updated commit message for patch #1
- Made use of for_each_child_of_node_scoped
- Moved sysc_init() to the end of the probe function

v1: https://lore.kernel.org/all/20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (7):
  clk: renesas: r9a09g077: Register SYSC regmap
  arm64: dts: renesas: r9a09g077: Adjust CPG register region sizes
  arm64: dts: renesas: r9a09g087: Adjust CPG register region sizes
  dt-bindings: watchdog: renesas,r9a09g057-wdt: Add CPG/MSSR syscon
    support
  watchdog: rzv2h: Add syscon support for WDTDCR
  arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

 .../watchdog/renesas,r9a09g057-wdt.yaml       |  29 +++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  28 ++--
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  28 ++--
 drivers/clk/renesas/Kconfig                   |   2 +
 drivers/clk/renesas/r9a09g077-cpg.c           | 140 ++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c        |   3 +
 drivers/clk/renesas/renesas-cpg-mssr.h        |   1 +
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/rzv2h_wdt.c                  |  56 +++++--
 9 files changed, 247 insertions(+), 41 deletions(-)

-- 
2.43.0

