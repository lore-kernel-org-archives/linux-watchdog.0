Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:32914 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbbG0FFa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 01:05:30 -0400
Received: by qged69 with SMTP id d69so44665351qge.0
        for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2015 22:05:29 -0700 (PDT)
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org, manabian@gmail.com,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH v4 0/2] Add support for NXP LPC18xx Watchdog timer
Date: Mon, 27 Jul 2015 02:04:51 -0300
Message-Id: <1437973493-26872-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch series adds support for the watchdog timer found in NXP LPC
SoCs family which includes LPC18xx/LPC43xx. Other SoCs in that family may
share the same watchdog hardware.

Patchset is based on tag next-20150624 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board and
on a CIAA NXP LPC4337 Board.

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
 drivers/watchdog/lpc18xx_wdt.c                     | 342 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
 create mode 100644 drivers/watchdog/lpc18xx_wdt.c

-- 
1.9.1

