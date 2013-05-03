Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm26-vm0.access.bullet.mail.mud.yahoo.com ([66.94.236.225]:44556
	"EHLO nm26-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755278Ab3ECBRl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 May 2013 21:17:41 -0400
Date: Thu, 2 May 2013 18:17:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dirk Eibach <dirk.eibach@gdsys.cc>
Cc: linux-kernel@vger.kernel.org,
	Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Make Book E watchdog reset type configurable
Message-ID: <20130503011741.GA23266@roeck-us.net>
References: <1367505913-18970-1-git-send-email-dirk.eibach@gdsys.cc>
 <20130502161720.GA7797@roeck-us.net>
 <429ec64cf7c30a139db40eb20fd3e682@gdsys.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429ec64cf7c30a139db40eb20fd3e682@gdsys.cc>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dirk,

On Thu, May 02, 2013 at 09:11:19PM +0200, Dirk Eibach wrote:
> Hi Guenter,
> 
> >>diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >>index e89fc31..6048593 100644
> >>--- a/drivers/watchdog/Kconfig
> >>+++ b/drivers/watchdog/Kconfig
> >>@@ -1172,6 +1172,38 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
> >>
> >> 	  The value can be overridden by the wdt_period command-line
> >>parameter.
> >>
> >>+choice
> >>+	prompt "PowerPC Book-E Watchdog reset type"
> >>+	depends on BOOKE_WDT
> >>+	default BOOKE_WDT_RESET_CHIP
> >>+	help
> >>+	  Specify what kind of reset will be executed on watchdog timeout.
> >>+
> >Seems to me it would be much better to make this configurable via
> >platform data
> >and/or device tree.
> 
> good catch. What do the device-tree gurus think to be a nice
> property name?
> 
How about "reset-type" ? If that is not acceptable, a more device specific
name might be "booke-reset-type".

I would suggest to write a patch including property description and copy
devicetree-discuss when you submit it. If devicetree works for your application,
I would not bother with platform data.

Btw, do you have an opinion about the timeout ? I'd like to get rid of the
configuration parameter, as it is quite confusing (try to match the parameter
to seconds on a Freescale processor and you'll understand what I mean).
I asked about it on the list a while ago, but did not get any feedback.

Thanks,
Guenter
