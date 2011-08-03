Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52754 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab1HCIPf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Aug 2011 04:15:35 -0400
Date: Wed, 3 Aug 2011 11:15:59 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: [RFC PATCH] watchdog: ep93xx: Use the WatchDog Timer Driver Core.
Message-ID: <20110803081559.GI13218@intel.com>
References: <201108011357.24745.hartleys@visionengravers.com>
 <20110802091640.GF13218@intel.com>
 <ADE657CA350FB648AAC2C43247A983F001F3882B8535@AUSP01VMBX24.collaborationhost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3882B8535@AUSP01VMBX24.collaborationhost.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 02, 2011 at 11:55:36AM -0500, H Hartley Sweeten wrote:
> >> -static const struct watchdog_info ident = {
> >> -	.options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
> >> -	.identity = "EP93xx Watchdog",
> >> +static const struct watchdog_info ep93xx_wdt_ident = {
> >> +	.options	= WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
> >> +	.identity	= "EP93xx Watchdog",
> >>  };

One more thing I noticed: you should add WDIOF_KEEPALIVEPING to the options
field. Otherwise it doesn't support ioctl(..., WDIOC_KEEPALIVE) which was
supported in the original driver.
