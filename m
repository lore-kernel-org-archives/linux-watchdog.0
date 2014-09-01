Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:42656 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbaIAI1T (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Sep 2014 04:27:19 -0400
Received: by mail-qa0-f41.google.com with SMTP id m5so4766677qaj.28
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Sep 2014 01:27:19 -0700 (PDT)
Date: Mon, 1 Sep 2014 09:27:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v2 4/4] mfd: rn5t618: document device tree bindings
Message-ID: <20140901082712.GB7374@lee--X1>
References: <1409403026-28818-1-git-send-email-b.galvani@gmail.com>
 <1409403026-28818-5-git-send-email-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1409403026-28818-5-git-send-email-b.galvani@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 30 Aug 2014, Beniamino Galvani wrote:

> This adds the device tree bindings documentation for Ricoh RN5T618.
>=20
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> Reviewed-by: Mark Brown <broonie@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/rn5t618.txt |   36 +++++++++++=
++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt

Whoops, should have replied to this one instead of the other one
twice.

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Docu=
mentation/devicetree/bindings/mfd/rn5t618.txt
> new file mode 100644
> index 0000000..937785a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
> @@ -0,0 +1,36 @@
> +* Ricoh RN5T618 PMIC
> +
> +Ricoh RN5T618 is a power management IC which integrates 3 step-down
> +DCDC converters, 7 low-dropout regulators, a Li-ion battery charger,
> +fuel gauge, ADC, GPIOs and a watchdog timer. It can be controlled
> +through a I2C interface.
> +
> +Required properties:
> + - compatible: should be "ricoh,rn5t618"
> + - reg: the I2C slave address of the device
> +
> +Sub-nodes:
> + - regulators: the node is required if the regulator functionality i=
s
> +   needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, LDO1,
> +   LDO2, LDO3, LDO4, LDO5, LDORTC1 and LDORTC2.
> +   The common bindings for each individual regulator can be found in=
:
> +   Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +Example:
> +
> +	pmic@32 {
> +		compatible =3D "ricoh,rn5t618";
> +		reg =3D <0x32>;
> +
> +		regulators {
> +			DCDC1 {
> +				regulator-min-microvolt =3D <1050000>;
> +				regulator-max-microvolt =3D <1050000>;
> +			};
> +
> +			DCDC2 {
> +				regulator-min-microvolt =3D <1175000>;
> +				regulator-max-microvolt =3D <1175000>;
> +			};
> +		};
> +	};

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
