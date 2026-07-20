Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569A43DA5C
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565475; cv=none; b=bY573ArrIKI2N3yi6rPoRmw4/t0N0hTq8bZlB3vtqTRI4gsrarXxiUbZheQXpeNzZPaU1KYGdRIhMg+MD8SunFAT/vFzbX0ZAYMOkxnpLR+wZs/sjk1mAyru++DmZff9RaFV7VkT4zGGsiSfVshkgfS3MjD7/AixZUQiKZOuLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565475; c=relaxed/simple;
	bh=YnuQNcBLsku2RqqyPvzUj2NQkTZrrDNgZjXga6bomuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZ6+M3790NsvgLMV8tcvPT3X4v3EOdC/cevvhLrGD5iceVvNp28xdruCmL+VUOCPdhlsSfyldGuKeXbQh8Z5dkrxw8L5BsIG0PmB0NsI0vxpCOg7eodbMkklC6LiSEw0ft9wrj6UsEeS9oDgWSeLUp1CXuHUgyr+ubbV8WTBEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=7TdHjpg6; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="7TdHjpg6"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 975567CD01F;
	Mon, 20 Jul 2026 18:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1784565135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLBHhEtJn4x4evy40Rf5cBK7ReLHFgmUUBlihEY+rH8=;
	b=7TdHjpg6GlcLG78L8tAG6lMqifgP1k60g7MwM2f1yAc4N32ot2wvVUebfVBuI1mmY33ibc
	0x80GcGkR0mfwFPxjwD0Pij+L9h1ZbOQhL8mdUrIDvaswtrTT9oNJ3D4Pn4LN+kC+kJGPg
	fRTATSKXXQays/c6ayqg/972ZRfb0CkCWQHYPxmwYX6xA0aj+CsO2vW5ArtluUcBmUCgUI
	jgMFJmHqUlDpKYAfs8OhkW3+nHVrTyVOouF1ggy6i10T8rItCxuBtla1zYrY0+Pfqn7YN7
	ehxCeLIwurxxYu1n+RExFpElvS/C/fU90de6OOuNejPwJrmKRFuCWrQI3SUK5A==
Message-ID: <d27c366d6e28a5f50ddcdfe456bf844cbaab9d0a.camel@svanheule.net>
Subject: Re: [PATCH 1/2] gpio: realtek-otto: use __raw_readl/writel in
 realtek_gpio_update_line_imr()
From: Sander Vanheule <sander@svanheule.net>
To: Rustam Adilov <adilov@disroot.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski	 <brgl@kernel.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-mips@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	markus.stockhausen@gmx.de, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Date: Mon, 20 Jul 2026 18:32:14 +0200
In-Reply-To: <20260710183439.996923-2-adilov@disroot.org>
References: <20260710183439.996923-1-adilov@disroot.org>
	 <20260710183439.996923-2-adilov@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Adding linux-mips as SWAP_IO_SPACE is mostly a MIPS thing, and some lists/p=
eople
for your other pending patches.

On Fri, 2026-07-10 at 23:34 +0500, Rustam Adilov wrote:
> In preparation for upcoming changes to how bank reads and writes
> are defined in this driver, change the ioread32 and iowrite32 to
> their __raw variants. The realtek_gpio_update_line_imr() function
> is used by all devices regardless of GPIO_PORTS_REVERSED flag and
> thus this is the only place where there shouldn't be any byte
> swapping whether SWAP_IO_SPACE config is enabled or not and that
> is only possible with __raw_readl and __raw_writel.
>=20
> Signed-off-by: Rustam Adilov <adilov@disroot.org>
> ---
> =C2=A0drivers/gpio/gpio-realtek-otto.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek=
-
> otto.c
> index 4a606bad5848..491fde846d46 100644
> --- a/drivers/gpio/gpio-realtek-otto.c
> +++ b/drivers/gpio/gpio-realtek-otto.c
> @@ -176,10 +176,10 @@ static void realtek_gpio_update_line_imr(struct
> realtek_gpio_ctrl *ctrl, unsigne
> =C2=A0	u32 reg_val;
> =C2=A0
> =C2=A0	reg +=3D 4 * (line_shift / 32);
> -	reg_val =3D ioread32(reg);
> +	reg_val =3D __raw_readl(reg);
> =C2=A0	reg_val &=3D ~(REALTEK_GPIO_IMR_LINE_MASK << shift);
> =C2=A0	reg_val |=3D (irq_type & irq_mask & REALTEK_GPIO_IMR_LINE_MASK) <<
> shift;
> -	iowrite32(reg_val, reg);
> +	__raw_writel(reg_val, reg);
> =C2=A0}
> =C2=A0
> =C2=A0static void realtek_gpio_irq_ack(struct irq_data *data)

As per my earlier message on your watchdog patch [1], I'm still not convinc=
ed
converting all existing drivers [2, 3] to work around an issue with the USB
framework is the right thing to do. You claim the required USB changes are =
not
upstreamable, but I have not seen you make an attempt at doing so.

Can the people from linux-mips shine their light on whether using __raw_*()=
 to
work around the effects of SWAP_IO_SPACE is reasonable? My gut feeling is t=
his
indicates SWAP_IO_SPACE shouldn't be enabled. Markus has apparently made th=
e
same remark [4].

[1] https://lore.kernel.org/all/ebdcb8c5563ceff723f3e4a3c4fdfe9bf87d42fa.ca=
mel@svanheule.net/
[2] https://lore.kernel.org/linux-watchdog/20260710074316.46643-1-adilov@di=
sroot.org/
[3] https://lore.kernel.org/all/20260511131520.98420-1-adilov@disroot.org/
[4] https://lore.kernel.org/all/016d01dce49a$36b7bd60$a4273820$@gmx.de/

Best,
Sander
