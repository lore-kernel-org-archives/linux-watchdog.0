Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:35004 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031915AbeCAPo2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 10:44:28 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 0/3] Add Gen2 support to rwdt driver
Date: Thu,  1 Mar 2018 15:44:05 +0000
Message-Id: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Dear All,

the changes from this series originally come from another series:
"Fix watchdog on Renesas R-Car Gen2 and RZ/G1"
However, the watchdog driver related changes are the only changes
still under open discussion, that's why I am moving on with a
smaller series now.

Geert highlighted problems on R-Car Gen3, and he also preferred
splitting commit "watchdog: renesas_wdt: Add R-Car Gen2 support"
into two commits, one for adding suspend/resume support, and
another one for adding the R-Car Gen2 compatible string.
This version of the series tackles those two open points.

Thanks,

Fabrizio Castro (3):
  watchdog: renesas_wdt: Add suspend/resume support
  watchdog: renesas_wdt: Add R-Car Gen2 support
  watchdog: renesas_wdt: Add restart handler

 drivers/watchdog/renesas_wdt.c | 52 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

-- 
2.7.4

