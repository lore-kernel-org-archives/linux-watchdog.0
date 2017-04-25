Return-path: <alexandre.belloni@free-electrons.com>
Date: Tue, 25 Apr 2017 18:32:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Moritz Fischer <moritz.fischer.private@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	linux-watchdog@vger.kernel.org, wim@iguana.be, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, alex.williams@ni.com
Subject: Re: [PATCH 0/2] DS1374 Watchdog fixes
Message-ID: <20170425163204.rj6on6phtbfuvcd7@piout.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
 <CAJYdmeP+XEBPpUECO1rWpRDs-RVihc_va970jtv6iau3OuWMWA@mail.gmail.com>
 <20170425161743.GA8443@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425161743.GA8443@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 25/04/2017 at 09:17:43 -0700, Guenter Roeck wrote:
> On Tue, Apr 25, 2017 at 07:55:28AM -0700, Moritz Fischer wrote:
> > Hi Guenter,
> > 
> > On Mon, Apr 24, 2017 at 10:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 04/24/2017 03:05 PM, Moritz Fischer wrote:
> > 
> > >> I'm very unhappy with the CONFIG_DRV_RTC_DS1374_WDT way of enabling
> > >> the watchdog behavior and currently I'm investigating how to make
> > >> that work via DT.
> > >>
> > >> Watchdog maintainers, do you have an idea on how to do that in a
> > >> non breaking fashion?
> > >>
> > >
> > > Depends on what you mean with "non breaking". Just using the normal mfd
> > > mechanisms, ie define an mfd cell for each client driver, should work.
> > > Do you see any problems with that ? Either case, that doesn't seem
> > > to be a watchdog driver problem, or am I missing something ?
> > 
> > Well so currently watchdog behavior is selected (out of the two options alarm,
> > or watchdog) by enabling the configuration option mentioned above.
> > If I change this over to use a dt-based approach like dallas,ds1374-mode = <2>;
> > to select the behavior in the mfd for example, won't that break people that
> > relied on the old behavior? If everyone involved is ok with that, I'm happy
> > to just add it to the binding.
> > 
> 
> Sorry, I must be missing something. Looking into the driver code, my
> understanding is that CONFIG_RTC_DRV_DS1374_WDT enables the watchdog in
> addition to rtc functionality, not one or the other. Sure you would need
> a different configuration option if you were to move the watchdog code into
> drivers/watchdog, but other than that I don't really understand the problem.
> What is the issue with, for example,
> 

The watchdog functionality and the rtc alarm are mutually exclusive.

> > The idea was to fix what's broken currently (this patchset) and then refactor.
> > But if you prefer I can do all in one go instead.
> > 
> 
> It just seemed a waste to me to change/fix a function which is going to
> be removed in a subsequent patch (I seem to recall that there was a fix
> to the ioctl function).
> 

I'd say that it depends on whether you want to backport the fixes to the
stable kernels. Backporting the full rework is probably riskier.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
