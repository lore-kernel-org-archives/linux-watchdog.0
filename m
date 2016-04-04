Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45591 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbcDDSX6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 14:23:58 -0400
Date: Mon, 4 Apr 2016 11:23:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT
 watchdogs
Message-ID: <20160404182359.GA26293@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
 <20160404145919.GE2983@katana>
 <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
 <20160404152506.GA19188@roeck-us.net>
 <CAMuHMdUb1ORUygOmFBE7RCe3vBxk60AEdSg+UgHBty6GfFHmEQ@mail.gmail.com>
 <20160404175239.GA24667@roeck-us.net>
 <CAMuHMdWtTYwe8ssqMfW9XrRxKpvYmTRVwUWdDFW_-8aBEYTQ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWtTYwe8ssqMfW9XrRxKpvYmTRVwUWdDFW_-8aBEYTQ7w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 04, 2016 at 08:14:02PM +0200, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Apr 4, 2016 at 7:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Apr 04, 2016 at 07:02:45PM +0200, Geert Uytterhoeven wrote:
> >> On Mon, Apr 4, 2016 at 5:25 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> > On Mon, Apr 04, 2016 at 05:21:44PM +0200, Geert Uytterhoeven wrote:
> >> >> On Mon, Apr 4, 2016 at 4:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> >> >> My Salvator-X reboots after timeout from "cat > /dev/watchdog0", but
> >> >> >> it doesn't reboot through "reboot" or "reboot -f"?
> >> >> >
> >> >> > That sadly doesn't work on Gen3. From the RFC v5 cover letter:
> >> >>
> >> >> > ===
> >> >> >
> >> >> > * drop restart_handler since ARM64 uses PSCI firmware resets which do
> >> >> >   not call restart handlers
> >> >> >
> >> >> > The last point was quite a bummer to me because plain reboot was the
> >> >> > reason I wrote this driver ;) Well, so is life...
> >> >>
> >> >> That's indeed silly. Can't we have it as a low-priority restart handler, to
> >> >
> >> > Yes, it is. It defeats the purpose of restart handlers. PSCI reset should have
> >> > been implemented as a high priority restart handler.
> >>
> >> Unfortunately that won't work: psci_sys_reset() doesn't return on failure.
> >>
> > You mean it just hangs ? That is bad. If that is the case, it is not reliable
> > and thus should be a low priority (or at best medium priority) restart handler
> > (which can be replaced with a working higher priority one).
> 
> On my Salvator-X board, it hangs. The call into PSCI doesn't return.
> As this is firmware, it may depend on the version of the firmware.
> 
> >> We can still clear arm_pm_restart in platform code, though ;-)
> >>
> > I had originally planned to replace arm_pm_restart() completely with restart
> > handlers. Maybe I should revive the effort ?
> 
> Perhaps. As I remember, it was not such a pretty experience?
> 
That was the attempt to introduce the same mechanism for power-off handling.
Yes, that bad experience got me to abandon the attempt to finish the restart
handler cleanup as well, but it may still worth at least a final attempt.

Guenter
