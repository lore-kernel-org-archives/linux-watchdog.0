Return-path: <ariel@vanguardiasur.com.ar>
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be,
	linux@roeck-us.net,
	ezequiel@vanguardiasur.com.ar,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH 0/2] Add support for NXP LPC18xx Watchdog timer
Date: Fri, 26 Jun 2015 15:24:30 -0300
Message-Id: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

This patch series adds support for the watchdog timer found in NXP LPC
SoCs family which includes LPC18xx/LPC43xx. Other SoCs in that family may
share the same watchdog hardware.

Patchset is based on tag next-20150624 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board and
on a CIAA NXP LPC4337 Board.

Ariel D'Alessandro (2):
  watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
  DT: watchdog: Add NXP LPC18XX Watchdog Timer binding documentation

 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt   |  19 ++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/lpc18xx_wdt.c                     | 340 +++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
 create mode 100644 drivers/watchdog/lpc18xx_wdt.c

-- 
1.9.1
