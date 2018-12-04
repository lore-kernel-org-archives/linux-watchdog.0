Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:60968
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbeLDMst (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 07:48:49 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
Date: Tue, 4 Dec 2018 12:48:31 +0000
Message-ID: <TY1PR01MB17709692A979A4CE1AF40309C0AF0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wolfram,

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 04 December 2018 12:02
> Subject: [RFC] watchdog: renesas_wdt: don't keep timer value during suspe=
nd/resume
>
> After discussing this mail thread [1] again, we concluded that giving
> userspace enough time to prepare is our favourite option. So, do not
> keep the time value when suspended but reset it when resuming.
>
> [1] https://patchwork.kernel.org/patch/10252209/
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Fabrizio: can you agree to that? The R-Car BSP team and we (the R-Car ups=
tream
> team) would prefer it this way (knowing it is also not perfect).

I am not too sure, as the system relies on the watchdog to fix problems tha=
t won't resolve
on their own, therefore if you have an application made of two threads, one=
 very critical
for the health of the system (but unfortunately buggy, which means it is de=
stined to not
ping watchdog on time), and the other thread takes care of putting the syst=
em to sleep,
you may find yourself in a place where the system doesn't work properly (as=
 the critical
thread won't work as expected) and never restarts (because the other thread=
 works properly
and putting the system to sleep resets the watchdog).
Sometimes the line between policies and mechanisms is not a clear cut, I th=
ink this patch
looks more like a policy decision, but I may be wrong.

Cheers,
Fab

>
>  drivers/watchdog/renesas_wdt.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
> index b570962e84f3..9f2307bf727b 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -48,7 +48,6 @@ struct rwdt_priv {
>  void __iomem *base;
>  struct watchdog_device wdev;
>  unsigned long clk_rate;
> -u16 time_left;
>  u8 cks;
>  };
>
> @@ -263,10 +262,9 @@ static int __maybe_unused rwdt_suspend(struct device=
 *dev)
>  {
>  struct rwdt_priv *priv =3D dev_get_drvdata(dev);
>
> -if (watchdog_active(&priv->wdev)) {
> -priv->time_left =3D readw(priv->base + RWTCNT);
> +if (watchdog_active(&priv->wdev))
>  rwdt_stop(&priv->wdev);
> -}
> +
>  return 0;
>  }
>
> @@ -274,10 +272,9 @@ static int __maybe_unused rwdt_resume(struct device =
*dev)
>  {
>  struct rwdt_priv *priv =3D dev_get_drvdata(dev);
>
> -if (watchdog_active(&priv->wdev)) {
> +if (watchdog_active(&priv->wdev))
>  rwdt_start(&priv->wdev);
> -rwdt_write(priv, priv->time_left, RWTCNT);
> -}
> +
>  return 0;
>  }
>
> --
> 2.11.0



[https://www2.renesas.eu/media/email/unicef.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
