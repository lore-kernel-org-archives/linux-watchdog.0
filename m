Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6643932D8;
	Mon, 22 Jun 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117769; cv=none; b=D653V6w8yd/yGX5QU/EpfQHD5FkSfSPf471HmF0QUyb1oPK1+xzTOrl2+2i4+69P0yxhkFO2N1VPXXzqB9OuJssKBnsH1i1AaKhbPYcerrpWOO3xJStEM7ioEporVTh4EujdJgwjWS4GCiHe3YF4KkF5f/jU+PL+dLHuXPCgHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117769; c=relaxed/simple;
	bh=NoIkgHjmiX4KCOnXdO+bozw96BGxwWSTYJxUK1g+uak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPv1JjhmVcvt+vmvZAT7rox/YzEXGhEMk5VElT8PVObv5YxB9RNXmCTuv6X6e7GExm/YBraXAOidArNsn7+OMzqRuOchtogFQWglbJb5CkLdVCbiFoG9hcFtPdcYReJUiZizy5znvfgiSwMN5UPsrUYKwxnkdT+QQuL1RsJiepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/t0jXdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/t0jXdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A91F00ADF;
	Mon, 22 Jun 2026 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782117767;
	bh=+Gp76w+0+T8PWIg87+yLuN/MbpfjdvEty2/M9YOxick=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/t0jXdDV6EUOYb6y5FcXqKGsOM55HhS8lUkoFmQXTx+8OuPaS7A6fhZxlJ0iemiC
	 j9CfGAxvJHz6UGLJgcrJ8jUSPXIzX8rCoviQ+wCSmSa0fsYtgclEzVy0hn1ePmavoW
	 9QQtpHuLOAEcJH1lvSoOEs/q28scVtcM77jLVF4IJ/jfhidrtZPfeNaBKbj2O8O+Gb
	 bDxzSDkLd8wq8YZSRgHsraelTLNxn2I/Gz/ll4Rb1HoA4huN4Sok/GXIZmpoMbgpXA
	 nYJEnNplem4vBMJOmy2x9OheLy0EDoHP0s4dkwBnHq3Sxr8Y/lt7jj1q84dBQFPqCD
	 zc65byleTaC6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] watchdog: npcm: add bootstatus support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomer Maimon" <tmaimon77@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260622083046.3189603-4-tmaimon77@gmail.com>
References: <20260622083046.3189603-1-tmaimon77@gmail.com>
 <20260622083046.3189603-4-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:42:46 +0000
Message-Id: <20260622084246.D01A91F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The first watchdog instance on NPCM750 clears the global RESSR reg=
ister without caching it, causing subsequent watchdog instances to permanen=
tly lose their reset status.
- [High] Non-atomic read-modify-write of the shared INTCR2 register clobber=
s concurrent modifications and incorrectly handles W1C semantics.
--

commit dafe1267618ef0158376caf5f3acee9d7fe7b1b7
Author: Tomer Maimon <tmaimon77@gmail.com>

watchdog: npcm: add bootstatus support

The NPCM750 uses RESSR and the NPCM845 uses INTCR2 to latch reset
indications. Read those bits during probe and map them into watchdog
bootstatus flags.

> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index e62ea054bc618..98660419ec3f0 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
[ ... ]
> @@ -169,6 +250,92 @@ static bool npcm_is_running(struct watchdog_device *=
wdd)
>  	return readl(wdt->reg) & NPCM_WTE;
>  }
> =20
> +static void npcm_get_reset_status(struct npcm_wdt *wdt, struct device *d=
ev,
> +				  const struct npcm_wdt_data *data,
> +				  resource_size_t start)
> +{
[ ... ]
> +	if (of_device_is_compatible(dev->of_node, "nuvoton,npcm845-wdt")) {
> +		ret =3D regmap_read(gcr_regmap, NPCM_INTCR2_OFFSET, &rstval);
> +		if (ret) {
> +			dev_warn(dev, "Failed to read INTCR2 reset status: %d\n",
> +				 ret);
> +			return;
> +		}
> +
> +		if (rstval & NPCM8XX_RST) {
> +			ret =3D regmap_write(gcr_regmap, NPCM_INTCR2_OFFSET,
> +					   rstval & ~NPCM8XX_RST);

[Severity: High]
Does this non-atomic read-modify-write risk clobbering concurrent modificat=
ions
to the shared INTCR2 register?

Since INTCR2 is a shared global control register accessed by multiple drive=
rs,
using regmap_read() followed by regmap_write() drops the regmap lock between
operations. Any concurrent modifications to INTCR2 by other drivers could be
overwritten.

Also, if INTCR2 contains Write-1-to-Clear (W1C) status bits, writing
`rstval & ~NPCM8XX_RST` might incorrectly write 1s to all other active bits
(clearing them) and 0s to the watchdog bits.

Could regmap_update_bits() or a W1C-safe write be used here instead?

> +			if (ret) {
> +				dev_warn(dev,
> +					 "Failed to clear INTCR2 reset status: %d\n",
> +					 ret);
> +				return;
> +			}
[ ... ]
> +		}
> +	} else if (of_device_is_compatible(dev->of_node, "nuvoton,npcm750-wdt")=
) {
> +		ret =3D regmap_read(gcr_regmap, NPCM_RESSR_OFFSET, &rstval);
> +		if (ret) {
> +			dev_warn(dev, "Failed to read RESSR reset status: %d\n",
> +				 ret);
> +			return;
> +		}
> +
> +		ret =3D regmap_write(gcr_regmap, NPCM_RESSR_OFFSET, rstval);

[Severity: High]
Will the first watchdog instance on NPCM750 clear the global RESSR register
without caching it, causing subsequent instances to lose their reset status?

The NPCM750 SoC has three watchdog instances that share the global RESSR
register. When the first watchdog probes, it reads RESSR and immediately
clears it by writing the value back. Because the value is not cached
(unlike the SCRPAD10 mechanism used for NPCM845), when the remaining
watchdogs probe, they will read 0 from RESSR and permanently lose their
boot status indications.

> +		if (ret) {
> +			dev_warn(dev, "Failed to clear RESSR reset status: %d\n",
> +				 ret);
> +			return;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622083046.3189=
603-1-tmaimon77@gmail.com?part=3D3
