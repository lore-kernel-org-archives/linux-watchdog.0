Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13996 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751580AbaB1QfW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Feb 2014 11:35:22 -0500
Date: Fri, 28 Feb 2014 11:34:48 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Chris Ball <chris@printf.net>, Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <eduardo.valentin@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dove: prepare new Dove DT Kconfig variable
Message-ID: <20140228163448.GM1872@titan.lakedaemon.net>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140228015310.GC9383@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140228015310.GC9383@sirena.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 28, 2014 at 10:53:10AM +0900, Mark Brown wrote:
> On Thu, Feb 27, 2014 at 10:28:03PM +0100, Sebastian Hesselbarth wrote:
> > DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> > mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> > DT-only MACH_DOVE to mmc, thermal, wdt, and asoc Kconfigs.
> 
> I'd be much happier merging this sort of stuff individually through the
> subsystems, we already have an annoying conflict here...  Is there some
> bisection problem with doing that?

shouldn't be.  Since these changes || the old with the new config
symbols.

Sebastian, can you split this up into individual patches?

thx,

Jason.
