Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43989 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753221AbaKJOst (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Nov 2014 09:48:49 -0500
Message-ID: <5460CFEF.1090400@free-electrons.com>
Date: Mon, 10 Nov 2014 11:47:11 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 2/3] watchdog: orion: Use the reference clock on Armada
 375 SoC
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com> <1415107293-19258-3-git-send-email-ezequiel.garcia@free-electrons.com> <5460CEB0.7080009@free-electrons.com>
In-Reply-To: <5460CEB0.7080009@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/10/2014 11:41 AM, Gregory CLEMENT wrote:
> Hi Ezequiel,
>=20
> [...]
>=20
>> +static int armada375_wdt_clock_init(struct platform_device *pdev,
>> +				    struct orion_watchdog *dev)
>> +{
>> +	int ret;
>> +
>> +	dev->clk =3D of_clk_get_by_name(pdev->dev.of_node, "fixed");
>> +	if (!IS_ERR(dev->clk)) {
>> +		ret =3D clk_prepare_enable(dev->clk);
>> +		if (ret) {
>> +			clk_put(dev->clk);
>> +			return ret;
>> +		}
>> +
>> +		atomic_io_modify(dev->reg + TIMER_CTRL,
>> +				WDT_AXP_FIXED_ENABLE_BIT,
>> +				WDT_AXP_FIXED_ENABLE_BIT);
>> +		dev->clk_rate =3D clk_get_rate(dev->clk);
>> +
>> +		return 0;
>> +	}
>> +
>> +	/* Mandatory fallback for proper devicetree backward compatibility=
 */
>> +	dev->clk =3D clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(dev->clk))
>> +		return PTR_ERR(dev->clk);
>> +
>> +	ret =3D clk_prepare_enable(dev->clk);
>> +	if (ret) {
>> +		clk_put(dev->clk);
>> +		return ret;
>> +	}
>> +
>> +	atomic_io_modify(dev->reg + TIMER_CTRL,
>> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
>> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
>> +	dev->clk_rate =3D clk_get_rate(dev->clk) / WDT_A370_RATIO;
>> +
>> +	return 0;
>> +}
>=20
> Shouldn't be possible to do the following:
>=20
> static int armada375_wdt_clock_init(struct platform_device *pdev,
> 				    struct orion_watchdog *dev)
> {
> 	if (armadaxp_wdt_clock_init(pdev, dev)) {
> 		/* Mandatory fallback for proper devicetree backward compatibility =
*/
> 		return armadaxp_wdt_clock_init(pdev, dev));

I guess you meant armada370_wdt_clock_init for the fallback?

> 	}
> 	return 0;
> }
>=20
> Actually reusing the armadaxp_wdt_clock_init() function  was also sug=
gested by Thomas
> on your first version but I didn't find your answer about it.
>=20

I replied here to the same objection on the clocksource driver:
http://www.spinics.net/lists/linux-watchdog/msg05318.html

I found that it's a fragile practice, just to save a few lines of code.
Someone can go and change the 370/xp clock init, in some way that's
incompatible with 375.

I guess I'm being paranoid, but it's a way to keep the code robust and
we are only duplicating a few lines.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
