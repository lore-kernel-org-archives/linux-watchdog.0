Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42687 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeFDPBO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Jun 2018 11:01:14 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/2] watchdog: da9063: small improvements
Date: Mon,  4 Jun 2018 17:00:57 +0200
Message-Id: <20180604150059.8602-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The intention of this series is to improve the code quality and the
readability. These patches implementing the results of the discussion
https://www.spinics.net/lists/linux-watchdog/msg13940.html. Since the
"fixes" patche series is already applied on watchdog-next, this patch
series is based on the watchdog-next branch
(git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git)
instead of the mainline kernel.

Based on Steve's statement, the da9061/2 and da9063 driver merge was
omitted.

Changelog:

v2:
  - fix compile error due to regval typo
  - fix "line over 80 characters" warning for
    da9063_wdt_update_timeout()

Marco Felsch (2):
  watchdog: da9063: rename helper function to avoid misunderstandings
  watchdog: da9063: remove duplicated timeout_to_sel calls

 drivers/watchdog/da9063_wdt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.17.1

