Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42096 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3LATO7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 Dec 2013 14:14:59 -0500
Date: Sun, 1 Dec 2013 11:14:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3] watchdog: GPIO-controlled watchdog
Message-ID: <20131201191457.GB19549@roeck-us.net>
References: <1385798072-3886-1-git-send-email-shc_work@mail.ru>
 <529B78DC.7070200@roeck-us.net>
 <1385924607.556195103@f310.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1385924607.556195103@f310.i.mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Dec 01, 2013 at 11:03:27PM +0400, Alexander Shiyan wrote:
> Hello.
> 
> > On 11/29/2013 11:54 PM, Alexander Shiyan wrote:
> > > This patch adds a watchdog driver for devices controlled through GPIO,
> > > (Analog Devices ADM706, Maxim MAX823, National NE555 etc).
> > >
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > 
> > Looks pretty good, except for a single nitpick below (sorry I didn't notice that one earlier).
> > 
> > Also, as mentioned before, a changelog describing what changed and what didn't
> > would be really helpful.
> 
> Just fixed all observations made by you earlier.
> 
Yes, but since you did not say that, I had to look up my earlier comments
and check against this version. This takes time, and time is one thing
which reviewers or subsystem maintainers don't always have readily
available.

> ...
> > > +	/* Disallow values lower than 2 and higher than 65535 ms */
> > > +	if ((hw_margin < 2) || (hw_margin > 65535))
> > 
> > Unnecessary ( ).
> 
> This can be corrected during merge. Isn't it? Or you expect v4?
> 
If I were the watchdog maintainer, yes. Since I am not, it really
depends on Wim. He might accept your patch as-is, make the change
himself, expect you to submit another version, or request additional
changes. You'll see.

Thanks,
Guenter
