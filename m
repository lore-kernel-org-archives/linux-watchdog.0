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
Subject: [PATCH v2 0/4] watchdog: aspeed: Retain enabled state and move to arch_initcall
Date: Wed, 20 Sep 2017 15:00:16 +0930
Message-Id: <20170920053020.6860-1-andrew@aj.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

This series fixes some issues with the Aspeed watchdog, as outlined in the
v1[1] cover letter.

I've added a bit of an explanation as to why we call aspeed_wdt_start() in
probe() if the watchdog is already enabled, but the essence of it is to ensure
the watchdog is configured to the expectations of the kernel driver (rather
than however the bootloader configured it).

Please review!

Andrew

Since v1:

* Rework patch 1/4 to simply remove the writel() call to restore the original
  behaviour.
* Rework patch 4/4 to remove the Kconfig changes to retain the ability to build
  the watchdog as a module, and add the exit handler.

[1] https://lkml.org/lkml/2017/9/18/14

Andrew Jeffery (4):
  watchdog: aspeed: Retain watchdog enabled state
  watchdog: aspeed: Fix 'Apseed' typo in Kconfig
  watchdog: aspeed: Remove specific reference to AST2400 in Kconfig
  watchdog: aspeed: Move init to arch_initcall

 drivers/watchdog/Kconfig      |  4 ++--
 drivers/watchdog/aspeed_wdt.c | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.11.0
