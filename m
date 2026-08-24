Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14C25B099;
	Mon, 24 Aug 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554529; cv=none; b=hdsoySqLiW+sw2F2S2V597hJWUiWBRxucotvJcrOqYi+Ltn5UQrDmXSsBO+bzrn1oY+NlGFyyZdVv+Wpme1EZO1arjYj/x/ui1qRrIN9Ms7oSXEsA/s6Jtd2ek3AeS/0/fZNXzgfzO/Kdxsp3to6Ue2Yhp+cTQyCK12i8iULZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554529; c=relaxed/simple;
	bh=CrSd4vQsDBsfapTgoZ+7Rx7OBf13qzd0b6oDvme5D0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5fMBVGPViFu/GzY1Q8sR4rJXJNuJEAZ6u8/tTw3NBw+KvKSWFicimJsusTwClxM+9kXzbqg/0wyme5SP4PJEw8AgyZDh9ffWwGXeprWFFyWtcsubxNkGS5zX4Ei0O+rHQ5YEiG0qxskZgWl9ZAGUoUi9bqyLWnnc+VXg+OkP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FFA11A0071;
	Mon, 24 Aug 2026 08:55:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 59C7F1A0053;
	Mon, 24 Aug 2026 08:55:21 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2804C18000B6;
	Mon, 24 Aug 2026 14:55:18 +0800 (+08)
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
Subject: [PATCH v2 0/4] Add driver for NXP PCF8525 RTC
Date: Mon, 24 Aug 2026 12:25:08 +0530
Message-Id: <20260824065512.693377-1-shivprakash.gupta@nxp.com>
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
 drivers/rtc/rtc-pcf8525.c                     | 1422 +++++++++++++++++
 4 files changed, 1535 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
 create mode 100644 drivers/rtc/rtc-pcf8525.c

-- 
2.34.1
