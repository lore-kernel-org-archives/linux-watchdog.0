Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351247F3B8;
	Tue, 13 Oct 2026 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863900; cv=none; b=Fqb4WBWZGqAEVHlIzdIciPmC8nyaIv9ZhJ3vthHllq4o7gaf6NT/tP8awNSLXP+r0YQvbayMJYobnBFHwBoxq/LZuJIV9D1nd4fWkrBb5IjMUleInBTdTCGkD5FYwb7xxuP3SmBIm9ZP+EvkHg1gINFYn5xuA7GCsahxtXiVHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863900; c=relaxed/simple;
	bh=OrVdjgD+5glFaM0MKCsZ+PVS8F+VvM8IBehW773rkQE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KdPlRcswDsjj0gZmNwzKfW24DxXvjlmzIryqhATA8CW6vLPpVWSUteEAgoYjjnLmO/qHkRD+IhW9VQbLSxe0KlPYJL+WO7ZFedO7TfGgKsZEENa0VKq/D3g2qGAmP3KRzoHIJ/4KC6RnKXGsz0MM4PIuhn+bfwfFJLwLpNjKg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekHgYFti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekHgYFti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27961F000FF;
	Tue, 13 Oct 2026 03:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863899;
	bh=t3RH2JEmcolAwcOmGoagd5O5IoHXg2QqxoqFtUzzMbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ekHgYFtiMXxGK42VvZKmkcLUMl5v3oWn0XH++lkQv5ZKDpxBx7pYs6Xru/NDLYVxH
	 meQhiEHpg9hOY5m9/97VLrhj7YOiQG/cBQeSsQpOaqz+tQ+fU4PUEHsuLWQRBIQaeF
	 QknF8YIunoFIY7mekMT78QGni3VNc0q/8030roYTxVFICRt39LbaDGumwCAl8mEJka
	 77HVMKzb8gLyVEYO+Ie4rIQxqOsiBWm8I+DKRrKG9TxbQyZAYSVY0G2qy+VejZNAlq
	 ebw8wPdXA4m2fOT2ua256GhuyL6R37d3ootbQah6DoV0l8IgbbIILyuHyd1htFWhzX
	 zRz3FAJ498PFQ==
Message-ID: <sashiko-outbox-168944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-s2-v2-4-94f8c0a90cda@gmail.com>
References: <20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com>
 <20261013-b4-cs75xx-s2-v2-4-94f8c0a90cda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:58:18 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kconfig: unmet direct dependency on HAS_IOMEM when selecting GPIO_G=
ENERIC
--

commit c0cf3f24c2d064770186cd2502b93c7a6f2518be
Author: Fil Dunsky <filipp.dunsky@gmail.com>

gpio: Add Cortina Systems CS75xx GPIO driver
   =20
This commit introduces a new GPIO driver for the Cortina Systems CS75xx SoC=
s.
It handles data and direction registers using gpio-mmio, manages GPIO line=
=20
pin multiplexing, and provides interrupt support.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index dfdc9ee1a6b38..6b9524f25d24c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -300,6 +300,18 @@ config GPIO_CLPS711X
>  	help
>  	  Say yes here to support GPIO on CLPS711X SoCs.
> =20
> +config GPIO_CS75XX
> +	tristate "Cortina Systems CS75xx GPIO support"
> +	depends on ARCH_CORTINA_ACCESS || COMPILE_TEST
> +	select GPIO_GENERIC

[Severity: Low]
Does this select statement cause a Kconfig unmet dependency warning?

Since GPIO_GENERIC depends on HAS_IOMEM, selecting it here without inheriti=
ng
the HAS_IOMEM dependency might cause build warnings or failures when compil=
ing
with COMPILE_TEST enabled on architectures that lack HAS_IOMEM (such as UML=
).

Should this config also have a depends on HAS_IOMEM to prevent this?

> +	select GPIOLIB_IRQCHIP
> +	help
> +	  Say yes here to support the GPIO banks of the Cortina Systems
> +	  CS75xx SoCs, including their interrupts.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
s2-v2-0-94f8c0a90cda@gmail.com?part=3D4
