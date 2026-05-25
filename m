Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DD3E16BC
	for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697275; cv=none; b=bmhLTnvCb3mZNK3xkCojtEEbAFas3ZSeC3msQ0CcpcMxMQtRrcc0DQI8eJy97vYEHM1Xlz/P0UqPglcCavgml7UiIJRuq+oc65anqThweuSsLD8dgtmoiIq8CGSJcvbWG+Pxzjy6n9LCWueGaa1/RCrd9BMUgxmux97QutUUVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697275; c=relaxed/simple;
	bh=cnpeNyrRTMfn71Iw1My7ZiOgcb+W5DMHV+tEtk3Jprw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j9p0z2NcpVZ0UwqvKl8Z2xTH6Jz7OM3P987aGXBsTqfFGeDLI4n8NI+rubpKTBBUw28E7rYpTuLrKuiSkJfZ7+NrkDoe9WlSLbDVw8hCyR2jMr/GV0zllTBNDJ7vUrsdLRrAPVe77ZBuPFk8ogpLockEcop/5R/nEjRxNKGpanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbdoETWZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbdoETWZ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c828daf83e2so4179417a12.2
        for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779697272; x=1780302072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h73HPPR4b8cE2zhlXM66PdYigBOxMozGSruLRQEyEiQ=;
        b=MbdoETWZnVu54cAdDYI+IcH7dP3KiMFUYIRxUXnG2Ab/xV7Ss0URUFR6Odm+pBRpqf
         PekTC9McdvzdVJcyapSELOrilu+qAdhIZMQkgfX3bzBJJlSpBT6lOJBe5RnBY06WK+t2
         XcXOt6hEq2rJaZMJP1daWYE41gC3xYCUUWXRW9vF3PdL7iu5fQyrjtJypt/BqxaRC2nl
         ltjyta0KdmPnzj7zUjF65Er4+TvQHtZi3QA19E1SbY1lC9pjbtnhxyP5GQQTFBDbLZcw
         D0wII5njH1rwFNM3iByK1cDPDckSOx6/yR5JW5IADz2NYgTq+koaLTdKR4mlCbSeRsuj
         1bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697272; x=1780302072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h73HPPR4b8cE2zhlXM66PdYigBOxMozGSruLRQEyEiQ=;
        b=cHEjLk1Sx3DBqcDWZ9JykoPpD6ytgY7A1QZCF93DwslgJXQujhF2J7EqSagG+0q2aH
         oQ1C2B+zbRJIk2DkwImrcYPv9PnlACnd9UmIKWHlNgEhWj6TxfMpK83qpV6iEQycfAsA
         vH2pUnICF+mWfy7NeXvPj/d/6vxZo4k2LGrXTBJjSdySmLJk98od/v1IEnixKVHo7NJD
         l6NwgVbuRsVzH+gW6W8g7GGGe7udaOY4a8gWpM0pz5dmjlFkWzRywmadHjWJfz1bBCKi
         9d5fOXaW/c5fwDw2kIp4cf+bdoN9GpSxn91n6brxl2yCcmyivJsUSCehK/VwiB/cYwMW
         x8sA==
X-Forwarded-Encrypted: i=1; AFNElJ+KOOxKZ7jEGbwo4G2P5yvoAZRfcxamuhgFEqcVHjzdu7ELO+9NtWrfGTSii/BpsSfAanWwB05MMXzXq8AQng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1Sep3ZEjmluxfFAEYFzF1mymlZ7JDQEL8vN7iFYrHnNvbtKH
	VNmiPg6x37HsTY2vQKMxj2YLsdkRcF5vkvsMvxxVMRNXrFomFfqZBmuu
X-Gm-Gg: Acq92OHuqjK8VcFu+WUO15KanEv6orGyCHrlRci3cGZ66xNGv5M+gOfwBtPgiMIW17Y
	3dvpJ48P+15M29mJrmLMFtddHALjNQjrpTOlS6ClSa+v0EYAOSIzWi1KqB+rKDkU8T6uRgbCnCP
	LDyX2/pgbYC07bQwhA9wmzeSfhqnSJteiRtzLfuZfkry23eDhCCzJQLiD8aicfc2OprahJS06r4
	+QNFNaTBY0U36xcz3LvqPOkYT4Q2V7MQuS2WQGcvD8kdUl9uWAxsUXfFqB6tUwdTYWHUlhykIOx
	AAdqkml+zVPzvfUTcVWT0FoSit3cJvd9d1CruaxYEl4ZA/2uLHKZLcLB4MjQ9OzLigDJD4Wqv/I
	2GluYDk/yu6a5mS4r/frx/1jSo49A25H7SWBp4TUexgX0ArNFeMSV5TgFEaSPsrHlXpHQkk2ba6
	xTBejNSwTsVK5s4xWqqWkSOVzeGuU1UusUuWq8bF7lQCvDZRmJ0HcpM7VaVnTGdj7LXw==
