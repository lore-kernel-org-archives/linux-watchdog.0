Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358144;
	b=ptRyjlpsWy2u4pcc8hneAFNSPaJjpOLv2ovIWhn2jGa2pP9k1tDAdvIc1aH19PQlGSC4
	 8f1/DHhJRtr/F2KVyiGZpgOFy85m8bRz6A9/RrnO3suhAsVYtPOt+AbIgb1IqqjgvwSYl
	 LvSMQ3hzsXFiXdgejt0r5tJYsAT9zZhxdLGZyoRKMSIgauB5f5+SnhZ6LwcZYubJzDkyq
	 ZlDXegngkXLohtcIERRSV9hM0lRzdUF91TOexnGI8CV3MvN/OfGrT2ginHXXeEHMZAYKq
	 sM0mSRlyoTCq5mcT05/Tp8U2x2Tq2cqi6G87SBJ+GCb5xspCulqcNU82+MfE9vRWHEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358144;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=dYsK9RCF4zGwTiyceQPJXihEmsN5wew5qV5M7Glsq3A=;
	b=mjiJTb7KLM//UyRRkWOGzcCjptqL4CzDjtC4kBWCfqXwXfMpB9XvSDZTA1xgubvIkdw8
	 5aMS5SjdXeIvfcuOVNRZm8Hq0DwYyDt2yJxZ49rwV33hGzqvLTRPuN++ZX0ruPLZqrXOi
	 nvrP0+NvCz9jT4i3OvWu2jg9ykMEfh6elwMrRDkIEPIOaS6/f35GQ+iESj+eC6Xkq4xoh
	 yqZkN1sk+kFP17DgHiN7dEjioXjschN5e9n2HEHWt/T+mnGofba2MnVQ2eLPKmBOIgoSX
	 dlJH1kqwxtvjIC2Xxx0RPgvaKu1cd7OzFmODaBETkRZl67Lm7zlaThpvojG3MzWTuhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7E606A31D;
	Fri, 30 Oct 2026 11:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C7DFD1A0005;
	Fri, 30 Oct 2026 12:02:15 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 922041A0002;
	Fri, 30 Oct 2026 12:02:15 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 987841800226;
	Fri, 30 Oct 2026 19:02:14 +0800 (+08)
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
Subject: [PATCH v4 0/4] rtc: Add NXP PCF8525 RTC driver with watchdog and hwmon
Date: Fri, 30 Oct 2026 16:31:35 +0530
Message-Id: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-Virus-Scanned: ClamAV using ClamSMTP

The PCF8525 is an NXP I2C real-time clock using an external
32.768-kHz crystal. It provides alarms, external timestamp capture,
recording of the last calendar write, backup battery switch-over,
a hardware watchdog timer, and an on-chip temperature sensor.

This series introduces DT bindings, the core RTC driver, watchdog
support, and optional hardware-monitoring (temperature readout) via
the hwmon subsystem.

Changes in v4:
- Rework timestamp handling to serialize sysfs clear and IRQ
  processing, read Timestamp1 before clearing TSF, and restore TSM
  after the CTS command.
- Correct Timestamp2 handling to report the last calendar write
  instead of treating it as a second external timestamp capture.
- Rework the INTA threaded IRQ handler to drain pending AF/MSF/TSF
  events and re-read status registers, avoiding missed events on an
  edge-triggered IRQ.
- Preserve all CTRL2 Write-0-to-Clear status flags, including WDTF,
  across register read-modify-write operations.
- Rework watchdog support to use nINTB as the watchdog output without
  a Linux watchdog IRQ or pretimeout notification; remove unsupported
  pretimeout handling and write-only watchdog-value read.
- Establish a known watchdog state at probe, clear stale WDTF before
  enabling the watchdog output, and report the hardware-achieved
  timeout.
- Fix RTC feature and time-setting handling, including
  update-interrupt capability reporting and writing the
  hundredths-of-a-second register when setting the calendar.
- Improve interrupt/wakeup and device-managed cleanup ordering so
  hardware interrupt sources are safely masked on probe failure and
  driver removal.
- Rework hwmon registration and power-management handling so the
  temperature readout is enabled before exposure to userspace and
  cleanly disabled on failure, suspend, and removal.

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
 MAINTAINERS                                   |    7 +
 drivers/rtc/Kconfig                           |   25 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-pcf8525.c                     | 1608 +++++++++++++++++
 5 files changed, 1727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
 create mode 100644 drivers/rtc/rtc-pcf8525.c

-- 
2.34.1
