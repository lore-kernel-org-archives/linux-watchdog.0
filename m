Return-path: <mdf@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: moritz.fischer@ettus.com,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@iguana.be,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	alex.williams@ni.com,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/2] DS1374 Watchdog fixes
Date: Mon, 24 Apr 2017 15:05:10 -0700
Message-Id: <1493071512-5718-1-git-send-email-mdf@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi all,

this series fixes two issues that I ran into when trying to use the
watchdog part of the DS1374 on of our products.

This series is basically a precursor to some further cleanup work,
that turns the DS1374 into a MFD device with an RTC and WDT in
separate drivers [1] each integrated in either the watchdog and
the rtc frameworks.

I'm very unhappy with the CONFIG_DRV_RTC_DS1374_WDT way of enabling
the watchdog behavior and currently I'm investigating how to make
that work via DT.

Watchdog maintainers, do you have an idea on how to do that in a
non breaking fashion?

Thanks,
Moritz

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux.git/log/?h=wip/mfd-ds1374-rfc

Moritz Fischer (2):
  rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt
    ticks
  rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL

 drivers/rtc/rtc-ds1374.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4
