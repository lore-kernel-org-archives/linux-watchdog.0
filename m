Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36630 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbHASh4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Aug 2015 14:37:56 -0400
Received: by qgeh16 with SMTP id h16so65727522qge.3
        for <linux-watchdog@vger.kernel.org>; Sat, 01 Aug 2015 11:37:55 -0700 (PDT)
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org, manabian@gmail.com,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH v5 0/2] Add support for NXP LPC18xx Watchdog timer
Date: Sat,  1 Aug 2015 15:37:15 -0300
Message-Id: <1438454237-22043-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch series adds support for the watchdog timer found in NXP LPC
SoCs family which includes LPC18xx/LPC43xx. Other SoCs in that family may
share the same watchdog hardware.

Patchset is based on tag next-20150624 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board and
on a CIAA NXP LPC4337 Board.

Changes since v4:
* Minor coding style fixes.

Changes since v3:
* Changed default timeout to 30.
* Minor changes.

Changes since v2:
* Changed config tristate to "LPC18xx/43xx".
* Added COMPILE_TEST as a dependency.
* Replaced raw_local_irq* calls by spinlock.
* Changed dt compatible string to "nxp,lpc1850-wwdt".

Changes since v1:
* Dropped "Windowed" term in Watchdog's name.
* Changed default timeout value from 1 to 5 because it was too tight.
* Fixed module remove function, since it was keeping the timer enabled. Warning
  message was added.
* Changed dt compatible string to "nxp,lpc1850-wdt".
* Renamed clocks matching most of the other lpc18xx drivers.

Ariel D'Alessandro (2):
  watchdog: NXP LPC18xx Watchdog Timer Driver
  DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation

 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt   |  19 ++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/lpc18xx_wdt.c                     | 340 +++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
 create mode 100644 drivers/watchdog/lpc18xx_wdt.c

-- 
1.9.1

