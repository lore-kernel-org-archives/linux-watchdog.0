Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780440E8D6;
	Tue, 30 Jun 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823892; cv=none; b=fXU4wMqnK1OlZcp5+GJO5KDhgAX6wfpWr8xA6umKy2oSCCLCjd374opWVQrrkvg8MfpfBFUVUGOp2suTQC8lrmFeSy1JjrDlwXUtZfxN2HJ62eaoMPvlfWjfDg1KIBkoW1AvuUJooXMXbkSAUsuraL0/OFYdQiwSN/MzeOGU5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823892; c=relaxed/simple;
	bh=Ew94CTnIuyG041Zskrgoh5pOpYPUy+JIIzndTHF8o4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jKnMHwqaAJ0zq+EhcXygoDZKcj4YIO89/yierrGKyiCozK4Fa7IF9NgEPBnbhAqYgoISyn7jf+Ibct4PvLV89eGFQjmsgSPhr208MRzF6/1TOg80Li/cqDA7AY/WYnrS043qtVhLZBCvhSqTuRjTmA7jkMIcW2WQVf2AuYBg5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ol53ycHT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ol53ycHT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D02AF1A0D5A;
	Tue, 30 Jun 2026 12:51:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A0D7B6025A;
	Tue, 30 Jun 2026 12:51:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55F4E106F1E97;
	Tue, 30 Jun 2026 14:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782823887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Y4vxuq1hsWIzJHmUQ5gpCbPTMUFi5om9JE3+vStt6zc=;
	b=Ol53ycHTwafFTsJ0jZuZC4mvH6xvLp5KPZGNOSnvgIW3KU74ZEuhiYbzABdmSfR1Gd0OU5
	mopW01mzA1bKH57thL2n0SKrd3Mh8FxotIuM2vtkYfdvI7lw0pBF1Ung05CtgtqwB1Ej2h
	Gj/noj0x7EHg4saiIHS5xTsw/LNctdT3wxa0QP1QNYaZPCYLASbgY2PWFXONbYvbxLXZUz
	Z4sTqnun5JJ53gh/J7fLsvoQDM8U8kQkfk+QuJonrBT4x/Xs0IxAsonSXE4NP2UhzvPDWU
	srCoI5+/0TIw3+9zxp+pn5lbg/WsjB8/eAhb5l1J3r9DURbEvbchGvXHtGn+xw==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Subject: [PATCH v6 0/5] Add support for AAEON SRG-IMX8P MCU
Date: Tue, 30 Jun 2026 14:51:10 +0200
Message-Id: <20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQ3UoDMRAF4FcpuTaSyV+zXvke4kUmmdiA3Ui2B
 qXsu5stSinL1sszMN8Z5swmqpkm9rQ7s0otT7mMPdiHHQsHP74Rz7FnJoU0IAF4pMZRc++pjPw
 YPnmsuVHlJMgNhEn7hKxvf1RK+esiv7z2fMjTqdTvS1GDZfq/2YALbgZMHtAHldQzlnJ6z+NjK
 Mel5FeQ9wWL0RoMjhLIG2G5q8m/W6wAqbYl2aUh6SAEJjQB15K6SlLckVSXhIdBKyn21oe1pK+
 Sknpb0l3q/xYAMen9oNeSuUpauG3JLFIcHEbtwFp3K83z/AO2BVRzKgIAAA==
X-Change-ID: 20251211-dev-b4-aaeon-mcu-driver-e0e89ebf4afb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This patch series introduces support for the AAEON SRG-IMX8P embedded
controller (MCU). The MCU is connected via I2C and provides GPIO and
watchdog functionality for the SRG-IMX8P board.

The series includes:
- Device tree binding for the MFD driver
- MFD driver that serves as the core driver for the MCU
- GPIO driver implementing the GPIO functionality
- Watchdog driver for system monitoring
- MAINTAINERS entry for the new drivers

The drivers follow the standard Linux kernel subsystem patterns, with
the MFD driver registering the sub-devices (GPIO and watchdog) which
are then handled by their respective subsystem drivers.

Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
---
Changes in v6:
- mfd: rename local variable to ddata in probe
- mfd: fix driver name from "aaeon_mcu" to "aaeon-mcu"
- mfd: set I2C_M_DMA_SAFE on all i2c_msg flags so the host driver
  skips bounce-buffering the heap-allocated DMA-safe buffers
