Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FD4A3410;
	Tue, 14 Jul 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045160; cv=none; b=BMc3bRtKFHL4xeOQF7qvC+QdRNHK3FNLyEQXRdd5t1Zp7wmhe1U7J+l3YdFABx21flNWO6WwP70CzYvQ8UHD+NDMAN7SpQakfCrBkEPB/rD6UttvSmjq1HwhRPoiBhxFcJr8RhJy1VZUadav664I457ahLhu9szpm/xcKzWmpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045160; c=relaxed/simple;
	bh=/RqNsl+dwe+/b4HmdObboRL0ludVvtrpNWFwysfj2ck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3vH+D8jZi+rOI5IcNDpf9mcyenzhLnoHGcAjHTbjZZALlIkSnO3oC3s3Q6945DSS+4PJjKL6FBCwiQy4046GVh68DQ8giazGszp4SV5dITsz0Enr5TeoJl1NQTs/JE1CRtTVGiGvOVPf8uRdHQtkyua3sjR3OoOSn0pXPgrvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca3HCeGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca3HCeGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C31F00A3A;
	Tue, 14 Jul 2026 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784045159;
	bh=PIHaNTc6hrDM2tGs8alKFFP9SFepX0G2mhQiZgFqkjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ca3HCeGBoE2pomYROI1smi0839DEcumJENkwkEFw/1BuzPvfDw7/UpDIkl1bWFVJb
	 KoFBS3mQDWFfnjxkvE/Ifju8rO4rBTpkPCEYw4r91z3/Byh6KmB9Heb8GoPr5YxTIP
	 bqV6Ugq3ZfD2RHUPBs+9piZp3pDzu2vebab/xuLsXuXiTV2RpxchzN3/OS25BYCdkG
	 6EXLUPqVn87rAg+GcbaPkiMXi+G20Hn+Uv8RXFAp+kAkGkQ5z7lXRyB038Ie6V+5/Z
	 fCafcjPVaK6/wbVILrbT1jgmhhLo41ZD16tAeQNXS3i5+oQXHPqtmLvZ6709PxiIZN
	 a6OVFdTBNJ/Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] Add Advantech EIO Hardware Monitor driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: linux-hwmon@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-watchdog@vger.kernel.org
In-Reply-To: <20260714-upstream-v2-v2-3-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-3-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:05:58 +0000
Message-Id: <20260714160558.C80C31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Use of bespoke parent-child accessors instead of standard kernel=
 APIs.
- [Low] Static tables missing `const` qualifier and containing entirely unu=
sed fields.
--

--- Patch [3]: [PATCH v2 3/8] Add Advantech EIO Hardware Monitor driver ---
commit 63ead2676c728959d0dbe217692c0d9b6f79eaa3
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>

Add Advantech EIO Hardware Monitor driver

This driver controls the Hardware Monitor block of the Advantech EIO chip.
There is a separate driver for the thermal device driver since it's a use
case we support currently.

> diff --git a/drivers/hwmon/eio-hwmon.c b/drivers/hwmon/eio-hwmon.c
> index 0000000000000..dd877664e9e89
> --- /dev/null
> +++ b/drivers/hwmon/eio-hwmon.c
[ ... ]
> +static struct {
> +	u8 cmd;
> +	u8 max;
> +	signed int shift;
> +	char name[MAX_NAME];
> +	u8 ctrl[16];
> +	u16 multi[16];
> +	char item[16][MAX_NAME];
> +	char labels[32][MAX_NAME];
> +} sen_info[] =3D {

[Severity: Low]
This isn't a bug, but should this array be declared as static const so it is
placed in the .rodata section rather than .data?

Also, it looks like the name and item fields are initialized but never read
anywhere in this driver. Can they be removed to reduce the memory footprint?

[ ... ]
> +static struct {
> +	enum _sen_type type;
> +	u8   ctrl;
> +	int  size;
> +	bool write;
> +} ctrl_para[] =3D {

[Severity: Low]
Similarly, should this lookup table be declared as static const?

[ ... ]
> +static int pmc_read(struct device *mfd, enum _sen_type type, u8 dev_id, =
u8 ctrl, void *data)
> +{
> +	int idx =3D para_idx(type, ctrl);
> +	int ret =3D 0;
> +
> +	if (idx =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (WARN_ON(!data))
> +		return -EINVAL;
> +
> +	struct pmc_op op =3D {
> +		 .cmd       =3D sen_info[type].cmd | EIO_FLAG_PMC_READ,
> +		 .control   =3D ctrl,
> +		 .device_id =3D dev_id,
> +		 .size	    =3D ctrl_para[idx].size,
> +		 .payload   =3D (u8 *)data,
> +	};
> +
> +	ret =3D eio_core_pmc_operation(mfd, &op);

[Severity: Medium]
Does this bypass standard kernel APIs by using a custom parent-child access=
or?

The MFD subsystem guidelines recommend avoiding bespoke accessors or helper
functions in the parent to pass state to child devices. Instead, child
drivers are encouraged to use standard subsystem APIs to prevent rigid,
tightly-coupled designs.

Could this communication be refactored to use standard APIs like regmap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D3
