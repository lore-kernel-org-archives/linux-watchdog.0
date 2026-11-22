Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330999;
	b=3o3ZxcsNCssHXzj3G9nwQiAOCbMocgNb7qs2JYb5WwGl+PCSH+ZsAa6xlGql4474+1eP
	 f1sYR8FZpIf5ctR10UFaaPM6nCxU1s/Ju4bHzw5smTMTbwN7Gm2HN9lYQUEj8PxYze4uG
	 qkJKyBVW9dm0hRiz+Sx0wal1dkHj8fwuKyIL6ucve3epaefztTOONqbspqwXzHcsOWbqQ
	 M3LJ18cvvpLnuk7LQ/OQqAc7K+mfKlnbl7XcR02r5hZCnwr11r04hlp9dGPv8vheNfsDW
	 99JhgVD6W99hg2pWwVgLkWL4Toia1tQOLj1nz8L0Z+WMhQEG7wBwmKzLT3fIiHpy3kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FGv+M23/3tHrt6xfC1VMgCGhjU3kLcdSUSdtLMyqS3A=;
	b=DhiMyqabcKOFjtPlFU+95Ns3BAwgm9ICYIYSQJWXHTOtnE0h5EFcEHdgEmwYTkjL5Pmr
	 3izfP2nscNBO3MDr1yDPyaGCmZTqFqkzQZ7yliAughV4fc4AsvYLx8SgugPe6s81tPmbi
	 BzAwTLDLaPPVQoWIyJe1yKKE7fZ6jdXsuQvLU4Lh8XN0LV/qW7Bt7sy9kVVb9vaNTn11M
	 UrowjxfoJZjqMD7zLSuslblOBHW7J9mRfTDOdlQplQrCh7P9LwRO6wqDVwLzucuIVCLc2
	 duhd8gRN+BGebv85yFibv8sfIxLt59jPVCLPMVbQy/sR3i4Qf+JcKwBsYr2/wvG0bDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+ez74Wz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C55606A320;
	Sun, 22 Nov 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+ez74Wz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269FC1F000C4;
	Sun, 22 Nov 2026 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795330999;
	bh=FGv+M23/3tHrt6xfC1VMgCGhjU3kLcdSUSdtLMyqS3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+ez74Wzb3kGTMFB1/31bomH7G+O1NC+UVENmfWe9eqIg3AuOLl498Eqjk0QygiMn
	 gVhCkGnjYXsMPVU+/bp/g0Rjo50+9URbD2joZFtfKCZdn92Lqi2MTCoTX4dSThIX2j
	 wyzVI2afEAvj5DoB9knm0DK1O6f9m1ALbQU1jjVjeFtmARgnyuhD5wFW4OBgQ3Gg+6
	 VGb7lHDL/VwcpM2NHLyQKqgOLF3VbOiQKUqsInogF3jV898pw7mmVO1gV/eDzVCZs8
	 tb5kx9TSJ5iIq4egYWaIbYOQ9cAkXbIgRXid7ROr96TJ+58rKuJyox5an2T7zs/l/F
	 i3rx1SrHORqhA==
Message-ID: <sashiko-outbox-227779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: Add HiSilicon STB watchdog
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Yang" <mmyangfl@gmail.com>, linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122065549.3265519-2-mmyangfl@gmail.com>
References: <20261122065549.3265519-1-mmyangfl@gmail.com>
 <20261122065549.3265519-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 07:03:18 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] dt-bindings: watchdog: redundant word binding in commit subject
- [Low] dt-bindings: watchdog: non-canonical property order in example
  node
--

commit a1622b56fb454eac20ec415b3fb13ffbe0760e8a
Author: David Yang <mmyangfl@gmail.com>

dt-bindings: watchdog: Add HiSilicon STB watchdog binding

This commit adds a Device Tree binding schema for the watchdog controller
found on HiSilicon STB SoCs.

> dt-bindings: watchdog: Add HiSilicon STB watchdog binding

[Severity: Low]
The "dt-bindings:" prefix already states that the patch adds a binding, so
"binding" at the end of the subject is redundant and can be dropped:
"dt-bindings: watchdog: Add HiSilicon STB watchdog".

> diff --git a/Documentation/devicetree/bindings/watchdog/hisilicon,histb-w=
dt.yaml b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.ya=
ml
> new file mode 100644
> index 0000000000000..c0a8ccdb482a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    watchdog@8a2c000 {
> +        compatible =3D "hisilicon,hi3798cv200-wdt", "hisilicon,histb-wdt=
";
> +        reg =3D <0x8a2c000 0x1000>;
> +        interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&crg 0>;
> +    };

[Severity: Low]
In the example node, clocks should be listed before interrupts to follow
the canonical property order used in the properties list above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122065549.3265=
519-1-mmyangfl@gmail.com?part=3D1
