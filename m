Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:56855 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbdKIQBt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 9 Nov 2017 11:01:49 -0500
Date: Thu, 9 Nov 2017 08:01:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <james.hogan@mips.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109160147.GB19959@roeck-us.net>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
 <20171109074718.GR15260@jhogan-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109074718.GR15260@jhogan-linux>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 09, 2017 at 07:47:19AM +0000, James Hogan wrote:
> Hi Wim,
> 
> On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> > This driver works for jz4740 & jz4780
> > 
> > Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> 
> I just noticed that though Ralf applied the other two patches in this
> series (defconfig + dt), he hadn't applied this patch.
> 
> Please can we have an ack from a watchdog maintainer so this can get
> into 4.15 via the MIPS tree? It could alternatively go via the watchdog
> tree if you prefer.
> 

FWIW, according to my logs I did send out a Reviewed-by: some time ago,
which normally means that I expect it to go through the watchdog tree.
I wasn't aware that you wanted the patch to go through the mips tree.
Sorry if I missed that earlier. For the record,

Acked-by: Guenter Roeck <linux@roeck-us.net>

since I don't care one way or another.

I assume you want me to drop this and the related patches from my own
watchdpog-next tree to prevent it from showing up in Wim's tree (if
it isn't already there). Is that correct ?

Guenter

> Thanks
> James
> 
> > ---
> >  drivers/watchdog/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index c722cbfdc7e6..ca200d1f310a 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1460,7 +1460,7 @@ config INDYDOG
> >  
> >  config JZ4740_WDT
> >  	tristate "Ingenic jz4740 SoC hardware watchdog"
> > -	depends on MACH_JZ4740
> > +	depends on MACH_JZ4740 || MACH_JZ4780
> >  	select WATCHDOG_CORE
> >  	help
> >  	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
> > -- 
> > 2.11.0
> > 
> > 


