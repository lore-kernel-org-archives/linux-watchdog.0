Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95D3D0908;
	Sun,  9 Aug 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292630; cv=none; b=ZD3ex0hgw6MNZQqqK1+es3wm7m2qQVGWMhOlTKxcf54H918o7rqrZ4vosdvqloructls7Ef1do98gtKCsDhsi/n8tR4WU3bdANQfwx+P+Mtq6rDss/PveU150d4okbWgz/Iihqy/kMN96z/Db+t3qdsuTmdjihjvQSl201H7IxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292630; c=relaxed/simple;
	bh=jUN7pyikgpDUZ944ueA5wjg3N3viF9p1/FLQgOrjumM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H5Dnd2Sq8p9S/dJp5yF7f7/M8ewpiqqgVdHj+2tomEEX2c4y0o+15e/knCaP2OXuNGvLPJJPbqIt1RpblwuYrTuUMaRYgd17xN6lpStXf3AV2QL9BzpFw+VAgolKltCGX2YyCtWUD47t7JHmEx4Lg21YXOKWzzmStCcDcdmtkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJnNU9HY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJnNU9HY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC541F000E9;
	Sun,  9 Aug 2026 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786292628;
	bh=IJn5y6tqfdkDxU/BvwNCruCd/dB9AFJCBJLVDufiDDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJnNU9HY0f5F3UjDyeQ1TdxheJj6jG+X3ZETM+NOldyTQPKmFqFpNH6AGes1TBtfa
	 Rn1CL5yrl4FA/EKN2gJ/MJg1CrCV1UYsT5KQpelwWD1i7mId6U/YiGafR5GJ8GGL8o
	 DSyLKYCkc71JZ//vCxboSgLPlALawgEzJwEQLKqYXL5TlVxfLa3BbiThD8ZtiXrqVW
	 OL9M+ZayjdOQqMr/NYox9Yc2H+pDh9CzXwkJr0MbHT/c+Co8Ep0zK8EW8iw6XDmizm
	 6+7JpQclYq5a4DDcEAospHHZnePmCcYUc//wMvRzGxFnoU4sm6oiUr591rp8TeYHYT
	 7m/M7uxZEyylg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260809160643.33991-5-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 16:23:47 +0000
Message-Id: <20260809162347.ADC541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `mediatek,mt8167-wdt` compatible string is introduced as a s=
tandalone compatible in the bindings but is not added to the watchdog drive=
r's match table.
- [Medium] The commit message claims the reset bit constants are different =
for mt8167, but the corresponding dt-bindings header file is missing.
--

--- Patch [4]: [PATCH v3 4/8] dt-bindings: watchdog: Add compatible for Med=
iaTek mt8167 ---
commit 801a3249de93e217207cdaff898bd46c2e41daba
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: watchdog: Add compatible for MediaTek mt8167

This commit adds a standalone compatible string mediatek,mt8167-wdt to the
MediaTek watchdog binding. The commit message notes that mt8167 has differe=
nt
reset lines compared to the mt6589 fallback.

>     Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
>     which in turn falls back on mt6589-wdt. However according to the data
>     sheet mt8167 has 15 sw resets instead of 12, and the systems to which
>     each reset bit corresponds are different from mt6589, so the reset bit
>     constants are different too.

[Severity: Medium]
The commit message mentions that the reset bit constants are different, but
this commit does not seem to include the corresponding dt-bindings header f=
ile
(e.g., include/dt-bindings/reset/mt8167-resets.h). Are these constants defi=
ned
in another patch in this series, or were they inadvertently omitted, leaving
device tree authors unable to utilize the MT8167 reset controller?

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
Does adding this as a standalone compatible string without a fallback cause=
 a
regression in probe behavior?=20

Looking at drivers/watchdog/mtk_wdt.c, the mtk_wdt_dt_ids match table does
not appear to have an entry for mediatek,mt8167-wdt:

drivers/watchdog/mtk_wdt.c:mtk_wdt_dt_ids[] {
    { .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },
    ...
};

If a device tree is updated to use this new compatible string as specified =
by
this binding, will the kernel driver fail to probe, breaking watchdog and r=
eset
functionality? Is a corresponding driver patch missing, or should this bind=
ing
retain a fallback compatible?

>            - mediatek,mt8183-wdt
>            - mediatek,mt8186-wdt
>            - mediatek,mt8188-wdt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809160643.3399=
1-1-l.scorcia@gmail.com?part=3D4
