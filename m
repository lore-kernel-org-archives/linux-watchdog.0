Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:55313 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782Ab2ECEs4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 May 2012 00:48:56 -0400
Date: Thu, 3 May 2012 06:48:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	=?utf-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>,
	BANAJIT GOSWAMI <banajit.g@samsung.com>,
	Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben@simtec.co.uk>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] watchdog: s3c2410-wdt: Use of_match_ptr().
Message-ID: <20120503044854.GI3074@spo001.leaseweb.com>
References: <4198193.124741336006837837.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4198193.124741336006837837.JavaMail.weblogic@epml09>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

>=20
> > Use of_match_ptr definition for the of_match_table.
> >=20
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> >=20
> > ---
> >=20
> > Can someone compile test this?
> >=20
> > Thanks,
> > Wim.
>=20
>=20
> I get this error. You probably need to add #include.
>=20
> scripts/kconfig/conf --silentoldconfig Kconfig
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      drivers/watchdog/watchdog_core.o
>   CC      drivers/watchdog/watchdog_dev.o
>   CC      drivers/watchdog/s3c2410_wdt.o
>   LD      drivers/watchdog/watchdog.o
> drivers/watchdog/s3c2410_wdt.c:517:3: error: implicit declaration of fu=
nction =E2=80=98of_match_ptr=E2=80=99
> drivers/watchdog/s3c2410_wdt.c:517:34: error: =E2=80=98s3c2410_wdt_matc=
h=E2=80=99 undeclared here (not in a function)
> make[2]: *** [drivers/watchdog/s3c2410_wdt.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/watchdog] Error 2
> make: *** [drivers] Error 2

Can you try with: #include <linux/of.h> ?

Thanks,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
