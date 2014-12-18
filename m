Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49651 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaLRJIM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Dec 2014 04:08:12 -0500
Received: by mail-qa0-f43.google.com with SMTP id x12so507164qac.30
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Dec 2014 01:08:10 -0800 (PST)
Date: Thu, 18 Dec 2014 09:08:05 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, kernel@stlinux.com,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	wim@iguana.be, arnd@arndb.de, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 6/8] watchdog: st_wdt: Add new driver
 for ST's LPC Watchdog
Message-ID: <20141218090805.GV13885@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
 <20141218084314.GA25901@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20141218084314.GA25901@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 18 Dec 2014, Peter Griffin wrote:

> Hi Lee,
>=20
> On Wed, 17 Dec 2014, Lee Jones wrote:
>=20
> > Signed-off-by: David Paris <david.paris@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig  |  13 ++
> >  drivers/watchdog/Makefile |   1 +
> >  drivers/watchdog/st_wdt.c | 323 ++++++++++++++++++++++++++++++++++=
++++++++++++
>=20
> You don't have a patch which adds the new files created in this serie=
s into
> the STI section of the MAINTAINERS file?

Very true.  I will supply one, thanks.

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
