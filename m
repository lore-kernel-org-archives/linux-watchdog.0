Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:50439 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754399AbbGVD1E (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jul 2015 23:27:04 -0400
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH 0/2] Add Mediatek watchdog suspend resume and shutdown 
Date: Wed, 22 Jul 2015 11:26:48 +0800
Message-ID: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series add Mediatek watchdog suspend, resume and shutdown support.
These patches are based on v4.2-rc1

Greta Zhang (2):
  watchdog: add wdt suspend/resume support
  watchdog: add wdt shutdown callback to disable wdt if enabled

 drivers/watchdog/mtk_wdt.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
1.8.1.1.dirty

