Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834137BE93
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786904; cv=none; b=fUTCAdGWnTRSLYmMHLeDML6SVJymQCXtAEN81G1T0CDlQViINbGneNjneiZkmDLLX0ozuMitnYKocxKgj+c7829sECEE1PHMyYgIQQW27EmaJKHxTDtTl93BxOQpcXWu7hFTP+dWF0RA1yh/OTS2Iazv5OJ2kBnV79WRdpcGTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786904; c=relaxed/simple;
	bh=PyrWdns1OrOzxEPcfbY+R34j4aE+Z2Ud3FTa8IgPb7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2Uipg2UniVvsm/TBesnAZ5f0ycGpS73fCQi573TQDmYv+F6YBnASa3mZiLNXT87RAGrmI48xxafw+yjkuJ+67SuKAEh9yGRk1CpbEci8A9nOxOIEq4ZdxxPq0PYvEFQs4krCcKBiGppV7nFKgdZgfYyU3E+1bztaB6uOuDBVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSMjpX6z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSMjpX6z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so3389135ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784786902; x=1785391702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RjXGzvZcsEIuIReWqV3AthYPTgXMH2ZnkuQulSBosYI=;
        b=dSMjpX6zDmwv9VF08XBefORxhYuMNZ8TaNMIJ9lbzmZE/K/4TubML4wbuU4jxizGfK
         0UUrk7CEF37RJg7se+0oPlE/kNWj2wc3W7iCbu9UWdCF4QE1kxCymFmNtZb/I79U+aqX
         JDzSAplkBs5/Gwz/byEGBEthjzjAUBI2otMXKprUU0IEY+NbfApqA+RFKqeNEsaPvBMk
         Qk1LrY2Nc7wSftFHkV384gOSGmvsIatfMQgl2mV6oePxk9p7O8P3V+wZouhNx3OK87Xg
         SodqkdWkw882zl50bSrUwErGZJBbkDXZ7vr8rede7GS5l+joNTL2kRzQCM4kxV2//LxM
         LVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786902; x=1785391702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RjXGzvZcsEIuIReWqV3AthYPTgXMH2ZnkuQulSBosYI=;
        b=Rpb7KIl/acsUGbqURgfhlkYwSEUOf/BQP1PIZL9XexqCkfYthKXf9wNk3+8AQ2O4gE
         ZPaT+6XPQyZtr2e3B3Ed3K0JajakMBFpXh4XKGNbA0XGSv0iliWTVsoas5FWRQ+blDgo
         W3fxejGQMDRd9qWUfAjmRZK+xyzHd3SfdrfBt5HV36NjKl+jAWeh+D+c/RgJfxKzMlcH
         5QTb27pjzhViePjmwjRlIUaa3MiLTh1d9RE9cgLV7UbJasWFQQFGk26UwMcsEFDV5vZR
         sP9SwPU4qjoPPHk3KAmLs1O7iOa02eaZ5BdO0AAHAewF9fpslY70mJOnEWuZ5FGS9hlA
         yvsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5tgcc4HvLgjW5O7rrB3UtAd41Jut1r3jmM3jBScTE60QK13ZqrzksWOp5BAwf81MLVE5SWBzRqRWduWn/8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrNVUzIwRY29Tv2lUevTzJUb+XhBmEDp2KMOinIp1Qh9BlfzY
	l+3HssRtUMOShdyVAImzR1DNAOdor4snJ6P1aofaeU14/1kqGpPcJIGf
X-Gm-Gg: AR+sD135aoYX6CTo+UAPc2hRmAn3UMw7KdGpVduV8KzMe1VqTalR+eCcfSLYD1/IwE5
	crmlJyIVidG5Hg/bRXcxDmvGyczuj3/T2YnLfYdwx+d6FstmouoCIDC9+MpPqNCBLW5SyYDRcdb
	+t9vPllMsBGwQrvhUHWMcRmEEzxRWMNzEhtLhiHzbS2Wo83uvG44vU7kblLVI5PHihL/GrV6zR5
	H+NPjZN9RIvOE9fRRuGOvrLjfLxhPvY8z0ec5Bs0m9ixzDmbn8l6JfOVGArzWdPLqLDjj0RAY+r
	b+gA300B41VhgdxutRG3WMMucTGmU42pScSzyLOBeQajgpONpwaFUYs1lyfXr9tkLuSRfSB349/
	F9yvwiB+yVq63Wv4yC2vsUEompIASocwJOqDxOPMpcRs2BXN3jHpZVUlmhZhIN25xDDsLsj9BQy
	HokAp+lztlQfgSjLULCNdKnOQjUNTLs8Ujy+a12J73dvEgDYk8PDqEnmEruR5p
X-Received: by 2002:a17:902:c402:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2cfa6b740b7mr21724555ad.13.1784786902450;
        Wed, 22 Jul 2026 23:08:22 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f390dd2sm26071285ad.79.2026.07.22.23.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:08:22 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 0/3] watchdog: ma35d1: Add support for MA35D1 Watchdog
Date: Thu, 23 Jul 2026 14:07:51 +0800
Message-Id: <20260723060755.1596858-1-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces watchdog timer support for the Nuvoton MA35D1
SoC platform.

The MA35D1 watchdog timer hardware provides a programmable countdown timer
capable of triggering a system reset upon timeout expiration or generating
an interrupt to wake up the system from low-power states.

Key features supported in this driver:
 - Standard watchdog operations (start, stop, ping, set_timeout).
 - Boot status detection to identify watchdog reset events (WDIOF_CARDRESET).
 - Power management support including suspend/resume and wakeup functionality.

Series breakdown:
 - Patch 1: Add DT binding documentation for Nuvoton MA35D1 watchdog.
 - Patch 2: Add the watchdog driver implementation for MA35D1.
 - Patch 3: Add the watchdog node in the MA35D1 SoC DeviceTree file.

Testing:
 - Tested on the Nuvoton MA35D1 development board using standard watchdog
   test utilities (e.g., watchdog-test from tools/testing/selftests/watchdog).


Zi-Yu Chen (3):
  dt-bindings: watchdog: Add MA35D1 Watchdog binding
  watchdog: Add Nuvoton MA35D1 watchdog driver support
  arm64: dts: nuvoton: Add WDT node for MA35D1 SoC

 .../bindings/watchdog/nuvoton,ma35d1-wdt.yaml |  55 +++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |   7 +
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/ma35d1_wdt.c                 | 357 ++++++++++++++++++
 5 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml
 create mode 100644 drivers/watchdog/ma35d1_wdt.c

-- 
2.34.1

