Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33307 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbbG2LKF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 07:10:05 -0400
Received: by wicmv11 with SMTP id mv11so214327276wic.0
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2015 04:10:04 -0700 (PDT)
Date: Wed, 29 Jul 2015 12:09:59 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150729110959.GH2773@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150729092934.1a54992b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150729092934.1a54992b@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 29 Jul, at 09:29:34AM, Jean Delvare wrote:
> Hi Matt,
> 
> On Mon, 27 Jul 2015 14:38:08 +0100, Matt Fleming wrote:
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 241fafde42cb..5336fe2ff689 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -797,7 +797,7 @@ config ITCO_WDT
> >  	tristate "Intel TCO Timer/Watchdog"
> >  	depends on (X86 || IA64) && PCI
> >  	select WATCHDOG_CORE
> > -	select LPC_ICH
> > +	depends on LPC_ICH || I2C_I801
> >  	---help---
> >  	  Hardware driver for the intel TCO timer based watchdog devices.
> >  	  These drivers are included in the Intel 82801 I/O Controller
> 
> I don't like that. Depending on the order of the subsystems in the
> Kconfig tree, the user may not see the option and has no clue that the
> option exists. When he/she later enables LPC_ICH or I2C_I801, the
> option becomes visible but he/she has no reason to return here to
> enable it.
 
Good point!

> I can think of several ways to address the issue. One of them is to
> select both drivers, as this is what most users will want anyway:
> 
> 	select LPC_ICH if !EXPERT
> 	select I2C_I801 if !EXPERT
> 
> Another possibility is to make config ITCO_WDT always visible, and add
> sub-options ITCO_WDT_LPC and ITCO_WDT_I2C which depend on it. Selecting
> either would select the driver it depends on:
> 
> config ITCO_WDT_LPC
> 	bool "Intel TCO Timer/Watchdog on LPC"
> 	depends on ITCO_WDT
> 	select LPC_ICH
> 
> config ITCO_WDT_I2C
> 	bool "Intel TCO Timer/Watchdog on I2C"
> 	depends on ITCO_WDT
> 	select I2C_I801
> 
> I did not test that, some care might be needed due to tristate vs.
> boolean.
> 
> I personally prefer the first approach. It may not be as clean as the
> second approach but it should be good enough in practice and avoids
> cluttering Kconfig with even more options.

Yeah, I'm with you on that. The first approach seems superior to me
because it doesn't require users to know which bus the TCO watchdog
device lives on for their platforms.

-- 
Matt Fleming, Intel Open Source Technology Center
