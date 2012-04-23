Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:51999 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab2DWQ03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 12:26:29 -0400
Message-ID: <4F9582AF.6040501@arm.com>
Date: Mon, 23 Apr 2012 17:26:23 +0100
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
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com> <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com> <4F9514AA.10403@arm.com> <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com> <4F9547E3.4000709@arm.com> <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com> <4F9573B8.9050607@arm.com> <CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com> <4F957A0C.7060607@arm.com> <CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com> <4F957F62.5090605@arm.com> <CAOh2x=n4JdZdZoofHpr+9G254ZL_kxyWEHHRr5W4PB4GgjeHsQ@mail.gmail.com>
In-Reply-To: <CAOh2x=n4JdZdZoofHpr+9G254ZL_kxyWEHHRr5W4PB4GgjeHsQ@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 23/04/12 17:16, viresh kumar wrote:
> On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Well, it definitely should. Can you share the relevant part of your DT=
?
>=20
> I Just tested it once, and will do it tomorrow again.
>=20
> 			wdt@ec800620 {
> 				compatible =3D "arm,cortex-a9-twd-wdt";
> 				reg =3D <0xec800620 0x20>;
> 				interrupts =3D <1 14 0x301>;
> 				status =3D "disabled";
> 			};
>=20
> Looking at your confidence, i am starting to feel, i am wrong here ;)

Well, having written the code that ensures request_irq() fails when
passed a PPI, I'd be very worried if the above started to be working... ;=
-)

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
