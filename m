Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F43AFAF1
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125483; cv=none; b=hdnmb4btK3z/8+Wj4JE02HUMtO54nH2WpaOg+57ZRArBC+249fCKQQc4K9P2AwoaYwcR5otUoY8sHb8HTd8eQJnAZJxcZWKu0bNNy1Z1e7eQzH+Cu2WFMR+CWMG0PQQs4JEjzYmc8I6FAp1Q1aucLYB5Xy//b3022EE0fQYw5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125483; c=relaxed/simple;
	bh=BP803oURR/lN8mCs4lhT55YLQxArhtFJ/cLKl3zfk0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMrmT+9yXYZTjls396OcZivl5xpW/rW/fDTiUcN9pjx7FdNZJUx/UmAkeqveNKs5Q2OPTAw4fme+ETMNpfuPTit6uZ2rd+3LgJv0QdUosArylGoXz3sQA45YX/IiR8atPEoQwPoyWRW9zsKWovSH5x3iT7E3ufMiivE5j5aV8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgxYvuu9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgxYvuu9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so1249842a12.2
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125465; x=1789730265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGymmArXv4evJmXGsdnDdmakRi+qhuX+cQlFqwWpb8A=;
        b=MgxYvuu9WAINZLrlXY8oj0LQQuraqCWwcCOdzY9kBKp0x05pNms4Y4IzU60eQWEIZP
         GDQmVmp6vJv6OAbTwzu+0q4lOtskFY+TnUz0VVOHMGgm4zhNAz/vfyKicym3949kPmSz
         z8teXUI8Y1Qk31epJ9SGu0Q1tjZV5VF8hc5u+djkhw6nyLt/5BW6pR9UmIne3P+bZEMp
         ggM3GrDIsyhLlkkaECUSP9mMQmNa3ejndFyBDv0WhFtq+5cadX21ZEfr811Q8FViyDm/
         nga6/H1pwgyxpYdlB2RugXzXMSdCgOy6dM0K6fdFU0g2IndkT/T2t5r8JXRumEftn8md
         JCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125465; x=1789730265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGymmArXv4evJmXGsdnDdmakRi+qhuX+cQlFqwWpb8A=;
        b=lAKDC+s54UfLmnrW7tjeIgMBLMMZyol6fFyMSAVualXd4knhmbQppoA1ecj7tAmg6v
         O/1v4K4mexFmTbz9gfkIz/Rw1yewLWUHNoWHr3PP743GvPJNF9Z9UyN8rJuYt1JU1bXI
         ka3kTLPAWbGhap9UZCpafiNoCHWzQvuUlDhmW1yL6kHk7deyL+YgIE1ppdGWLJ4SgPho
         WxQ4CFVbgOfFnQPeuPr/8Zu1RZzRnrNi/qm7MUJectsgNPAwQtAWtYIHnNXd1JLBgN+X
         Rwv/qZ0gPWSb/PE/Zt3lhLBMkJkdqAxOtYlK5b88cl1Yu5WVDQn1pM1B8+SLJ3cr2g3l
         hnNA==
X-Forwarded-Encrypted: i=1; AKwUvBxjq63tjJHXTaq0pIg64q/ba+5Tq4gUNLTOlAFJbwB+wKSWaxm+/8LfPo6M5fRcStSc/SjeQjq+yGNIybRR3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lYSf6KLzCtmhOSWpwVWnIvcn2A2341DNU6yKDT3IHJWINOmqW9
	guaKLCIJOz0f/TGedtvnnVtgX+exNPdsi1kqHK1dzIi7k2BZOH1tcsuN
X-Gm-Gg: AYBFou0WRR1FGTabGlOcSVq9fGHayWFyDQK47t71OrLLC65zZ2u2R4mTVItGwgkK7S4
	9L2+JYf+wOvhy5Lf8rlgUQ3xmune4onOvEK+vfe5FGqDJzGRB0pTTzG6aX4QFtYTeNngaQFWVrq
	+MfJj8ySG6CtLwyFy72bf8IljQoRk7HK8r3oj98bvMIq3gjRYG6GCPNxyVrbAEVTBcKW0jc7Tpa
	eFkP86V19Lm+ocHl1jouORe2RuEr/fG1bAhcD3TNisIKipXXbSELtruZIEs9aZND1LNZmM81+EF
	BEU0Bx7EqoKBc1DdxkY+B/8svh0zFIQ53nDiyBYUo+T7oU6YWVgFVR2q48PjQrPaqdeU8TFnot7
	uYzwDN3OVG8qUtiRndYVi8XyFA0PC9DOaGv/wOGfNMMbDpOPXd+IbOpiApnU7s9YxUPc32xfYxv
	J+0PnJDfaEmVemqmbXXmBXJUsXy2Ghs0AWHsh3Ailew7SPzRLpbp0rhQaxSmQ8tg9INr4NivZyj
	2DfUng0CMsLXTQgMWsie5U4a5rw85ANdUcmq31g9OJ8YuhIkZUwxNp2ua+LyviBkVbqdDBQ7g8i
	FY/CKrGIE1k63JAfcyM=
X-Received: by 2002:a05:6402:1587:b0:6a6:584:d9e7 with SMTP id 4fb4d7f45d1cf-6a9b5626b12mr1656298a12.15.1789125463808;
        Fri, 11 Sep 2026 04:17:43 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:3de1:9f21:e874:3931])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5438182f8f.5.2026.09.11.04.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:17:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 0/8] Add syscon support for Renesas WDT driver
Date: Fri, 11 Sep 2026 12:17:23 +0100
Message-ID: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Merge startegy, as the WDT driver and DTSI changes are interdependent
maybe the driver patches can go via renesas-soc.

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
  watchdog: rzv2h: Drop enabling clocks in the restart handler
  watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
  watchdog: rzv2h: Propagate WDTDCR access errors
  watchdog: rzv2h: Use pm_runtime_put_sync()
  watchdog: rzv2h: Convert WDTDCR handling to regmap
  watchdog: rzv2h: Add syscon support for WDTDCR
  arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi |  24 ++--
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi |  24 ++--
 drivers/watchdog/Kconfig                   |   1 +
 drivers/watchdog/rzv2h_wdt.c               | 134 +++++++++++++++------
 4 files changed, 122 insertions(+), 61 deletions(-)

-- 
2.55.0

