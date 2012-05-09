Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:43068
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753588Ab2EID1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 May 2012 23:27:11 -0400
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related
 code to prom.c
Date: Wed, 9 May 2012 03:27:06 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF86B7@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03CF692C@039-SN2MPN1-023.039d.mgd.msft.net>
 <ED492CCEAF882048BC2237DE806547C90B2EB2@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <ED492CCEAF882048BC2237DE806547C90B2EB2@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Xie Shaohui-B21989
> Sent: Wednesday, May 09, 2012 8:50 AM
> To: Bhushan Bharat-R65777; linux-watchdog@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: RE: [PATCH 1/2] powerpc/watchdog: move booke watchdog param re=
lated
> code to prom.c
>=20
> >> -----Original Message-----
> >> From:
> >> linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org
> >> [mailto:linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.oz=
lab
> >> s
> >> .org] On Behalf Of Shaohui Xie
> >> Sent: Tuesday, May 08, 2012 11:37 AM
> >> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> >> Cc: Xie Shaohui-B21989
> >> Subject: [PATCH 1/2] powerpc/watchdog: move booke watchdog param
> >> related code to prom.c
> >>
> >> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" i=
s
> >> in setup_32.c, it cannot be used in 64-bit, so move it to a common
> >> place prom.c, which will be shared by 32-bit and 64-bit.
> >>
> >> Also, replace the simple_strtoul with kstrtol.
> >>
> >> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> >> ---
> >>  arch/powerpc/kernel/prom.c     |   27 +++++++++++++++++++++++++++
> >>  arch/powerpc/kernel/setup_32.c |   24 ------------------------
> >>  2 files changed, 27 insertions(+), 24 deletions(-)
> >
> >Is not setup-common.c is better place to move this?
>=20
> Move out from setup_32.c does not mean it have to go into setup-common.=
c, I need
> better reason to do this.
>=20

What I think that setup_32.c is for 32 bit, setup_64.c is for 64 bit and =
setup-common.c is for both.

I am not saying that you move this to setup-common.c. I am asking why you=
 have not used setup-common.c ? I am ok even with prom.c.


Thanks
-Bharat

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
