Return-path: <eddie.huang@mediatek.com>
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-watchdog@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Sascha
 Hauer <kernel@pengutronix.de>
Subject: [PATCH v3 0/2] Add Mediatek watchdog suspend resume and shutdown 
Date: Fri, 24 Jul 2015 15:28:44 +0800
Message-ID: <1437722926-54509-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

This series add Mediatek watchdog suspend, resume and shutdown support.
These patches are based on v4.2-rc1

Change in v3:
Add mtk_wdt in subject line

Change in v2:
Use watchdog_active() to check whether watchdog been active.
Change to register suspend,resume function to dev_pm_ops
