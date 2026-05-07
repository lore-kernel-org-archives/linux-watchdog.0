Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19E175A85
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185213; cv=none; b=LzNfTzibU/H7UcO4YajwDn+o5TlY114SanwY6ZEiiyqtw4/Uco88v2jNa3Po6WEwAZxUQP3aZOA11reBu/su6OMdoHBwf2nqIL3wSM6IHuCJlGBLXRmAJIV6jnj+ZoGWjbfHs3ZsWVQIW7axxesZbMhzi79h2zhtOj/K5wlEsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185213; c=relaxed/simple;
	bh=IsR/O7hHmyMTSa8nbvs9hmFC/mA1Q0FsJwwzTska6uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E33vT649M5icDHIr+CaKmvoOF6MfsJJxl508lIUsQW7xgd2KISFCLS110yw5yOKKx/dCGbwH7CuXLH+N304FypfNGZB7zxP6adkDs3ak5fv21VLdyyPHmMrFrdBiAqi59xlne5S/Fv9gZeqp5e6Pee7oAv1NOmhgW9dggyPErwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS8mvlwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS8mvlwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1184CC2BCB2;
	Thu,  7 May 2026 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185213;
	bh=IsR/O7hHmyMTSa8nbvs9hmFC/mA1Q0FsJwwzTska6uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GS8mvlwfF24U74mV5qPTtaSJfL3BHLcF26LwiDQwotPDShuhdysLuuIKFV6Sxh2pu
	 mdkptYZpTDLDzbt+bwEGkL1Zq4l+ztdRNFlQBsdPU54Sx0adndts0bw2vTDELYes4l
	 L4Uo9CNRDQLNdWT2PYI3qsUDb+suWdful9L4bJN15TjpF0g7XQO+D29MEEB2O6v/6x
	 xpai3YdC/8byW3E6YBhl5+T/m5Ce3IdaqN1g3CIIQ9jxtzrsosGy0ktLII0VTPKxhR
	 Lvw4Sr/5rJiPGI8+lWokZkk2E7I8OWTPFR3yKRyg4l7WRvlaj8NEjFD2YvDaOfngYk
	 y0B6whLMLcU9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Reply-To: sashiko@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 20:20:12 +0000
Message-Id: <20260507202013.1184CC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The watchdog driver will fail to bind because it only matches 'a=
pple,wdt', which is missing from both the DT schema and the new DT node.
--

commit 1d69bd3e024c70ab83ba6b193a047aaf6e2baef9
Author: Janne Grunau <j@jannau.net>

dt-bindings: watchdog: apple,wdt: Add t8122 compatible

This commit adds "apple,t8122-wdt" as a SoC-specific compatible string for
the Apple t8122 (M3) SoC watchdog. It specifies "apple,t8103-wdt" as its
fallback string in the device tree bindings.

>     The watchdog on the Apple silicon t8122 (M3) SoC is compatible with t=
he
>     existing driver. Add "apple,t8122-wdt" as SoC specific compatible und=
er
>     "apple,t8103-wdt" used by the driver.

Is the statement that the driver uses "apple,t8103-wdt" accurate?

Looking at drivers/watchdog/apple_wdt.c, the driver's of_match_table
exclusively matches the generic "apple,wdt" string, rather than
"apple,t8103-wdt":

static const struct of_device_id apple_wdt_of_match[] =3D {
	{ .compatible =3D "apple,wdt" },
	{},
};
MODULE_DEVICE_TABLE(of, apple_wdt_of_match);

> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/=
Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 05602678c070d..845b5e8b5abc3 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -16,7 +16,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: apple,t6020-wdt
> +          - enum:
> +              - apple,t6020-wdt
> +              - apple,t8122-wdt
>            - const: apple,t8103-wdt

Will this configuration prevent the watchdog driver from binding?

Since this block limits the compatible array to exactly two items, the
generic "apple,wdt" string will be omitted from the device tree node.

Because the driver exclusively matches "apple,wdt", does this schema need
to be updated to include "apple,wdt" as a third fallback string, or should
the driver be updated to match "apple,t8103-wdt"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-apple-m3-i=
nitial-devicetrees-v3-0-ca07c81b5dc7@jannau.net?part=3D2
