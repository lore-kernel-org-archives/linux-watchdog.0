Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36867 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbaLRINl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Dec 2014 03:13:41 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so2138981obc.11
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Dec 2014 00:13:39 -0800 (PST)
Date: Thu, 18 Dec 2014 08:13:34 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, kernel@stlinux.com,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: bindings: Provide ST bindings for ST's LPC
 Watchdog device
Message-ID: <20141218081334.GO13885@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-6-git-send-email-lee.jones@linaro.org>
 <5479005.CEJLtxOOIa@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <5479005.CEJLtxOOIa@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 17 Dec 2014, Arnd Bergmann wrote:

> On Wednesday 17 December 2014 16:45:24 Lee Jones wrote:
> > +- compatible   : Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > +                                 "st,stih415-lpc" "st,stid127-lpc"
> > +- reg          : LPC registers base address + size
> > +- interrupts    : LPC interrupt line number and associated flags
> > +- clocks       : Clock used by LPC device (See: ../clock/clock-bin=
dings.txt)
> > +- st,lpc-mode  : The LPC can run either one of two modes ST_LPC_MO=
DE_RTC [0] or
> > +                 ST_LPC_MODE_WDT [1].  One (and only one) mode mus=
t be
> > +                 selected.
> >=20
>=20
> I'm glad you got it to work with two drivers for the same device.
>=20
> With this binding, I'm still a bit unhappy about the st,lpc-mode prop=
erty,
> in particular since you rely on a shared include file for something t=
hat
> can only be set in one way or another and always has to be present.
>=20
> Why not just use a boolean property that enforces one mode when prese=
nt
> and another mode when absent?

There is nothing stopping me from doing that, and it was a
consideration.  I concluded that this method would be more explicit
however.  Both when describing our choices in DT and at a functional
level within each of the drivers.

Let me know if you fundamentally disagree and I can fix-up.

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
