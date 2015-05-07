Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38600 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbEGTVo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 15:21:44 -0400
Received: by wiun10 with SMTP id n10so3226467wiu.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 12:21:43 -0700 (PDT)
Date: Thu, 7 May 2015 20:21:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 08/12] rtc: bindings: Supply knowledge
 of a third supported device - clocksource
Message-ID: <20150507192139.GE16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-9-git-send-email-lee.jones@linaro.org>
 <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt | 15 ++++++++=
+------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b=
/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > index 73407f50..daf8826 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > @@ -1,20 +1,23 @@
> >  STMicroelectronics Low Power Controller (LPC) - RTC
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > =20
> > -LPC currently supports Watchdog OR Real Time Clock functionality.
> > +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> > +functionality.
> > =20
> >  [See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
> > +[See: ../timer/st,stih407-lpc for Clocksource options]
> > =20
> >  Required properties
> > =20
> > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > -				  "st,stih415-lpc" "st,stid127-lpc"
> > +- compatible 	: Must be: "st,stih407-lpc"
>=20
> You are removing the compatibles documentation for the other supporte=
d SoC's like
> stih416-lpc stih415-lpc here.

It would be pretty difficult to do that by mistake. :)

See the comment I made to the Watchdog bindings patch for more info.

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
