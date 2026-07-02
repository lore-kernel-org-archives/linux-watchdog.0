Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309D48124E;
	Thu,  2 Jul 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996174; cv=none; b=MV2R4Dp12gkZ7qOQqv/OXq25OgkNDgjKvC4nm7fyQsioHvq3w+k7Cj2f/uRcRgP9CxAxoagSnpTyrTTDGDdQEGuxFx8EGoyRg0rTu9G4mE/cB4W72mcIQobJX8+hO5J4xJHXJAmdbKLc+6HuVcmen0qGmmjxrv1bd4LfqwcOxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996174; c=relaxed/simple;
	bh=OzV8cP9QZGr+41f8NmTp8mZKxv03Jpl2DNS9zZ8Xr+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZ0NB9XjGDn12os5Qo58DkpMJbfKMuHd+t/xxLWq5Zb4Y3Y/+FBpwsenEWOODhmIPCEXTOszs+qp63sOKXQfB4CHlLBlNvFZ0heT71mczOqyWh5tHyI0oO+vays6qT5W5Zd0ZTWUwIhel3i0y6kxIAKYrUwbS5gUF7rMsq1gv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDCsjV81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDCsjV81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B51F000E9;
	Thu,  2 Jul 2026 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996173;
	bh=SF9O4nRzwUFA6GE0sxzFCpvmzTqtQjXTF7DW/vG1rYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDCsjV81/TbU5kSNRY3lOjyL5NZGQBwKL677GX9JrEMfEmLREzJUEipcdYWTM0tEj
	 1o31KrYEjNxpHTpBlDUb9Jr8TGevVSUrc2NG9Gc6NIrdHxE37ED3s5NFFC0I6yxqOW
	 5Wa5BrQDv6GvqHNPEMpz8X2h4IDT3DzLUq6f9eYHpLLqdZoyr86DcMk/INRu7vhOaW
	 cVpUoW4f59sTpkgV/1tymJaStgyMTIOdnhDNCbef/A35n+Yk/I/OmU/+jrJeHdR/Iy
	 rDaEVK15wsAahTy/KQKqrATNlUpACxKUTRsCxUlzk7O+WNumM7zxfCHVbfdgYF6gSI
	 iZQKOtWtnJAqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 7/9] watchdog: rzv2h: Add syscon support for
 RZ/T2H and RZ/N2H WDT control register
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260702123112.161160-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:42:51 +0000
Message-Id: <20260702124252.8C1B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error rollback path in `rzv2h_wdt_stop()` leaves the watchdog =
deasserted but unconfigured, breaking the hardware state machine and potent=
ially causing spurious resets.
--

commit e9173a2a019341cec05cdc87e042bd8dd2f92721
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Add syscon support for RZ/T2H and RZ/N2H WDT control regis=
ter

On RZ/T2H and RZ/N2H SoCs, the WDTDCR register is shared and managed by a
dedicated SYS driver. This commit updates the WDT driver to support a syscon
regmap interface for WDTDCR control while maintaining backward compatibility
with direct mapping.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index e9545b8f5fd09..e14ff853a4e9f 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -179,8 +208,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
ev)
>  	if (ret)
>  		return ret;
> =20
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_stop(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> +		if (ret) {
> +			reset_control_deassert(priv->rstc);
> +			return ret;
> +		}
> +	}

[Severity: High]
When rzt2h_wdt_wdtdcr_count_stop() fails, this rollback path deasserts the
reset line and returns an error without reconfiguring the hardware.

Because rzv2h_wdt_stop() returns an error, the watchdog subsystem will keep
the device marked as active and continue pinging it via rzv2h_wdt_ping().

Since the earlier reset_control_assert() wiped the configuration registers,
will the subsequent ping lock the unconfigured control registers and
potentially cause an immediate spurious system reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702123112.1611=
60-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7
