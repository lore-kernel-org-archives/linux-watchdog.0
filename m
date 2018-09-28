Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Johannes Thumshirn <jth@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'MEN Z069 WATCHDOG DRIVER'
Date: Fri, 28 Sep 2018 14:56:55 -0700
Message-Id: <20180928215656.30272-1-joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9483	MEN Z069 WATCHDOG DRIVER
	9484	M:	Johannes Thumshirn <jth@kernel.org>
	9485	L:	linux-watchdog@vger.kernel.org
	9486	S:	Maintained
-->	9487	F:	drivers/watchdog/menz069_wdt.c

Commit that introduced this:

commit 81ceed41d0c2b2c9300de7bc30c1451680257f52
 Author: Johannes Thumshirn <jthumshirn@suse.de>
 Date:   Mon Jul 16 09:25:10 2018 +0200
 
     watchdog: add driver for the MEN 16z069 IP-Core
     
     Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
     
     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
     Reviewed-by: Michael Moese <mmoese@suse.de>
     Reviewed-by: Guenter Roeck <linux@roeck-us.net>
     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
     Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
 
  MAINTAINERS                   |   6 ++
  drivers/watchdog/Kconfig      |  10 +++
  drivers/watchdog/Makefile     |   1 +
  drivers/watchdog/menz69_wdt.c | 170 ++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 187 insertions(+)

No commit with drivers/watchdog/menz069_wdt.c found
