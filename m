Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677109;
	b=hb5issivbj189oYJtFCkgmQvrzUBxnGnZ+8qm5Baifb3lh11VzBQnHmLameJKb+td2OY
	 5J1yDeElEIg6BPl1f3y9uUN3dCvD+WYQtjrFW1nj6UUQSDcS+U0eJ+b32GqyC4broH6JS
	 LiR5RHj0rreZW6Xa1I0zw1EafX5mwQ4GI5KtBwurvJG3n8FZkZQxvaMVxFXPlaU7yiDoF
	 OzPihL/728NxL7F/WEmFF3GkHji2/NZ2WCxFR+b2DgqX6aRKvXKSO/HKjQnKFTk8q50/f
	 va4DXXHI6Vthuquq0a7pCVppO480lOS/MNTOQzwqrLvX0Gh5aFXq0s/2ywnVLHT7pdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677109;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=veEpLpa04jFUmQZYhUWlBxOH+vahXzO8oIEUnRnJ6eg=;
	b=bDTKibi5/HxUwHWF24bRHKj4j739ondPa9flvUzFK+sp2uM2SWLuBNQJc/GZSfQc2Xi0
	 DOk0u/x9GyU4/0KKOyJRc39nh5xud4J0ljFjfsFiDa5k5z1az1h+mEOtSvNeH0xOl0lxm
	 OSfkbHswfMwC3wEAyt9IGCmT/YST96k9BSxaW96us7vLQ+0TYK/CMpWS4ijxF4K+dAh09
	 ZBnPN2v2ttrWizw92Zzn0dRLisBNXjygRqgwTZ/Vjld7VH0U29TR3GoBfjUAuHPVGTbUY
	 RIFgByM0qo32DWmeOpR38XydXEoYxRs247VMJS9E56hODpuuWC62Ws8dE8ggDxHghqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC58606A31E;
	Thu, 26 Nov 2026 07:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCA82200026;
	Thu, 26 Nov 2026 08:11:40 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97FF320001F;
	Thu, 26 Nov 2026 08:11:40 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7208D1800088;
	Thu, 26 Nov 2026 15:11:37 +0800 (+08)
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
Subject: [PATCH v5 0/4] rtc: Add NXP PCF8525 RTC support
Date: Thu, 26 Nov 2026 12:41:20 +0530
Message-Id: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
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

Changes in v5:
- Remove the reset-source property and its example entry from the
  binding; watchdog expiry is reported through INTB as an alarm-only
  watchdog.
- Remove the quartz-load-femtofarads property, as the crystal load
  capacitance is fixed and Control_5 bit 1 is reserved. Allow a single
  named inta or intb interrupt, or both in the order inta, intb, and
  use level-low interrupts in the example.
- Reject wakeup-source in the binding when only the intb interrupt is
  described, as the wakeup line is INTA.
- Program and read back the month and year alarm fields using the
  Rev. 3.0 alarm enable bit positions, and keep the alarm interrupt
  disabled while the alarm is rewritten.
- Use one helper for the CTRL2 write-0-to-clear flags.
- Mask the unused INTA sources and drain stale TSF/AF/MSF flags before
  unmasking INTA, failing probe if the drain fails. The runtime
  handler uses the same bounded drain and no longer claims an event
  whose acknowledge failed.
- Propagate I2C errors from the Timestamp1 read; only an invalid or
  empty timestamp is acknowledged so INTA cannot stay stuck low.
- Refresh the OTP after setting the time clears the oscillator-stop
  flag, even if clearing STOP fails.
- When interrupt-names is present, do not take INTA from the first
  interrupt if only INTB is named.
- Use RTC_FEATURE_ALARM_WAKEUP_ONLY when only wakeup is wired, and do
  not repeat the wakeup setup the I2C core already did.
- Set up wakeup before registering the RTC so that wakealarm is exposed
  without a wakeup-source property.
- Apply the start-year offset to the sysfs timestamps, make timestamp1
  read-only, and clear just TSF on a timestamp0 write instead of
  issuing the CTS command.
- Rate-limit the VLF and interrupt warnings, and use devm_mutex_init(),
  guard(mutex) and the regmap bit helpers.
- Register the watchdog only when the INTB interrupt is described,
  advertise WDIOF_ALARMONLY and clear WDTF in the handler.
- Mask all INTB sources before touching watchdog state, start from a
  stopped counter with the 1/4 Hz source, clear a stale WDTF and
  switch the nINTB pin last; on start, load the counter before
  enabling WD_CD and unmasking INTB, undoing it on error.
- Keep the watchdog counter and WD_CD across suspend and only mask the
  INTB route, re-arming on resume. On teardown leave the INTB route
  intact if the watchdog is still running (nowayout).
- Clear TEMP_RD_EN to enable the digital temperature readout, and drop
  the cleanup action since the bit only gates the readout register.
- Select the closest supported update_interval instead of failing with
  -EINVAL.

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

 .../devicetree/bindings/rtc/nxp,pcf8525.yaml  |   88 ++
 MAINTAINERS                                   |    8 +
 drivers/rtc/Kconfig                           |   24 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-pcf8525.c                     | 1404 +++++++++++++++++
 5 files changed, 1525 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
 create mode 100644 drivers/rtc/rtc-pcf8525.c

-- 
2.34.1

