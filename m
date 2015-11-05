Return-path: <linux@rempel-privat.de>
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@iguana.be,
	devicetree@vger.kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH v2] add Alphascale asm9260-wdt driver
Date: Thu,  5 Nov 2015 10:06:55 +0100
Message-Id: <1446714416-22587-1-git-send-email-linux@rempel-privat.de>
In-Reply-To: <20151027023132.GA1270@roeck-us.net>
References: <20151027023132.GA1270@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hallo devicetree list,
this driver had already one rewiev round on watchdog list, please
take a look a devicetree part. Maybe some of you hase
comments or suggestions.

Thank you,

v2:
- fix DT types
- remove obsolet comments
- add clk error handling
- reduce log noise
- allow to return an error in asm9260_wdt_get_dt_mode

Oleksij Rempel (1):
  watchdog: add Alphascale asm9260-wdt driver

 .../bindings/watchdog/alphascale-asm9260.txt       |  39 ++
 drivers/watchdog/Kconfig                           |   9 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/asm9260_wdt.c                     | 415 +++++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
 create mode 100644 drivers/watchdog/asm9260_wdt.c

-- 
2.5.0
