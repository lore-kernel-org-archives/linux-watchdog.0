Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:55937 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbaKUT0k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Nov 2014 14:26:40 -0500
From: naidu.tellapati@gmail.com
To: wim@iguana.be, linux@roeck-us.net, abrestic@chromium.org,
	ezequiel.garcia@imgtec.com, james.hartley@imgtec.com,
	james.hogan@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	arul.ramasamy@imgtec.com, Jude Abraham <Jude.Abraham@imgtec.com>
Subject: [PATCH RESEND v5 0/2] watchdog: Add support for ImgTec PowerDown Controller Watchdog Timer
Date: Sat, 22 Nov 2014 00:55:55 +0530
Message-Id: <1416597957-10516-1-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Jude Abraham <Jude.Abraham@imgtec.com>

This patchset provides support for the PowerDown Controller (PDC) Watchdog Timer
found on Pistachio SOC from Imagination Technologies (ImgTec).

The series is based on 3.18-rc5.

I am re-sending the series with gmail SMTP as we had some problems with
the mail server we used in the previous rounds.

Please review and provide your comments.

Changes from v4:

 * Added warning message if initial timeout is invalid.

Changes from v3:

 * Removed PDC_WD_MAX_DELAY.

 * Removed spinlock.

 * Removed timeout check inside pdc_wdt_set_timeout function.

 * Changed identity to IMG PDC Watchdog.

 * Removed pdc_wdt_set_timeout call from the probe function.

 * Removed pdc_wdt_shutdown function call from pdc_wdt_remove function
   and added pdc_wdt_stop function call instead.

Changes from v2:

 * Removed interrupt.h header file.

 * Removed clock rate-change notifier callback.

Changes from v1:

 * Arranged all include files in alphabetical order.

 * Arranged register field masks/shifts defines next to their
   corresponding register

 * Registered clock rate-change notifier callback.

 * Removed all references to 32 kHz fixed clock rate.
   Now the clock rate is read dynamically using clk_get_rate().

 * Defined a macro PDC_WD_CONFIG_ENABLE.

 * Added code for getting system clock.

 * Moved module_param stuffs next to the corresponding variable defines.

 * Added code in the function pdc_wdt_remove for stopping watchdog.

 * Removed MODULE_ALIAS.

 * Removed few unwanted spaces and unwanted blank lines.

Jude Abraham (2):
  watchdog: ImgTec PDC Watchdog Timer Driver
  DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation

 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |   18 ++
 drivers/watchdog/Kconfig                           |   11 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/imgpdc_wdt.c                      |  301 ++++++++++++++++++++
 4 files changed, 331 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
 create mode 100644 drivers/watchdog/imgpdc_wdt.c

