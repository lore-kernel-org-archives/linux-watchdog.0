Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44077 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaJIMIy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Oct 2014 08:08:54 -0400
Date: Thu, 9 Oct 2014 15:08:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: carlo@caione.org
Cc: linux-watchdog@vger.kernel.org
Subject: re: ARM: meson: add watchdog driver
Message-ID: <20141009120838.GA12751@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Carlo Caione,

The patch 2b0523c42849: "ARM: meson: add watchdog driver" from Sep
20, 2014, leads to the following static checker warning:

	drivers/watchdog/meson_wdt.c:54 meson_restart_handle()
	warn: was hexadecimal intended '100'

drivers/watchdog/meson_wdt.c
   51  static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
    52                                  void *cmd)
    53  {
    54          u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN | 100;
                                                                       ^^^
Is it supposed to be 0x100 here?  Anyway, magic numbers are bad so this
should be changed probably.

    55          struct meson_wdt_dev *meson_wdt = container_of(this,
    56                                                         struct meson_wdt_dev,
    57                                                         restart_handler);
    58  
    59          while (1) {
    60                  writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
    61                  mdelay(5);
    62          }
    63  
    64          return NOTIFY_DONE;
    65  }

regards,
dan carpenter
