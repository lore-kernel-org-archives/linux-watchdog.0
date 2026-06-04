Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63799175A64
	for <linux-watchdog@vger.kernel.org>; Thu,  4 Jun 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535617; cv=none; b=l/Ju54TRwuM5rb8hZyf2vg5f582rO4+YMRvXFehXYdPrgvZ+BgStCHmiuS8arGMZZqWpNh4dhTgl7MNOD9oz29sCQOZ5C37uodF3aEgZgfKpam2J6Y3cmRcJfeHSFMHeAkWj1jOefYtbZ4n/XYiOzvXUKoDrHTW5V/KP73+Or9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535617; c=relaxed/simple;
	bh=ur3HnI0nCtOLuLXLP7vTZiU4UIGS7aUcOLgB27Y6vRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=memuZbmTNKdkoFWT/16XR5HILBSjs7f9N5I9JCFYummTpN0NWEnKLZ8Vc0esImxtgtdFbkNig8ELJUYp7EnUMwPWhuAZOMxq9tTfZCUJErJzvXUnb+GU1bTdHiE+Y3qKGII1Fo0IANjx5/fRnTtYWUc/jqAlpfY9DUkitgSeMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJLRRpSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJLRRpSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DEF1F00893;
	Thu,  4 Jun 2026 01:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535616;
	bh=T+Ct0nONqaZrrS0yzALWtrT80NwnTz3emBALhtt4fzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJLRRpSe2H6hSOwugzK/DwrwLnZvSTDwumVhiO8O/qslkuoLmQbxIz0tDDx2llte0
	 nbnOzCX/DkMud32/Nmq5uUiBFYt2CZiTqVzvmQqTIUK18nIFnocFM+EZZUGYF1yC9k
	 B8HCRONtrfh0PzhgarXIe3d/qs+kUopOwMgmiAWCWzwvFKMpldoFznAV8jVHs2J3de
	 UzkjmKQpE3vJUbVgylLGwcSeuOHC+sWfKnR7aZp4TsVA5WFU+3R7XTS+D+YImRa/9h
	 zBFs7RH6EgpVk1dShw9xpG6qZkLAUmwL6LuDWCHSrS/N9mHec2fQ1uYkpirjYS946G
	 4ISdLcgMbiS4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: sama5d4: use platform_get_irq_optional()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260604010542.23177-3-rosenp@gmail.com>
References: <20260604010542.23177-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 01:13:35 +0000
Message-Id: <20260604011335.C6DEF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition leading to NULL pointer dereference if the watchdog=
 interrupt fires before probe completes.
--

commit 81aa11d20f236c5efcd53479d7c7d1601cbc92d0
Author: Rosen Penev <rosenp@gmail.com>
watchdog: sama5d4: use platform_get_irq_optional()

irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
bother with it as platform_get_irq_optional() doesn't need it.

Also handle EPROBE_DEFER.

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index b7b5b24afb34b..d218fc04b770c 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c

[ ... ]

> @@ -287,8 +286,11 @@ static int sama5d4_wdt_probe(struct platform_device =
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
This is a pre-existing issue, but since the IRQ handling is being updated
here, could this lead to a NULL pointer dereference if the interrupt fires
early?

Further down in sama5d4_wdt_probe(), the interrupt is registered and
unmasked, passing pdev as the dev_id context:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_probe() {
        ...
        ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
                               IRQF_IRQPOLL | IRQF_NO_SUSPEND,
                               pdev->name, pdev);
        ...
        ret =3D sama5d4_wdt_init(wdt, wdd->timeout);
        ...
}

The sama5d4_wdt_init() function enables the hardware interrupts, creating
a race window because platform_set_drvdata(pdev, wdt) is not called until
the very end of the probe function.

If an interrupt fires before platform_set_drvdata() completes (for example,
if left pending by the bootloader), the interrupt handler will retrieve a N=
ULL
pointer:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
        struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
        ...
        if (wdt->sam9x60_support)
        ...
}

Should platform_set_drvdata() be moved up before the interrupt is
requested, or should devm_request_irq() be passed the wdt pointer directly
instead of pdev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604010542.2317=
7-1-rosenp@gmail.com?part=3D2
