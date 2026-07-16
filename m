Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1B433BCB;
	Thu, 16 Jul 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220566; cv=none; b=n66n3L4k/zEokmZt/sN/4kPv4O/LE5xoJmT5qJ/0ryq540hBwlmedpF2ZfBNUnl/TSowPCl3+8x3uM2gELb1Kia2Df4l818BPe/f7ArtnwUhs74eMaaDTkUNbJNgk8M5b3tmG4aOUoMxyLOZUs6XqX3fPu1bHox4f8hxqGiG7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220566; c=relaxed/simple;
	bh=lRrwvZp09I4N2JdAcsrG0rbgsxZ/VlDINPJPkxxPSL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WCnsKsSHphtb87sw6JnfRbidUk0EEm9qaNmVC8r2XMdGCVS1byT4tYAK7tX01rqeqSCbMOJKIxxpSzw1oJMlLWdb6oz5cDibYPocoMuhTRFS9d9rM9jtknYUahJJZjJv2ZTGrLPcAomn8U0BaBilV75oPMjPWaXn/4lEvbuXw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWe7jNp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWe7jNp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB991F000E9;
	Thu, 16 Jul 2026 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220557;
	bh=718xPuGkWNlVfDlj4YGOOqYAOLW0WJDpHZTYeJoVSJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWe7jNp77lByXOL/kYCSaCFNmCruXrQu4QGbLI0csFDYo9xp+cjG12y/ZT/8Cshvp
	 jiw9xi9yhnb0Vtha9Lz6Q9N617+8kDgsy2YHISM/5xZj03NelrtTbBL03lVDYcHzz0
	 sskoRhSCujZwuA9TJOXipVeY3TFICZ09iyeI8Hz2lKX1/72n9wvEYjsU9Jm1ofwH44
	 oIIpquWHGhPZuZKbqgUJwTRmxw9XoAcj6E/8OdIs23F1k42jMft6MsBsGSb6evAkNN
	 vwE1xMe1uRWLxa9F+Y+Ae/LjxczSgTfDzUxt7KTutUFYd7MZzKPS7N371055DjaFNb
	 0ubuODX+xuN5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: watchdog: mediatek,mtk-wdt: remove
 mt6589 fallback items
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260716161923.266315-5-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-5-akkun11.open@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:49:16 +0000
Message-Id: <20260716164916.CFB991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Removing the fallback `items` block breaks schema validation for=
 existing older Device Trees.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the schema fails=
 to conditionally enforce `#reset-cells` as a required property for watchdo=
g variants that act as reset providers.
--

--- Patch [4]: [PATCH 4/7] dt-bindings: watchdog: mediatek,mtk-wdt: remove =
mt6589 fallback items ---
commit 51d21b22f4b3e7a458ffe7ba34258074ee5dc9ac
Author: Akari Tsuyukusa <akkun11.open@gmail.com>

dt-bindings: watchdog: mediatek,mtk-wdt: remove mt6589 fallback items

This commit removes the fallback items block for the mediatek,mt6589-wdt
compatible string from the MediaTek watchdog binding. It retains only the
flat enum, under the premise that all DTS files have been converted to
standalone compatibles.

> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index f4eaa5f7c5bc3..2411c02f1cb0f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -42,21 +42,6 @@ properties:
>            - mediatek,mt8195-wdt
>            - mediatek,mt8365-wdt
>            - mediatek,mt8516-wdt
> -      - items:
> -          - enum:
> -              - mediatek,mt2701-wdt
> -              - mediatek,mt6572-wdt
> -              - mediatek,mt6582-wdt

[Severity: Medium]
Will removing this fallback block cause validation regressions for existing
older device trees?

If users run dtbs_check against older device trees containing compatible
arrays like "mediatek,mt8516-wdt", "mediatek,mt6589-wdt", they will now
fail validation.

[ ... ]

Looking at the required properties list further down in
Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml:

>   '#reset-cells':
>     const: 1
>=20
> required:
>   - compatible
>   - reg

[Severity: High]
This is a pre-existing issue, but does the schema fail to conditionally
enforce #reset-cells as a required property for watchdog variants that act
as reset providers?

If device trees omit this property for reset provider variants like
"mediatek,mt8188-wdt", they silently pass validation. Dependent subsystems
relying on the reset line will then fail at runtime when attempting to use
the undocumented functionality.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716161923.2663=
15-1-akkun11.open@gmail.com?part=3D4
