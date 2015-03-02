Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39381 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbbCBHty (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Mar 2015 02:49:54 -0500
Received: by wggx12 with SMTP id x12so31626425wgg.6
        for <linux-watchdog@vger.kernel.org>; Sun, 01 Mar 2015 23:49:51 -0800 (PST)
Date: Mon, 2 Mar 2015 07:49:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it,
	kernel@stlinux.com
Subject: Re: [PATCH v4 6/9] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
Message-ID: <20150302074944.GD12821@x1>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
 <1424872349-4155-7-git-send-email-lee.jones@linaro.org>
 <1425137789.24292.44.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1425137789.24292.44.camel@x220>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 28 Feb 2015, Paul Bolle wrote:
> On Wed, 2015-02-25 at 13:52 +0000, Lee Jones wrote:
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: David Paris <david.paris@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig      |  13 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/st_lpc_wdt.c | 333 ++++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 347 insertions(+)
> >  create mode 100644 drivers/watchdog/st_lpc_wdt.c
>=20
> A few nits follow.

Thanks Paul, will fix.

[...]

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
