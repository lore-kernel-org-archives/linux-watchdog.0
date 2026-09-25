Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289583CCFB0
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323184; cv=none; b=fbFmmtHAhMpxjfpUwRcjRRwI5S/sf1qrN/W+Vl9u5fbpZ6zSUWy2yjg8oxA/c2+qhcXqlkW35jr/WPGEaJmo1yZMDEaaYFOj92EySsR8BMgIMUqZSAdqbhnivyzvEEwstaQAmiSYTgBl1hcKh6NuFMoUFx7kUcjxewYC49qMILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323184; c=relaxed/simple;
	bh=Q5bao3uiE6gLE3Szz1b09t3MNBcI0VtyBTDXM/hiLHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G0KTo+k1Y/4i46m7ok8xJIHKLbIPvz02nUtkr0RUS6xbsLhglU1dfutIu6cIMgR3wNmZwHeHhu0hJvM3zjg4XJ5LSDSmsQxHRN3GyRvEaAapU3bueCbSJWJHnTOOEm4d0lRNDjTqsM7KvAb19zG5P1bXHQQX44J5+hJr3X6QMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iefumjGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iefumjGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB91F000FF;
	Fri, 25 Sep 2026 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790323182;
	bh=0xkFzJ0TkFzipxcVfQyKgWxsjjoc0Ai7+lMe3fpAMho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iefumjGmJpXnKxz7dgMj9Ik14UQ3uU7vy1X50ZSwOWto2Ghiu52gzs8hhU/850sGG
	 6/f7RzFO7o0+YMB4LkDnWOYc5iRlxgySrH4h42lAKwCg0nNtTflBNN/4wRo2aCs7EW
	 wJgS/+rzGtYuqdEmTbQ0goXTwZ5KyO6hVqtUshtIHBGWFfudBYXhDfHxgQFmEk4S+T
	 nBvyUAKtv5nlsRfdI4mpt7HcpfrAiEnk9QVBBUxYxboenI85Ld8FbQi4hON8rqbCco
	 kZd7I5nxhPd92dFRyEn2lDM6/+vui9hKjNEbdUvqFwHV6idghNphL/MF+f1X76xWIF
	 p6rlnSdU+gJjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:59:42 +0000
Message-Id: <20260925075942.82FB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] acpi: missing property_read_int_array stub breaks integer fwnode=
 fallback
--

commit 5d9e9568158b8ab98bc89d0fdfe42ecee301d73a
Author: Lorenzo Pieralisi <lpieralisi@kernel.org>

ACPI: Introduce irq_get() for static fwnodes

To describe and map GSIs for firmware nodes created out of ACPI static
table entries, this commit defines standard properties and implements
an irq_get() callback for static fwnodes. An empty stub for
property_read_string_array() is also added to allow fallback.

> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8ee5a1f0eb486..c609100c08db0 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
[ ... ]
> @@ -1766,7 +1766,74 @@ static int acpi_fwnode_irq_get(const struct fwnode=
_handle *fwnode,
[ ... ]
> +static int acpi_static_fwnode_irq_get(const struct fwnode_handle *fwnode,
> +				      unsigned int index)
> +{
> +	u32 gsi, trigger, polarity;
> +	int ret;
> +
> +	if (!fwnode->secondary)
> +		return -ENODEV;
> +
> +	fwnode =3D fwnode->secondary;
> +
> +	ret =3D acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GS=
I,
> +						index, &gsi);

[Severity: Medium]
Does the lack of a generic integer fallback mechanism force explicitly
hardcoding reads from the secondary fwnode here, bypassing the generic
fwnode fallback entirely?

[ ... ]
> +const struct fwnode_operations acpi_static_fwnode_ops =3D {
> +	.property_read_string_array =3D acpi_static_fwnode_read_string_array,
> +	.irq_get =3D acpi_static_fwnode_irq_get,
> +};

[Severity: Medium]
This structure appears to be missing the .property_read_int_array callback.
Does this omission cause the fwnode core to return -ENXIO when generic
driver code attempts to read an integer property (e.g., via
fwnode_property_read_u32()) from an ACPI static fwnode?

Without an equivalent stub for .property_read_int_array to return -EINVAL,
the operation bypasses the secondary software node entirely and breaks the
standard fwnode property fallback contract.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-acpi-stati=
c-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=3D2
