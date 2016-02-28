Return-path: <vilhelm.gray@gmail.com>
Date: Sun, 28 Feb 2016 09:36:04 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
Message-ID: <20160228143548.GA26320@sophia>
References: <20160125190942.GA6824@sophia>
 <20160125192810.2487661b@lxorguk.ukuu.org.uk>
 <20160228140739.GA7577@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160228140739.GA7577@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Feb 28, 2016 at 03:07:39PM +0100, Wim Van Sebroeck wrote:
>> > +static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
>> > +{
>> > +	/* resolution is in minutes for timeouts greater than 255 seconds */
>> > +	if (t > 255) {
>> > +		/* truncate second resolution to minute resolution */
>> > +		t /= 60;
>> > +		wdev->timeout = t * 60;
>> > +
>> > +		/* set watchdog timer for minutes */
>> > +		outb(0x00, CFG_ADDR);
>> 
>> If ask for 299 seconds surely I should get 300 not 240 ?
>> (Whether to round off or round up is an interesting question for the
>> middle range - does it go off early or late - I'd have said late but...)
>
>This is my preference:
>	if (t > 255)
>		t = (((t - 1) / 60) + 1) * 60;
>
>Which basically is a round-up to minutes
>t = 256 -> gives 300
>t = 299 -> gives 300 
>t = 300 -> gives 300
>t = 301 -> gives 360
>t = 15299 -> gives 15300
>t = 15300 -> gives 15300
>t = 15301 -> gives 15360
>
>So I am also for going late.
>
>Kind regards,
>Wim.

I decided to give this another consideration: perhaps we should allow it
to go late rather than early. I figure that when a user configures the
watchdog timer for a certain value in seconds they will have an
expectation that the watchdog timer will wait at least that amount of
time (with the understanding that it may be somewhat late due to the
granularity of the timer).

This behavior follows a lot of other timer standards (e.g. nanosleep)
so it's what the user expects and what we should follow for now. I'll
submit a version 5 patch with this change.

William Breathitt Gray
