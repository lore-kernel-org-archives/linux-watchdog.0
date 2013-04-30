Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39849 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3D3CSf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 22:18:35 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Guenter Roeck' <linux@roeck-us.net>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001101ce44bd$0a0105f0$1e0311d0$@samsung.com>
 <20130429180957.GG5183@roeck-us.net>
In-reply-to: <20130429180957.GG5183@roeck-us.net>
Subject: Re: [PATCH RESEND 7/7] watchdog: ts72xx_wdt: use devm_*() functions
Date: Tue, 30 Apr 2013 11:18:33 +0900
Message-id: <000701ce4549$03cc1a80$0b644f80$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday, April 30, 2013 3:10 AM, Guenter Roeck wrote:
> On Mon, Apr 29, 2013 at 06:36:34PM +0900, Jingoo Han wrote:
> > Use devm_*() functions to make cleanup paths simpler.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/watchdog/ts72xx_wdt.c |   64 +++++++----------------------------------
> >  1 files changed, 11 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> > index b8a9245..b19ca75 100644
> > --- a/drivers/watchdog/ts72xx_wdt.c
> > +++ b/drivers/watchdog/ts72xx_wdt.c
> > @@ -396,7 +396,7 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
> >  	struct resource *r1, *r2;
> >  	int error = 0;
> >
> > -	wdt = kzalloc(sizeof(struct ts72xx_wdt), GFP_KERNEL);
> > +	wdt = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_wdt), GFP_KERNEL);
> >  	if (!wdt) {
> >  		dev_err(&pdev->dev, "failed to allocate memory\n");
> >  		return -ENOMEM;
> > @@ -405,44 +405,22 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
> >  	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!r1) {
> >  		dev_err(&pdev->dev, "failed to get memory resource\n");
> > -		error = -ENODEV;
> > -		goto fail;
> > -	}
> > -
> > -	r1 = request_mem_region(r1->start, resource_size(r1), pdev->name);
> > -	if (!r1) {
> > -		dev_err(&pdev->dev, "cannot request memory region\n");
> > -		error = -EBUSY;
> > -		goto fail;
> > +		return -ENODEV;
> >  	}
> >
> > -	wdt->control_reg = ioremap(r1->start, resource_size(r1));
> > -	if (!wdt->control_reg) {
> > -		dev_err(&pdev->dev, "failed to map memory\n");
> > -		error = -ENODEV;
> > -		goto fail_free_control;
> > -	}
> > +	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
> > +	if (IS_ERR(wdt->control_reg))
> > +		return PTR_ERR(wdt->control_reg);
> >
> >  	r2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >  	if (!r2) {
> >  		dev_err(&pdev->dev, "failed to get memory resource\n");
> > -		error = -ENODEV;
> > -		goto fail_unmap_control;
> > +		return -ENODEV;
> >  	}
> >
> > -	r2 = request_mem_region(r2->start, resource_size(r2), pdev->name);
> > -	if (!r2) {
> > -		dev_err(&pdev->dev, "cannot request memory region\n");
> > -		error = -EBUSY;
> > -		goto fail_unmap_control;
> > -	}
> > -
> > -	wdt->feed_reg = ioremap(r2->start, resource_size(r2));
> > -	if (!wdt->feed_reg) {
> > -		dev_err(&pdev->dev, "failed to map memory\n");
> > -		error = -ENODEV;
> > -		goto fail_free_feed;
> > -	}
> > +	wdt->feed_reg = devm_ioremap_resource(&pdev->dev, r2);
> > +	if (IS_ERR(wdt->feed_reg))
> > +		return PTR_ERR(wdt->feed_reg);
> >
> You have a mix of returns with and without error messages now. Can you make sure
> that this is all consistent ?

As I previously mentioned, there is no need to add an error message.
(http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg426498.html)

Best regards,
Jingoo Han

> 
> Thanks,
> Guenter

