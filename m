Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:60569 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727057AbeICSPE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Sep 2018 14:15:04 -0400
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 1/2] watchdog: core: fix null pointer dereference when
 releasing cdev
Date: Mon, 3 Sep 2018 13:54:43 +0000
Message-ID: <TYXPR01MB17752F4F15CD7BC4080C14F2C00C0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
 <20180828101348.12443-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828101348.12443-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Subject: [PATCH 1/2] watchdog: core: fix null pointer dereference when re=
leasing cdev
>
> watchdog_stop() calls watchdog_update_worker() which needs a valid
> wdd->wd_data pointer. So, when unregistering the cdev, clear the
> pointers after we call watchdog_stop(), not before.
>
> Fixes: bb292ac1c602 ("watchdog: Introduce watchdog_stop_on_unregister hel=
per")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

> ---
>  drivers/watchdog/watchdog_dev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
> index ffbdc4642ea5..f6c24b22b37c 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1019,16 +1019,16 @@ static void watchdog_cdev_unregister(struct watch=
dog_device *wdd)
>  old_wd_data =3D NULL;
>  }
>
> -mutex_lock(&wd_data->lock);
> -wd_data->wdd =3D NULL;
> -wdd->wd_data =3D NULL;
> -mutex_unlock(&wd_data->lock);
> -
>  if (watchdog_active(wdd) &&
>      test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
>  watchdog_stop(wdd);
>  }
>
> +mutex_lock(&wd_data->lock);
> +wd_data->wdd =3D NULL;
> +wdd->wd_data =3D NULL;
> +mutex_unlock(&wd_data->lock);
> +
>  hrtimer_cancel(&wd_data->timer);
>  kthread_cancel_work_sync(&wd_data->work);
>
> --
> 2.11.0




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
