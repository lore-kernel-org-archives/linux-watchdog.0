Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39318 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbcKKTrL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Nov 2016 14:47:11 -0500
Date: Fri, 11 Nov 2016 11:47:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] watchdog: bcm7038_wdt: fix module autoload
Message-ID: <20161111194708.GA30151@roeck-us.net>
References: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
 <20161014165548.GA21425@roeck-us.net>
 <6cd2fbb2-02b3-96b7-625e-e5701595b105@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd2fbb2-02b3-96b7-625e-e5701595b105@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Javier,

On Fri, Nov 11, 2016 at 04:43:37PM -0300, Javier Martinez Canillas wrote:
> Hello Guenter,
> 
> On 10/14/2016 01:55 PM, Guenter Roeck wrote:
> > On Fri, Oct 14, 2016 at 12:23:50PM -0300, Javier Martinez Canillas wrote:
> >> If the driver is built as a module, autoload won't work because the module
> >> alias information is not filled. So user-space can't match the registered
> >> device with the corresponding module.
> >>
> >> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> >>
> >> Before this patch:
> >>
> >> $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
> >> $
> >>
> >> After this patch:
> >>
> >> $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
> >> alias:          of:N*T*Cbrcm,bcm7038-wdtC*
> >> alias:          of:N*T*Cbrcm,bcm7038-wdt
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> 
> Are you going to pick this (and patch 2/2)?
> 
> I'm asking because you provided your r-b tag but the patch
> was never merged, so I wonder who should I ping about it.
> 
Wim would be the one to pick it.

Maybe it got lost.  I hope I'll find some time during the weekend
to update my tracking branch.

Guenter
