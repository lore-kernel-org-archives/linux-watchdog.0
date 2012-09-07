Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50971 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757507Ab2IGV1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Sep 2012 17:27:37 -0400
Received: by dady13 with SMTP id y13so19837dad.19
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Sep 2012 14:27:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Murali Karicheri <m-karicheri2@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<wim@iguana.be>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1346351350-28807-1-git-send-email-m-karicheri2@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
References: <1346351350-28807-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <20120907212732.20289.62310@nucleus>
Subject: Re: [PATCH] wdt:clk: preparation for switch to common clock framework
Date: Fri, 07 Sep 2012 14:27:32 -0700
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Quoting Murali Karicheri (2012-08-30 11:29:10)
> As a first step towards migrating davinci platforms to use common clock
> framework, replace all instances of clk_enable() with clk_prepare_enabl=
e()
> and clk_disable() with clk_disable_unprepare(). Until the platform is
> switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
> adds a might_sleep() call and would work without any issues.
>=20
> This will make it easy later to switch to common clk based implementati=
on
> of clk driver from DaVinci specific driver.
>=20
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/watchdog/davinci_wdt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_=
wdt.c
> index c8c5c80..eb44b03 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -208,7 +208,7 @@ static int __devinit davinci_wdt_probe(struct platf=
orm_device *pdev)
>         if (WARN_ON(IS_ERR(wdt_clk)))
>                 return PTR_ERR(wdt_clk);
> =20
> -       clk_enable(wdt_clk);
> +       clk_prepare_enable(wdt_clk);
> =20
>         if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>                 heartbeat =3D DEFAULT_HEARTBEAT;
> @@ -256,7 +256,7 @@ static int __devexit davinci_wdt_remove(struct plat=
form_device *pdev)
>                 wdt_mem =3D NULL;
>         }
> =20
> -       clk_disable(wdt_clk);
> +       clk_disable_unprepare(wdt_clk);
>         clk_put(wdt_clk);
> =20
>         return 0;
> --=20
> 1.7.9.5
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
