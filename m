Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5F41A57E;
	Fri, 24 Jul 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885123; cv=none; b=gI6wRv4+2blKOQ9knUWQ0cPuuHvytWEGcG48Q7d3vvs05kaS24yd8+EXR7yGxieLIWt0IFkJfVlHbFN+ZROiKev46rjV78jMj/v6kxH1/hQIdEcuEDI7q06eEbvTTet8DjTF0LiJ+47BS9ME/grhm2LExmlmC8BTQEPexK23mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885123; c=relaxed/simple;
	bh=WNHjXO/UuL39xekOIK3huhNRC9yzlniUsw5SOIfMolU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfR5hFmN4qChCoXnFBuqwoBLCYV52ucP2w7V6uS8Q6o7x2qo1bco4ogOr1w/Ar+bpjQBWGx40lo0bnhPhHfUtlsYF/JOv53SAvvqugZEaT2RRNo16Wdo3Y9jKW2JVU4PgziiT2TgmxceG6a9L0LFRaapz4gancvyK847lZvFcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jykeq5T4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jykeq5T4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197D81F000E9;
	Fri, 24 Jul 2026 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784885116;
	bh=SwWfwFIGbk97BGw0fuaDSY/jq2X2DKeafxB1u6UlYcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jykeq5T4lcitCRknHsPZkXqJ7rDefI/G8mUviGG2JGpnLslp3IcSijEQMjnZvsXwh
	 APJvKX+nnZad8Pzp7CjIEJgZ7q2HjuYWfcXCRPKrg2eHMNQNCWoV1ZgVnRJixEdGzc
	 /AJiGmf++jgKjlvVixP7k2Obhk3KexqvrKTM/qbQVXEijKgu2mQsfm0MzvH5HT4Ibw
	 sYWsS07XiTmZOBlFmA645qAd4AmXVWvvHJvcOEjD64KyPaJdFLw8NkM3ul8WcPJAx3
	 clXX3+RYRu2vor2dmjatlVJsgMGY79X1zp/pkhCfLSNVu0VZ+RMPX2fY8+v/CjBWcp
	 gOytgYcU48P5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi-Yu Chen" <zychennvt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260724091427.1689980-4-zychennvt@gmail.com>
References: <20260724091427.1689980-1-zychennvt@gmail.com>
 <20260724091427.1689980-4-zychennvt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:25:15 +0000
Message-Id: <20260724092516.197D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Read-modify-write operations on REG_WDT_CTL do not mask write-1-to=
-clear (W1C) flags, leading to unintentional clearing of pending interrupts=
 or reset flags.
--

--- Patch [3]: [PATCH v2 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 =
SoC ---
commit a67dd4dd104040028c3121676f3993b8ca0f94db
Author: Zi-Yu Chen <zychennvt@gmail.com>

arm64: dts: nuvoton: Add WDT node for MA35D1 SoC

This commit adds the Watchdog Timer (WDT) device node to the Nuvoton
MA35D1 device tree. It defines the register space, interrupt, and clock
for the watchdog controller.

> diff --git a/drivers/watchdog/ma35d1_wdt.c b/drivers/watchdog/ma35d1_wdt.c
> new file mode 100644
> index 0000000000000..e5247e55dfee4
> --- /dev/null
> +++ b/drivers/watchdog/ma35d1_wdt.c
[ ... ]
> +static int ma35d1_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D watchdog_get_drvdata(wdt_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	val &=3D ~WDTEN;
> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);

[Severity: High]
Does this read-modify-write clear pending write-1-to-clear (W1C) flags?

If IF, WKF, or RSTF bits are set when this reads REG_WDT_CTL, writing the
value back without masking those bits will unintentionally clear them, which
could result in dropped interrupts or wakeup events.

[ ... ]
> +static int ma35d1_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				  unsigned int timeout)
> +{
[ ... ]
> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	val &=3D ~TOUTSEL;
> +	val |=3D FIELD_PREP(TOUTSEL, i);
> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);

[Severity: High]
Does this update silently drop pending interrupts?

By performing a read-modify-write without masking out the W1C bits (such as
IF or WKF), any currently pending flags will be written back as 1s and clea=
red
before they can be processed.

[ ... ]
> +static int ma35d1_wdt_suspend(struct device *dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&ma35d1_wdt->wdt_dev)) {
> +		u32 val;
> +		int ret;
> +
> +		guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +		val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +
> +		if (device_may_wakeup(dev)) {
> +			val &=3D ~RSTEN;
> +			val |=3D (INTEN | WKEN);
> +		} else {
> +			val &=3D ~(WDTEN | RSTEN);
> +		}
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);

[Severity: High]
Could this lose a race with a wakeup event?

Writing back the modified control register without clearing the W1C bits fi=
rst
will unintentionally acknowledge and drop any wakeup or interrupt events th=
at
occurred just before the read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724091427.1689=
980-1-zychennvt@gmail.com?part=3D3
