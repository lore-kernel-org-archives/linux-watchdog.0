Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34982 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab2AaFaB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Jan 2012 00:30:01 -0500
MIME-Version: 1.0
In-Reply-To: <20120130190106.GA29850@infomag.iguana.be>
References: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
	<20120113111117.GT1068@n2100.arm.linux.org.uk>
	<20120113214555.GA19495@infomag.iguana.be>
	<CAJ0PZbSpL0-LNHfU7TTM06tPi1B4VgCp=oyPA06qAjp8PoPT2w@mail.gmail.com>
	<20120130190106.GA29850@infomag.iguana.be>
Date: Tue, 31 Jan 2012 14:30:00 +0900
Message-ID: <CAJ0PZbShsR74ZDdM5665+M0bcDg0O7TNuqzqAC7s_oehG=2xOQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset at booting)
From: MyungJoo Ham <myungjoo.ham@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
	kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 4:01 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi,
>
>> Yes, if we set wdt_count value properly before request_irq, it's fine.
>>
>> Anyway, as registering the device (watchdog_register_device()) may be
>> done after request_irq without any problem, moving request_irq right
>> before it, not after it should be fine.
>
> So what that be attached patch then? Could you also test this patch?

This patch looks fine and works. It's tested in Exynos4 machine.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Thanks.

Cheers!
MyungJoo.

>
> Kind regards,
> Wim.
> ---
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_=
wdt.c
> index 4bc3744..404172f 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -312,18 +312,26 @@ static int __devinit s3c2410wdt_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0wdt_dev =3D &pdev->dev;
>
> - =A0 =A0 =A0 /* get the memory region for the watchdog timer */
> -
> =A0 =A0 =A0 =A0wdt_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> =A0 =A0 =A0 =A0if (wdt_mem =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "no memory resource specifi=
ed\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOENT;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 wdt_irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0=
);
> + =A0 =A0 =A0 if (wdt_irq =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no irq resource specified\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* get the memory region for the watchdog timer */
> +
> =A0 =A0 =A0 =A0size =3D resource_size(wdt_mem);
> =A0 =A0 =A0 =A0if (!request_mem_region(wdt_mem->start, size, pdev->name=
)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to get memory regio=
n\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0wdt_base =3D ioremap(wdt_mem->start, size);
> @@ -335,29 +343,17 @@ static int __devinit s3c2410wdt_probe(struct plat=
form_device *pdev)
>
> =A0 =A0 =A0 =A0DBG("probe: mapped wdt_base=3D%p\n", wdt_base);
>
> - =A0 =A0 =A0 wdt_irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0=
);
> - =A0 =A0 =A0 if (wdt_irq =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no irq resource specified\n=
");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_map;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 ret =3D request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pd=
ev->name, pdev);
> - =A0 =A0 =A0 if (ret !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to install irq (%d)\=
n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_map;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0wdt_clock =3D clk_get(&pdev->dev, "watchdog");
> =A0 =A0 =A0 =A0if (IS_ERR(wdt_clock)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to find watchdog cl=
ock source\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(wdt_clock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_map;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0clk_enable(wdt_clock);
>
> - =A0 =A0 =A0 if (s3c2410wdt_cpufreq_register() < 0) {
> + =A0 =A0 =A0 ret =3D s3c2410wdt_cpufreq_register();
> + =A0 =A0 =A0 if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR PFX "failed to register =
cpufreq\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_clk;
> =A0 =A0 =A0 =A0}
> @@ -378,12 +374,18 @@ static int __devinit s3c2410wdt_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"cannot start\n");
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 ret =3D request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pd=
ev->name, pdev);
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to install irq (%d)\=
n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_cpufreq;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0watchdog_set_nowayout(&s3c2410_wdd, nowayout);
>
> =A0 =A0 =A0 =A0ret =3D watchdog_register_device(&s3c2410_wdd);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "cannot register watchdog (=
%d)\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_cpufreq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (tmr_atboot && started =3D=3D 0) {
> @@ -408,23 +410,26 @@ static int __devinit s3c2410wdt_probe(struct plat=
form_device *pdev)
>
> =A0 =A0 =A0 =A0return 0;
>
> + err_irq:
> + =A0 =A0 =A0 free_irq(wdt_irq->start, pdev);
> +
> =A0err_cpufreq:
> =A0 =A0 =A0 =A0s3c2410wdt_cpufreq_deregister();
>
> =A0err_clk:
> =A0 =A0 =A0 =A0clk_disable(wdt_clock);
> =A0 =A0 =A0 =A0clk_put(wdt_clock);
> -
> - err_irq:
> - =A0 =A0 =A0 free_irq(wdt_irq->start, pdev);
> + =A0 =A0 =A0 wdt_clock =3D NULL;
>
> =A0err_map:
> =A0 =A0 =A0 =A0iounmap(wdt_base);
>
> =A0err_req:
> =A0 =A0 =A0 =A0release_mem_region(wdt_mem->start, size);
> - =A0 =A0 =A0 wdt_mem =3D NULL;
>
> + err:
> + =A0 =A0 =A0 wdt_irq =3D NULL;
> + =A0 =A0 =A0 wdt_mem =3D NULL;
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -432,18 +437,18 @@ static int __devexit s3c2410wdt_remove(struct pla=
tform_device *dev)
> =A0{
> =A0 =A0 =A0 =A0watchdog_unregister_device(&s3c2410_wdd);
>
> + =A0 =A0 =A0 free_irq(wdt_irq->start, dev);
> +
> =A0 =A0 =A0 =A0s3c2410wdt_cpufreq_deregister();
>
> =A0 =A0 =A0 =A0clk_disable(wdt_clock);
> =A0 =A0 =A0 =A0clk_put(wdt_clock);
> =A0 =A0 =A0 =A0wdt_clock =3D NULL;
>
> - =A0 =A0 =A0 free_irq(wdt_irq->start, dev);
> - =A0 =A0 =A0 wdt_irq =3D NULL;
> -
> =A0 =A0 =A0 =A0iounmap(wdt_base);
>
> =A0 =A0 =A0 =A0release_mem_region(wdt_mem->start, resource_size(wdt_mem=
));
> + =A0 =A0 =A0 wdt_irq =3D NULL;
> =A0 =A0 =A0 =A0wdt_mem =3D NULL;
> =A0 =A0 =A0 =A0return 0;
> =A0}



--=20
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
