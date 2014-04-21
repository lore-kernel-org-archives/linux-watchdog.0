Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55107 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaDUUFM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Apr 2014 16:05:12 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so4063352pbb.17
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Apr 2014 13:05:12 -0700 (PDT)
Date: Mon, 21 Apr 2014 13:05:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Eric Ernst <eric.ernst@intel.com>, linux-watchdog@vger.kernel.org,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: Intel MID vs. Intel SCU watchdog
Message-ID: <20140421200508.GB20398@roeck-us.net>
References: <20140421181652.GA31616@roeck-us.net>
 <20140421195127.GA30085@psi-dev26.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140421195127.GA30085@psi-dev26.jf.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 21, 2014 at 12:51:27PM -0700, David Cohen wrote:
> On Mon, Apr 21, 2014 at 11:16:53AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > with the recent submission of an Intel MID watchdog driver, we now have
> > 
> > config INTEL_SCU_WATCHDOG
> >         bool "Intel SCU Watchdog for Mobile Platforms"
> > 	depends on X86_INTEL_MID
> > 	---help---
> > 	  Hardware driver for the watchdog time built into the Intel SCU
> > 	  for Intel Mobile Platforms.
> > 
> > 
> > config INTEL_MID_WATCHDOG
> >         tristate "Intel MID Watchdog Timer"
> > 	depends on X86_INTEL_MID
> > 	--help--
> > 	  Watchdog timer driver built into the Intel SCU for Intel MID Platforms.
> > 
> > 	  This driver currently supports only the watchdog evolution
> > 	  implementation in SCU, available for Merrifield generation.
> > 
> > Furthermore, in the SCU watchdog driver initialization code, we have
> > 
> > 	...
> > 	 * If it isn't an intel MID device then it doesn't have this watchdog
> >          */
> >          if (!intel_mid_identify_cpu())
> >                   return -ENODEV;
> > 
> > I must admit I find this very confusing. Both watchdogs have the same
> > dependencies. The MID watchdog driver only instantiates for Tangier,
> > while the SCU watchdog driver instantiates for all MID CPUs (specfically
> > including Tangier, but also Penwell and Cloverview and, from earlier
> > commit logs, Moorsetown).
> > 
> > I understand I was told earlier that the supported devices would be
> > "sufficiently different" to warrant separate drivers, but this doesn't
> > really make sense to me, at least not without further explanation.
> > 
> > Can someone please clarify which driver is supposed to work on which device,
> > and why there are now two watchdog drivers for Tangier (or at least two
> > watchdog drivers which instantiate on Tangier) ? Does the SCU driver work
> > on Tangier, or does it not ? If not, why is there no code in the SCU driver
> > which would cause it to fail to instantiate on Tangier, and why is this
> > limitation not mentioned in Kconfig ? If yes, why do we need separate drivers
> > in the first place ?
> 
> Let me try to give extra info:
> 
> INTEL_SCU_WATCHDOG supports Penwell and Cloverview. But it is using an
> obsolete interface and would need too much if's to support Tangier (and
> newer ones). And it is mostly unsupported nowadays.
> 
> Internally we had a new watchdog for Tangier (and newer platforms)
> called INTEL_SCU_WATCHDOG_EVO. Somebody else tried to upstream it but
> got nacked due to obsolete interface too. I started to rewrite this
> watchdog to comply with community comments [1].
> 
> While rewriting the _EVO one, I felt it would be better to not have 2
> wdt drivers for Intel MID, but only one. This new INTEL_MID_WATCHDOG
> supports only Tangier now but I am trying to make it generic enough to
> bring the legacy platforms too. Then we can get rid of INTEL_SCU_WATCHDOG.
> 
> Does that sound feasible? Maybe I need to write comments to
> INTEL_SCU_WATCHDOG's Kconfig entry about its limitation.
> 
Yes, I think that would make sense. I also think the SCU watchdog
driver should fail to load if it is instantiated on Tangier,
if that is not supported. Or, rather, it should only instantiate on 
Penwell and Cloverview if those are the only supported platforms
(but what about Moorestown ?).

Can you submit a patch to do that ?

Thanks,
Guenter
