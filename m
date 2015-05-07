Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33203 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbbEGTTS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 15:19:18 -0400
Received: by wief7 with SMTP id f7so21047779wie.0
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 12:19:16 -0700 (PDT)
Date: Thu, 7 May 2015 20:19:09 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 06/12] watchdog: bindings: Supply
 knowledge of a third supported device - clocksource
Message-ID: <20150507191909.GC16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 15 +++=
++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.=
txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> > index 388c88a..0b1a784 100644
> > --- a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> > @@ -1,20 +1,23 @@
> >  STMicroelectronics Low Power Controller (LPC) - Watchdog
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -LPC currently supports Watchdog OR Real Time Clock functionality.
> > +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> > +functionality.
> > =20
> >  [See: ../rtc/rtc-st-lpc.txt for RTC options]
> > +[See: ../timer/st,stih407-lpc for Clocksource options]
> > =20
> >  Required properties
> > =20
> > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > -				  "st,stih415-lpc" "st,stid127-lpc"
> > +- compatible 	: Must be one of: "st,stih407-lpc"
>=20
> The same comment as the RTC DT patch, you are removing the compatible=
s
> documentation for the other supported platforms like stih416-lpc.
> AFAIK they are required in the driver to get the correct sysconfig re=
gister.

That's intentional.  I haven't yet tested any of this IP on
STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not even
sure if this IP even exists on some of the other platforms.  I will
add them back when support is added to both driver and DTB and I've
been able to test them.

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
