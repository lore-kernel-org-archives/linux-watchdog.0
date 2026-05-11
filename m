Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039E4C0428
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525468; cv=none; b=AG5rKEsBegp7Xurb9uNPPS/QUVQ2RXEtoOiQ+XgeZdmaE1sJ3uX6q2rLh83iVt2CdDymt7kTM7pjp7YF5lrbFElujimpg3RgX0fo+x8brFQmHYbe1cH3GnHG0cnIKwQgrQvnILvTLLu0snpCQL2CVAz4lJHciyMuejrUVU01i9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525468; c=relaxed/simple;
	bh=DT00nk2LP9Il6r5Jw/XCnU4nDevdgeglfjX5CCyi9ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CiqSxHLIpzNCTduvcKWtOXAv8n6DbBZgvU8S9HFSdcHpgVmjnYp3rWr5b1sB5BPUdWeXg2bp7fY7BSwwSvjOR8RHx/Ho92IWchtcrSDJMGrLfC1BBJ4Wfe7tuPaYbfNEaE+x6jvtHqrX1qYCInyvgCxVMgAk/F65xtVUj25czMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoN7uiUm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoN7uiUm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so41672045e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525465; x=1779130265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=789XEeQ4I50MnaW2OnqahHH0vEgS0bTPRF2lefmkIno=;
        b=CoN7uiUmhC1IwDUitqX6Df+HS49PlSE7ASxWpNFZu/2e/ATuZPC06AWqKRZ23FLOGG
         Q+HD86ULr3lWgTdrTTElPjO/3L/7pafYMgBFFaWngwXK0UNwdqA2HspRAAycGgth06qz
         +4g4rJAYwRJq/YtLKjX80jK2dFVZIXTE6ICncM4vnjIn4YoJhn3sWdA0ejCnvLuUO/58
         pd/JfgQmcw07GUGrND3vEkjMrM6xiJ5W8FiAc9fBpYOxstDwQrpcXa6a6+Dm6+L1Dywu
         5+aT98Yku0lQ7BV66PhYXtpxS5eqjdFZMVIANmQZp1bJX2zhNaOKBcMQPYhl0PM8GgHw
         ZgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525465; x=1779130265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=789XEeQ4I50MnaW2OnqahHH0vEgS0bTPRF2lefmkIno=;
        b=D4ZW/44lOD0grZJLTepvXRj1hMs8S1vo5ODr7DwimUMx5vQdx/Vv2gdBnBKTP0AwiI
         MjLjvYUdSZ4bKX4vAo6MHjYq+1fFwPuEdT4JkfhSOsIzBQxdLV5KOrOLgmzM/SpxHbQc
         KrQ4gCu+mcW6MejO9CI5kXiJ7AwrbfW8krYlus6YxeGTQ3rFMbjorZEPK+Wi5FoFRYMw
         VOpe0FG5vtwJ+IebqKcC9HA0vdfe2kT/NfSy/JTZbF0q5eUfeXvCD/ZPyTmtYMFIdQB/
         pRr06zTeAHk4BPJ+y1rBGUMQhB0otV7zKRZO6kizpF/9te2VTnFXLlLR7LaMnyU5nUq6
         /AdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aXaLQkREiTbcFCZHnKmTwY2PqKsB5DR3tIJQSInBEtu7AUAHEby8Qx/U/By3Tf+4wru7SVeWB80S9NH/Zdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCTccQiHuWLxZ3gXs+WbvMXF24/y4AWv6R39c1q19EqewRZN9
	90YwhytZDkYk7h+OlOWoXQK+1AUd44n3gwyl8hx2KKuuJ2yoG3XlAUtw
