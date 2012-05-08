Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:7327 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756498Ab2EHRNM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 May 2012 13:13:12 -0400
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related
 code to prom.c
Date: Tue, 8 May 2012 17:13:05 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF692C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.=
org
> [mailto:linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlab=
s.org] On
> Behalf Of Shaohui Xie
> Sent: Tuesday, May 08, 2012 11:37 AM
> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: Xie Shaohui-B21989
> Subject: [PATCH 1/2] powerpc/watchdog: move booke watchdog param relate=
d code to
> prom.c
>=20
> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is i=
n
> setup_32.c, it cannot be used in 64-bit, so move it to a common place p=
rom.c,
> which will be shared by 32-bit and 64-bit.
>=20
> Also, replace the simple_strtoul with kstrtol.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
>  arch/powerpc/kernel/prom.c     |   27 +++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_32.c |   24 ------------------------
>  2 files changed, 27 insertions(+), 24 deletions(-)

Is not setup-common.c is better place to move this?

Thanks
-Bharat

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
