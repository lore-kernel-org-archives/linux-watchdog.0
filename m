Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:40318 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751643AbbF3G6O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Jun 2015 02:58:14 -0400
Date: Tue, 30 Jun 2015 08:58:07 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Guenter Roeck <linux@roeck-us.net>, poeschel@lemonage.de,
	Jonathan Corbet <corbet@lwn.net>,
	LKML doc <linux-doc@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: omap_wdt: early_enable module parameter
Message-ID: <20150630065807.GA5645@spo001.leaseweb.nl>
References: <1435227711-29875-1-git-send-email-poeschel@lemonage.de> <558C0634.9050802@roeck-us.net> <CAP=VYLr5wVMBdA76U0HKP2GTN07qiCkCTtBmFG5Z_bWE0QvT9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=VYLr5wVMBdA76U0HKP2GTN07qiCkCTtBmFG5Z_bWE0QvT9g@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Paul,

> On Thu, Jun 25, 2015 at 9:46 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 06/25/2015 03:21 AM, poeschel@lemonage.de wrote:
> >>
> >> From: Lars Poeschel <poeschel@lemonage.de>
> >>
> >> Add a early_enable module parameter to the omap_wdt that starts the
> >> watchdog on module insertion. The default value is 0 which does not
> >> start the watchdog - which also does not change the behavior if the
> >> parameter is not given.
> >>
> >> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> >
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> In case the info hasn't looped back around yet, this breaks the
> omap builds in linux-next:
> 
> drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared
> (first use in this function)
> 
> (Not sure how this could have ever worked as-is.)
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/12452335/
> 
> I see a patch has already been posted to arm-kernel but not
> Cc'd to all originally involved so figured I'd mention it.

It's fixed. The reason why we din't catch it was because of interference
with 'watchdog: omap: put struct watchdog_device into driver data'.

Kind regards,
Wim.

