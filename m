Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63628 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab1FJPaS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Jun 2011 11:30:18 -0400
Received: by wya21 with SMTP id 21so1943920wya.19
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Jun 2011 08:30:17 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 2/3] WATCHDOG: mtx1-wdt: request gpio before using it
Date: Fri, 10 Jun 2011 17:34:34 +0200
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>, stable@kernel.org
References: <201106021454.20111.florian@openwrt.org> <20110607095847.GB21174@pulham.picochip.com>
In-Reply-To: <20110607095847.GB21174@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106101734.35048.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Jamie,

On Tuesday 07 June 2011 11:58:47 Jamie Iles wrote:
> On Thu, Jun 02, 2011 at 02:54:20PM +0200, Florian Fainelli wrote:
> > Otherwise, the gpiolib autorequest feature will produce a WARN_ON():
> > 
> > WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
> > autorequest GPIO-215
> > [...]
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> > index 63df28c..16086f8 100644
> > --- a/drivers/watchdog/mtx-1_wdt.c
> > +++ b/drivers/watchdog/mtx-1_wdt.c
> > @@ -214,6 +214,11 @@ static int __devinit mtx1_wdt_probe(struct
> > platform_device *pdev)
> > 
> >  	int ret;
> >  	
> >  	mtx1_wdt_device.gpio = pdev->resource[0].start;
> > 
> > +	ret = gpio_request(mtx1_wdt_device.gpio, "mtx1-wdt");
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to request gpio");
> > +		return ret;
> > +	}
> 
> Could you use gpio_request_one() here to make sure the GPIO is in the
> correct direction first?

Makes sense, I will respin a v2 of these.
--
Florian
