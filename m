Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 18 Mar 2014 14:59:18 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Lee Jones <lee.jones@linaro.org>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	James Ralston <james.d.ralston@intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: iTCO_wdt: Add support for v3 silicon
Message-ID: <20140318135918.GF1484@spo001.leaseweb.com>
References: <1394487298-14459-1-git-send-email-ptyser@xes-inc.com> <1394487298-14459-5-git-send-email-ptyser@xes-inc.com> <20140315200309.GC14815@spo001.leaseweb.com> <20140318082759.GC25478@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140318082759.GC25478@lee--X1>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Lee,

> > > Some new Atom's, eg Avoton and Bay Trail, have slightly different iTCO
> > > functionality:
> > > - The watchdog timer ticks at 1 second instead of .6 seconds
> > > 
> > > - Some 8 and 16-bit registers were combined into 32-bit registers
> > > 
> > > - Some registers were removed (DAT_IN, DAT_OUT, MESSAGE)
> > > 
> > > - The BOOT_STS field in TCO_STS was removed
> > > 
> > > - The NO_REBOOT bit is in the PMC area instead of GCS
> > > 
> > > Update the driver to support the above changes and bump the version to
> > > 1.11.
> > > 
> > > Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> > > Tested-by: Rajat Jain <rajatjain@juniper.net>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: James Ralston <james.d.ralston@intel.com>
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Wim Van Sebroeck <wim@iguana.be>
> > > Cc: linux-watchdog@vger.kernel.org
> > 
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Why Signed-off-by?

1) I'm the author of iTCO_wdt.
2) I'm tha maintainer of the watchdog device drivers.

Wim.
