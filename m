Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54174 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab3D3B4k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 21:56:40 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Guenter Roeck' <linux@roeck-us.net>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
References: <000d01ce44bc$da891380$8f9b3a80$@samsung.com>
 <20130429175507.GC5183@roeck-us.net>
In-reply-to: <20130429175507.GC5183@roeck-us.net>
Subject: Re: [PATCH RESEND 3/7] watchdog: mv64x60_wdt: use devm_ioremap()
Date: Tue, 30 Apr 2013 10:56:39 +0900
Message-id: <000501ce4545$f43495f0$dc9dc1d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday, April 30, 2013 2:55 AM, Guenter Roeck wrote:
> On Mon, Apr 29, 2013 at 06:35:15PM +0900, Jingoo Han wrote:
> > Use devm_ioremap() to make cleanup paths simpler.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> This patch also addresses the missing call to iounmap() if the call
> to misc_register fails.

When devm_ioremap() is used, there is no need to call devm_iounmap().

It is because, these resource managed functions such as
devm_ioremap() allow the driver core to automatically
clean up any allocation, when probe function fails.

> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thank you for your reviewing.

Best regards,
Jingoo Han

> 
> > ---
> >  drivers/watchdog/mv64x60_wdt.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
> > index c7fb878..e4cf980 100644
> > --- a/drivers/watchdog/mv64x60_wdt.c
> > +++ b/drivers/watchdog/mv64x60_wdt.c
> > @@ -276,7 +276,7 @@ static int mv64x60_wdt_probe(struct platform_device *dev)
> >  	if (!r)
> >  		return -ENODEV;
> >
> > -	mv64x60_wdt_regs = ioremap(r->start, resource_size(r));
> > +	mv64x60_wdt_regs = devm_ioremap(&dev->dev, r->start, resource_size(r));
> >  	if (mv64x60_wdt_regs == NULL)
> >  		return -ENOMEM;
> >
> > @@ -293,8 +293,6 @@ static int mv64x60_wdt_remove(struct platform_device *dev)
> >
> >  	mv64x60_wdt_handler_disable();
> >
> > -	iounmap(mv64x60_wdt_regs);
> > -
> >  	return 0;
> >  }
> >
> > --
> > 1.7.2.5
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

