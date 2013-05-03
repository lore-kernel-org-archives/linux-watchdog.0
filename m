Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm16.access.bullet.mail.mud.yahoo.com ([66.94.237.217]:20304
	"EHLO nm16.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933135Ab3ECP7Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 11:59:25 -0400
Date: Fri, 3 May 2013 08:59:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dirk Eibach <dirk.eibach@gdsys.cc>
Cc: linux-kernel@vger.kernel.org,
	Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Make Book E watchdog reset type configurable
Message-ID: <20130503155927.GA8695@roeck-us.net>
References: <1367505913-18970-1-git-send-email-dirk.eibach@gdsys.cc>
 <20130502161720.GA7797@roeck-us.net>
 <429ec64cf7c30a139db40eb20fd3e682@gdsys.cc>
 <20130503011741.GA23266@roeck-us.net>
 <7be2cb3417615ff206270a756c6422d6@gdsys.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be2cb3417615ff206270a756c6422d6@gdsys.cc>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 03, 2013 at 10:33:13AM +0200, Dirk Eibach wrote:
> Hi Guenter,
> 
> >>>>diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >>>>index e89fc31..6048593 100644
> >>>>--- a/drivers/watchdog/Kconfig
> >>>>+++ b/drivers/watchdog/Kconfig
> >>>>@@ -1172,6 +1172,38 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
> >>>>
> >>>>	  The value can be overridden by the wdt_period command-line
> >>>>parameter.
> >>>>
> >>>>+choice
> >>>>+	prompt "PowerPC Book-E Watchdog reset type"
> >>>>+	depends on BOOKE_WDT
> >>>>+	default BOOKE_WDT_RESET_CHIP
> >>>>+	help
> >>>>+	  Specify what kind of reset will be executed on watchdog
> >>>>timeout.
> >>>>+
> >>>Seems to me it would be much better to make this configurable via
> >>>platform data
> >>>and/or device tree.
> >>
> >>good catch. What do the device-tree gurus think to be a nice
> >>property name?
> 
> having a closer look, I realized booke_wdt is not device-tree based
> yet. Migrating it would come close to a rewrite, breaking
> compatibility for all current users. Sorry, this is way beyond the
> time I have for this project. So I suggest merging the change the
> way it is, as it is clearly an improvement.
> 
I sent a couple of RFC patches converting the driver to a platform driver and
adding of support to linux-watchdog and linux-kernel mailing lists.
Compile tested only, and missing is automatic driver instantiation.

Guenter
