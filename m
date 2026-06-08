Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A938C2D8
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949769; cv=none; b=hJ2+nw5KH330m0c0QvvN+7QpZl74ez+s0zor8WVAIzhlL39K1DyCgaRx7EQeWHgxBvNwevmTy7l4d7mmhUOkUJDjYUrzLma9/27ENVDCEg2sU7MsEg48YfgEKIBZV4uJOxE5xRcEr8IqfpMF25XCO3/b4cVZM8101pmbyg/vnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949769; c=relaxed/simple;
	bh=b6PGJV8dh7GjcweQqfFFWInm6NO1son4sIUh3h+4sKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNAxyFlnRy9nsUCsKOJW+VGJYPRQx5r1FjchWHiIXsMCwrsv5l+oGNsUAWkz5fVWkkKfzDL7ufvvubFAAXb9V+KgCLYWV4hzorNJhVg4jbbF/P8BOVo9g79koWZdhFez0lkvqfbv2xf9nGJyWPiDmCkhL0cfzfXXky+qeaYZVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7bx5D7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7bx5D7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE3E1F00899;
	Mon,  8 Jun 2026 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949768;
	bh=mYtYV+LDOxBn/d7nl9jK6qGD6IUzKU6T0NWvpW/sjfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7bx5D7NilG7NNpizkggDRp92W1hRCXxfMS7RwxtfI2UabOwSjf1sOW93YlB+2JOD
	 YvblbKYnHIo+zlz6JCJGJTcfF8I1eTqFp96+3I5LOmTBgKHvDmGdNsqn9fqHreTb1s
	 DccuNELa9l78OltnBpdo24U8MtfFw5IIKAcvhCcXwbLd8eBVzb9Sv8iO+w/dA0kXdZ
	 Eo6nX1tiLr83aONTCjKFMl+YlmAHaorGHwmRfxPMT3LB3tq6+aQR/+T8wTHUsGoD4y
	 /p9lxU4wKkLv3feKXnjwxYWDGgZbK5P6151pSErlLctibo0RQLStimRypcMqE7Thc1
	 zqKMTix1xQPmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 2/3] watchdog: sama5d4: use
 platform_get_irq_optional()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260608200933.18669-3-rosenp@gmail.com>
References: <20260608200933.18669-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:16:08 +0000
Message-Id: <20260608201608.AAE3E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The interrupt handler relies on platform drvdata but is registered=
 before drvdata is set, which can lead to a NULL pointer dereference.
--

commit 6a0bceec2bdd17bb8ca5d9b9518a193041169703
Author: Rosen Penev <rosenp@gmail.com>

watchdog: sama5d4: use platform_get_irq_optional()

This commit replaces irq_of_parse_and_map() with platform_get_irq_optional()
to avoid needing irq_dispose_mapping() on failure. It also adds handling for
-EPROBE_DEFER.

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index 13e72918338a2..e12499547d735 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c

[ ... ]

> @@ -286,8 +285,11 @@ static int sama5d4_wdt_probe(struct platform_device =
*pdev)
>  		return ret;
> =20
>  	if (wdt->need_irq) {
> -		irq =3D irq_of_parse_and_map(dev->of_node, 0);
> -		if (!irq) {
> +		irq =3D platform_get_irq_optional(pdev, 0);
> +		if (irq =3D=3D -EPROBE_DEFER)
> +			return irq;
> +
> +		if (irq < 0) {
>  			dev_warn(dev, "failed to get IRQ from DT\n");
>  			wdt->need_irq =3D false;
>  		}

[Severity: High]
This is a pre-existing issue, but since the interrupt is registered
with IRQF_SHARED shortly after this, could the handler fire before
platform_set_drvdata() is called?

In sama5d4_wdt_probe(), the interrupt is registered like this:

	ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
			       IRQF_SHARED | IRQF_IRQPOLL |
			       IRQF_NO_SUSPEND, pdev->name, pdev);

Because it is shared, another device on the same IRQ line could trigger
an interrupt immediately. The handler then retrieves the wdt pointer
using platform_get_drvdata():

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
	struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
	...
	if (wdt->sam9x60_support)
		...
}

However, platform_set_drvdata() is only called at the very end of
sama5d4_wdt_probe(). Would this result in a NULL pointer dereference
if the interrupt triggers early? Should platform_set_drvdata() be
moved before the interrupt is requested?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608200933.1866=
9-3-rosenp@gmail.com?part=3D1
