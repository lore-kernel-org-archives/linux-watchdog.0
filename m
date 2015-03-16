Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33041 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbCPIRV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Mar 2015 04:17:21 -0400
Received: by wgbcc7 with SMTP id cc7so33130110wgb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2015 01:17:20 -0700 (PDT)
Date: Mon, 16 Mar 2015 08:17:16 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 02/10] mfd: syscon: Add atmel system timer registers
 definition
Message-ID: <20150316081716.GF3383@x1>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426162054-9987-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150313080315.GC3383@x1>
 <20150313104032.GG4329@piout.net>
 <550315C7.7010403@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <550315C7.7010403@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 13 Mar 2015, Nicolas Ferre wrote:

> Le 13/03/2015 11:40, Alexandre Belloni a =C3=A9crit :
> > Hi,
> >=20
> > On 13/03/2015 at 08:03:15 +0000, Lee Jones wrote :
> >> On Thu, 12 Mar 2015, Alexandre Belloni wrote:
> >>
> >>> AT91RM920 has a memory range reserved for timer and watchdog conf=
iguration.
> >>> Expose those registers so that drivers can make use of the system=
 timer syscon
> >>> declared in at91 DTs.
> >>>
> >>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electron=
s.com>
> >>> Acked-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>>  include/linux/mfd/syscon/atmel-st.h | 49 +++++++++++++++++++++++=
++++++++++++++
> >>>  1 file changed, 49 insertions(+)
> >>>  create mode 100644 include/linux/mfd/syscon/atmel-st.h
> >>
> >> Applied, thanks.
>=20
> > Actually, I was thinking this could go through the at91 to avoid
> > depending on your branch.
>=20
> Lee,
>=20
> I was planning to take the whole series with me to limit the number o=
f
> merge conflicts and dependencies.
> Do you mind if I take this patch with the other AT91 cleanup patches
> through the arm-soc tree?
> If you are okay, can you remove this patch already applied on your tr=
ee?

Yes, no problem.

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
