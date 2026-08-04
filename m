Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C98428464
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827112; cv=none; b=V0B7rUodLQhgly2qLiMwN1obtjyMW5lcRyPHzOTDsX2VCDtm/6h1V6jE/Mh0/rpEM5DEg4/WQMAfJC8Yhfd6Tgvl1BW/j1VyKHsBt1KDo004IWAXaTNViG2ZpG7ne6ZLW+Y3b839XbobTTcJoEid+9/6H1NVV/lqLxRRnzeJqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827112; c=relaxed/simple;
	bh=UQLoxgFdRGmfeGkdyRiO8Pw1s81tlUUoDSru2L5czZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgpbd4TtA94XQwG5wWfwSGmmJX+juBe3CPdJ+PRqPEERqZRkmt/vPGb8h7vToIDez7R7zNBfvfvac9k/3+R/24vDetSW1uj3NsmuFyuVM7E2n2CSB6k9XExm0cgdk7OEsxew7M4pz/gi+uNATZOnNrj+BlPOtRP6fs5tr+imH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ18ZAlS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ18ZAlS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3978446a91.1
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Aug 2026 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827110; x=1786431910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7r8iZsa4EFD7LRQXVCVW9FMeh53EBj3eyxUC5DEXkhg=;
        b=KZ18ZAlSzPdp5MwhRIquI3S3e+q+1Io4HmZR3tSpvjDL0RWfyldfaFSJr1Dl/g0/+P
         xd8sxDkBtcgC8GQaBU/XB+b/MIx0isIC+roZUm0HIwu+5NIFztuGZ8pziOMch5Y+nxpp
         FymuaTn9lafexIVv85/kEIVVlHzj5hQzybjUO01ulSTPLU9FdmgMdy59Ve7L/IIyvynM
         YzC+9xKgj7E9vjnvmbVmOR3NyeJeBEZt6LU5fjyV+K2d0C03a19hbk8aOaequzAIQATB
         ORQxkQp0HDyhRmBwDaGiO1Vyna2gnxOCNSNe3DU1slL7AqpZOT8JazLtQExJ2nRD4uB9
         agjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827110; x=1786431910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7r8iZsa4EFD7LRQXVCVW9FMeh53EBj3eyxUC5DEXkhg=;
        b=JdYVOVKsCEbcrmqnYJ5w/8yu7iiGUUcewWM0q69oRC0Av+gNCjgWKSfhOMVxM5HRk2
         bQJtsy/PhopQMwkXdI+f2e+aVTASlL9bdH9OkxSG8HaTHyFP+2bawhzsxwmiX3n3LPYp
         0HAkUYWxdhVkJDvPFbd4ZvLCSAa9w3yhuyZL6cFjKpMm87HzZeG5AVWNZaijuXLugDKg
         N78bFDqXztAMsO76FFtrEJS8ibKfX8U/4gQwOsPK8cQEuxDR8nWcaEcJA5erFiFSVgb/
         /bIfJVgfgC/eGhIrt+ua+ugwmo+d7YFM4tJorldv0X7SR/1PbimLhrPu6zYre5IJ87Vr
         2a8A==
X-Forwarded-Encrypted: i=1; AHgh+Rr48XIT1aFe/0er6zBhe1rEFpBSVmpN7uyPTnAOS8BNWt3zsvKxbgWgOipW82lmj0iEHNyZoow6x5+2iXr3yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybm5txvIE1iYwiiOU8/WXz7/UqK88MjlgV6XuE3IsKthyWTRew
	OtpyglGQ5zzJS5pSAmYqCKUq2FyV3b0GEAAsvlx8X0aFZacAGIhHID4h
X-Gm-Gg: AR+sD11HIvi+tWrQJBppN+F61Lp1b3wtkytWNPerFJB2MixyTxdA0mLDhWcs/HaMCPU
	68Y9w6D7mUDPXnMSWHIDHiqHOFD37Osp/20RqeNnLCz8G4LP9xh7cnQJ+D0ydFZjoxnc2h9mhRg
	QX+cIDOd4CY26zyOX8v9BCbCYhF+U4fCCF2CJ7BU7p0VBFEfWbXCo64oRUgYN3XlsUrRyebEcmI
	3Qpfx3yWre6rAAjp3ZO9Jb7fF8uIU01uiGaCorBZ6UkKiJp1umrRlxm/VzwVbWPegriM4uGC4Rk
	Jc2cqmfUcr6m/lcDp231DdbDgAL7SRAljErlDR0y1f0prLCrysm0T/wEG5jorbA2V/D2tjNl860
	ktmHs42qWOfJ6FIv5yeOYEMH600vIDCQ4889h/iqSTQbOouH3fSzghVjWgn0q0R/VEObxbmJbd9
	iAudqJebC4gfFNsJ/WHC2PF5MUT8wI7bujir17CH0v3G55dRY5dVtmwE0xVNK5nql/4RXcdhIaT
	07dJFjaTtoc6OmT4qdw/n7w+ItnxNDpSwGFYrBSZS5QgdI=
X-Received: by 2002:a17:90b:57e6:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-38fbc3e596cmr12071256a91.5.1785827109823;
        Tue, 04 Aug 2026 00:05:09 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfd8ff8sm859815a91.4.2026.08.04.00.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:05:09 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v3 0/3] watchdog: ma35d1: Add support for MA35D1 Watchdog
Date: Tue,  4 Aug 2026 15:03:48 +0800
Message-Id: <20260804070351.1846165-1-zychennvt@gmail.com>
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

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
Changes in v3:
 - Added check for watchdog_hw_running in suspend/resume.
 - Add set_timeout in probe before devm_watchdog_register_device.
 - fix spelling mistake in Kconfig help text.
 - Drop redundant "binding" wording from patch 1 subject.

Changes in v2:
 - Added `watchdog_stop_on_reboot()` and `watchdog_stop_on_unregister()`.
Addressed automated review feedback (Sashiko AI) and reviewer comments:
 - Remove redundant 'struct device *dev' from driver private structure.
 - Add ma35d1_wdt_wait_sync() after writing WDTEN to REG_WDT_CTL in
   ma35d1_wdt_start().
 - Preserve wdt_dev->timeout when requested timeout exceeds hardware maximum.
 - Replace dev_pm_set_wake_irq with devm_pm_set_wake_irq.
 - Set WDOG_HW_RUNNING if watchdog was already enabled by bootloader.
 - Fix IRQ variable type from u32 to int.
 - Removed unnecessary `select MFD_SYSCON` from Kconfig.

 Note: RMW operations on REG_WDT_CTL have no runtime side-effects on W1C
       flags as IF/WKF are only utilized during PM suspend/resume window.

Zi-Yu Chen (3):
  dt-bindings: watchdog: Add MA35D1 Watchdog
  watchdog: Add Nuvoton MA35D1 watchdog driver support
  arm64: dts: nuvoton: Add WDT node for MA35D1 SoC

 .../bindings/watchdog/nuvoton,ma35d1-wdt.yaml |  55 +++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |   7 +
 drivers/watchdog/Kconfig                      |  10 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/ma35d1_wdt.c                 | 363 ++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml
 create mode 100644 drivers/watchdog/ma35d1_wdt.c

-- 
2.34.1

