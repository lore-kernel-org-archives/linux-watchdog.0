Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24195 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458AbaISGcl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 02:32:41 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <wim@iguana.be>, <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/2] watchdog: dw_wdt: one bug fix and restart handler support
Date: Fri, 19 Sep 2014 14:29:57 +0800
Message-ID: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

These patches are intend to improve dw_wdt in the following two aspects:

Firstly, the TOP_INIT may be zero at reset on some HW, so the timeout period
may be very short, thus we will see immediate system reset after openning 
the watchdog. Fix this problem by restarting the counter immediately after
WDT enabling.

Secondly, the WDT can also be used to reboot the system with the help of
recently introduced restart handler.

Tested on Marvell BG2Q DMP board.

Jisheng Zhang (2):
  watchdog: dw_wdt: restart the counter immediately after enabling WDT
  watchdog: dw_wdt: add restart handler support

 drivers/watchdog/dw_wdt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.1.0

