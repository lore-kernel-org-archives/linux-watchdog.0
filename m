Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336C3081BE;
	Thu, 29 Jan 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695662; cv=none; b=VIEJq4oOvQFpddrBeyOgbWLzfx0q6dj3sqBXBkmECPqGhEX2X7XzQnI7i2NdU/vDNZ80DW+qZsL/1VFLr2ixLkIJeHt9M9XqheVcHLiuympgTEHTQSFd/T4UkpLTZS6T/FzV6azAf1inCIUdHC/kO24GtSC87vHB8Hd2EIyAYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695662; c=relaxed/simple;
	bh=j2B6oCIQlW85QfPvxgMRUkjd7ewA+gIOMHByUGvmrBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJw2CPILtUY16dvmkGBpyq7MQ6vT0O9dOd5kCfFPAZohdO2ZQy4v62jJnzZc6MRczYNYh4a9lCy16rCGQz1mYOcyUDzLw+Xer2mR6YlLEFm+phICFHgzCt+LQl2oRqZ7fC1BNJVoqkjWi9uNc8PH/cT+wu9vNDODW3VaM7a3O8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: T+hVw0mWTBOgU8YDHgLTDw==
X-CSE-MsgGUID: uqTPQBSuTq6Qw3dQUfC7OQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jan 2026 23:07:37 +0900
Received: from mind-2s.example.org (unknown [10.226.36.118])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C8EB041AE669;
	Thu, 29 Jan 2026 23:07:32 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Rob Herring <robh@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-clk@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH mainline-linux 0/3] Remove WDT{0,2,3} support from RZ/V2H(P)
Date: Thu, 29 Jan 2026 14:07:28 +0000
Message-ID: <20260129140731.12633-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear All,

The HW user manual states that the CA55 cores from the Renesas RZ/V2H(P)
SoC are only allowed access to WDT1, however when WDT support was added
it included all the WDT IPs (WDT0, WDT1, WDT2, and WDT3).

Address this by removing the device tree nodes and clock/reset entries
for WDT{0,2,3}.

Cheers,
Fab

Fabrizio Castro (3):
  dt-bindings: watchdog: renesas,r9a09g057-wdt: Rework example
  arm64: dts: renesas: r9a09g057: Remove wdt{0,2,3} nodes
  clk: renesas: r9a09g057: Remove entries for WDT{0,2,3}

 .../watchdog/renesas,r9a09g057-wdt.yaml       |  8 ++---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 30 -------------------
 drivers/clk/renesas/r9a09g057-cpg.c           | 15 ----------
 3 files changed, 4 insertions(+), 49 deletions(-)

-- 
2.34.1

