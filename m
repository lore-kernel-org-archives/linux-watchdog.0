Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57723 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab3DRETU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Apr 2013 00:19:20 -0400
Date: Wed, 17 Apr 2013 21:19:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kevin Strasser <kevin.strasser@linux.intel.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] mfd: Kontron PLD mfd driver
Message-ID: <20130418041940.GB7535@roeck-us.net>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
 <alpine.LFD.2.02.1304132152320.21884@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1304132152320.21884@ionos>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 13, 2013 at 10:38:07PM +0200, Thomas Gleixner wrote:

[ ... ]

> 
> > +	return kempld_read8(pld, index) | kempld_read8(pld, index+1) << 8;
> 
>   	       			 	  		    index + 1)
> Please
> 
Wondering .... why does checkpatch not report those ? I just reviewed another
driver with the same kind of problem, and checkpatch is just as silent. There
seems to be a whole class of expressions where it does not complain about
missing spaces.

Joe, any idea ?

Thanks,
Guenter
