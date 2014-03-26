Return-Path: <Li.Xiubo@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <w.sang@pengutronix.de>,
	<linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 0/2] Add big endian support
Date: Wed, 26 Mar 2014 10:21:38 +0800
Message-ID: <1395800500-22655-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Li.Xiubo@freescale.com
List-ID: <linux-watchdog@vger.kernel.org>

This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
in BE mode.

And this has been test on Vybird.

Changes in V2:
- Add the detail information in the commit comment.
- 'big-endians' --> 'big-endian'.


Xiubo Li (2):
  watchdog: imx2_wdt: Sort the header files alphabetically
  watchdog: imx2_wdt: Add big-endian support

 drivers/watchdog/imx2_wdt.c | 52 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 15 deletions(-)

-- 
1.8.4
