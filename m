Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBA35AC33;
	Wed, 12 Aug 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521314; cv=none; b=enQjIcjzYGaIbNKqGwrRg4LcVPKWQ+IAdu73tuI8vhF0N8F4moJu1wIfMJgNXpLERCKRfeJrN0PbYFJx6e4ZXD5sQ5kZorIOXcNat1ttuM6VAMSbleB4ZsdUYTpoAQ8cnG5Cwp5ZOwgTvcLb3T4WIr+Ap396sS9B96c78ViTChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521314; c=relaxed/simple;
	bh=Rx2CBw3K4esUxEFsvi6dLQvfnPkfbTyer+svNHeYM74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RO1wDOIPoJXiPXNRDfFjFBLLCDTGAZBv+ZIPipp5KbjmSRHU67LnJ6bz02po25avJ2eP/qAuiMhFAVJer+0T/I2/tQVyvh8avLACVoDvoIs1yb4vpOHSTbyu0wpcWyQBEvfeS4unTcAUZUvZiuZbkhUvUyyKGAl477L6DoP6PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PorX8XIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PorX8XIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F541F000E9;
	Wed, 12 Aug 2026 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521311;
	bh=A3fyBnfXz5RP3rFdjgVSA9oIgGkbKLmM1VlG3sZaiVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PorX8XIK4LIyr3y2IfTXOpBdsTvUe7CFjQ/noy1NMxqAKWZhTeJWtiqQRvyEvdKuK
	 sCmk98QwoSbUsJfoPH0T2GsQ4e++ikAzEgeUyIOKdz4B3psJJpdcTkkXB3ypkeetkq
	 rb+ceY9GLfXYODIj180n2LsTsStBuPjDTyvs7W/s8me32qupkAkmVGF7m3V/916UGa
	 jkKT+BdpJW1Kujz/lpG3pq7bsfvPvbFn1gPRHtUY0QViJ0VPUZSN8Wyno86n4ZI37b
	 fgaZFsdkFBKeeDHMbFBJYqe1L+hiMyEsRYcFDHl4vOa6dvBFHk9Fqb2mIfnIE4mQ6/
	 n8qhWDW1WnFhg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v4 2/5] rtc: pcf85363: support reporting battery
 switch-over via RTC_VL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260812074533.3545058-2-lakshay.piplani@nxp.com>
References: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
 <20260812074533.3545058-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:55:10 +0000
Message-Id: <20260812075511.42F541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The IRQ handler silently clears the Battery Switch-over Flag (BS=
F) from the hardware register without saving its state, causing battery swi=
tch-over events to be lost if an interrupt triggers before userspace calls =
RTC_VL_READ.

Pre-existing issues:
- [High] `pcf85363_probe()` unconditionally wipes the `CTRL_FLAGS` register=
, destroying boot-time battery switch-over events before they can be read v=
ia `RTC_VL_READ`.
--

--- Patch [2]: [RESEND v4 2/5] rtc: pcf85363: support reporting battery swi=
tch-over via RTC_VL ---
commit 641bd03440f1f0094b5ca119b02a17fb2dd848b5
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: support reporting battery switch-over via RTC_VL

Add battery switch-over reporting for PCF85263/PCF85363 using the standard
RTC_VL_* ioctl interface. When the backup supply takes over, the BSF flag
is exposed to userspace through RTC_VL_READ and can be cleared using
RTC_VL_CLR.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 540042b9eec8f..c03d5a65c5f79 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -295,23 +296,67 @@ static int pcf85363_rtc_set_alarm(struct device *de=
v, struct rtc_wkalrm *alrm)
>  static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
>  {
>  	struct pcf85363 *pcf85363 =3D i2c_get_clientdata(dev_id);
> +	bool handled =3D false;
>  	unsigned int flags;
>  	int err;
> =20
>  	err =3D regmap_read(pcf85363->regmap, CTRL_FLAGS, &flags);
> +
>  	if (err)
>  		return IRQ_NONE;
> =20
> +	if (flags) {
> +		dev_dbg(&pcf85363->rtc->dev, "IRQ flags: 0x%02x%s%s\n",
> +			flags, (flags & FLAGS_A1F) ? " [A1F]" : "",
> +			(flags & FLAGS_BSF) ? " [BSF]" : "");
> +	}
> +
>  	if (flags & FLAGS_A1F) {
>  		rtc_update_irq(pcf85363->rtc, 1, RTC_IRQF | RTC_AF);
>  		regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_A1F, 0);
> -		return IRQ_HANDLED;
> +		handled =3D true;
>  	}
> =20
> -	return IRQ_NONE;
> +	if (flags & FLAGS_BSF) {
> +		regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_BSF, 0);
> +		handled =3D true;
> +	}

[Severity: Medium]
Does this unconditionally clear the hardware Battery Switch-over Flag (BSF)
without saving its state?

If an interrupt triggers before userspace calls RTC_VL_READ, won't the
battery switch-over event be lost since the hardware flag is cleared but not
cached in software?

> +
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int pcf85363_rtc_ioctl(struct device *dev,
> +			      unsigned int cmd, unsigned long arg)
> +{
> +	struct pcf85363 *pcf85363 =3D dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ: {
> +		u32 status =3D 0;
> +
> +		ret =3D regmap_read(pcf85363->regmap, CTRL_FLAGS, &val);

[Severity: Medium]
Because RTC_VL_READ reads directly from the hardware register, it will retu=
rn
0 if the IRQ handler has already cleared the flag.

> +
> +		if (ret)
> +			return ret;
> +
> +		if (val & FLAGS_BSF)
> +			status |=3D RTC_VL_BACKUP_SWITCH;
> +
> +		return put_user(status, (u32 __user *)arg);
> +	}
> +
> +	case RTC_VL_CLR:
> +		return regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_BSF, 0);
> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the pre-existing code
in pcf85363_probe() appears to break the boot-time power loss detection
intended by this new feature.

During system boot, pcf85363_probe() unconditionally clears all hardware fl=
ags
if an IRQ or wakeup source is configured:

drivers/rtc/rtc-pcf85363.c:pcf85363_probe() {
    ...
	if (client->irq > 0 || wakeup_source) {
		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
	}
    ...
}

Does this destroy the battery switch-over event before userspace can query =
it
with RTC_VL_READ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812074533.3545=
058-1-lakshay.piplani@nxp.com?part=3D2
