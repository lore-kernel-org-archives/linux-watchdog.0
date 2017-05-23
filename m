Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:42757 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033029AbdEWVZa (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 May 2017 17:25:30 -0400
Subject: Re: [PATCH v2 09/15] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-10-hauke@hauke-m.de>
 <1495445613.3558.67.camel@pengutronix.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <2f809dc7-53c6-ebf9-53c1-466bf34e39db@hauke-m.de>
Date: Tue, 23 May 2017 23:25:25 +0200
MIME-Version: 1.0
In-Reply-To: <1495445613.3558.67.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 11:33 AM, Philipp Zabel wrote:
> Hi Hauke,
>=20
> thank you for the patch. I have a few questions and comments below:
>=20
> On Sun, 2017-05-21 at 15:09 +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>=20
> Does this driver replace arch/mips/lantiq/xway/reset.c?

This serial consists of multiple patches which are all together
replacing this code. The RCU register block does controls multiple
blocks in the SoC. One is the reset controller, but also the GPHY FW
loading and some other unrelated stuff.

>> For some devices the request and the status bits are different.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>  .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  30 +++
>>  drivers/reset/Kconfig                              |   6 +
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-lantiq-rcu.c                   | 201 ++++++++++++=
+++++++++
>>  4 files changed, 238 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu=
-reset.txt
>>  create mode 100644 drivers/reset/reset-lantiq-rcu.c
>>
>> diff --git a/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.=
txt b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>> new file mode 100644
>> index 000000000000..ac57c4a1b191
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>> @@ -0,0 +1,30 @@
>> +Lantiq XWAY SoC RCU reset controller binding
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +This binding describes a reset-controller found on the RCU module on =
Lantiq
>> +XWAY SoCs.
>> +
>> +
>> +---------------------------------------------------------------------=
----------
>> +Required properties (controller (parent) node):
>> +- compatible		: Should be "lantiq,rcu-reset"
>> +- lantiq,rcu-syscon	: A phandle to the RCU syscon, the reset register
>> +			  offset and the status register offset.
>> +- #reset-cells		: Specifies the number of cells needed to encode the
>> +			  reset line, should be 2.
>> +			  The first cell takes the reset set bit and the
>> +			  second cell takes the status bit.
>> +
>> +---------------------------------------------------------------------=
----------
>> +Example for the reset-controllers on the xRX200 SoCs:
>> +	rcu_reset0: rcu_reset {
>=20
> I'd prefer
> 	rcu_reset0: reset-controller {

Ok I will change this

>> +		compatible =3D "lantiq,rcu-reset";
>> +		lantiq,rcu-syscon =3D <&rcu0 0x10 0x14>;
>> +		#reset-cells =3D <2>;
>> +	};
>> +
>> +	rcu_reset1: rcu_reset {
>> +		compatible =3D "lantiq,rcu-reset";
>> +		lantiq,rcu-syscon =3D <&rcu0 0x48 0x24>;
>> +		#reset-cells =3D <2>;
>> +	};
>=20
> I think these should be children of the &rcu0 node. Then you could use
> the reg property to specify the registers.

The problem is that the RCU registers at offset 0x10 and 0x14 also have
bits to indicate what caused the last hardware reset and which boot mode
was selected by putting some pins to low or high level. I want to access
the same register from the watchdog driver and probably form more
positions which do not have anything to do with a reset controller.

> Also, have you considered using a binding like the ti-syscon-reset?=20
> That could remove the need for a rcu_reset node per register pair
> altogether, but might not make sense if the reset registers are densely
> populated.

Would your suggestion be something like this?

rcu_reset0: reset-controller {
	compatible =3D "lantiq,rcu-reset";
	lantiq,rcu-syscon =3D <&rcu0>;
	#reset-cells =3D <2>;
	ti,reset-bits =3D <
		0x48 0x24
		0x10 0x14
	>;
};

I prefer to have two device tree nodes entries for these two register
blocks.

>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index d21c07ccc94e..632e82155590 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -41,6 +41,12 @@ config RESET_IMX7
>>  	help
>>  	  This enables the reset controller driver for i.MX7 SoCs.
>> =20
>> +config RESET_LANTIQ_RCU
>> +	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
>> +	default SOC_TYPE_XWAY
>> +	help
>> +	  This enables the reset controller driver for Lantiq / Intel XWAY S=
oCs.
>> +
>>  config RESET_LPC18XX
>>  	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
>>  	default ARCH_LPC18XX
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 02a74db94339..b19e77847b98 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_RESET_A10SR) +=3D reset-a10sr.o
>>  obj-$(CONFIG_RESET_ATH79) +=3D reset-ath79.o
>>  obj-$(CONFIG_RESET_BERLIN) +=3D reset-berlin.o
>>  obj-$(CONFIG_RESET_IMX7) +=3D reset-imx7.o
>> +obj-$(CONFIG_RESET_LANTIQ_RCU) +=3D reset-lantiq-rcu.o
>>  obj-$(CONFIG_RESET_LPC18XX) +=3D reset-lpc18xx.o
>>  obj-$(CONFIG_RESET_MESON) +=3D reset-meson.o
>>  obj-$(CONFIG_RESET_OXNAS) +=3D reset-oxnas.o
>> diff --git a/drivers/reset/reset-lantiq-rcu.c b/drivers/reset/reset-la=
ntiq-rcu.c
>> new file mode 100644
>> index 000000000000..f24191beed56
>> --- /dev/null
>> +++ b/drivers/reset/reset-lantiq-rcu.c
>> @@ -0,0 +1,201 @@
>> +/*
>> + *  This program is free software; you can redistribute it and/or mod=
ify it
>> + *  under the terms of the GNU General Public License version 2 as pu=
blished
>> + *  by the Free Software Foundation.
>> + *
>> + *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
>> + *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
>> + *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googl=
email.com>
>> + *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
>> + */
>> +
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/of_platform.h>
>> +
>> +#define LANTIQ_RCU_RESET_TIMEOUT	1000000
>> +
>> +struct lantiq_rcu_reset_priv {
>> +	struct reset_controller_dev rcdev;
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	u32 reset_offset;
>> +	u32 status_offset;
>> +};
>> +
>> +static struct lantiq_rcu_reset_priv *to_lantiq_rcu_reset_priv(
>> +	struct reset_controller_dev *rcdev)
>> +{
>> +	return container_of(rcdev, struct lantiq_rcu_reset_priv, rcdev);
>> +}
>> +
>> +static int lantiq_rcu_reset_status(struct reset_controller_dev *rcdev=
,
>> +			     unsigned long id)
>=20
> Please align with the opening parenthesis above, or use consistent
> indentation for broken lines, also in the other cases below.

Will change this

>> +{
>> +	struct lantiq_rcu_reset_priv *priv =3D to_lantiq_rcu_reset_priv(rcde=
v);
>> +	unsigned int status =3D (id >> 8) & 0x1f;
>> +	u32 val;
>> +	int ret;
>> +
>> +	if (status >=3D rcdev->nr_resets)
>> +		return -EINVAL;
>=20
> This should be checked in lantiq_rcu_reset_xlate instead.

Ok will do

>> +	ret =3D regmap_read(priv->regmap, priv->status_offset, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return !!(val & BIT(status));
>> +}
>> +
>> +static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev=
,
>> +				   unsigned long id, bool assert)
>> +{
>> +	struct lantiq_rcu_reset_priv *priv =3D to_lantiq_rcu_reset_priv(rcde=
v);
>> +	int ret, retry =3D LANTIQ_RCU_RESET_TIMEOUT;
>> +	unsigned int set =3D id & 0x1f;
>> +	u32 val;
>> +
>> +	if (set >=3D rcdev->nr_resets)
>> +		return -EINVAL;
>=20
> This should be checked in lantiq_rcu_reset_xlate instead.

Ok will do

>> +	if (assert)
>> +		val =3D BIT(set);
>> +	else
>> +		val =3D 0;
>> +
>> +	ret =3D regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set=
),
>> +				 val);
>> +	if (ret) {
>> +		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
>> +		return ret;
>> +	}
>> +
>> +	do {} while (--retry && lantiq_rcu_reset_status(rcdev, id) !=3D asse=
rt);
>=20
> This ignores errors returned by lantiq_rcu_reset_status. Consider using
> regmap_read_poll_timeout() instead of open-coding the timeout.

