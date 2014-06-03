Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:4520
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753095AbaFCDUB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Jun 2014 23:20:01 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: imx2_wdt: adds big endianness support.
Date: Tue, 3 Jun 2014 03:19:58 +0000
Message-ID: <cc49edeb85294b00af2a2e6a88e542fc@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1401430217-29543-1-git-send-email-Li.Xiubo@freescale.com>
 <5388975A.7040109@roeck-us.net>
In-Reply-To: <5388975A.7040109@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > @@ -201,6 +204,10 @@ static int __init imx2_wdt_probe(struct platform_device
> *pdev)
> >   	if (!wdev)
> >   		return -ENOMEM;
> >
> > +	big_endian = of_property_read_bool(np, "big-endian");
> > +	if (big_endian)
> > +		imx2_wdt_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> > +
> 
> You'll need to document the use of this property in
> Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt.
>

Sorry for late.

Please see the next version.

Thanks,

BRs
Xiubo




> Guenter
> 
> >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   	base = devm_ioremap_resource(&pdev->dev, res);
> >   	if (IS_ERR(base))
> >

