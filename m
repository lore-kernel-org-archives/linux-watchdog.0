Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44D12C534;
	Sun,  9 Aug 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292964; cv=none; b=f7fTLqgtI355qHRMWPzxAu/Rk436YxaGhQZMm8tjrG3kT4d0uYduv/KC7T1/Ss6xXdGYAHshH0RS1ovYCgo45apWsDhsNjMG2wUKtZoc05kEOOBuUjm8wbaHTeH/Di83nrQfNXk9CsiSQ9L3Bzp1ZZjLEPHwjdPPk8AhsFx5oTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292964; c=relaxed/simple;
	bh=pybhIXOpVZLfTPKibkQtr5aagi4UEQw0Mt3bNYdqGiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=krWWeCUrcjaDUxiw1mwLMBouV+kudLoz1sKf5wSgRX8S3HZa/KYGuLALCbiRomEUmaTIoIhf+pl9ZeAeSaAN3kw6DcXqWqYy4AMVzpYB1REiZ2n4M53zIlker+UkgeLjXXB8laWeotWDT3VcNDV+1ErWshiTecxl7ih1HzxlMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0+Ye5ay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0+Ye5ay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16F71F000E9;
	Sun,  9 Aug 2026 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786292963;
	bh=TB2ckxel/cqyG/dCjnmyt+ZJb1l5dy4cEzKOD4LJiwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0+Ye5ay0Yvi4gA8UGVqGsC9tfWofBwaz+pDS3Z/k+1N5RBW1zT4gmC0zysHSJm4u
	 ZhQ7hO+ze89BJ77O1nMaThSTeBAm0NDCbGxnZnxRtTLdERDg8sR7OnrBvI6lUg2iYL
	 nSvuK9RNhJhPnS1dD7VCKbEbPA/0OT0l+OxbN1U/cuyfp7j8RCYm+BqDZhxPuh2zTG
	 V7YJKRPtJ2Dkwwp4kyHCjyi7u4N7KWDVH+eq+8jLEpkC7LTH0tauGJ/lPP2VYwfY3M
	 QER+TogwdcAlpM0+hN42CUsGhv+3PHHK8wEeu+y9ui5BqzqnY4k+3vMBR9yQ4XX0jD
	 jbsMqXHrud2jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] watchdog: mediatek: Add wdt/toprgu resets for
 MT6589
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260809160643.33991-3-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 16:29:22 +0000
Message-Id: <20260809162922.B16F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device configuration properties are parsed from the device tree af=
ter the watchdog device is registered and exposed to userspace.
- [High] The pretimeout interrupt service routine does not clear the hardwa=
re interrupt status, leading to an interrupt storm.
--

--- Patch [2]: [PATCH v3 2/8] watchdog: mediatek: Add wdt/toprgu resets for=
 MT6589 ---
commit b68277d0ead460e42db1066fa50165b7b3c50d48
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

watchdog: mediatek: Add wdt/toprgu resets for MT6589

This commit populates the toprgu_sw_rst_num field for the MT6589 watchdog to
allow toprgu resets in the device tree for compatible devices.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16f..e61f6ae743276 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c

[ ... ]

drivers/watchdog/mtk_wdt.c:mtk_wdt_probe() {
	...
	err =3D devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
	if (unlikely(err))
		return err;

	dev_info(dev, "Watchdog enabled (timeout=3D%d sec, nowayout=3D%d)\n",
		 mtk_wdt->wdt_dev.timeout, nowayout);

	wdt_data =3D of_device_get_match_data(dev);
	if (wdt_data) {
		err =3D toprgu_register_reset_controller(pdev,
						       wdt_data->toprgu_sw_rst_num);
		if (err)
			return err;

		mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
	}

	mtk_wdt->disable_wdt_extrst =3D
		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but could this cause the watchdog
hardware to be misconfigured if it's opened immediately after registration?

The watchdog character device is fully registered and exposed to
userspace before the configuration flags (like mediatek,disable-extrst
and mediatek,reset-by-toprgu) are parsed from the device tree.

If a userspace process opens /dev/watchdog and starts it right after
devm_watchdog_register_device() completes, but before mtk_wdt_probe()
finishes parsing these properties, could the system fail to reset properly
when the watchdog triggers?


drivers/watchdog/mtk_wdt.c:mtk_wdt_isr() {
	struct watchdog_device *wdd =3D arg;

	watchdog_notify_pretimeout(wdd);

	return IRQ_HANDLED;
}

[Severity: High]
This is a pre-existing issue, but does this interrupt handler need to clear
the hardware interrupt status?

It successfully notifies the core but returns IRQ_HANDLED without
interacting with the device registers (like calling mtk_wdt_ping()) to
acknowledge and clear the interrupt source.

Since this is a level-triggered IRQ, could returning IRQ_HANDLED without
explicitly clearing the hardware interrupt status cause the CPU to endlessly
loop servicing the unacknowledged interrupt, leading to an interrupt storm
and system hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809160643.3399=
1-1-l.scorcia@gmail.com?part=3D2