X-Received: by 2002:a17:902:e74b:b0:2bc:7d09:dcef with SMTP id d9443c01a7336-2beb06bc155mr153249445ad.29.1779697272248;
        Mon, 25 May 2026 01:21:12 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3bb6sm88798165ad.47.2026.05.25.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:21:11 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v5 0/7] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Mon, 25 May 2026 16:20:49 +0800
Message-Id: <20260525082049.2906283-1-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 is a peripheral expander that provides GPIO, I2C,
CAN-FD, Watchdog, HWMON, PWM, and RTC sub-devices. Currently, the
driver only supports USB as the host transport interface.

This series refactors the NCT6694 MFD core to support multiple transport
backends and adds a new Host Interface (HIF) transport driver that
communicates over eSPI using Super-I/O shared memory.

Changes since version 4:
- Split the monolithic refactoring and HIF support patch into a series of
  smaller, logical commits to improve reviewability and adhere to the
  single logical change principle.
- Decoupled USB-specific data into a dedicated 'nct6694_usb_data' 
  structure.
- Abstracted device I/O operations by introducing 'read_msg' and 
  'write_msg' function pointers in the core structure.
- Renamed the existing driver to 'nct6694-usb.c' to strictly identify its
  transport boundary, alongside Kconfig/Makefile updates.
- Extracted transport-agnostic device management (IRQ domain setup, IDA
  initialization, and MFD cell registration) into a standalone
  'nct6694-core.c' module.
- Added the 'nct6694-hif' eSPI transport driver clean on top of the new
  core abstraction.

Changes since version 3:
- Remove redundant module type macro definitions from sub-device drivers
  that are now provided by the shared header <linux/mfd/nct6694.h>,
  fixing -Wmacro-redefined warnings.

Changes since version 2:
- Restore per-device IDA and mfd_add_hotplug_devices()/PLATFORM_DEVID_AUTO
  to avoid child device ID conflicts with multiple NCT6694 chips.
- Validate irq_find_mapping() return value before dispatching IRQs.
- Check superio_enter() return value in nct6694_irq_init().

Changes since version 1:
- Reworked the Super-I/O access helpers.

Ming Yu (7):
  mfd: nct6694: Move module type macros to shared header
  mfd: nct6694: Refactor USB-specific data into nct6694_usb_data
  mfd: nct6694: Introduce transport abstraction with function pointers
  mfd: nct6694: Rename static I/O functions with _usb_ prefix
  mfd: nct6694: Rename driver to nct6694-usb and update Kconfig
  mfd: nct6694: Extract core device management into a separate module
  mfd: nct6694: Add Host Interface (HIF) eSPI transport driver

 MAINTAINERS                              |   2 +-
 drivers/gpio/gpio-nct6694.c              |   7 -
 drivers/hwmon/nct6694-hwmon.c            |  21 -
 drivers/i2c/busses/i2c-nct6694.c         |   7 -
 drivers/mfd/Kconfig                      |  38 +-
 drivers/mfd/Makefile                     |   4 +-
 drivers/mfd/nct6694-core.c               | 136 ++++++
 drivers/mfd/nct6694-hif.c                | 529 +++++++++++++++++++++++
 drivers/mfd/{nct6694.c => nct6694-usb.c} | 185 +++-----
 drivers/net/can/usb/nct6694_canfd.c      |   6 -
 drivers/rtc/rtc-nct6694.c                |   7 -
 drivers/watchdog/nct6694_wdt.c           |   7 -
 include/linux/mfd/nct6694.h              |  63 ++-
 13 files changed, 821 insertions(+), 191 deletions(-)
 create mode 100644 drivers/mfd/nct6694-core.c
 create mode 100644 drivers/mfd/nct6694-hif.c
 rename drivers/mfd/{nct6694.c => nct6694-usb.c} (62%)

-- 
2.34.1

