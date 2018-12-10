Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:64512
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbeLJJku (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Dec 2018 04:40:50 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
Date: Mon, 10 Dec 2018 09:40:43 +0000
Message-ID: <TY1PR01MB177088485BE3A5F8F07E8F5AC0A50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
 <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
 <20181207214528.GA2853@kunai>
In-Reply-To: <20181207214528.GA2853@kunai>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wolfram,

> From: Wolfram Sang <wsa@the-dreams.de>
> Sent: 07 December 2018 21:45
> Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during s=
uspend/resume
>
> Hi Guenter, all,
>
> > > After discussing this mail thread [1] again, we concluded that giving
> > > userspace enough time to prepare is our favourite option. So, do not
> > > keep the time value when suspended but reset it when resuming.
> > >
> > > [1] https://patchwork.kernel.org/patch/10252209/
> > >
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Above exchange says it all, no need to repeat.
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Thanks.
>
> I can relate to the policy argument, though. Regardless of this patch, I
> wonder if we can make it configurable from userspace. A draft:
>
> #defineWDIOF_RESUME_OPTS0x0800
>
> #defineWDIOS_RESUME_KEEP0x0008
> #defineWDIOS_RESUME_RESET0x0010
>
> and then in watchdog_ioctl() under WDIOC_SETOPTIONS:
>
> if (!(wdd->info->options & WDIOF_RESUME_OPTS))
> err =3D -EOPNOTSUPP;
> goto break;
>
> if (val & WDIOS_RESUME_KEEP)
> wdd->status |=3D WDOG_KEEP_TIMER_WHEN_RESUME;
>
> if (val & WDIOS_RESUME_RESET)
> wdd->status ~=3D ~WDOG_KEEP_TIMER_WHEN_RESUME;
>
> So, drivers with WDIOF_RESUME_OPTS could act on the
> WDOG_KEEP_TIMER_WHEN_RESUME flag.
>
> Opinions?

This probably allows for user customization and yet could keep the current
behaviour in place, therefore I think it's a good start. Maybe once every s=
ingle
driver makes an informed decision during suspend-resume we could drop one
of the flags?

Thanks,
Fab

>
> Thanks,
>
>    Wolfram



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
