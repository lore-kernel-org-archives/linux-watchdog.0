Return-Path: <tim@krieglstein.org>
Return-path: <tim@krieglstein.org>
From: Tim Sander <tim@krieglstein.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-rt-users@vger.kernel.org
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
Date: Thu, 20 Sep 2018 10:18:33 +0200
Message-ID: <2133238.jDSj0JK9k1@dabox>
In-Reply-To: <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
References: <73d0tbdjqz.fsf@pengutronix.de> <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

Hi

I am also seeing this problem. 
Am Dienstag, 18. September 2018, 15:46:15 CEST schrieb Guenter Roeck:
> Please not only describe what you are doing, but also provide the complete
> context. Specifically,
> - Did this ever work ?
I have not found a working kernel version.
> If yes, what are working kernel versions ?
I have tried different kernel version which where *not* working:
patch-4.11.12-rt15 (with some Altera/Intel driver patches)
4.16.8-rt3
4.18-rc8-rt1
4.18.7-rt5 (with adxl372 iio patches and denali nand race fix reported on 
mainline)
> - Is the watchdog device open ?
Good point: The bootloader arms the watchdog.  Then 
WATCHDOG_HANDLE_BOOT_ENABLED is enabled in kernel.
But i forgot to let usermode take over.

> - Does it make a difference if it is ?
If i set RuntimeWatchdogSec=30 in /etc/systemd/system.conf (i.e. enable 
usermode watchdog) the problem seems to go away (at least i didn't had a 
reboot dony with my short testruns by now).

> - What is the configured watchdog timeout (both from BIOS/ROMMON and in
> Linux) ?
30s

So to wrap up: i have the suspicion that the option 
WATCHDOG_HANDLE_BOOT_ENABLED without usermode taking over in Linux leads to 
some strange behaviour with preempt rt?

Best regards
Tim