- mfd: drop COMPILE_TEST
- gpio: replace __set/__clear/__assign_bit with atomic set_bit/
  clear_bit/assign_bit to fix potential races on shared bitmaps
- gpio: write output value before switching pin to output mode to
  avoid a potential glitch on direction_output
- gpio: add MODULE_ALIAS("platform:aaeon-mcu-gpio")
- watchdog: add WDIOF_SETTIMEOUT and watchdog_init_timeout() so the
  software timeout is configurable via ioctl, DT timeout-sec or
  the watchdog_timeout boot parameter
- watchdog: add watchdog_stop_on_reboot() to prevent a spurious
  reset from the external MCU during system shutdown
- watchdog: add MODULE_ALIAS("platform:aaeon-mcu-wdt")
- Link to v5: https://lore.kernel.org/r/20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com

Changes in v5:
- mfd: use heap-allocated DMA-safe buffers for I2C transfers, replacing
  stack-allocated buffers in the regmap bus callbacks
- mfd: switch from REGCACHE_NONE to REGCACHE_MAPLE; add volatile_reg
  callback marking GPIO input read registers (opcode 0x72) as volatile;
  add max_register
- mfd: use PLATFORM_DEVID_AUTO instead of PLATFORM_DEVID_NONE
- mfd: use MFD_CELL_BASIC() macro for cell definitions
- mfd: use dev_err_probe() for regmap initialization error
- Link to v4: https://lore.kernel.org/r/20260324-dev-b4-aaeon-mcu-driver-v4-0-afb011df4794@bootlin.com

Changes in v4:
- mfd: switch to a custom regmap bus; remove aaeon_mcu_i2c_xfer() and the aaeon_mcu_dev struct
- mfd: locking delegated to regmap's built-in mutex; drop explicit mutex
- mfd: remove firmware version reading at probe time
- gpio, watchdog: use regmap_read()/regmap_write() via dev_get_regmap()
- include: replace aaeon_mcu_i2c_xfer() declaration with AAEON_MCU_REG() macro
- dt-bindings: remove unused label from example node
- Link to v3: https://lore.kernel.org/r/20260203-dev-b4-aaeon-mcu-driver-v3-0-0a19432076ac@bootlin.com

Changes in v3:
- Renamed SRG-IMX8PL to SRG-IMX8P
- dt-bindings: add gpio-controller properties as required
- mfd: move struct aaeon_mcu_dev from header to .c file (private)
- mfd: use guard(mutex) and devm_mutex_init() for cleanup
- mfd: firmware version log changed to dev_dbg()
- mfd: add select MFD_CORE to Kconfig
- Kconfig: add || COMPILE_TEST to all three drivers
- watchdog: add comments explaining hardware timeout and WDOG_HW_RUNNING
- watchdog: remove unused platform_set_drvdata()
- watchdog: add a function to query the status
- Link to v2: https://lore.kernel.org/r/20260123-dev-b4-aaeon-mcu-driver-v2-0-9f4c00bfb5cb@bootlin.com

Changes in v2:
- Fold GPIO and watchdog bindings into MFD binding
- Drop OF_GPIO dependency in GPIO Kconfig
- Use __set_bit/__clear_bit/__assign_bit instead of atomic variants
- Various driver cleanups and improvements
- Link to v1: https://lore.kernel.org/r/20251212-dev-b4-aaeon-mcu-driver-v1-0-6bd65bc8ef12@bootlin.com

---
Thomas Perrot (Schneider Electric) (5):
      dt-bindings: vendor-prefixes: Add AAEON vendor prefix
      dt-bindings: mfd: Add AAEON embedded controller
      mfd: aaeon: Add SRG-IMX8P MCU driver
      gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
      watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU

 .../bindings/mfd/aaeon,srg-imx8p-mcu.yaml          |  67 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-aaeon-mcu.c                      | 230 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/aaeon-mcu.c                            | 205 ++++++++++++++++++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/aaeon_mcu_wdt.c                   | 144 +++++++++++++
 include/linux/mfd/aaeon-mcu.h                      |  40 ++++
 13 files changed, 731 insertions(+)
---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20251211-dev-b4-aaeon-mcu-driver-e0e89ebf4afb

Best regards,
-- 
Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

