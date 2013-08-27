Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:37522 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3H0SFe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Aug 2013 14:05:34 -0400
Received: by mail-we0-f181.google.com with SMTP id q57so4120872wes.26
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Aug 2013 11:05:33 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Aug 2013 21:05:33 +0300
Message-ID: <CAC0tyxObqmsEh1xWfVMH09BG0Hqp1hb3niVvRp+dweX83y79OQ@mail.gmail.com>
Subject: MX28: Enable watchdog before reaching userspace
From: =?ISO-8859-1?Q?M=E5rten_Wikman?= <marten.wikman@novia.fi>
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

The thing is that I'm using a Freescale mx28 based board with 3.11
mainline kernel and now I want to enable watchdog before reaching
userspace so it will reset my board if no rootfs is found for some
reason.

I have compiled the kernel with stmp3xxx-rtc and stmp3xxx_rtc_wdt and
the watchdog is working fine in userspace when I echo something to
/dev/watchdog0.  I can't however get watchdog to reset my board in the
early boot process. RTC and RTC_WDT is loaded on boot and I got the
following output:

[    1.990863] stmp3xxx-rtc 80056000.rtc: rtc core: registered
80056000.rtc as rtc0
[    1.999625] i2c /dev entries driver
[    2.012643] stmp3xxx_rtc_wdt stmp3xxx_rtc_wdt: initialized watchdog
with heartbeat 19s

but  watchdog won't reset my board if I trigger a kernel panic by
removing rootfs.