Thanks for the hint wil use that function.

>> +	if (!retry) {
>> +		dev_err(priv->dev, "Failed to %s bit %u\n",
>> +			assert ? "assert" : "deassert", set);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int lantiq_rcu_reset_assert(struct reset_controller_dev *rcdev=
,
>> +			     unsigned long id)
>> +{
>> +	return lantiq_rcu_reset_update(rcdev, id, true);
>> +}
>> +
>> +static int lantiq_rcu_reset_deassert(struct reset_controller_dev *rcd=
ev,
>> +			       unsigned long id)
>> +{
>> +	return lantiq_rcu_reset_update(rcdev, id, false);
>> +}
>> +
>> +static int lantiq_rcu_reset_reset(struct reset_controller_dev *rcdev,
>> +			    unsigned long id)
>> +{
>> +	int ret;
>> +
>> +	ret =3D lantiq_rcu_reset_assert(rcdev, id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return lantiq_rcu_reset_deassert(rcdev, id);
>> +}
>> +
>> +static struct reset_control_ops lantiq_rcu_reset_ops =3D {
>=20
> reset_control_ops should be const.

Ok

>> +	.assert =3D lantiq_rcu_reset_assert,
>> +	.deassert =3D lantiq_rcu_reset_deassert,
>> +	.status =3D lantiq_rcu_reset_status,
>> +	.reset	=3D lantiq_rcu_reset_reset,
>> +};
>> +
>> +static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
>> +			       struct lantiq_rcu_reset_priv *priv)
>> +{
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +
>> +	priv->regmap =3D syscon_regmap_lookup_by_phandle(np,
>> +							"lantiq,rcu-syscon");
>=20
> This could be
> 	priv->regmap =3D syscon_node_to_regmap(np->parent);
> if the reset controller device node is a child of the MFD device node.

I will look into this.

>> +	if (IS_ERR(priv->regmap)) {
>> +		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
>> +		return PTR_ERR(priv->regmap);
>> +	}
>> +
>> +	if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
>> +		&priv->reset_offset)) {
>> +		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 2,
>> +		&priv->status_offset)) {
>> +		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int lantiq_rcu_reset_xlate(struct reset_controller_dev *rcdev,
>> +				  const struct of_phandle_args *reset_spec)
>> +{
>> +	unsigned int status, set;
>> +
>> +	set =3D reset_spec->args[0];
>> +	status =3D reset_spec->args[1];
>=20
> Check that set and status are valid here.

Will do this.

>> +	return (status << 8) | set;
>> +}
>> +
>> +static int lantiq_rcu_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct lantiq_rcu_reset_priv *priv;
>> +	int err;
>> +
>> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->dev =3D &pdev->dev;
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	err =3D lantiq_rcu_reset_of_probe(pdev, priv);
>> +	if (err)
>> +		return err;
>> +
>> +	priv->rcdev.ops =3D &lantiq_rcu_reset_ops;
>> +	priv->rcdev.owner =3D THIS_MODULE;
>> +	priv->rcdev.of_node =3D pdev->dev.of_node;
>> +	priv->rcdev.nr_resets =3D 32;
>> +	priv->rcdev.of_xlate =3D lantiq_rcu_reset_xlate;
>> +	priv->rcdev.of_reset_n_cells =3D 2;
>> +
>> +	err =3D reset_controller_register(&priv->rcdev);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
>=20
> You can just
> 	return reset_controller_register(&priv->rcdev);
> here.

Yes

>> +}
>> +
>> +static const struct of_device_id lantiq_rcu_reset_dt_ids[] =3D {
>> +	{ .compatible =3D "lantiq,rcu-reset", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, lantiq_rcu_reset_dt_ids);
>> +
>> +static struct platform_driver lantiq_rcu_reset_driver =3D {
>> +	.probe	=3D lantiq_rcu_reset_probe,
>> +	.driver =3D {
>> +		.name		=3D "lantiq-rcu-reset",
>> +		.of_match_table	=3D lantiq_rcu_reset_dt_ids,
>> +	},
>> +};
>> +module_platform_driver(lantiq_rcu_reset_driver);
>> +
>> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.co=
m>");
>> +MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
>> +MODULE_LICENSE("GPL");
>=20
> regards
> Philipp
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
