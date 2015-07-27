Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52431 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbbG0PsD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 11:48:03 -0400
Message-ID: <1438011952.29746.93.camel@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee.jones@linaro.org>,
	Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 27 Jul 2015 18:45:52 +0300
In-Reply-To: <20150727153344.GC21114@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
	 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
	 <20150727153344.GC21114@x1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2015-07-27 at 16:33 +0100, Lee Jones wrote:
> On Mon, 27 Jul 2015, Matt Fleming wrote:
> 
> > From: Matt Fleming <matt.fleming@intel.com>
> > 
> > Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible 
> > across
> > the SMBus, unlike previous generations of PCH/ICH where it was on 
> > the
> > LPC bus. Because it's on the SMBus, it doesn't make sense to pass 
> > around
> > a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> > watchdog driver is kind of backwards anyway.
> > 
> > This change introduces a new 'struct iTCO_wdt_platform_data' for 
> > use
> > inside the iTCO watchdog driver and by the upcoming Intel 
> > Sunrisepoint
> > code, which neatly avoids having to include lpc_ich headers in the 
> > i801
> > i2c driver.
> > 
> > A simple translation layer is provided for converting from the 
> > existing
> > 'struct lpc_ich_info' inside the lpc_ich mfd driver.
> 
> Is this patch related to Andy's patch-set?

No, it's a separate stuff. They are pretty independent as I can see.


> 
>   https://lkml.org/lkml/2015/7/27/599
> 
> > Cc: Peter Tyser <ptyser@xes-inc.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> > ---
> >  drivers/mfd/lpc_ich.c                  | 32 
> > +++++++++++++++++++++++++++++---
> >  drivers/watchdog/Kconfig               |  2 +-
> >  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
> >  include/linux/mfd/lpc_ich.h            |  6 ------
> >  include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
> >  5 files changed, 53 insertions(+), 16 deletions(-)
> >  create mode 100644 include/linux/platform_data/iTCO_wdt.h
> 
> How are all of these changes related?
> 
> Why do they all have to be in a single patch?
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
