Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8A427FB0;
	Tue, 15 Sep 2026 03:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444507; cv=none; b=J4Dq9013YIxttqrftBMpN8HlMnrRXvMkiKuFiDyldqB/0l3/j/8CTUXjs/QCH8xzqKeKK52NW+EWeUwE4fMO3b0tFOlHjR2gb3l0rKExRnBv5+yBAtUeMbMBHwi5mLjTDC/GLrHSuV4Ekqmokw0M1EnWwwK0MGhjC5BhMKswC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444507; c=relaxed/simple;
	bh=vsw1D1MYaWnP1qm6WIOKh9eV1j/Xz9qu7BqL1Bo880o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ah+jsNkcQfbeQb9mkBrKmNN/HHn+THLN7MiN1R0UNaasCcMH0SXoaKCSlQz9+PsuZZ41rn1whd2OcEqpTAISfg4fkUExPi4OP1Qrb1nm13CdHxaniP7ZTPWPaLIgeWpruKlqRxYdtXMen8D6J+4jQY9LW5MIfrjU/SKjyTdx2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKhTPZHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKhTPZHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC211F000FF;
	Tue, 15 Sep 2026 03:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789444505;
	bh=0LhWowadj20bo+UmDvFA3C5bZ1PuHQynBhj4oC/cNAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKhTPZHFJ9Dpr1yjaFeX8/nnzJXyudUqcoEZjQV0+zaUKL4PwpZHsY48M6OTvhNyW
	 N8c9ZkxmBK1dnlt/uQ+6TbawLOMqy88w0d/EGp/zHUtCxm8onIiHO0OXj4482+DqF0
	 AuJzSmr3jY/ieOdgO7Lgujq1xmH2+KVDp6h6yEK6C8Wl0xzGbibwLNgQ077hhAf9nG
	 HB1lnfSOyTdxgwLZw76LmvnSk1CbY9hGUELIAIhDuL2VLLXBD4Glq4aadGDb0mACux
	 3YZF/P551UomvtgXYluzKVmOBvSqMS03Zf2LRs5r2Vo3oinlkhS5NPJ61waHa5MHLV
	 pw7d3XxU8fzYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] rtc: pcf85363: add timestamp support with
 configurable timestamp mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260915034452.4086683-3-lakshay.piplani@nxp.com>
References: <20260915034452.4086683-1-lakshay.piplani@nxp.com>
 <20260915034452.4086683-3-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:55:04 +0000
Message-Id: <20260915035504.9FC211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rtc: pcf85363: uninitialized ts_last_event state when DT property =
is missing
- [High] rtc: pcf85363: incorrect TSR3_SHIFT misconfigures hardware
- [High] rtc: pcf85363: GENMASK used as value misconfigures TS pin mode
--

commit f0ef4cbc1465704e262d43ce6c2e731b6a23a590
Author: Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: rtc: pcf85363: add timestamp support with configurable timestamp m=
ode

Add support for the timestamp capture registers on PCF85263/PCF85363,
which latch the time on selected events (TS pin or battery switch-over).
The capture source is selected via the nxp,timestamp-mode device tree
property and latched values are exported through read-only sysfs
attributes.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 00f37ffcca260..ef846dd231a04 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -102,22 +109,50 @@
>  #define PIN_IO_INTA_OUT	2
>  #define PIN_IO_INTA_HIZ	3
> =20
> +#define PIN_IO_TSPM     GENMASK(3, 2)
> +#define PIN_IO_TSIM     BIT(4)
> =20
>  #define OSC_CAP_SEL	GENMASK(1, 0)
>  #define OSC_CAP_6000	0x01
>  #define OSC_CAP_12500	0x02
> =20
>  #define STOP_EN_STOP	BIT(0)
> =20
> +#define RTCM_BIT        BIT(4)
> =20
>  #define RESET_CPR	0xa4
> =20
>  #define NVRAM_SIZE	0x40
> =20
> +#define TSR1_MASK       0x03
> +#define TSR2_MASK       0x07
> +#define TSR3_MASK       0x03
> +#define TSR1_SHIFT      0
> +#define TSR2_SHIFT      2
> +#define TSR3_SHIFT      6

[Severity: High]
Is TSR3_SHIFT correct here? The DT_TS_MODE register uses bits 7:5 for TSR3,
so the shift should be 5. Shifting by 6 maps the value to bits 7:6, corrupt=
ing
the TSR3 configuration when written to the hardware.

[ ... ]
> @@ -539,29 +761,72 @@ static int pcf85363_probe(struct i2c_client *client)
>  			.reg_write =3D pcf85363_nvram_write,
>  		},
>  	};
> =20
>  	if (data)
>  		config =3D data;
> =20
> -	pcf85363 =3D devm_kzalloc(&client->dev, sizeof(struct pcf85363),
> -				GFP_KERNEL);
> +	pcf85363 =3D devm_kzalloc(&client->dev, sizeof(*pcf85363), GFP_KERNEL);
>  	if (!pcf85363)
>  		return -ENOMEM;
> =20
[ ... ]
> +	if (!device_property_read_u32_array(dev, "nxp,timestamp-mode", tsr_mode=
, 3)) {

[Severity: High]
Can this result in an uninitialized ts_last_event state?

If the "nxp,timestamp-mode" property is missing from the device tree, this
block is skipped and pcf85363_classify_ts_modes() is never called. This lea=
ves
ts_last_event as false (from kzalloc).

If the hardware was pre-configured to a last-event mode by a bootloader, the
driver will treat it as a first-event mode, bypassing the stable-read retry
loop and exposing userspace to torn reads.

> +		bool ts_pin_used;
> +
> +		tsr_mode[0] &=3D TSR1_MASK;
> +		tsr_mode[1] &=3D TSR2_MASK;
> +		tsr_mode[2] &=3D TSR3_MASK;
> +
> +		val =3D (tsr_mode[2] << TSR3_SHIFT) |
> +		      (tsr_mode[1] << TSR2_SHIFT) |
> +		      (tsr_mode[0] << TSR1_SHIFT);
> +
> +		ret =3D regmap_write(pcf85363->regmap, DT_TS_MODE, val);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to write timestamp mode register\n");
> +
> +		pcf85363_classify_ts_modes(pcf85363, val);
> +
> +		ts_mode_configured =3D tsr_mode[0] || tsr_mode[1] || tsr_mode[2];
> +
> +		/*
> +		 * Only the TS-pin capture modes drive the TS pin. Select the
> +		 * timestamp function (TSPM) for those and leave the input mode
> +		 * (TSIM) at its reset default rather than forcing the
> +		 * mechanical-switch detector.
> +		 */
> +		ts_pin_used =3D tsr_mode[0] =3D=3D PCF85363_TSR1_FE ||
> +			      tsr_mode[0] =3D=3D PCF85363_TSR1_LE ||
> +			      tsr_mode[1] =3D=3D PCF85363_TSR2_FE ||
> +			      tsr_mode[1] =3D=3D PCF85363_TSR2_LE;
> +
> +		if (ts_pin_used) {
> +			ret =3D regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> +						 PIN_IO_TSPM, PIN_IO_TSPM);

[Severity: High]
Does this misconfigure the TS pin mode?

PIN_IO_TSPM evaluates to 0x0C (binary 11 in bits 3:2). Using it as both the
mask and the value to regmap_update_bits() sets bits 3:2 to 11, which
configures the pin as an output according to the datasheet.

To capture timestamps from external events, shouldn't the TS pin be configu=
red
as an input (mode 10)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915034452.4086=
683-1-lakshay.piplani@nxp.com?part=3D3
