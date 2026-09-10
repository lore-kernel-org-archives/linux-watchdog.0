Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD23B0587;
	Thu, 10 Sep 2026 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020574; cv=none; b=n4fB3ZoO6S1siOHRgzxS6aVxNXC7HLmwuMSFkRxELHP+V4vDt+Fa/S83u6ri3VTXD4aCUAYoSW7R8eoHgZMljvt0CIPXb/dvSc/Qbu9596CC2TcJa8iHGHlcDdUAYJn63xC71n4GHr3aetHQdpNWd1CVpDZ0D/hKVYFMfXBfcdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020574; c=relaxed/simple;
	bh=t8JANTFU7UxtiP+6KgcsdKxe35jESsN4YGFqLP2pFRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvveB6zdZYXxsFZXeQBIe4W9OkhCRVgUXkMXKQnGPEABJhi90D1VjrgbK6lLJK4s4Nj9BWmrWTs1+3V0ClZ3ysSKHCJRgFgHXYWl2/qbmVBhQXhb7eUSv9kPl5dJtrbkOzU0Qx+ZbEYnZGXZML2gGGm/W1q8WZBg6HrIajJeuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D22F2000FD;
	Thu, 10 Sep 2026 08:09:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6542200369;
	Thu, 10 Sep 2026 08:09:27 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B24C918000B1;
	Thu, 10 Sep 2026 14:09:24 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	lakshay.piplani@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH v3 0/4] Add driver for NXP PCF8525 RTC
Date: Thu, 10 Sep 2026 11:39:08 +0530
Message-Id: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

The PCF8525 is an NXP I2C real-time clock with integrated crystal
oscillator, dual timestamp capture inputs, backup battery switch-over,
a windowed watchdog, and an on-chip temperature sensor.

This series adds:
  - DT binding (YAML schema)
  - Core RTC driver: timekeeping, alarms, dual timestamps, crystal
    configuration, backup switch-over, and clock offset correction
  - Watchdog support via the Linux watchdog framework
  - Temperature sensor support via the hwmon framework

Changes in v3:
- patch 2: protect the Write-0-to-Clear (W0C) status flags in the
  CTRL2/CTRL3 read-modify-write cycles so concurrently asserted
  interrupt events are not silently cleared
- patch 2: replace the timestamp spinlock with a mutex and re-read
  CTRL4 under it, closing the TOCTOU race between the threaded IRQ
  handler and the sysfs timestamp store
- patch 3: configure the nINTB/CLKOUT pin (CLKOE=0) before requesting
  the watchdog IRQ to avoid a spurious interrupt storm
- patch 3: add suspend/resume PM ops to stop and re-ping the watchdog
  across system sleep
- patch 3: add WDIOF_PRETIMEOUT so the watchdog core attaches a
  pretimeout governor
- patch 3: re-mask INTA/INTB interrupts on driver unbind via devm
  cleanup actions
- patch 4: enable TEMP_RD_EN before registering the hwmon device and
  add a devm cleanup to disable it on unbind

Changes in v2:
- Fix include: use <linux/pm_wakeirq.h> instead of <pm_wakeup.h>
- Add spinlock_t ts_lock to protect ts[]/ts_valid[] from IRQ/sysfs race
- Fix W0C ordering: clear AF/TSF flags before acting on alarm/timestamp
  events
- Use dev_pm_set_wake_irq() for suspend wakeup wiring
- Clear stale WDTF before unmasking watchdog interrupt on INTB to prevent
  boot loop when battery-backed flag persists across resets
- Add watchdog_notify_pretimeout() call in INTB IRQ handler
- Set WDOG_HW_RUNNING if bootloader left watchdog running at probe time
- Register hwmon device first, then enable PCF8525_CTRL5_TEMP_RD_EN only
  after successful registration

Shiv Prakash Gupta (4):
  dt-bindings: rtc: Add NXP PCF8525 RTC
  rtc: pcf8525: Add NXP PCF8525 RTC driver
  rtc: pcf8525: Add watchdog support
  rtc: pcf8525: Add temperature sensor support via hwmon

 .../devicetree/bindings/rtc/nxp,pcf8525.yaml  |   86 +
 drivers/rtc/Kconfig                           |   26 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-pcf8525.c                     | 1600 +++++++++++++++++
 4 files changed, 1713 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
 create mode 100644 drivers/rtc/rtc-pcf8525.c

-- 
2.34.1

