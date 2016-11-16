Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:60620 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbcKPROq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 Nov 2016 12:14:46 -0500
Date: Wed, 16 Nov 2016 09:14:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: Tero Kristo <t-kristo@ti.com>
Cc: Cor Peters <cpeters@victronenergy.com>, linux-omap@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: am33xx.dtsi: Added syscon compatible prcm_dev
 device
Message-ID: <20161116171442.GR4082@atomide.com>
References: <3071466.kDDk30H73u@corpeters>
 <20161115173515.GL4082@atomide.com>
 <20161115173816.GM4082@atomide.com>
 <6861ab40-8727-86ab-17bc-6bb7dc3de30a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6861ab40-8727-86ab-17bc-6bb7dc3de30a@ti.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [161115 11:18]:
> On 15/11/16 19:38, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [161115 09:35]:
> > > * Cor Peters <cpeters@victronenergy.com> [161115 01:00]:
> > > > This patch adds the PRM_DEV as a syscon compatible device to
> > > > am33xx.dtsi. This is needed for the watchdog bootstatus patch.
> > > 
> > > We somehow need to see the bootreason for sure.. But we need to
> > > check with Tero on the reset driver work too.
> > > 
> > > Tero, does setting up of PRM_DEVICE as syscon cause issues for
> > > your reset driver work?
> 
> Good question, currently the reset driver is on hold waiting for hwmod /
> interconnect work to nudge forward. We could probably try to even re-use the
> syscon reset driver for OMAPs (drivers/reset/reset-ti-syscon.c); reset
> handling is not performance critical as such, and we only have few sources
> for these so...
> 
> > 
> > The nightmare scenario is that we have drivers calling random
> > syscon areas across various interconnect targets and then we have
> > zero chance of getting genpd to ever to work properly.
> 
> Exporting this specific area exposes a few interesting features, like
> performing a system wide reset or tweaking SRAM PM configs (preventing SRAM
> LDOs from idling for example.)
> 
> > Do the reset drivers offer some way of exporting the reset status?
> 
> reset_control_status() can be used to read the reset status, this is however
> mostly meant for checking if reset line is currently asserted or not. We
> could in theory overload this for checking if reset has been asserted
> previously or not (checking current status for watchdog reset doesn't make
> much sense for example.)

OK in that case I'd prefer that we get the status from a reset driver.
I think a minimal reset driver could be already done as a regular
device driver that works also as a loadable module. It probably still
needs some callback functions passed to it in platform_data via
pdata-quirks.c though.

Regards,

Tony
