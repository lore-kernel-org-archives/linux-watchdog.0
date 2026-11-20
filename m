Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159454;
	b=VdL97TQqYR6C5cn8lXVpcxxu1r5z0Lsq5QSo5Cc3/NzTTDcTfQFJVhqYbWpSem9mYFYQ
	 6D+IgijlZjwHN3ghOVvVR3vYuitMAKGIZ1cdcspBgiIToDGzaZ2UXW9H9HTIKEOrwdu9Z
	 OmsbIYE2o9Ovn2ozlqyldqcrZfG8xic+bDzRJIS6Fto+h13av/1zm4GG3tdoK4C1P7zj8
	 vPuSZ8eHvo/D9O6LQ3VeFj/r8ijYplvh6GyX6shu7Y9+7nYJ9TscJFDoVDMBbZdbfmeAc
	 y9n1xfeXzv3VbE/tOxW7NKtkpv6Hwg6UWFGkw2hnCXkgBYZgtUM5MXezp9YdgQF7UcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159454;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=vCkduuwTwhdRZPFHnESFbOpUc/C7mFXMs6TuK3gtbA4=;
	b=4jnSx+Y+9B/IdQ/Rzu1x30OBtNjFBuAlP7HEhWKm7dtkWPLVyHmRpqDOB4qG9sOgpnmA
	 Q/9ghTDzTo8AJG5YNUWBuL4gZyogsIRbhC/BG7yYJqUK8FrVnaoPBpTJEKi1sD7XRFG8u
	 T+fV295FNlhMK5V2X+WjRazh9nWl7rbFcsNNZLxiswSeoXI5vWQYHQckCve/UXjslaTpp
	 TgYqkSIwAxndiewoI/Filt9y+qO2AmUHPmgyfJHRVRc+kwKVOI0j0zE+FGhTjn7qS7EqR
	 KgdG03SuQifrWLQAe9QBYhI1CtxLorRrS06eF0l/jHxAS7L8YHRXZtHrH5P0Er41puQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=towOuZq7;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E4606A326;
	Fri, 20 Nov 2026 07:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=towOuZq7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E87491A173C;
	Fri, 20 Nov 2026 07:24:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7E206017D;
	Fri, 20 Nov 2026 07:24:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFD5C11BC10F1;
	Fri, 20 Nov 2026 08:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795159448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vCkduuwTwhdRZPFHnESFbOpUc/C7mFXMs6TuK3gtbA4=;
	b=towOuZq7KtmvM/Q5f4+wBK6Ap2w3YihaT2IF64czyeetprLfLrifLCIHG61hzQG9JRcF3n
	DqNqSbhRmyaA41r/KS0ivKFBnjZLwB/Mti284NMMxujNUWt28azre3dJxJ/7zy7OmBHbBz
	zH2hrbP8RROp6/n9lZAWMaOQWBkj2XEx9MlX+NCVLW8GsgJ44UUStx4QaGLRTvBFNThTO/
	FDimLuVfBvq+rTknmEpY5S0vtwm2GP8CssMqNMc9mx/l12lrUiVX+Bc5d6o2eVAG1XOyhc
	Namz9s4cMG1w4IdY2ncPhpyakgfYOtOPCx/az7KUm4jt2tm9bfd7ULqTsCo0+A==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Subject: [PATCH v10 0/5] Add support for AAEON SRG-IMX8P MCU
Date: Fri, 20 Nov 2026 08:23:52 +0100
Message-Id: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XS207DMAwG4FeZek2QnVMTrngPxEWcA4sELWpHB
 Zr27rgTUKbScWlL+Wzl97EZ81Dz2Nztjs2QpzrWvuMC4WbXxH3onrKoiRuNBGlQIoqUJ0FahJD
 7TrzEN5GGOuVBZMjOZyo6FGr49euQS30/0w+PXO/reOiHj/OkCefu/+aEAoTxVAJSiKqoe+r7w
 3PtbmP/Mg/5EuR1wVKyhqLLBeWFMO81ye9dLKBU25JkyRcdAaiQibSW1CJJuCIpliCg10pCa0N
 cS3qRlNTbkmaJ/xsQU9Gt12vJLJIGty2ZWUreUdIOrXVryS6SVbAtWZaStWRKpCQLrKV2kVpot
 6WWpRhsND5wgu0f2blfkrpyR27OLhDwjUIqMqwl/yMhSL8teZaKJ5sgRmTsUjqdTp+alBrpUwM
 AAA==
X-Change-ID: 20251211-dev-b4-aaeon-mcu-driver-e0e89ebf4afb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev, 
 linux-doc@vger.kernel.org, 
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
Changes in v10:
- dt-bindings: send the AAEON vendor prefix patch again as patch 1; v9
  omitted it, leaving the "aaeon" compatible vendor undocumented
- mfd: reject reads whose register or value size is not the 2-byte
  address and 1-byte value of a MCU command, as writes already do
