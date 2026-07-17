Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF0377558;
	Fri, 17 Jul 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310652; cv=none; b=esbWv5S1uzjTkHahFaZ3I/feA0+4re2sWdGd02SJMMpmZU0+8rtu3/GtEnWL8JJkw5oC2umxB/lZmtOkFrroajtJ+pias6qtzwMkV+sPpfEZDnGDCGACGUxo3sXMbtxAMi0+VAvNRTjqj9Y/M0644SkEitDzXK16TLUG5lDcZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310652; c=relaxed/simple;
	bh=6pCqkTZFeL3KDtJL2IeiD2UVLkXXzgJPhQG33y1hrDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eFLenjAOWktzO5azhzruL8kBMcnITkPD9vaEifRX8RbAB/bMg8CQb4ql966qaiedzrY55Dv6vT6ghajyBEVTVNwlbvQMnS1Myks9yBOwbECb88EdXArhl32gaveR6PbBy50fClZU/tYd2/Q3P902q4VbH+Le+Us5ZNP0y9XQneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nim79BmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nim79BmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9A31F000E9;
	Fri, 17 Jul 2026 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310651;
	bh=QTeuEtAoFyQbd3tRI55GUWQau2Iy0uaZTpg7PUeJd3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nim79BmGtTwZ4qRkh8uwLSroEpQLBVKT5H8zzgsc2gAElGtqtF/i8HQykR4mRQL7B
	 v6pmtrjER6rLJ5S0j8gAm9l9njQYHvyvCMSJ0QDBkQuq6qaybc213w9/qddvYgznDs
	 zhGG/lionWIhmJr99m/Y0IPEchZWpAZIpyXbbOV1R68yXCq2rBSsSZlp7/iBXf+tA8
	 vRpFqEzI9BSGqA7l/GR+Vp6rJ4yC+UTUJ+cwcgbBmPbooVyDo0Tq0NgOCiwCXxVbnZ
	 W2uFL74LaNKOq3JGvlvTvfs2gYYUdWjaL+EiGDffU4d/HnNOsZ9J5Ml8LQCEB7WtIr
	 MJcpurYwTbBag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: reset: Add reset controller
 constants for mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260717163959.714561-5-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:50:50 +0000
Message-Id: <20260717175051.3D9A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect reset ID mapping for MMSYS SW1 reset constants.
--

--- Patch [4]: [PATCH v2 4/7] dt-bindings: reset: Add reset controller cons=
tants for mt8167 ---
commit 3e501b19a4f1986647da6f341a25af00a37a8d1d
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: reset: Add reset controller constants for mt8167

This commit adds identifying bits for watchdog and mmsys resets on
the mt8167 platform.

> diff --git a/include/dt-bindings/reset/mediatek,mt8167-resets.h b/include=
/dt-bindings/reset/mediatek,mt8167-resets.h
> new file mode 100644
> index 0000000000000..85d2d0e99c689
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt8167-resets.h

[ ... ]

> +#define MT8167_MMSYS_SW0_RST_B_DPI0		23
> +#define MT8167_MMSYS_SW0_RST_B_MIPI_TX_CONFIG	24
> +#define MT8167_MMSYS_SW1_RST_B_LVDS_ENCODER	25
> +#define MT8167_MMSYS_SW1_RST_B_DPI1		26
> +#define MT8167_MMSYS_SW1_RST_B_HDMI		27

[Severity: High]
Will these reset IDs correctly map to the SW1 register?

In drivers/soc/mediatek/mtk-mmsys.c, mtk_mmsys_reset_update() dynamically
calculates the register offset by dividing the ID by 32.

Since MT8167 does not provide an rst_tb mapping array, the raw ID is used f=
or
this division. For IDs 25, 26, and 27, this calculates to an offset of 0,
which targets the SW0_RST_B register instead of SW1_RST_B.

Should these IDs be greater than or equal to 32 if they belong to SW1, or is
the SW1 naming a typo for bits that actually reside in the SW0 register?

> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8167 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717163959.7145=
61-1-l.scorcia@gmail.com?part=3D4
