Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52120 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757080Ab2BBRwK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Feb 2012 12:52:10 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Roland Stigge <stigge@antcom.de>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/4] pnx4008: convert to watchdog framework
Date: Thu,  2 Feb 2012 18:48:07 +0100
Message-Id: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Thanks to Roland's work of making lpc32xx boot again, I could finally brush up
those patches and test them on the latest version of the watchdog framework.

Patch 3/4 is of special interest, because it extends the core to allow to set
timeouts without having a dedicated callback. Since the core automatically sets
'timeout' in the watchdog device (and does limit checking, too), there is
nothing else left to do for this device since it uses that value every time in
start/ping.

Please review and consider for inclusion. Roland, if you'd like to test them,
too, please do and donate "Tested-by" tags. Thanks!

Regards,

   Wolfram

Wolfram Sang (4):
  watchdog: pnx4008: cleanup resource handling using managed devices
  watchdog: pnx4008: don't use __raw_-accessors
  watchdog: dev: don't enforce set_timeout()
  watchdog: pnx4008: convert driver to use the watchdog framework

 .../watchdog/convert_drivers_to_kernel_api.txt     |   10 +-
 Documentation/watchdog/watchdog-kernel-api.txt     |    4 +-
 drivers/watchdog/Kconfig                           |    1 +
 drivers/watchdog/pnx4008_wdt.c                     |  264 +++++---------------
 drivers/watchdog/watchdog_dev.c                    |   11 +-
 5 files changed, 79 insertions(+), 211 deletions(-)

-- 
1.7.8.3

