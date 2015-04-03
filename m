Return-path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Aubrey Li <aubrey.li@intel.com>, Borun Fu <borun.fu@intel.com>
Subject: Re: [PATCH] PM / watchdog: iTCO: stop watchdog during system suspend
Date: Fri, 03 Apr 2015 13:04:47 +0200
Message-ID: <1741516.p64k4HnZLy@vostro.rjw.lan>
In-Reply-To: <551E29B7.7050801@roeck-us.net>
References: <2017660.nPaHVT8bW3@vostro.rjw.lan> <2928815.XiLbVYtUVn@vostro.rjw.lan> <551E29B7.7050801@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday, April 02, 2015 10:48:39 PM Guenter Roeck wrote:
> On 04/02/2015 03:04 PM, Rafael J. Wysocki wrote:
> [ ... ]
> >
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: PM / watchdog: iTCO: stop watchdog during system suspend
> >
> > If the target sleep state of the system is not an ACPI sleep state
> > (S1, S2 or S3), the TCO watchdog needs to be stopped during system
> > suspend, because it may not be possible to ping it any more after
> > timekeeping has been suspended (suspend-to-idle does that for
> > one example).
> >
> > For this reason, provide ->suspend_noirq and ->resume_noirq
> > callbacks for the iTCO watchdog driver and use them to stop
> > and restart the watchdog during system suspend and resume,
> > respectively, if the system is not going to enter an ACPI
> > sleep state (in which case the watchdog will be stopped
> > by the platform firmware before the state is entered).
> >
> > Reported-by: Borun Fu <borun.fu@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

I'll take it into the PM tree, unless anyone objects.

Rafael
