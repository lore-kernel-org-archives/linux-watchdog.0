Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE55261B9B
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151953; cv=none; b=HKvFll54z46U31K3Y00/cf6U8Q4cKActrU3Na7Fh6Q2iEowMJWaMxDkCf0ejlFqpFK2hJS1udFYP3oxYe3N5Z4wj7qEiKvvCKU8hP/HTYf+XgBlNI3VDJroOgR8hr1NQkdvu3+JypFwA0mGaLoVcKNg+qPkxDbMAu5XzYcQKVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151953; c=relaxed/simple;
	bh=zc86o6ylrLfcrAOkFLsx7yBUhit1Y82HRK9DBQAQWeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIysKi/C5XYaG4hNo9fjmFvo6rlH38nKo8P8NiWQLHs1goC5pn/nuduSobjjWsceWYDHCRrGqokcfOapzWRpQ4/e4bgbb4Lq9ATDk3f6gTkLAxj9BrCNZYSzYO6rrPXGwwsWvJafAcd1cEELLiBJcPi8cCcy3wpxRagyUrId28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNVl+r6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNVl+r6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE8EC2BCF7;
	Tue, 19 May 2026 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779151953;
	bh=zc86o6ylrLfcrAOkFLsx7yBUhit1Y82HRK9DBQAQWeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PNVl+r6/DleFTYQGZL9MdUxKWLb3oZ+UF0z1WxJB4BdwMMdWOE0dxtHr8AChlQE6x
	 FLnYDkf9yYdj/VsNcS0betLqCNcyoh9Bi+wNGY3mREBtbSFjxPJ7x3JVu0LbT/P1DL
	 xpWcS1A+K5PhGNM8CwVttwWaIjRJ8ezFQYg9MOZmqWJf5BYdpGweJhGz731XP/hXtn
	 RdG3OzDIxyZFjSdkyCbbWdTWgHja6IIvEIFXdMJZI/TQ+7wFylIBfNSrkI/RzCsC7i
	 x0NGmvkcqp0zY72iAxB1W2/eEwCN+tYlNlsSKb0U8TV3Y7BOjP0iQOqBtj1dMVJhdC
	 hm5OiKxKxU9Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: orion: Use of_device_get_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260519003742.626477-1-rosenp@gmail.com>
References: <20260519003742.626477-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 00:52:32 +0000
Message-Id: <20260519005232.DDE8EC2BCF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The clock is explicitly disabled before the `devm`-managed interru=
pt is freed, leading to a potential bus fault or system hang. This problem =
wasn't introduced by this patch, but it is a pre-existing high-severity bug.
--

commit d9eb7a064a32ff51e0077728d87320936861ffad
Author: Rosen Penev <rosenp@gmail.com>

watchdog: orion: Use of_device_get_match_data()

Use of_device_get_match_data() to fetch watchdog match data directly
instead of open-coding an of_match_device() lookup.

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 0e145f762f6f2..a92701ff26530 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
[ ... ]
> @@ -563,15 +561,14 @@ static int orion_wdt_probe(struct platform_device *=
pdev)
>  	if (!dev)
>  		return -ENOMEM;
> =20
> -	match =3D of_match_device(orion_wdt_of_match_table, &pdev->dev);
> -	if (!match)
> +	dev->data =3D of_device_get_match_data(&pdev->dev);
> +	if (!dev->data)
>  		/* Default legacy match */
> -		match =3D &orion_wdt_of_match_table[0];
> +		dev->data =3D orion_wdt_of_match_table[0].data;
> =20
>  	dev->wdt.info =3D &orion_wdt_info;
>  	dev->wdt.ops =3D &orion_wdt_ops;
>  	dev->wdt.min_timeout =3D 1;
> -	dev->data =3D match->data;
> =20
>  	ret =3D orion_wdt_get_regs(pdev, dev);
>  	if (ret)

While reviewing this patch, I noticed a pre-existing issue in the probe
error path.

If watchdog_register_device() fails later in orion_wdt_probe(), the code
jumps to the disable_clk label:

        ret =3D watchdog_register_device(&dev->wdt);
        if (ret)
                goto disable_clk;

[ ... ]

disable_clk:
        clk_disable_unprepare(dev->clk);
        clk_put(dev->clk);
        return ret;

Since devm_request_irq() is used to allocate the interrupts, the devres
core will automatically free them only after the probe function returns.

Does this create a teardown window where the clock is explicitly disabled
but the interrupts remain active?

If a watchdog pre-timeout interrupt fires during this window, could the
handlers (orion_wdt_pre_irq or orion_wdt_irq) attempt to access
memory-mapped hardware registers while the clock is turned off, resulting
in a bus fault or system hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519003742.6264=
77-1-rosenp@gmail.com?part=3D1
