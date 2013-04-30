Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: "'Guenter Roeck'" <linux@roeck-us.net>
Cc: "'Andrew Morton'" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, "'Wim Van Sebroeck'" <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Jingoo Han <jg1.han@samsung.com>
References: <000e01ce44bc$e5d1dec0$b1759c40$@samsung.com>
 <20130429180235.GD5183@roeck-us.net>
In-reply-to: <20130429180235.GD5183@roeck-us.net>
Subject: Re: [PATCH RESEND 4/7] watchdog: nuc900_wdt: use devm_*() functions
Date: Tue, 30 Apr 2013 11:14:35 +0900
Message-id: <000601ce4548$761d8110$62588330$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Tuesday, April 30, 2013 3:03 AM
> To: Jingoo Han
> Cc: 'Andrew Morton'; linux-kernel@vger.kernel.org; 'Wim Van Sebroeck'; linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH RESEND 4/7] watchdog: nuc900_wdt: use devm_*() functions
> 
> On Mon, Apr 29, 2013 at 06:35:33PM +0900, Jingoo Han wrote:
> > Use devm_*() functions to make cleanup paths simpler.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/watchdog/nuc900_wdt.c |   45 ++++++++--------------------------------
> >  1 files changed, 9 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
> > index 04c45a1..89e8991 100644
> > --- a/drivers/watchdog/nuc900_wdt.c
> > +++ b/drivers/watchdog/nuc900_wdt.c
> > @@ -246,7 +246,8 @@ static int nuc900wdt_probe(struct platform_device *pdev)
> >  {
> >  	int ret = 0;
> >
> > -	nuc900_wdt = kzalloc(sizeof(struct nuc900_wdt), GFP_KERNEL);
> > +	nuc900_wdt = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_wdt),
> > +				GFP_KERNEL);
> 
> General hint: sizeof(*nuc900_wdt) is preferred by most maintainers.

OK, I will fix it.

> 
> >  	if (!nuc900_wdt)
> >  		return -ENOMEM;
> >
> > @@ -257,30 +258,18 @@ static int nuc900wdt_probe(struct platform_device *pdev)
> >  	nuc900_wdt->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (nuc900_wdt->res == NULL) {
> 
> It is no longer necessary to save the resource in nuc900_wdt, as it is only
> used in the probe function. So you might as well drop the variable from the
> structure and declare it locally.

OK, I will drop 'nuc900_wdt->res' variable from the 'nuc900_wdt' structure and
declare it as logical variable.

> 
> >  		dev_err(&pdev->dev, "no memory resource specified\n");
> > -		ret = -ENOENT;
> > -		goto err_get;
> > +		return -ENOENT;
> >  	}
> >
> > -	if (!request_mem_region(nuc900_wdt->res->start,
> > -				resource_size(nuc900_wdt->res), pdev->name)) {
> > -		dev_err(&pdev->dev, "failed to get memory region\n");
> > -		ret = -ENOENT;
> > -		goto err_get;
> > -	}
> > -
> > -	nuc900_wdt->wdt_base = ioremap(nuc900_wdt->res->start,
> > -					resource_size(nuc900_wdt->res));
> > -	if (nuc900_wdt->wdt_base == NULL) {
> > -		dev_err(&pdev->dev, "failed to ioremap() region\n");
> > -		ret = -EINVAL;
> > -		goto err_req;
> > -	}
> > +	nuc900_wdt->wdt_base = devm_ioremap_resource(&pdev->dev,
> > +						nuc900_wdt->res);
> > +	if (IS_ERR(nuc900_wdt->wdt_base))
> > +		return PTR_ERR(nuc900_wdt->wdt_base);
> >
> Does devm_ioremap_resource() spit out an error if it fails ?
> If not, you might want to add an error message for consistency
> with the other messages.

I CC'ed Thierry Reding who is the author of devm_ioremap_resource().

Um, devm_ioremap_resource() spits out an error if it fails.

According to commit message of the previous patch made by Thierry Reding,

"devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths."

Thus, there is no need to add an error message.

Best regards,
Jingoo Han

> 
> Thanks,
> Guenter
