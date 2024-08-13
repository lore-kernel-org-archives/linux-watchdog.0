Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57C1A0709;
	Tue, 13 Aug 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565397; cv=none; b=NhomI+vwml7EFGMIkIeWUhirIN6vtIlGUx89KG6oUu+cjwpwHmrneXE3RpTAnqKaas+rwgXPYwsC4FisBxmW/1MzEk6o7kDtYbcUOxR7Ln6y89FfZpYptMZjLNZXklvwTaL+YTqczY3p5CzWnFwEYomLRHAV9IuVYVp72abnw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565397; c=relaxed/simple;
	bh=etiP4ivdDC0Q6QNfnYXdJZaBIBDYlEpcghlgNInR8kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZbfLDV/N5mSm4/xmOH8XSE75K/eMk0DI5Zc6BCinS6/IpNAp0mvZSSomc5xP980ROKT9Un0l97dtuak3oHJehlmvqWAbVRPGyRZi1qQVvePkG7wetb0AZT5REn/fJePlnU/W923ZW26YkFc45S9AjG/ZSveTtXnFU8q9ukXcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArPwd28v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArPwd28v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA82C4AF09;
	Tue, 13 Aug 2024 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723565397;
	bh=etiP4ivdDC0Q6QNfnYXdJZaBIBDYlEpcghlgNInR8kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArPwd28vZ33Q5aiHtxp1kd590z7VgE7e1NCh9npjKMl9tZ1Sic+kVWUUSeiQaig2g
	 n4L2Cw1+ZCch63NzRfnjL6f9QUM4o/KcRdbkBx2Rrzx9wELLZfGVyPjE/sFkE1sKMu
	 VeLWu7d6zGdSCJmoTB7dBMK/E9OHyP0mz27gX9QmXogfztedYzIe0aderXKDJiZeD8
	 yUKftRlZMQZS2TW5tnRFlQNyU0pR1iaNHD/+N8AwykkH69JUdgPowql0d8TtyOeff1
	 jGfgGI6cf4obtEHPzag4FXaz3hytrpSxijNQqc+8c0Wi/Iu5q1MY3Ir36hX/GoXXu8
	 ZdX0gfhNkhmXg==
Date: Tue, 13 Aug 2024 17:09:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: watchdog: convert ziirave-wdt.txt to
 yaml
Message-ID: <20240813-trodden-paprika-b2c95d1d265d@spud>
References: <20240812162810.3812802-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AQLZFFmAfzrtOTaF"
Content-Disposition: inline
In-Reply-To: <20240812162810.3812802-1-Frank.Li@nxp.com>


--AQLZFFmAfzrtOTaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:28:09PM -0400, Frank Li wrote:
> Convert ziirave-wdt.txt to yaml format.
>=20
> Additional change:
> - Add i2c node in example.
> - Add ref to watchdog.yaml
>=20
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800=
000/i2c@30a40000/watchdog@38:
> 	failed to match any schema with compatible: ['zii,rave-wdt']
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add ref watchdog.yaml
> - Remove timeout-sec
> ---
>  .../bindings/watchdog/zii,rave-wdt.yaml       | 47 +++++++++++++++++++
>  .../bindings/watchdog/ziirave-wdt.txt         | 19 --------
>  2 files changed, 47 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-w=
dt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ziirave-wd=
t.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/zii,rave-wdt.yaml=
 b/Documentation/devicetree/bindings/watchdog/zii,rave-wdt.yaml
> new file mode 100644
> index 0000000000000..0206d9ddf872d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/zii,rave-wdt.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/zii,rave-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zodiac RAVE Watchdog Timer
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>

When you're converting bindings, listing yourself as the maintainer only
really makes sense if you know/care about the hardware IMO.

> +
> +properties:
> +  compatible:
> +    const: zii,rave-wdt
> +
> +  reg:
> +    maxItems: 1
> +    description: i2c slave address of device, usually 0x38
> +
> +  reset-duration-ms:
> +    description:
> +      Duration of the pulse generated when the watchdog times
> +      out. Value in milliseconds.
              ^^^^^^^^^^^^^^^^^^^^^
This is obvious, and could have been dropped. Keep an eye out for things
like that while doing conversions.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        watchdog@38 {
> +            compatible =3D "zii,rave-wdt";
> +            reg =3D <0x38>;
> +            timeout-sec =3D <30>;
> +            reset-duration-ms =3D <30>;
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt b=
/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> deleted file mode 100644
> index 3d878184ec3ff..0000000000000
> --- a/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Zodiac RAVE Watchdog Timer
> -
> -Required properties:
> -- compatible: must be "zii,rave-wdt"
> -- reg: i2c slave address of device, usually 0x38
> -
> -Optional Properties:
> -- timeout-sec: Watchdog timeout value in seconds.
> -- reset-duration-ms: Duration of the pulse generated when the watchdog t=
imes
> -  out. Value in milliseconds.
> -
> -Example:
> -
> -	watchdog@38 {
> -		compatible =3D "zii,rave-wdt";
> -		reg =3D <0x38>;
> -		timeout-sec =3D <30>;
> -		reset-duration-ms =3D <30>;
> -	};
> --
> 2.34.1
>=20
>=20

--AQLZFFmAfzrtOTaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZruFUAAKCRB4tDGHoIJi
0lUwAP4kUZkvMFonhZbuNpnrd6wekgNLyHVLIfWn2GVMJyK1VwD9E1Xo9+df9amP
iRLPPUJ6PCLE+9TLGf6oo2YbXkcp7A0=
=JvS/
-----END PGP SIGNATURE-----

--AQLZFFmAfzrtOTaF--
