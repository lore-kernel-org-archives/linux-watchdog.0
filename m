Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52150 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2GPNLC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Jul 2012 09:11:02 -0400
From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
To: Zumeng Chen <zumeng.chen@windriver.com>,
	"Hilman, Kevin" <khilman@ti.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"tony@atomide.com" <tony@atomide.com>,
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RESEND V3 0/3] Watchdog: OMAP3: bootstatus fix and
 changes for the current watchdog framework
Date: Mon, 16 Jul 2012 13:10:13 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA6DFAE@DBDE01.ent.ti.com>
References: <1342338246-29101-1-git-send-email-zumeng.chen@windriver.com>
In-Reply-To: <1342338246-29101-1-git-send-email-zumeng.chen@windriver.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2012 at 13:14:03, Zumeng Chen wrote:
> Hello,
>=20
> The following patches based on the 3.5-rc6 from Wim, which
> focus on:
>=20
> 1. bootstatus fix for omap3,
>=20
> 2. omap-wdt framework update cater for the current framework
>    as Shubhrajyoti comments mentioned.
>=20
> V3 changes:
>=20
> 1. New comments updated as Kevin mentioned in the third patch;
> 2. 3530evm works well,
>    AM33xx seems work well with the following changes:
> 	+   if (cpu_is_am335x())
> 	+       return omap2_prm_read_mod_reg(AM33XX_PRM_DEVICE_MOD,
> 	+           AM33XX_PRM_RSTST_OFFSET) & 0x7f;
>    But since some definitions not ready for am33xx, so I don't
>    give the patch, if they have been updated, feel free to take these.=20
>=20

Did you test it on any of AM33xx platform? If you use linux-omap/master p=
r=20
linux-next branch as a baseline you should have basic things (except hwmo=
d=20
data) available.

I will test it and send a patch for this on your behalf (if you are ok wi=
th=20
it).


Note: Change in convention, cpu_is_am335x() =3D> soc_is_am335x()

Thanks,
Vaibhav


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
