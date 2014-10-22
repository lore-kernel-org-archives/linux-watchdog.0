Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53712 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753594AbaJVPaq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 11:30:46 -0400
Message-ID: <5447CCEA.7010109@free-electrons.com>
Date: Wed, 22 Oct 2014 12:27:38 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 4/4] ARM: dts: Enable the reference clock for timer and
 watchdog on Armada 375 SoC
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com> <20141022155510.5fee5f8e@free-electrons.com>
In-Reply-To: <20141022155510.5fee5f8e@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2014 10:55 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
>=20
> On Wed, 22 Oct 2014 10:34:44 -0300, Ezequiel Garcia wrote:
>=20
>> -				clocks =3D <&coreclk 0>;
>> +				clocks =3D <&refclk>;
>> +				clock-names =3D "fixed";
>=20
> Why not do like we do on Armada XP, and actually represent the
> hardware, by showing that it takes two clocks as input:
>=20

Yes, I guess that would work.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
