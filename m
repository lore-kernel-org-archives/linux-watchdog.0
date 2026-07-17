Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDC26FA4B;
	Fri, 17 Jul 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309960; cv=none; b=T0VFG4g2ioX9kPbcavZUf68UTYu2mAlOZgwIp7huDXHBVdil2qJdhkpjxu7AQpALKRpdp+2Zuf4h+wqjJGGpFwjMc7VUBRqwxzvf9o+lUglUiNTu5T+6j5BFgfAlSnuuhCML4NPqW6XogyI9qB7lwuGqa3AS+3rJTiRSSnRPjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309960; c=relaxed/simple;
	bh=dtP/MW12yFmQoRjPto5WIL1OLcgDMWkGlCBnNiTlVm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SM13w87vBHOxOhlvcfWUEb1ZnpO82TeIbcUgsKgFNkPsAvmzMWE1CwtDPSca0+v4V0PrBqd9DBRIvHTyMoQfz3nzUcacnZyKIwXrcZmK4k+7ZNTLFaGX3Qv257aGUVKI3JU3qPPxTuESBH7bUensiIy5q5eokxsoc/5aQGEHbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv4S3tZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv4S3tZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38C21F000E9;
	Fri, 17 Jul 2026 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309959;
	bh=KsSlOvkHW4kPr+vyID9BdIu2wQUKlb5NVh1SlBnks+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lv4S3tZooFIsSDzaqzmJK/tp0LmuZ4bpzbsWF1fmJV8G0/qmqwqKZ1RJM+gK/MwpX
	 i2RnYW+jqIZh4Sj0nLTbpbwX7LmphzFR2gUH8Iwe7vQ/n3rtd/JT5MMxvREx0/TX4c
	 zHCFXYDTCEVFKh0zUY9f1mQ9T2pJzzxdz6oIqTGJUkQcbAIJA3QY0rOd0JcNjJrLF7
	 uv/kJ0eRbkVeC/fpV5fA9jwlMqWFkKLcb4w/cyLatzQPqAz1RT5fqhUA3Zs7xOsCab
	 1Hti562Xaxwi00iaNWFMMjFEgqmG/+65JJGjmwE6zAq/IB/k3AAMfpEyrX4USN7omW
	 0RJSG+WavA3Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260717163959.714561-4-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:39:18 +0000
Message-Id: <20260717173918.F38C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `mediatek,mt8167-wdt` compatible string is added as a standa=
lone compatible (without fallback) in the DT bindings, but the patch series=
 is missing the corresponding driver support and reset definitions header.
--

--- Patch [3]: [PATCH v2 3/7] dt-bindings: watchdog: Add compatible for Med=
iaTek mt8167 ---
commit 666f2d36168cb1a5fa647ba2d10b40b0cd2f2240
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: watchdog: Add compatible for MediaTek mt8167

This commit adds a dedicated compatible string for the MediaTek mt8167
watchdog. It replaces the previous fallback to mt6589-wdt since the
mt8167 hardware has 15 software resets instead of 12, and in a different
order.

> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 953629cb9558b..f514be8a5851d 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt6795-wdt
>            - mediatek,mt7986-wdt
>            - mediatek,mt7988-wdt
> +          - mediatek,mt8167-wdt

[Severity: Medium]
Will this new compatible string probe successfully without driver support?

Looking at the driver match table:

drivers/watchdog/mtk_wdt.c:mtk_wdt_dt_ids[] {
    { .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },
    ...
}

It seems there is no match entry for "mediatek,mt8167-wdt".

Since this is added as a standalone compatible without a fallback to
an existing string, any device tree using it will fail to probe the
watchdog driver.

Additionally, the commit message mentions the mt8167 has 15 software resets
instead of 12, but there doesn't appear to be a corresponding dt-bindings
header exporting these new reset indices for device tree consumers to use.

>            - mediatek,mt8183-wdt
>            - mediatek,mt8186-wdt
>            - mediatek,mt8188-wdt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717163959.7145=
61-1-l.scorcia@gmail.com?part=3D3
