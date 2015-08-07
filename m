Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57586 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbHGKIC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 06:08:02 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel@pengutronix.de, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v1 0/5] watchdog: mpc8xxx: several cleanups
Date: Fri,  7 Aug 2015 12:07:42 +0200
Message-Id: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

while working with an MPC5125 processor and Guenter's latest watchdog series
I cleaned up the mpc8xxx a bit. Here is the result.

Best regards
Uwe

Uwe Kleine-König (5):
  watchdog: mpc8xxx: remove dead code
  watchdog: mpc8xxx: simplify registration
  watchdog: mpc8xxx: make use of of_device_get_match_data
  watchdog: mpc8xxx: use dynamic memory for device specific data
  watchdog: mpc8xxx: allow to compile for MPC512x

 drivers/watchdog/Kconfig       |   2 +-
 drivers/watchdog/mpc8xxx_wdt.c | 150 +++++++++++++++++------------------------
 2 files changed, 61 insertions(+), 91 deletions(-)

-- 
2.4.6

