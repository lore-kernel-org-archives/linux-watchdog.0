Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66550340A76
	for <linux-watchdog@vger.kernel.org>; Mon,  3 Aug 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741991; cv=none; b=pt2YRfHQA7Ef1MK7koCPdnqAtlJQSRYSa+oFCm/76S2C4Xubb5F4SG/ZO7dPL7M9s00LXTyOzpuGBjhVP6aNFvXqHO9md8VBaDoELZJL6Mg2J2fC3WJbrPd/nOREBAZ5U1uW/IqHX9l2bLx2PD818dEE36TU5xiYVjGeIHw68qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741991; c=relaxed/simple;
	bh=vQwd1i4xZBO7iaTf3xI+GT9zpOsStu5WkihLBXGnRgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p+vwGu3P4DwTLbax7GZEs9gHlO0drGiR16GO+Ch0YM/4a5kBsRYBISEMfYh2f8pa5twXSNTnrR9b1Wk0O1VfE0qfYD7sSNx8XRKvcwG+bbbhv1uzlupz259y2mwywvsj1kHYgvFlaz1S5nSOzBH9pBc/jKk4pye3WbppBBxl+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hayeC0BK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hayeC0BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FA21F000E9;
	Mon,  3 Aug 2026 07:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785741990;
	bh=tlUZDQLtvMovLcJV8sgBnaaO+Ahx6v4yMsYA3tqbD8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hayeC0BKDgoY0HZnFiQVab0CGmozkGB1jra1wIP1GA0nWw4YvR9bFeKTrvMR8lwDF
	 9psgpyodrbIpHv3I7jEJ9/YGUhTSbFTV+vgR1IH1s8AsNv14eRi0zE3BT2lSSstlpS
	 MmkeEr0y1HkNWSSEeBQTSHnHQw18/ZR8SJ7IaZlb9nwJ5xsdH7taw1FiPYriWcbkGr
	 LSjMDLd0Et/Usr18/zwFp6WUM189FlmybAIqDQUEAw8hnLUjXTBS/bx21jJB5PjLud
	 9EsipiyoLoOVgqV8EqJF/mgTlg3ufHWvfDej/DDa05Mq0xojBaGfWp/oy5dxKvRkQo
	 xIV/bY/I13w8A==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH] watchdog: sbsa_gwdt: add force_enable module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zexin Wang" <ot_zexin.wang@mediatek.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260803071823.27759-1-ot_zexin.wang@mediatek.com>
References: <20260803071823.27759-1-ot_zexin.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 07:26:29 +0000
Message-Id: <20260803072629.D5FA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver incorrectly modifies the global module parameter `actio=
n` during probe, which corrupts the state for other watchdog instances.
--

--- Patch [1]: [RESEND PATCH] watchdog: sbsa_gwdt: add force_enable module =
parameter ---
commit 623541ce58e645c9b614e94550edb9e275d4dbbe
Author: Zexin Wang <ot_zexin.wang@mediatek.com>

watchdog: sbsa_gwdt: add force_enable module parameter

The sbsa_gwdt driver only manages and registers the watchdog timer if it
was already enabled by a previous boot stage. This patch introduces a new
module parameter 'force_enable' to allow overriding this behavior and
actively enable it during the probe phase.

> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index e04d42cc7774d..4b49e1aeef84f 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
[ ... ]
> @@ -386,14 +392,27 @@ static int sbsa_gwdt_probe(struct platform_device *=
pdev)
[ ... ]
>  	dev_info(dev, "Initialized with %ds timeout @ %u Hz, action=3D%d.%s\n",
>  		 wdd->timeout, gwdt->clk, action,

[Severity: High]
This is a pre-existing issue, but does modifying the global module parameter
action during probe cause issues for systems with multiple watchdog instanc=
es?

Earlier in sbsa_gwdt_probe(), if action=3D1 but the interrupt setup fails, =
the
driver overwrites the global module parameter:

	if (action) {
		irq =3D platform_get_irq(pdev, 0);
		if (irq < 0) {
			action =3D 0;
			dev_warn(dev, "unable to get ws0 interrupt.\n");
		} else {
			...
			if (devm_request_irq(...)) {
				action =3D 0;
				dev_warn(dev, "unable to request IRQ %d.\n", irq);
			}
		}

If a second watchdog instance fails its IRQ setup and sets action =3D 0, a =
first
successfully initialized watchdog will now read action =3D=3D 0 when pinged.

This causes sbsa_gwdt_set_timeout() to halve its programmed hardware timeou=
t:

	if (action)
		sbsa_gwdt_reg_write((u64)gwdt->clk * timeout, gwdt);
	else
		sbsa_gwdt_reg_write(((u64)gwdt->clk / 2) * timeout, gwdt);

Could this lead to premature hardware resets on systems with multiple
sbsa_gwdt instances?

> -		 status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
> +		 watchdog_hw_running(wdd) ? " [enabled]" : "");
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803071823.2775=
9-1-ot_zexin.wang@mediatek.com?part=3D1
