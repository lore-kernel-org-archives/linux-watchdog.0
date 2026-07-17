Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E349620;
	Fri, 17 Jul 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302254; cv=none; b=gY7rB7DoSAp2XSPSEFZJFqggjjFzdW2iN36SjMsAemJy6iSg444KLpbgzlcdJ+Q44oK8AiyKlbL34lkgw8wbZc+ch9Olx2/tQsHa+8wN+XQnRBZj/uWvoqGr8wKaxw1HzF7n+gA9KCXciP+ieI7RfmLfJFoGA+ISFOR2bXh+fXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302254; c=relaxed/simple;
	bh=7q/7X8LdnFYjf0r1UcheQlvta0nHexIx3wWv2IG/9ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qxwRufGLMh65B+W/ir2jV+80+ST9C12UzcGGgCSnptik0+cwxT2YdcbVvEj/1+pWogAB3HXuRjRWxJ0RWu0gzeHRujXxUnH4YdtYzZ9DgtquF/Q2BHVBWKo74bCdkSv9g1RYbKgBdXe9oTJPo5iF5SjV0YEHJx2BjlMN9LGrEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UraVCTWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UraVCTWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225451F000E9;
	Fri, 17 Jul 2026 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784302253;
	bh=2R4/nNLQIy/RxO6IY9YbkPmSeHRQuaZy+AU1E8zbpxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UraVCTWZb9H7qKasjYZzACV+2LsE84aGzB4PEYILPoeiz3/fYFoQlZLolhUZvGesQ
	 bq2EOFdvYS1DYyZQHJPQSLsyE4LDWgWTsGLFVXA+0oYaU/apB1dBnMurDGN+UZsxbY
	 05z8IR3wx71mLGxsOIpEySA9lOnT6Y4pcimowln2xVmUtlCNRYItV/7h8dRiCJMaIl
	 gm23tBAl2dFexHjVitw+zcpXGpR9zOojsR1PTtCiLf61wWKRvW0qfd+XTkwcHiEmWb
	 0fOAnjpF8lu4jFZSkXNvqfXufJ7h0+IrSAgFcvkRyeykfsxFIbWCRrqaMxO+LWdX75
	 gWzrV5WZzFRhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] soc: mediatek: mtk-mmsys: Add resets for mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260717151134.678839-8-l.scorcia@gmail.com>
References: <20260717151134.678839-1-l.scorcia@gmail.com>
 <20260717151134.678839-8-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:30:52 +0000
Message-Id: <20260717153053.225451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing array mapping for MT8167_MMSYS_SW0_RST_B_MIPI_TX_CONFIG (I=
D 24) causes it to default to 0, unintentionally aliasing to and resetting =
the SMI_COMMON block.
--

--- Patch [7]: [PATCH 7/7] soc: mediatek: mtk-mmsys: Add resets for mt8167 =
---
commit c0225a0e854c0cfee4ad1db37b9fac3a7690abdd
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

soc: mediatek: mtk-mmsys: Add resets for mt8167

This commit adds 64 MMSYS resets for the MT8167 SoC, spanning two contiguou=
s=20
32-bit registers (SW0 and SW1).

> diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/m=
t8167-mmsys.h
> index eef14083c47b5..b8f38ff8cf443 100644
> --- a/drivers/soc/mediatek/mt8167-mmsys.h
> +++ b/drivers/soc/mediatek/mt8167-mmsys.h
[ ... ]
> +/* MMSYS resets */
> +static const u8 mmsys_mt8167_rst_tb[] =3D {
> +	[MT8167_MMSYS_SW0_RST_B_SMI_COMMON]	=3D MMSYS_RST_NR(0, 0),
> +	[MT8167_MMSYS_SW0_RST_B_SMI_LARB0]	=3D MMSYS_RST_NR(0, 1),
[ ... ]
> +	[MT8167_MMSYS_SW0_RST_B_DSI0]		=3D MMSYS_RST_NR(0, 22),
> +	[MT8167_MMSYS_SW0_RST_B_DPI0]		=3D MMSYS_RST_NR(0, 23),
> +	/* bit 24 is SMI_COMMON again according to data sheet */
> +	/* bit 25 is SMI_LARB0 again according to data sheet */
> +	/* all other bits are not described in data sheet */
> +	[MT8167_MMSYS_SW1_RST_B_LVDS_ENCODER]	=3D MMSYS_RST_NR(1, 2),
> +	[MT8167_MMSYS_SW1_RST_B_DPI1]		=3D MMSYS_RST_NR(1, 3),
> +	[MT8167_MMSYS_SW1_RST_B_HDMI]		=3D MMSYS_RST_NR(1, 4),
> +};

[Severity: High]
Does this array omit the mapping for MT8167_MMSYS_SW0_RST_B_MIPI_TX_CONFIG
(ID 24)?

Because index 24 is unmapped in this array, it will default to 0. When a=20
driver requests a reset for the MIPI TX config ID, mtk_mmsys_reset_update()=
=20
will look up index 24 and retrieve 0, which directly maps to=20
MMSYS_RST_NR(0, 0) (the SMI_COMMON block).

Can this omission cause the SMI_COMMON block to be unintentionally reset
instead, potentially disrupting the multimedia subsystem's memory transacti=
ons?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717151134.6788=
39-1-l.scorcia@gmail.com?part=3D7
