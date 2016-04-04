Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39779 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbcDDPZG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 11:25:06 -0400
Date: Mon, 4 Apr 2016 08:25:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT
 watchdogs
Message-ID: <20160404152506.GA19188@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
 <20160404145919.GE2983@katana>
 <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 04, 2016 at 05:21:44PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
> 
> On Mon, Apr 4, 2016 at 4:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> My Salvator-X reboots after timeout from "cat > /dev/watchdog0", but
> >> it doesn't reboot through "reboot" or "reboot -f"?
> >
> > That sadly doesn't work on Gen3. From the RFC v5 cover letter:
> 
> > ===
> >
> > * drop restart_handler since ARM64 uses PSCI firmware resets which do
> >   not call restart handlers
> >
> > The last point was quite a bummer to me because plain reboot was the
> > reason I wrote this driver ;) Well, so is life...
> 
> That's indeed silly. Can't we have it as a low-priority restart handler, to

Yes, it is. It defeats the purpose of restart handlers. PSCI reset should have
been implemented as a high priority restart handler.

Guenter

> restart the system if PSCI fails to do so?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
