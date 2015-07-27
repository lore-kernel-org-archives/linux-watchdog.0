Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35884 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbG0Vck (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 17:32:40 -0400
Received: by wicgb10 with SMTP id gb10so130186796wic.1
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2015 14:32:39 -0700 (PDT)
Date: Mon, 27 Jul 2015 22:32:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150727213236.GJ21114@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150727153344.GC21114@x1>
 <20150727203208.GB23196@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150727203208.GB23196@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul 2015, Matt Fleming wrote:

> On Mon, 27 Jul, at 04:33:44PM, Lee Jones wrote:
> > On Mon, 27 Jul 2015, Matt Fleming wrote:
> > 
> > > From: Matt Fleming <matt.fleming@intel.com>
> > > 
> > > Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible across
> > > the SMBus, unlike previous generations of PCH/ICH where it was on the
> > > LPC bus. Because it's on the SMBus, it doesn't make sense to pass around
> > > a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> > > watchdog driver is kind of backwards anyway.
> > > 
> > > This change introduces a new 'struct iTCO_wdt_platform_data' for use
> > > inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoint
> > > code, which neatly avoids having to include lpc_ich headers in the i801
> > > i2c driver.
> > > 
> > > A simple translation layer is provided for converting from the existing
> > > 'struct lpc_ich_info' inside the lpc_ich mfd driver.
> > 
> > Is this patch related to Andy's patch-set?
> > 
> >   https://lkml.org/lkml/2015/7/27/599
>  
> Nope, the two are independent.
> 
> > > Cc: Peter Tyser <ptyser@xes-inc.com>
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Wim Van Sebroeck <wim@iguana.be>
> > > Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> > > ---
> > >  drivers/mfd/lpc_ich.c                  | 32 +++++++++++++++++++++++++++++---
> > >  drivers/watchdog/Kconfig               |  2 +-
> > >  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
> > >  include/linux/mfd/lpc_ich.h            |  6 ------
> > >  include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
> > >  5 files changed, 53 insertions(+), 16 deletions(-)
> > >  create mode 100644 include/linux/platform_data/iTCO_wdt.h
> > 
> > How are all of these changes related?
>  
> They create the platform data struct and use it in lpc_ich and iTCO_wdt.
> The Kconfig change shouldn't have snuck into this patch though, that's
> wrong, sorry.
> 
> > Why do they all have to be in a single patch?
> 
> I'll happily split them into more patches if you'd prefer. Maybe one
> that introduces the platform data structure and then a separate one that
> uses it in iTCO_wdt and lpc_ich?
> 
> Technically we could also split the change between iTCO_wdt and lpc_ich,
> but then we'd be passing in an 'lpc_ich_info' and pulling out a
> 'iTCO_wdt_platform_data' and that just seems crazy.

If it's possible to split them up per subsystem, that would be ideal.
Cross-subsystem patches are a pain in a backside.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
