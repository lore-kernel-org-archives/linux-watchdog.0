Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:38128 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932304Ab2COVSb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Mar 2012 17:18:31 -0400
Date: Thu, 15 Mar 2012 22:18:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 3/4] watchdog: dev: don't enforce set_timeout()
Message-ID: <20120315211830.GF10698@spo001.leaseweb.com>
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de> <1328204891-32551-4-git-send-email-w.sang@pengutronix.de> <20120314184033.GA20092@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120314184033.GA20092@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> On Thu, Feb 02, 2012 at 06:48:10PM +0100, Wolfram Sang wrote:
> > Some watchdogs rewrite the timer on every ping, so they don't need a specific
> > set_timeout callback. Allow the callback to be empty for such devices.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Wim, I saw that the first two patches are in linux-next, but not this and the
> following one? Any remarks?

first 2 patches are in indeed, but the 4th one (with some adoptions because I left
3 out) is also in. I have to look at patch 3 again, but I gave priority to Hans his
patch nr 4: watchdog_dev: Let the driver update the timeout field on set_timeout
success. Some device indeed don't have a 1 second resolution. That's why it should
be the drivers responsibility to update the code.

But on the other hand, you also are right to say that a lot of drivers just will do:

static int wdt_set_timeout(struct watchdog_device *wdd, unsigned timeout)
{
	wdd->timeout = timeout;
	retun 0;
}

For this we can add a helper or adjust the watchdog code to do this as default.
I have to check out what the best solution is.

Kind regards,
Wim.

