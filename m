Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38473 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab2DWMPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 08:15:38 -0400
Message-ID: <4F9547E3.4000709@arm.com>
Date: Mon, 23 Apr 2012 13:15:31 +0100
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
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com> <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com> <4F9514AA.10403@arm.com> <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
In-Reply-To: <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 23/04/12 12:35, viresh kumar wrote:
> On Mon, Apr 23, 2012 at 2:06 PM, Marc Zyngier <marc.zyngier@arm.com> wr=
ote:
>> Irk! Have you actually tested this?
>=20
> Yes. But with incorrect base address. I passed timers address by mistak=
e.

Ah, that explains why it worked. I suppose you do have additional
patches that fix the IRQ request bit?

>> The DT binding indicates:
>> - reg : Specify the base address and the size of the TWD watchdog
>>        register window.
>>
>> while all the offsets in smp_twd.h are expressed in bytes from the TWD
>> *timer* base. So you have to either fix these offsets (which breaks
>> potential users of the non-DT version of the driver), or correct the
>> base when using DT.
>=20
> You are correct. Which one do you prefer:
> - Change bindings to pass timers base address

No. We already discussed this on LAK, and the outcome was the current
binding, so let's not change that again.

> - subtract 0x20 from base address for DT case

That's a possibility.

> - something else.

Given that no in-tree platform seem to be using this watchdog (at least
a quick grep didn't reveal anything), I'd be inclined to simply change
the offset in smp_twd.h and let them break.

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
