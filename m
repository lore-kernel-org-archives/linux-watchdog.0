Return-path: <wimvs@spo001.leaseweb.nl>
Date: Tue, 24 Mar 2015 08:42:48 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: James Hogan <james.hogan@imgtec.com>, linux-watchdog@vger.kernel.org,
	James Hogan <james@albanarts.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: Re: [PATCH 0/2] watchdog: imgpdc: Runtime fixes
Message-ID: <20150324074248.GA1408@spo001.leaseweb.nl>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com> <20150320205315.GB22574@jhogan-linux.le.imgtec.org> <550EF67C.7050601@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550EF67C.7050601@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi All,

> >>A couple of basic runtime fixes for the IMG PDC watchdog driver. These
> >>were found by attempting to enable the driver for TZ1090 and running
> >>under Meta QEMU. Note that QEMU doesn't emulate the actual watchdog
> >>functionality beyond the soft reset register, so I cannot claim to have
> >>tested the driver's watchdog timer functionality yet.
> >>
> >>James Hogan (2):
> >>   watchdog: imgpdc: Fix probe NULL pointer dereference
> >>   watchdog: imgpdc: Fix default heartbeat
> >
> >Thanks Guenter for the reviews.
> >
> >Any chance of these fixes getting merged in time for v4.0?
> >
> 
> I agree that would be good. There is also 'watchdog: mtk_wdt:
> signedness bug in mtk_wdt_start()' which should be in 4.0 as well.

Correct.

> Wim, if you are busy, want me to prepare and send a pull request to Linus ?

I'm preparing the 3 patches so that they can go upstream relatively soon.

Kind regards,
Wim.
