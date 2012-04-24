Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49712 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab2DXLs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Apr 2012 07:48:57 -0400
Message-ID: <4F969321.1090406@arm.com>
Date: Tue, 24 Apr 2012 12:48:49 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@st.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	spear-devel <spear-devel@list.st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>
Subject: Re: [PATCH V3 2/2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
References: <31b0b89e21e6a234cb904761a1d0e5106405da82.1335246446.git.viresh.kumar@st.com> <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com> <4F9671D8.4080308@arm.com> <4F9681D4.9010904@st.com>
In-Reply-To: <4F9681D4.9010904@st.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 24/04/12 11:35, Viresh Kumar wrote:
> On 4/24/2012 2:56 PM, Marc Zyngier wrote:
>> I'm sorry, but I really have to ask: What is the point of adding DT
>> support to this driver when it is obvious that it is already broken?
>=20
> Interrupt is only for testing. And that's why it worked for me earlier,
> as i didn't passed irq from DT.
>=20
> So, i believe this patch still makes sense. Obviously we can have anoth=
er
> patch to get interrupts fixed.

That's exactly what I object to. You're giving a false sense of
usability ("see, this driver is maintained, it even has DT support!"),
while the damn thing has not worked for quite a long time. And I don't
mean only the interrupt. The driver is not working properly on an SMP
system.

At that point, and unless someone is willing to step up and fix it, I'd
rather make it depend on CONFIG_BROKEN.

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
