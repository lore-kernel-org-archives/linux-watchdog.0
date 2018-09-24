Return-Path: <miquel.raynal@bootlin.com>
Return-path: <miquel.raynal@bootlin.com>
Date: Mon, 24 Sep 2018 11:18:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org, Guenter Roeck
 <linux@roeck-us.net>, Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 1/4] watchdog: Add support for Armada 37xx CPU
 watchdog
Message-ID: <20180924111801.48471d9b@xps13>
In-Reply-To: <20180907130553.14271-2-marek.behun@nic.cz>
References: <20180907130553.14271-1-marek.behun@nic.cz>
	<20180907130553.14271-2-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Marek,

Marek Beh=C3=BAn <marek.behun@nic.cz> wrote on Fri,  7 Sep 2018 15:05:50
+0200:

> This adds support for the CPU watchdog found on Marvell Armada 37xx
> SoCs.
>=20
> There are 4 counters which can be set as CPU watchdog counters.
> This driver uses the second counter (ID 1, counting from 0) as watchdog
> counter, and first counter (ID 0) to implement pinging on the second
> counter without the need to disable it.
>=20
> Since counters IDs 2 and 3 are enabled already before even U-Boot
> starts, this driver does not use them at all, for example by adding a
> device tree property for counter selection.
>=20
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> ---

Sorry for the delay, it took me some time to catchup.

With my EspressoBin:

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
