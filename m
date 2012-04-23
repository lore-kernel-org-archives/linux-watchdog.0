Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46185 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2DWQM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 12:12:28 -0400
Message-ID: <4F957F62.5090605@arm.com>
Date: Mon, 23 Apr 2012 17:12:18 +0100
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
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com> <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com> <4F9514AA.10403@arm.com> <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com> <4F9547E3.4000709@arm.com> <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com> <4F9573B8.9050607@arm.com> <CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com> <4F957A0C.7060607@arm.com> <CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com>
In-Reply-To: <CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 23/04/12 17:01, viresh kumar wrote:
> On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> The TWD watchdog uses a per-cpu interrupt (usually interrupt #30), and
>> the GIC configuration should flag it as such. With this setup,
>> request_irq() should fail, and the right API is request_percpu_irq(),
>> together with enable_percpu_irq()/disable_percpu_irq().
>=20
> request_irq() doesn't fail for me even if i pass it.

Well, it definitely should. Can you share the relevant part of your DT?

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
