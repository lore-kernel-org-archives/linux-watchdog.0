Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:58140 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750917AbbGWFtU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 01:49:20 -0400
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH v2 0/2] Add Mediatek watchdog suspend resume and shutdown 
Date: Thu, 23 Jul 2015 13:49:09 +0800
Message-ID: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series add Mediatek watchdog suspend, resume and shutdown support.
These patches are based on v4.2-rc1

Change in v2:
Use watchdog_active() to check whether watchdog been active.
Change to register suspend,resume function to dev_pm_ops

Greta Zhang (2):
  watchdog: add wdt suspend/resume support
  watchdog: add wdt shutdown callback to disable wdt if enabled

 drivers/watchdog/mtk_wdt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
1.8.1.1.dirty

