Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
To: linux-watchdog@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>,
	wim@iguana.be,
	linux@roeck-us.net,
	joel@jms.id.au,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-aspeed@lists.ozlabs.org,
	ryan_chen@aspeedtech.com
Subject: [PATCH 0/4] watchdog: aspeed: Retain enabled state and move to
Date: Mon, 18 Sep 2017 15:19:01 +0930
Message-Id: <20170918054905.16470-1-andrew@aj.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

We had reports of Aspeed BMC systems entering a reboot loop, each time
attempting and failing to probe some PMBus devices. For whatever reason the
PMBus devices weren't appearing on the I2C bus, and several factors came into
play:

1. i2c-aspeed's transfer timeout is set to 5 seconds
2. The kernel's pmbus core now tests for the presence of the status
   word, then the status byte. Not all devices support the status word,
   therefore on error we fall back to probing the status byte. This leads to
   back-to-back uninterruptible transfers, totalling 10 seconds of delay if the
   device is not present before propagating a probe error back up the call
   chain
3. The BMC watchdogs are enabled by u-boot to catch a kernel hang
4. The hardware's default watchdog counter value equates to a 22 second period
5. The watchdog driver is probed after the I2C subsystem iterates all the
   described devices.

Thus as it stands nearly 50% of the watchdog period can be spent dealing with
one missing PMBus device. Arguably the I2C timeout value is too large, but as
the watchdog driver is not probed until after the I2C busses are iterated, the
work to ping the watchdog cannot even be scheduled to take place between
transfers.

Patch 4 shifts aspeed_wdt to arch_initcall so the watchdog can be pinged as
needed. Patch 1 fixes an oversight that lead to the watchdogs being disabled
until userspace opened the chardev. The remaining two patches are minor fixes
to the Kconfig.

Please review!

Cheers,

Andrew

Andrew Jeffery (4):
  watchdog: aspeed: Retain watchdog enabled state
  watchdog: aspeed: Fix 'Apseed' typo in Kconfig
  watchdog: aspeed: Remove specific reference to AST2400 in Kconfig
  watchdog: aspeed: Move init to arch_initcall

 drivers/watchdog/Kconfig      |  8 +++-----
 drivers/watchdog/aspeed_wdt.c | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.11.0
