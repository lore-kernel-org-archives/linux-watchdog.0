Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:44672 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800Ab3JIXrG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Oct 2013 19:47:06 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so1698111wes.9
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Oct 2013 16:47:04 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 9 Oct 2013 16:47:03 -0700
Message-ID: <CAPdLdqnz9EpW5S4OSh_2mokWH36n5zO0q-7MMuctRL_LQTYsNQ@mail.gmail.com>
Subject: Disabling watchdog when closing /dev/watchdog
From: Markus Mayer <markus.mayer@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linux Watchdog <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently, the watchdog framework works such that upon closing
/dev/watchdog it will attempt to disable the watchdog timer and,
failing that, will poke the watchdog (via the watchdog_release()
function).

I am working on a new watchdog driver for a Broadcom SoC, and for test
purposes at least, it would be helpful if the watchdog could be left
alone when the device is closed (i.e. the watchdog is neither stopped
nor poked). That way I could use a command line utility to issue ioctl
calls and observe the effect of these calls.

Right now, using my line tool to check the "time left" will return the
proper amount of time left, but it will also poke the watchdog,
therefore changing the time that's actually left until the watchdog
expires (the command line tool opens /dev/watchdog, issues an ioctl
and closes /dev/watchdog), turning a "read-only" operation into one
that actually changes the watchdog's status.

Automatically stopping or poking the watchdog upon close only makes
sense in the case of a continuously running daemon that keeps
/dev/watchdog open at all times. It doesn't work for case where an
application would open the watchdog device only for brief amounts of
time.

Would it make sense to add a flag like "WDOG_LEAVE_ON" to, say, struct
watchdog_device's "status" values, which the driver could set,
allowing watchdog_release() to leave the watchdog alone upon closing
the device? Or is there a different way to achieve this? A daemon is
not practicable for me at this point, and even later on, we may not
want to go with a daemon solution, but may want to rely on the
watchdog continuing to run even if the device is closed.

Thanks,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
