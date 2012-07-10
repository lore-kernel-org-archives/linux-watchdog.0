Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46076 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066Ab2GJLjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Jul 2012 07:39:40 -0400
Subject: Re: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related code to prom.c
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF8714@039-SN2MPN1-023.039d.mgd.msft.net>
Date: Tue, 10 Jul 2012 06:39:33 -0500
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-Id: <E9954978-A8D4-443F-AC4A-0EB52F257F84@kernel.crashing.org>
References: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com> <6A3DF150A5B70D4F9B66A25E3F7C888D03CF692C@039-SN2MPN1-023.039d.mgd.msft.net> <ED492CCEAF882048BC2237DE806547C90B2EB2@039-SN2MPN1-013.039d.mgd.msft.net> <6A3DF150A5B70D4F9B66A25E3F7C888D03CF86B7@039-SN2MPN1-023.039d.mgd.msft.net> <ED492CCEAF882048BC2237DE806547C90B2EF0@039-SN2MPN1-013.039d.mgd.msft.net> <6A3DF150A5B70D4F9B66A25E3F7C888D03CF8714@039-SN2MPN1-023.039d.mgd.msft.net>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable


On May 8, 2012, at 10:46 PM, Bhushan Bharat-R65777 wrote:

>>>>>> .org] On Behalf Of Shaohui Xie
>>>>>> Sent: Tuesday, May 08, 2012 11:37 AM
>>>>>> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>>>>>> Cc: Xie Shaohui-B21989
>>>>>> Subject: [PATCH 1/2] powerpc/watchdog: move booke watchdog param
>>>>>> related code to prom.c
>>>>>>=20
>>>>>> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period"
>>>>>> is in setup_32.c, it cannot be used in 64-bit, so move it to a
>>>>>> common place prom.c, which will be shared by 32-bit and 64-bit.
>>>>>>=20
>>>>>> Also, replace the simple_strtoul with kstrtol.
>>>>>>=20
>>>>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>>>>> ---
>>>>>> arch/powerpc/kernel/prom.c     |   27 +++++++++++++++++++++++++++
>>>>>> arch/powerpc/kernel/setup_32.c |   24 ------------------------
>>>>>> 2 files changed, 27 insertions(+), 24 deletions(-)
>>>>>=20
>>>>> Is not setup-common.c is better place to move this?
>>>>=20
>>>> Move out from setup_32.c does not mean it have to go into
>>>> setup-common.c, I need better reason to do this.
>>>>=20
>>>=20
>>> What I think that setup_32.c is for 32 bit, setup_64.c is for 64 bit
>>> and setup-common.c is for both.
>>>=20
>>> I am not saying that you move this to setup-common.c. I am asking why
>>> you have not used setup-common.c ? I am ok even with prom.c.
>>>=20
>> [Xie Shaohui] I'm not a fan of prom.c, I did this because I see same k=
ind of
>> early parameters checking is did in this file only, so I thought maybe=
 I should
>> put them together. And seems setup-common.c is not the place to do com=
mand line
>> checking (I'm not sure about this).
>>=20
>=20
> Ok, so you are also not sure.
> Let us see what other guys things of this.

Put it in setup-common.c.  prom.c has normally been mostly OF/dts related=
 parsing.

- k--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
