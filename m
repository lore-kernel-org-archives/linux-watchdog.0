Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46360 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2L0TuZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Dec 2012 14:50:25 -0500
Message-ID: <50DCA67A.1080504@hauke-m.de>
Date: Thu, 27 Dec 2012 20:50:18 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Watchdog soft timer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I am currently working on the bcm47xx_wdt driver and it uses some soft
timer, because some devices have a max timeout of 2 seconds. The kernel
timer pings the hardware watchdog every second and the userspace just
have to ping the driver e.g. every 30 seconds. I saw that 12 drivers in
drivers/watchdog/ are currently calling setup_timer and are probably
doing something similar to the bcm47xx_wdt driver.

I think this soft timer in between should go into watchdog_core.c. A
driver should set some option in struct watchdog_device to request a
soft timer in between and set the maximum timeout of the hardware timer
and then gets pinged e.g. every second or even more often and
watchdog_core.c abstracts that the user space just have to ping the
kernel e.g. every 30 seconds. This would just work for drivers using
struct watchdog_ops, but could make some driver smaller. This could also
be activated if a driver sets a maximum timeout of e.g. less then 5
seconds, then the interface does not have to be changes.

Hauke
