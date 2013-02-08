Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36944 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967Ab3BHFiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Feb 2013 00:38:09 -0500
From: "Kumar, Anil" <anilkumar.v@ti.com>
To: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>
CC: "wim@iguana.be" <wim@iguana.be>, "Nori, Sekhar" <nsekhar@ti.com>,
	"Kumar, Anil" <anilkumar.v@ti.com>
Subject: RE: [PATCH] watchdog: davinci_wdt: update to devm_* API
Date: Fri, 8 Feb 2013 05:37:58 +0000
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C5AB3@DBDE01.ent.ti.com>
References: <1360207935-24325-1-git-send-email-anilkumar.v@ti.com>
In-Reply-To: <1360207935-24325-1-git-send-email-anilkumar.v@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2013 at 09:02:15, Kumar, Anil wrote:
> Update the code to use devm_* API so that driver
> core will manage resources.
>=20
> Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
> ---
> This patch applies on top of v3.8-rc6.
>=20
> Tested on da850 EVM.
>=20
> :100644 100644 e8e8724... 6ad76a3... M	drivers/watchdog/davinci_wdt.c
>  drivers/watchdog/davinci_wdt.c |   34 +++++++++-----------------------=
--
>  1 files changed, 9 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_=
wdt.c
> index e8e8724..6ad76a3 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -69,7 +69,6 @@ static unsigned long wdt_status;
>  #define WDT_REGION_INITED 2
>  #define WDT_DEVICE_INITED 3
> =20
> -static struct resource	*wdt_mem;
>  static void __iomem	*wdt_base;
>  struct clk		*wdt_clk;
> =20
> @@ -201,10 +200,10 @@ static struct miscdevice davinci_wdt_miscdev =3D =
{
> =20
>  static int davinci_wdt_probe(struct platform_device *pdev)
>  {
> -	int ret =3D 0, size;
> -	struct device *dev =3D &pdev->dev;
> +	int ret =3D 0;
> +	static struct resource  *wdt_mem;
> =20
> -	wdt_clk =3D clk_get(dev, NULL);
> +	wdt_clk =3D clk_get(&pdev->dev, NULL);
>  	if (WARN_ON(IS_ERR(wdt_clk)))
>  		return PTR_ERR(wdt_clk);
> =20
> @@ -213,49 +212,34 @@ static int davinci_wdt_probe(struct platform_devi=
ce *pdev)
>  	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>  		heartbeat =3D DEFAULT_HEARTBEAT;
> =20
> -	dev_info(dev, "heartbeat %d sec\n", heartbeat);
> +	dev_info(&pdev->dev, "heartbeat %d sec\n", heartbeat);
> =20
>  	wdt_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (wdt_mem =3D=3D NULL) {
> -		dev_err(dev, "failed to get memory region resource\n");
> +		dev_err(&pdev->dev, "failed to get memory region resource\n");
>  		return -ENOENT;
>  	}
> =20
> -	size =3D resource_size(wdt_mem);
> -	if (!request_mem_region(wdt_mem->start, size, pdev->name)) {
> -		dev_err(dev, "failed to get memory region\n");
> -		return -ENOENT;
> -	}
> -
> -	wdt_base =3D ioremap(wdt_mem->start, size);
> +	wdt_base =3D devm_request_and_ioremap(&pdev->dev, wdt_mem);
>  	if (!wdt_base) {
> -		dev_err(dev, "failed to map memory region\n");
> -		release_mem_region(wdt_mem->start, size);
> -		wdt_mem =3D NULL;
> +		dev_err(&pdev->dev, "ioremap failed\n");
>  		return -ENOMEM;
>  	}
> =20
>  	ret =3D misc_register(&davinci_wdt_miscdev);
>  	if (ret < 0) {
> -		dev_err(dev, "cannot register misc device\n");
> -		release_mem_region(wdt_mem->start, size);
> -		wdt_mem =3D NULL;
> +		dev_err(&pdev->dev, "cannot register misc device\n");
>  	} else {
>  		set_bit(WDT_DEVICE_INITED, &wdt_status);
> +		return ret;

No need of return "ret" as it is retuning "ret" just below.
I will fix it in V2.=09

>  	}
> =20
> -	iounmap(wdt_base);
>  	return ret;
>  }
> =20
>  static int davinci_wdt_remove(struct platform_device *pdev)
>  {
>  	misc_deregister(&davinci_wdt_miscdev);
> -	if (wdt_mem) {
> -		release_mem_region(wdt_mem->start, resource_size(wdt_mem));
> -		wdt_mem =3D NULL;
> -	}
> -
>  	clk_disable_unprepare(wdt_clk);
>  	clk_put(wdt_clk);
> =20
> --=20
> 1.7.4.1
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
