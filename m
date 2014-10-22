Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53603 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752745AbaJVPZH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 11:25:07 -0400
Message-ID: <5447CBAF.2000602@free-electrons.com>
Date: Wed, 22 Oct 2014 12:22:23 -0300
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
Subject: Re: [PATCH 3/4] clocksource: armada-370-xp: Use the reference clock
 on A375 SoC
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<1413984884-20273-4-git-send-email-ezequiel.garcia@free-electrons.com> <20141022155410.0cc36e4c@free-electrons.com>
In-Reply-To: <20141022155410.0cc36e4c@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2014 10:54 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
>=20
> On Wed, 22 Oct 2014 10:34:43 -0300, Ezequiel Garcia wrote:
>=20
>> +static void __init armada_375_timer_init(struct device_node *np)
>> +{
>> +	struct clk *clk;
>> +
>> +	clk =3D of_clk_get_by_name(np, "fixed");
>> +	if (!IS_ERR(clk)) {
>> +		clk_prepare_enable(clk);
>> +		timer_clk =3D clk_get_rate(clk);
>> +	} else {
>> +
>> +		/*
>> +		 * This fallback is required in order to retain proper
>> +		 * devicetree backwards compatibility.
>> +		 */
>> +		clk =3D of_clk_get(np, 0);
>> +
>> +		/* Must have at least a clock */
>> +		BUG_ON(IS_ERR(clk));
>> +		clk_prepare_enable(clk);
>> +		timer_clk =3D clk_get_rate(clk) / TIMER_DIVIDER;
>> +		timer25Mhz =3D false;
>> +	}
>=20
> Maybe we could re-use a bit more existing code, don't know if it make=
s
> things clearer though:
>=20
> 	clk =3D of_clk_get_by_name(np, "fixed");
> 	if (!IS_ERR(clk))
> 		armada_xp_timer_init(np);
> 	else
> 		armada_370_timer_init(np);
>=20

Yeah, I thought about this option, but chosen to implement it explicitl=
y.

The reason is that I wanted to make sure we had a sane backward
compatibility fallback, which is specifically crafted for A375.

By re-using the 370 and XP, we are exposed to someone changing the
armada_xp_timer_init() thinking it will only affect AXP, which might
break things for A375.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
