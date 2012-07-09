Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21108 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab2GII5s (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Jul 2012 04:57:48 -0400
Date: Mon, 9 Jul 2012 01:57:36 -0700
From: Tony Lindgren <tony@atomide.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: jgq516@gmail.com, grant.likely@secretlab.ca,
	rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk,
	b-cousson@ti.com, rnayak@ti.com, jon-hunter@ti.com,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCHv2 3/3] watchdog: omap_wdt: add device tree support
Message-ID: <20120709085735.GB1122@atomide.com>
References: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
 <1338525856-4359-4-git-send-email-jgq516@gmail.com>
 <20120706082801.GO1122@atomide.com>
 <20120707120709.GW735@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120707120709.GW735@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

* Wim Van Sebroeck <wim@iguana.be> [120707 05:11]:
> Hi Tony,
> 
> > Hi Wim,
> > 
> > * jgq516@gmail.com <jgq516@gmail.com> [120531 20:56]:
> > > From: Xiao Jiang <jgq516@gmail.com>
> > > 
> > > Add device table for omap_wdt to support dt.
> > 
> > Care to ack this patch in the series?
> 
> Yep.
> Acked-by: Wim Van Sebroeck <wim@iguana.be>

Thanks, I'll apply all three into omap devel-dt branch.

Regards,

Tony
