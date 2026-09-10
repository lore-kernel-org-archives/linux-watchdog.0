Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7D373C1A;
	Thu, 10 Sep 2026 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017505; cv=none; b=fSvepTxGB6fFWF3MxoOol0tgwaU8szMhdPzV0gJf+B6KzQuEyKp8Z5SRY1nZ6nr+cYDJvpRRaxYXseqOxr74PN/I92i/onzwTrFJNQNdLqgNLV6qM7n6K2SCAaSPyYuuM8j2mw6u8nK4lAD4OcG4FVhKmMt4ir9Ll6ZVCN6tHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017505; c=relaxed/simple;
	bh=oLytN5sGKwXVQqKjiJxYhIeCOZdT24WF9BJZxJZxxAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UF9cWEpCw89kdmHahkSPQiITNmEPiN5Xb9QgeZmVp3nsonLeCU4+yNFIHJPavsFVfk1deSIKO3onMLlxISmIk+PI5Hx9hf6f2cqsiaoL5lPuidfLy0R+UArLVRpjYMSlDxUayLFS9JnitGNLKLO1L9wUiqU3rkMiI9ObIxWPOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXH85JaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXH85JaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D780A1F000FF;
	Thu, 10 Sep 2026 05:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017503;
	bh=jVgoy28piPW1BxY3JhQfRDdVhvOrHJbwYO15FNlHsGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXH85JaImch2jvcQ/vZ5wgwqOPs2mZEpaJdgvy95fh+uPVd9TI9KaAxFLA1lVpNC1
	 gRqRZ0djXYb6noVwkL68GMj6vGIDRm7PFCtI7K5rE8dnWEb1GENJFeLth2lxZzMuWp
	 Tt9HCATOHS0dDN2d54f0tPSOKyamxB9AXOysXrBEkCLiSkwu0QiZGHVjc2heU9LytH
	 HlDM/YP+7dknqkuh6LF4kEt4b90k+fTK4CnLol4uP/51qDeL1kDvccIsvyJ2dCmQz8
	 JZt0nr0Ia3n4+RvGT2XFs7s0wgCFbZ2CBHcAKxQbCcNliHRqGSWLk3RKiT+ZOD223O
	 3sz0btMmLn4XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] rtc: pcf85363: add watchdog support with
 configurable step size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260910050747.1901440-5-lakshay.piplani@nxp.com>
References: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
 <20260910050747.1901440-5-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:18:22 +0000
Message-Id: <20260910051822.D780A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Watchdog is neither stopped nor adopted on probe, leading to spu=
rious periodic interrupts across reboots.
--

commit a09fcbd2e909232c9247652551e0a3249e36a82e
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add watchdog support with configurable step size

Add watchdog support to PCF85263/PCF85363 using the watchdog subsystem.
The 5-bit count selects the timeout with a clock step: timeouts up to
30 seconds use the 1 Hz step, longer ones the 0.25 Hz step (max 120 s),
reported back through the watchdog device. One count of margin is added
because the first period after a reload lasts between WDR and WDR-1
counts, so the timeout is never shorter than requested. Select
WATCHDOG_CORE if WATCHDOG so the device can register.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 9da4b1617f82a..2046643788fdc 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -691,6 +725,153 @@ static const struct pcf85x63_config pcf_85363_confi=
g =3D {
>  	.num_nvram =3D 2
>  };
[ ... ]
> +static int pcf85363_watchdog_init(struct device *dev, struct pcf85363 *p=
cf85363)
> +{
> +	struct pcf85363_watchdog *wd;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_WATCHDOG))
> +		return 0;
> +
> +	wd =3D devm_kzalloc(dev, sizeof(*wd), GFP_KERNEL);
> +	if (!wd)
> +		return -ENOMEM;
> +
> +	wd->pcf85363 =3D pcf85363;
> +
> +	wd->wdd.info =3D &pcf85363_wdt_info;
> +	wd->wdd.ops =3D &pcf85363_wdt_ops;
> +	wd->wdd.min_timeout =3D WD_TIMEOUT_MIN;
> +	wd->wdd.max_timeout =3D WD_TIMEOUT_MAX;
> +	wd->wdd.timeout =3D WD_DEFAULT_TIMEOUT;
> +	wd->wdd.parent =3D dev;
> +	wd->wdd.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	/* Fixed default timeout; userspace can change it via WDIOC_SETTIMEOUT.=
 */
> +	pcf85363_wdt_select_clock(wd);
> +
> +	ret =3D pcf85363_clear_flags(pcf85363, FLAGS_WDF);
> +	if (ret) {
> +		dev_err(dev, "failed to clear WDF:%d\n", ret);
> +		return ret;
> +	}
> +
> +	watchdog_set_drvdata(&wd->wdd, wd);
> +
> +	return devm_watchdog_register_device(dev, &wd->wdd);

[Severity: Medium]
Since the watchdog configuration registers (CTRL_WDOG and CTRL_INTA_EN) are
battery-backed and persist across system reboots, could the watchdog already
be running when the driver probes?

The driver does not clear the watchdog interrupt enable bit (WDIE) during
probe, and pcf85363_watchdog_init() registers the watchdog but neither stops
the hardware nor sets WDOG_HW_RUNNING in wdd.status.

Without WDOG_HW_RUNNING, the watchdog core will be unaware the hardware is
active and will not automatically ping it.

If the watchdog was started before a reboot or by a bootloader, will this
cause it to continuously expire and perpetually trigger the interrupt
handler, resulting in repeated "watchdog timer expired" warnings in the
logs?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910050747.1901=
440-1-lakshay.piplani@nxp.com?part=3D5