- mfd: replace the opcode shift and the watchdog status argument with
  named macros, and name the register, value and command lengths
- mfd: embed the two I2C transfer buffers, aligned to ARCH_DMA_MINALIGN,
  in struct aaeon_mcu instead of allocating them separately
- mfd: move the Kconfig entry, which sat between ABX500_CORE and
  AB8500_CORE and broke the menuconfig submenu of the latter
- mfd: include linux/module.h
- dt-bindings: define timeout-sec in the binding (maxItems and
  description) instead of a bare "true"; watchdog.yaml cannot be
  referenced from an embedded-controller node
- gpio: return 0 or 1 from .get() instead of the raw MCU byte, which
  gpiolib warns about
- gpio: use the shared read opcode instead of a duplicate define, and
  build the GPIO register addresses in a helper using MAX_GPOS
- watchdog: use the shared watchdog register macros
- watchdog: document the timeout parameter in watchdog-parameters.rst
- watchdog: trim the Kconfig help and add the module name line, as the
  other MFD-child watchdog drivers do
- watchdog: document that the suspend callback stops the MCU watchdog even
  with nowayout set, and say so in the commit message
- Link to v9: https://lore.kernel.org/r/20261029-dev-b4-aaeon-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com

Changes in v9:
- mfd: hold the I2C segment lock across the MCU command write and the
  response read, so no other transfer on the same I2C segment can land
  in between; the STOP between the two is kept
- mfd: read the response through the driver's DMA-safe buffer instead of
  flagging the regmap caller's buffer as I2C_M_DMA_SAFE; reject writes
  that are not a single 3-byte command
- mfd: add .readable_reg so only the GPIO input and watchdog status
  registers can be read; any other address is a command that a read
  (e.g. through the regmap debugfs registers file) would execute
- mfd: drop "Multi-Function Device (MFD)" from the commit message and
  document the bus locking and the readable registers
- dt-bindings: document the timeout-sec property read by the watchdog
  driver and reword the watchdog description accordingly
- gpio: move GPIO_AAEON_MCU to the "MFD GPIO expanders" Kconfig menu
- watchdog: set min_timeout to the 25 second hardware heartbeat, as
  shorter timeouts cannot be honoured
- watchdog: honour CONFIG_WATCHDOG_NOWAYOUT with watchdog_set_nowayout()
- watchdog: fix the timeout comment and commit message (timeout module
  parameter, not a "watchdog_timeout" boot parameter); align the defines
  with tabs
- MAINTAINERS: keep the F: entries sorted
- Link to v8: https://lore.kernel.org/r/20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com

Changes in v8:
- mfd: add .use_single_read = true to regmap config; the MCU produces exactly
  one response byte per command and a bulk read passing val_size > 1 to the
  bus callback would be incorrect
- watchdog: call watchdog_stop_ping_on_suspend() in probe so the kthread ping
  worker is cancelled before platform devices are suspended, preventing I2C
  transfers on a suspended bus
- watchdog: check watchdog_hw_running() alongside watchdog_active() in the
  suspend/resume callbacks so watchdog is stopped before sleep and restarted
  on wake, preventing a spurious MCU reset if suspend exceeds the 25-second
  hardware timeout
- Link to v7: https://lore.kernel.org/r/20260707-dev-b4-aaeon-mcu-driver-v7-0-ca6c59abd672@bootlin.com

Changes in v7:
- mfd: fix select REGMAP Kconfig entry indented with spaces instead of a tab
- mfd: use devm_kcalloc() instead of devm_kzalloc() for the cmd buffer allocation
- mfd: add .use_single_write = true to the regmap config to prevent regcache sync
or debugfs from issuing multi-register writes that would overflow the fixed 3-byte
cmd buffer
- watchdog: remove max_timeout; it is documented as irrelevant when
max_hw_heartbeat_ms is set and is silently ignored by the watchdog core
- watchdog: pass dev->parent to watchdog_init_timeout() so that the timeout-sec
DT property is correctly read from the MCU I2C node; the MFD child platform device
has no of_node of its own
- watchdog: add suspend/resume PM hooks to stop the watchdog before entering sleep
and restart it on resume, preventing spurious resets if suspend lasts longer than
the 25-second hardware heartbeat
- Link to v6: https://lore.kernel.org/r/20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com

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

 .../bindings/mfd/aaeon,srg-imx8p-mcu.yaml          |  73 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/watchdog/watchdog-parameters.rst     |   8 +
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-aaeon-mcu.c                      | 235 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/aaeon-mcu.c                            | 227 ++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/aaeon_mcu_wdt.c                   | 174 +++++++++++++++
 include/linux/mfd/aaeon-mcu.h                      |  46 ++++
 14 files changed, 809 insertions(+)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20251211-dev-b4-aaeon-mcu-driver-e0e89ebf4afb

Best regards,
-- 
Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

