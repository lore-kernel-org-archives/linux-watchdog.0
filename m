Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34769 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcDDOvP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 10:51:15 -0400
MIME-Version: 1.0
In-Reply-To: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
Date: Mon, 4 Apr 2016 16:51:14 +0200
Message-ID: <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT watchdogs
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Fri, Apr 1, 2016 at 1:56 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Here is V2 of this series with the following changes:
>
> * include bitops.h
> * s/unsigned/unsigned int/
> * drop set_timeout() because core does it already
> * add get_timeleft()
> * don't make "nowayout" a readable parameter
> * use "watchdog" instead of "wdt" in the dt bindings
>
> The dts and defconfig changes should go via Simon's tree once the driver is
> accepted.
>
> To use this driver, you need a recent firmware/uboot which initializes the
> WDTRSTCR register which can only be changed in secure mode. 'md 0xe6160054 4'
> should give you 0x8002 or something else with bit 15 set and bit 0 cleared.

Thanks a lot!

My Salvator-X reboots after timeout from "cat > /dev/watchdog0", but
it doesn't reboot through "reboot" or "reboot -f"?

Am I missing something?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
