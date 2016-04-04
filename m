Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20160404152506.GA19188@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
	<CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
	<20160404145919.GE2983@katana>
	<CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
	<20160404152506.GA19188@roeck-us.net>
Date: Mon, 4 Apr 2016 19:02:45 +0200
Message-ID: <CAMuHMdUb1ORUygOmFBE7RCe3vBxk60AEdSg+UgHBty6GfFHmEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT watchdogs
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi G=C3=BCnter,

On Mon, Apr 4, 2016 at 5:25 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Apr 04, 2016 at 05:21:44PM +0200, Geert Uytterhoeven wrote:
>> On Mon, Apr 4, 2016 at 4:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >> My Salvator-X reboots after timeout from "cat > /dev/watchdog0", but
>> >> it doesn't reboot through "reboot" or "reboot -f"?
>> >
>> > That sadly doesn't work on Gen3. From the RFC v5 cover letter:
>>
>> > =3D=3D=3D
>> >
>> > * drop restart_handler since ARM64 uses PSCI firmware resets which do
>> >   not call restart handlers
>> >
>> > The last point was quite a bummer to me because plain reboot was the
>> > reason I wrote this driver ;) Well, so is life...
>>
>> That's indeed silly. Can't we have it as a low-priority restart handler,=
 to
>
> Yes, it is. It defeats the purpose of restart handlers. PSCI reset should=
 have
> been implemented as a high priority restart handler.

Unfortunately that won't work: psci_sys_reset() doesn't return on failure.

We can still clear arm_pm_restart in platform code, though ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
