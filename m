Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35615 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbcDDPVp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 11:21:45 -0400
MIME-Version: 1.0
In-Reply-To: <20160404145919.GE2983@katana>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
	<CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
	<20160404145919.GE2983@katana>
Date: Mon, 4 Apr 2016 17:21:44 +0200
Message-ID: <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT watchdogs
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Mon, Apr 4, 2016 at 4:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> My Salvator-X reboots after timeout from "cat > /dev/watchdog0", but
>> it doesn't reboot through "reboot" or "reboot -f"?
>
> That sadly doesn't work on Gen3. From the RFC v5 cover letter:

> ===
>
> * drop restart_handler since ARM64 uses PSCI firmware resets which do
>   not call restart handlers
>
> The last point was quite a bummer to me because plain reboot was the
> reason I wrote this driver ;) Well, so is life...

That's indeed silly. Can't we have it as a low-priority restart handler, to
restart the system if PSCI fails to do so?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
