Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447430D410;
	Wed, 14 Oct 2026 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961450; cv=none; b=XF7enrHwgh/kr9tV/mnlBNHtJyBMTc0HRCu1J5oIfRjJERZGvNnDFW3eZF2Mc0eUPw0aHlHQnbXVawd0bHUTppouNpQO2nDKYAJ/kKvD7H2dW+TESUm5dJCzwQhraQNQ9pud+YNv8k1eMJ1oGY3x5OscIGWWIi5C5QV8K3+DVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961450; c=relaxed/simple;
	bh=effApVqbX6TaP60lYcuWqqNdAYdSPychen8ungTpImA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rIbZjDVRD6RFWgywjfC3uLkQ1xSM8HOjvYRhwZi41NQiO7q+D8eCvAYiatYG4QxzVlZVKtbklrPfpjQ0RRj36fX4APlGBg2ncaAU5P+XX+96xS5+BYfyxmeJVuswXWoO3C72MLdSQObtXaGg79OzD+Esfx0wBhmIg3LnoJIsAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G079IqHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G079IqHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11CE1F000FF;
	Wed, 14 Oct 2026 07:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791961449;
	bh=3Zq4E38kVSnchpNSMMvZwIYt+PcaJ1J6OJkqnVHJgrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G079IqHIIKgbKDDHaRsMJD5kNqKex9DmwEc4iCATEnzjBiVJLAgVUSNe6vwk2kQU4
	 JPgfJXoLR9M4+D9Defr4usH7p6n+jUk/DBca9IgogYMlQLk16L6TvBfBFz252KFJ2E
	 n6+84fyUXTgn7kqXd424yPW4BShs/HO0jUUBD2OubmOf7e1ddN9k4IAs7OUFIBXcxo
	 7nvTFUaOjL6gxsccGCw2GpR6Rw39sv0cEze/AS9Xmm5xQXYD48mSluuTKzIbiImFKj
	 yYMNjejyxn7q4HaZ2a7DXEVP8nS32+QgGIJiMJQuBu7C6fcPT0EQtxBZ2kKAjFBA9t
	 oGy0XTYQs8PfQ==
Message-ID: <sashiko-outbox-170921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] arm64: dts: apple: Add minimal t604x (M4
 Pro/Max) device trees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-10-961edd8d661b@cyberchaos.dev>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-10-961edd8d661b@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 07:04:08 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kbuild: Makefile entries for device trees are not sorted alphabetic=
ally
--

commit 82cbbc1479b59d13a418d2b1deaeea36cb85e6fa
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: Add minimal t604x (M4 Pro/Max) device trees

This commit introduces minimal device trees for the Apple M4 Pro and M4
Max systems, including multiple MacBook Pro, Mac mini, and Mac Studio
models. It also wires up the new targets in the arm64 Apple device tree
Makefile.

> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/app=
le/Makefile
> index 4f31beeb11ac4..12fc777405b3f 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -94,6 +94,12 @@ dtb-$(CONFIG_ARCH_APPLE) +=3D t6031-j516c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t6032-j575d.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t6034-j514m.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t6034-j516m.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6040-j773s.dtb

[Severity: Low]
This isn't a bug, but could we keep these build targets alphabetically
sorted? Placing t6040-j773s.dtb before the j614s and j616s entries breaks
the sequential ordering convention, which is typically maintained to prevent
merge conflicts when multiple patch series add new devices in parallel.

> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6040-j614s.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6040-j616s.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6041-j575c.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6041-j614c.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6041-j616c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t8112-j413.dtb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-apple-m4-p=
ro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev?part=3D10
