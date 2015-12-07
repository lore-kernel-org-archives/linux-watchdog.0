Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34312 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650AbbLGJkY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Dec 2015 04:40:24 -0500
Received: by wmvv187 with SMTP id v187so157368099wmv.1
        for <linux-watchdog@vger.kernel.org>; Mon, 07 Dec 2015 01:40:23 -0800 (PST)
Date: Mon, 7 Dec 2015 09:40:20 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v7 2/6] mfd: syscon: add a DT property to set value width
Message-ID: <20151207094020.GF3384@x1>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448899191-13891-3-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1448899191-13891-3-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 30 Nov 2015, Damien Riegel wrote:

> Currently syscon has a fixed configuration of 32 bits for register an=
d
> values widths. In some cases, it would be desirable to be able to
> customize the value width.
>=20
> For example, certain boards (like the ones manufactured by Technologi=
c
> Systems) have a FPGA that is memory-mapped, but its registers are onl=
y
> 16-bit wide.
>=20
> This patch adds an optional "reg-io-width" DT binding for syscon that
> allows to change the width for the data bus (i.e. val_bits). If this
> property is provided, it will also set the register stride to
> reg-io-width's value. If not provided, the default configuration is
> used.
>=20
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.txt |  4 ++++
>  drivers/mfd/syscon.c                             | 13 +++++++++++++
>  2 files changed, 17 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Docum=
entation/devicetree/bindings/mfd/syscon.txt
> index fe8150b..408f768 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> @@ -13,6 +13,10 @@ Required properties:
>  - compatible: Should contain "syscon".
>  - reg: the register region can be accessed from syscon
> =20
> +Optional property:
> +- reg-io-width: the size (in bytes) of the IO accesses that should b=
e
> +  performed on the device.
> +
>  Examples:
>  gpr: iomuxc-gpr@020e0000 {
>  	compatible =3D "fsl,imx6q-iomuxc-gpr", "syscon";
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 176bf0f..b7aabee 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct dev=
ice_node *np)
>  	struct syscon *syscon;
>  	struct regmap *regmap;
>  	void __iomem *base;
> +	u32 reg_io_width;
>  	int ret;
>  	struct regmap_config syscon_config =3D syscon_regmap_config;
> =20
> @@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct de=
vice_node *np)
>  	 else if (of_property_read_bool(np, "little-endian"))
>  		syscon_config.val_format_endian =3D REGMAP_ENDIAN_LITTLE;
> =20
> +	/*
> +	 * search for reg-io-width property in DT. If it is not provided,
> +	 * default to 4 bytes. regmap_init_mmio will return an error if val=
ues
> +	 * are invalid so there is no need to check them here.
> +	 */
> +	ret =3D of_property_read_u32(np, "reg-io-width", &reg_io_width);
> +	if (ret)
> +		reg_io_width =3D 4;
> +
> +	syscon_config.reg_stride =3D reg_io_width;
> +	syscon_config.val_bits =3D reg_io_width * 8;
> +
>  	regmap =3D regmap_init_mmio(NULL, base, &syscon_config);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
