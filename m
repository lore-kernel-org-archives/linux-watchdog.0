Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:62451 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935032Ab3DRNfe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Apr 2013 09:35:34 -0400
Date: Thu, 18 Apr 2013 06:35:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Strasser <kevin.strasser@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Michael Brunner <michael.brunner@kontron.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>,
	Michael Brunner <mibru@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] mfd: Kontron PLD mfd driver
Message-ID: <20130418133555.GA2767@roeck-us.net>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
 <alpine.LFD.2.02.1304132152320.21884@ionos>
 <20130418041940.GB7535@roeck-us.net>
 <1366260053.28609.66.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366260053.28609.66.camel@joe-AO722>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Apr 17, 2013 at 09:40:53PM -0700, Joe Perches wrote:
> On Wed, 2013-04-17 at 21:19 -0700, Guenter Roeck wrote:
> > On Sat, Apr 13, 2013 at 10:38:07PM +0200, Thomas Gleixner wrote:
> > > > + return kempld_read8(pld, index) | kempld_read8(pld, index+1) << 8;
> > >                                                         index + 1)
> > > Please
> > Wondering .... why does checkpatch not report those ?
> 
> because checkpatch doesn't care about spacing around
> arithmetic as long as it's consistent.
> 
> Documentation/CodingStyle doesn't say anything about
> it either.
> 
Hi Joe,

"Use one space around (on each side of) most binary and ternary operators"

doesn't apply, then ? When does it apply ? I always thought it would apply
to cases such as the above.

Thanks,
Guenter
