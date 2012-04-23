Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:51312 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2DWPWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 11:22:51 -0400
Message-ID: <4F9573B8.9050607@arm.com>
Date: Mon, 23 Apr 2012 16:22:32 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: viresh kumar <viresh.linux@gmail.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"spear-devel@list.st.com" <spear-devel@list.st.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM mpcore
 watchdog
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com> <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com> <4F9514AA.10403@arm.com> <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com> <4F9547E3.4000709@arm.com> <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com>
In-Reply-To: <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 23/04/12 15:21, viresh kumar wrote:
> On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Ah, that explains why it worked. I suppose you do have additional
>> patches that fix the IRQ request bit?
>=20
> Missed this earlier. That patchset is in review currently and have alre=
ady
> fixed that. :)

Right. Please post that patch as a prerequisite for any other change.

>> Given that no in-tree platform seem to be using this watchdog (at leas=
t
>> a quick grep didn't reveal anything), I'd be inclined to simply change
>> the offset in smp_twd.h and let them break.
>=20
> Even i can't find any users of it. :)
>=20
> @Wim: Please apply following patch before this one.

Probably it would be better to keep everything in a single series,
including the above IRQ fixes. It would surely make things easier for
the maintainer and other people who are reviewing the changes you're
making to the driver.

> Here we go:
>=20
> From: Viresh Kumar <viresh.kumar@st.com>
> Date: Mon, 23 Apr 2012 19:39:47 +0530
> Subject: [PATCH] ARM: SMP_TWD: WDOG: Start registers from 0x00 instead =
of
>  0x20
>=20
> TWD_WDOG is at offset 0x20 from TWD base address. Current register offs=
ets
> contain this extra 0x20 offset, i.e. users were required to pass base a=
ddress of
> TWD instead of WDOG to WDOG driver.
>=20
> Change this, so that users can pass base address of WDOG to WDOG driver=
 instead
> of TWD module. For this, subtract 0x20 from offsets of WDOG registers.
>=20
> This could break any current users of TWD_WDOG, but i couldn't find any=
 users of
> this driver in current Linux tree. So, haven't fixed any platform code.=
 If some
> platforms are broken please report to me, so that we can get them fixed=
 in this
> patch only.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/include/asm/smp_twd.h |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_=
twd.h
> index 57857d1..ff3f67e 100644
> --- a/arch/arm/include/asm/smp_twd.h
> +++ b/arch/arm/include/asm/smp_twd.h
> @@ -6,12 +6,17 @@
>  #define TWD_TIMER_CONTROL		0x08
>  #define TWD_TIMER_INTSTAT		0x0C
>=20
> -#define TWD_WDOG_LOAD			0x20
> -#define TWD_WDOG_COUNTER		0x24
> -#define TWD_WDOG_CONTROL		0x28
> -#define TWD_WDOG_INTSTAT		0x2C
> -#define TWD_WDOG_RESETSTAT		0x30
> -#define TWD_WDOG_DISABLE		0x34
> +/*
> + * TWD_WDOG is at offset 0x20 from TWD base address. Following registe=
r offsets
> + * doesn't contain this extra 0x20 offset, i.e. users of TWD_WDOG
> must pass base
> + * address of WDOG to WDOG driver instead of TWD module.
> + */
> +#define TWD_WDOG_LOAD			0x00
> +#define TWD_WDOG_COUNTER		0x04
> +#define TWD_WDOG_CONTROL		0x08
> +#define TWD_WDOG_INTSTAT		0x0C
> +#define TWD_WDOG_RESETSTAT		0x10
> +#define TWD_WDOG_DISABLE		0x14
>=20
>  #define TWD_WDOG_LOAD_MIN		0x00000000
>  #define TWD_WDOG_LOAD_MAX		0xFFFFFFFF
>=20

Now that we made it that far, why not moving the TWD_WDOG_* #defines to
the driver itself? Nobody else should care about it anyway...

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
