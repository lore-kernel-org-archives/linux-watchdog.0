Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33362 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEGTUg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 15:20:36 -0400
Received: by wgin8 with SMTP id n8so53193235wgi.0
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 12:20:35 -0700 (PDT)
Date: Thu, 7 May 2015 20:20:31 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 12/12] ARM: STi: Update platform level
 menuconfig 'help'
Message-ID: <20150507192031.GD16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-13-git-send-email-lee.jones@linaro.org>
 <20150507141526.GB9793@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150507141526.GB9793@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 07 May 2015, Peter Griffin wrote:

> Hi Lee,
>=20
> On Thu, 07 May 2015, Lee Jones wrote:
>=20
> > Encompass newer STiH4{07,10} SoC based platforms.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/mach-sti/Kconfig | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> > index cb886de..59928d9 100644
> > --- a/arch/arm/mach-sti/Kconfig
> > +++ b/arch/arm/mach-sti/Kconfig
> > @@ -16,11 +16,9 @@ menuconfig ARCH_STI
> >  	select PL310_ERRATA_769419 if CACHE_L2X0
> >  	select RESET_CONTROLLER
> >  	help
> > -	  Include support for STiH41x SOCs like STiH415/416 using the dev=
ice tree
> > -	  for discovery
> > -	  More information at Documentation/arm/STiH41x and
> > -	  at Documentation/devicetree
> > -
> > +	  Include support for STMicroelectronics' STiH415/416 and stih407=
/10
> > +	  family SoCs using the Device Tree for discovery.  More informat=
ion
> > +	  can be found in Documentation/arm/sti/ & Documentation/devicetr=
ee.
>=20
> You should use the same capitalisation throughout.

Good spot, that was unintentional.  Will fix.

> Also you can mention STiH418, as that is now supported upstream.

Yep, thanks.

> Once fixed you can add my: -
>      Acked-by: Peter Griffin <peter.griffin@linaro.org>

Ta.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
