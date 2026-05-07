Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012E301717
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187941; cv=none; b=EFiuOOvR8fPJq/Y5fiFeU71UVaBuBJafJROKlYAR31MIcmJgXNX4ejYWq97GhpD8ELHhpiKj8luRkliPeEuT6Al8xxwwoN9RmNRsrmSnmWzScdRfOcd2JaMSjCmZ4LTDdMuH4kvK0ufhOlASW3cv4dBJPG/Hd4RGqiOx3HBNMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187941; c=relaxed/simple;
	bh=NMkszKHR+RI6Bwo6SEP110qeEka2qoKN4ttIzgW3k3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pa+j7z8fEk41rEdL7Ja1xf4QcCMFw5QCC/QEFQ5BI68woX3UCirdf9uWG0SWGgE+DyhpYkXmXm4qPOUkMs1G0RRm7+d9/KVNZS7uwc5I1yKROiuWr13tmfbC6UOQIyfk1rN4tu8UtEC2JPo+R3cM8BPFc4uwhqxYNcYl63+xYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCdEeJ4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCdEeJ4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB205C2BCB2;
	Thu,  7 May 2026 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778187941;
	bh=NMkszKHR+RI6Bwo6SEP110qeEka2qoKN4ttIzgW3k3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kCdEeJ4IUex0+URbBpQTATok76koSPbroD5i/Uan3pfRiVOG/M8FF+Cm31In6LfwI
	 5tBpUlZ1ASvhbYIruxnH5R8o8YZWR9UUshQeLjAIiHGmXi1ED7WewScdtTOxV3wYGp
	 Cr6Fa/pfRbQY5gOqLuCZGiWup79EHN3qr7I2dQz3xn6H/e1S3q/q22NhkjnkIBZ0Qt
	 UyrHP09rqJPKvd2oOye6Sqk4gR/spOef/G2GGXurgiahB9aiQhZSf7KE4ZkHJzOIZZ
	 tCHu9ldNMktBbcZ+FkE7d/6BMXMgMvwFy0/9COCqzSdAs1DtVc0CJEYKzDSndhiTLR
	 5csI9whgL3XXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] watchdog: rzn1: remove now obsolete interrupt
 support
Reply-To: sashiko@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260507102410.43384-4-wsa+renesas@sang-engineering.com>
References: <20260507102410.43384-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 21:05:40 +0000
Message-Id: <20260507210540.EB205C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally removing the interrupt workaround breaks watchdog =
reboot functionality on existing systems running older bootloaders.
--

commit cc090392d96a1601fdb1492a2e01bab3e4a23303
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>

watchdog: rzn1: remove now obsolete interrupt support

This commit removes the interrupt-based workaround that used
emergency_restart() on watchdog timeout. It assumes the controller is now
configured by the bootloader to reset the system directly.

> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> --- a/drivers/watchdog/rzn1_wdt.c
> +++ b/drivers/watchdog/rzn1_wdt.c

[ ... ]

> @@ -116,15 +106,6 @@ static int rzn1_wdt_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
> =20
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> -
> -	ret =3D devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
> -			       np->name, wdt);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to request irq %d\n", irq);

Will this break existing systems running older bootloaders?

If the bootloader hasn't been updated to configure the hardware for direct
reset, the watchdog timeout will assert the interrupt line. Without this
handler, the unhandled interrupt might cause the system to hang entirely
instead of rebooting.

Could we use platform_get_irq_optional() here instead and retain the
interrupt handler as a fallback for backward compatibility with older
firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507102410.4338=
4-1-wsa+renesas@sang-engineering.com?part=3D3
