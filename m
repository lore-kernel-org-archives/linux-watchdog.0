Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 4.mo6.mail-out.ovh.net ([87.98.184.159]:33112 "EHLO
	mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753933Ab3KCSQX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Nov 2013 13:16:23 -0500
Received: from mail425.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id 4E3F6FFA762
	for <linux-watchdog@vger.kernel.org>; Sun,  3 Nov 2013 18:53:36 +0100 (CET)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Guenter Roeck <groeck7@gmail.com>,
	Yang Wenyou <wenyou.yang@atmel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH 0/3] watchdog: at91sam9_wdt: various fixes and improvements
Date: Sun,  3 Nov 2013 18:52:41 +0100
Message-Id: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

This patch series fix the secs_to_ticks macro in case 0 is passed as an
argument.

It also rework the heartbeat calculation to increase the security margin of the
watchdog reset timer, and use the min_heartbeat value instead of the calculated
heartbeat value for the first watchdog reset (to avoid spurious watchdog
reset).

Best Regards,

Boris

Boris BREZILLON (3):
  watchdog: at91sam9_wdt: fix secs_to_ticks
  watchdog: at91sam9_wdt: avoid spurious watchdog reset during init
  watchdog: at91sam9_wdt: increase security margin on watchdog counter
    reset

 drivers/watchdog/at91sam9_wdt.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
1.7.9.5