X-Gm-Gg: Acq92OE7D16ZlQ5wJ92v3px89gFm9Jr56Vm7utWBkZJWfuGsYsibMgu9sjyxmK7lelr
	ZdA18ltxnGz7CDZqzAqI3DP5ILPpLs0NeVCh4KqUiLS+RMYYb4T5tPnCVjKBTbFIS03xo4xS+GN
	aOayFIrn8bNvhCS0D9SFwiv9VyKqhWNPPQr2JBMyQ5uAQhFXJotwSNsmXpdNlZwO92w8uJgnr6W
	dQ5TXcvaRO7JDuYAkAu4pP/4BgrxcVjjYnizXuw/Q6NZmMOVYIknchJ+Sa8fxI6ryy8shrtwclf
	inciO5+X1+xVvABIasWBdtQkCOQuMzPSa8mXaajYvwCfNYy5Nl06ZsNPnjGPGPwNY/WgWJWT/HW
	Kpt6ZL13946aK29ij+gqE8hVgLLFHMJ0j55drSBAGWqiGvZQLvVhxSHBpH5pTaccM7vYUYP2LBE
	aGcIZ/h46sSf7z2VqW27QpQQgUGf26Nc3u2vANbwQrURJKiywAk3jj4I1KAxsNWLD+7Ml0WCGDW
	7nQe5/3l+6TXEC8Fm+s6ZWb657nyS7UY4rM1A==
X-Received: by 2002:a05:600c:c166:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-48e6f39f7d2mr194207385e9.10.1778525464608;
        Mon, 11 May 2026 11:51:04 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:04 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/9] Add System Controller support for RZ/T2H and RZ/N2H SoCs
Date: Mon, 11 May 2026 19:50:49 +0100
Message-ID: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This series adds support for the System Controller (SYSC) blocks found on
the Renesas RZ/T2H and RZ/N2H SoCs. These blocks handle critical low-power
management and access control functions.

Hardware Architecture & Dependency Challenges:
----------------------------------------------
The SYSC in these SoCs is a multi-functional block responsible for:
    - Clock & Reset Control
    - Low Power Management
    - Clock Monitor (CLMA)
    - Access Control

A key architectural detail is that these SYSC blocks are physically located
within the CPG/MSSR (Clock Pulse Generator / Module Standby Software Reset)
address space. While the CPG/MSSR driver is already implemented and
functional for these SoCs, the integration of SYSC adds a layer of
complexity due to a cyclic dependency:
    - SYSC requires CPG: The system controller needs a clock to operate.
    - CPG requires SYSC: Access control registers within the SYSC contain
      bits necessary to control the PLLs managed by the CPG.

If implemented as a completely separate top-level system controller node, we
would face a cyclic dependency between the CPG and SYSC drivers during the
boot process.

Proposed Implementation
----------------------------
To resolve this, the SYSC blocks are represented as child nodes of the
CPG/MSSR controller in the device tree. The SYSC regmap is registered
directly against the CPG device node. This hierarchy correctly models the
hardware address space while allowing the drivers to share resources
without deadlock.

I am sending this as an RFC specifically to get feedback on the
implementation of the SYSC as child nodes of the CPG to resolve the
dependency cycle.

I have also included patches which updates the WDT driver to use
the SYS syscon for register access.

Cheers,
Prabhakar

Lad Prabhakar (9):
  dt-bindings: clock: renesas,cpg-mssr: Support RZ/T2H system
    controllers
  clk: renesas: r9a09g077: Add SYSC regmap support
  arm64: dts: renesas: r9a09g077: Add system controller child nodes
  arm64: dts: renesas: r9a09g087: Add system controller child nodes
  dt-bindings: watchdog: renesas,r9a09g057-wdt: Add SYS syscon support
  watchdog: rzv2h: Refactor WDTDCR start/stop handling
  watchdog: rzv2h: Add syscon support for RZ/T2H and RZ/N2H WDT control
    register
  arm64: dts: renesas: r9a09g077: Use SYS syscon for WDTDCR access
  arm64: dts: renesas: r9a09g087: Use SYS syscon for WDTDCR access

 .../bindings/clock/renesas,cpg-mssr.yaml      |  39 ++++
 .../watchdog/renesas,r9a09g057-wdt.yaml       |  29 ++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  38 ++--
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  38 ++--
 drivers/clk/renesas/Kconfig                   |   2 +
 drivers/clk/renesas/r9a09g077-cpg.c           | 180 ++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c        |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h        |   1 +
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/rzv2h_wdt.c                  | 104 ++++++++--
 10 files changed, 394 insertions(+), 44 deletions(-)

-- 
2.54.0

