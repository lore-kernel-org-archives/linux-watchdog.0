Return-path: <alexandre.belloni@free-electrons.com>
Date: Fri, 28 Nov 2014 01:30:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
Message-ID: <20141128003002.GN4508@piout.net>
References: <5465C00E.4030808@offcode.fi>
 <1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi>
 <5476CA7F.4000802@offcode.fi>
 <5476ED44.603@atmel.com>
 <54775E12.6020906@roeck-us.net>
 <20141127200647.4f0575ca@bbrezillon>
 <54777C18.3010609@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54777C18.3010609@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 27/11/2014 at 11:31:36 -0800, Guenter Roeck wrote :
> On 11/27/2014 11:06 AM, Boris Brezillon wrote:
> >>As for DT not supposed to be used for configuration, that is really a
> >>tricky problem which is hard to solve. I seem to recall, though, that
> >>it may be now acceptable under certain conditions. A module parameter
> >>might be easier.
> >
> >I'm not a big fan of passing these kind information through module
> >params, cause it's kind of hard to assign parameters when you have
> >multiple device instances (it might not be applicable to watchdog
> >devices though).
> >Moreover, adding more module parameters will just expand the cmdline
> >and make it less and less readable.
> >
> Agreed but ...
> 
> >Anyway, this is not my call to make :-).
> 
> it isn't us who restrict the DT scope (though of course timeout-sec
> _is_ configuration, but that was before things got more restrictive).
> 

My understanding is that it is OK if this is something you need at boot
time versus something you can configure from userspace later. But I'm
not a DT expert ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
