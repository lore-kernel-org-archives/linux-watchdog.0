Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45418 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdCIAFf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Mar 2017 19:05:35 -0500
Date: Wed, 8 Mar 2017 11:16:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: intel-mid_wdt: Keep watchdog running
Message-ID: <20170308191652.GB4486@roeck-us.net>
References: <20170308111029.60744-1-andriy.shevchenko@linux.intel.com>
 <846f18ec-e41c-364e-c867-fa6b3dbc18d4@roeck-us.net>
 <1488985870.20145.137.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488985870.20145.137.camel@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 08, 2017 at 05:11:10PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-03-08 at 06:21 -0800, Guenter Roeck wrote:
> > Hi Andy,
> > 
> > On 03/08/2017 03:10 AM, Andy Shevchenko wrote:
> > > Firmware followed by bootloader leaves watchdog running.
> > > 
> > 
> > Is that always the case ?
> 
> Yes if no-one patched boot loader specifically to avoid this.
> 
> >  If not, does it hurt if the watchdog is pinged
> > while not active ?
> > 
> > Also, this assumes that its default timeout is in the default range
> > configured by the driver, ie not (much) lower than 30 seconds.
> 
> Correct. It is hard coded in SCU firmware (60 seconds IIRC). U-Boot for
> now doesn't change it.
> 
> > Not objecting, but it would help to have comments in the code
> > explaining
> > the context in some more detail.
> 
> Last time you were not satisfied by the line which stops the running
> watchdog [1]. I found a way how to keep it running gracefully, which I
> proposed to do at that time (assuming boot loader doesn't stop it) [2].
> 
> I'm confused now what is preferable way to do the things?
> 

The suggested patch is ok. I was just asking for additional comments,
along the line of 1) the SCU firmware sets the timeout to 60s, the default
timeout of 30s is therefore safe, and 2) that the watchdog is by default
enabled in the SCU firmware (and, if appropriate, that it doesn't get a
hiccup if it is pinged if it should have been disabled for some unspecified
/ unknown reason).

Thanks,
Guenter
