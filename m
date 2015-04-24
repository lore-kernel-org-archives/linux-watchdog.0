Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39261 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934213AbbDXJtE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 05:49:04 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 0/3] watchdog: omap: several cleanups
Date: Fri, 24 Apr 2015 11:48:30 +0200
Message-Id: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

this is the current state of my cleanups for the omap watchdog driver.
As overtaking a running watchdog isn't that trivial as expected I'm
sending this out that it doesn't bitrot.

Best regards
Uwe Kleine-König

Uwe Kleine-König (3):
  watchdog: omap: use watchdog_init_timeout
  watchdog: omap: put struct watchdog_device into driver data
  watchdog: omap: simplify assignment of bootstatus

 .../devicetree/bindings/watchdog/omap-wdt.txt      |  9 +--
 drivers/watchdog/omap_wdt.c                        | 66 +++++++++-------------
 2 files changed, 32 insertions(+), 43 deletions(-)

-- 
2.1.4

