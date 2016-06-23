Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35523 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcFWRXJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jun 2016 13:23:09 -0400
Received: by mail-oi0-f52.google.com with SMTP id r2so80403373oih.2
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jun 2016 10:23:09 -0700 (PDT)
MIME-Version: 1.0
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 23 Jun 2016 22:52:49 +0530
Message-ID: <CANAwSgSPVgLb2i28XYxiEvAy7XabiDA=H6a08fCamBryn2mWsA@mail.gmail.com>
Subject: Meson gxbb watchdog driver.
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Neil,

I have seen you post on watchdog driver for Meson gxbb_wdt.

I would like to know if this driver can work with watchdog demon.

When I configure this device /dev/watchdog with watchdog demon
It tries to send continuous ping to reset the timer.

On debugging further gxbb_wdt driver reset the control register to zero

So when I try to kill the watchdog demon it triggers following.

[   85.616779] .....ping continuously to say alive
[   85.616902] .....ping continuously to say alive
[   85.616908] .....ping continuously to say alive
[   85.967005] watchdog watchdog0: watchdog did not stop!
[   85.967036] .....ping continuously to say alive
[   86.018820] .....ping continuously to say alive
[   86.018836] .....ping continuously to say alive
[   86.028546] .....ping continuously to say alive
[   87.028586] .....ping continuously to say alive

This dose not trigger watchdog reset and reboot.

Could you help me out how this should work out.

Second question should watchdog demon register to all the cpu cores.

Best Regards
-Anand Moon
