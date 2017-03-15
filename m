Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35758 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdCOK1F (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 15 Mar 2017 06:27:05 -0400
Received: by mail-wr0-f178.google.com with SMTP id g10so7782894wrg.2
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Mar 2017 03:27:04 -0700 (PDT)
Date: Wed, 15 Mar 2017 10:27:01 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
Message-ID: <20170315102701.ugauplmckezcj7rc@dell>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-3-arnd@arndb.de>
 <20170314111449.m4kejht32bdejxfk@dell>
 <CAK8P3a11maAoSYXPuTLwNsdc+aut4Lo71una7rZyMRdH23sFZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a11maAoSYXPuTLwNsdc+aut4Lo71una7rZyMRdH23sFZw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Mar 2017, Arnd Bergmann wrote:

> On Tue, Mar 14, 2017 at 12:14 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
> > On Tue, 28 Feb 2017, Arnd Bergmann wrote:
> >
> >> When the db8500 watchdog is enabled without the PRCMU, we get a lot =
of
> >> warnings about duplicate or missing helper functions:
> >>
> >> In file included from drivers/watchdog/ux500_wdt.c:21:0:
> >> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prc=
mu_abb_read'
> >>  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 si=
ze)
> >>
> >> This removes the duplicate function definitions and moves the helper=
s in
> >> dbx500-prcmu outside of the #ifdef that hides them.
> >>
> >> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  include/linux/mfd/db8500-prcmu.h | 27 ----------------------
> >>  include/linux/mfd/dbx500-prcmu.h | 49 ++++++++++++++++++++---------=
-----------
> >>  2 files changed, 25 insertions(+), 51 deletions(-)
> >
> > Is this patch still valid?
>=20
> Yes. The build error was resolved with a different patch, but this is
> still a useful cleanup.

Okay, so at least it needs LinusW's Ack.

Once obtained can I take this independently from the rest of the set?=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
