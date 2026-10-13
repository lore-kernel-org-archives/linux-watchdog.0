Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81D3890F3;
	Tue, 13 Oct 2026 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864639; cv=none; b=mBHZ6U2iz+Qo9UV1yqHoatxBLqOoyX5oYQwwqjoBsoTbc5KC+J5wVhlYeliu3sGpQDtAtISCN7F5OPupHHqr3CZpUsrtTHMCzAwGq8J3w6F8yTq+RAAfLhRYVWYyDVx+IsDVyXLlTJWevYUyMpjNcBzoG3OuciXPXPYuQoiqqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864639; c=relaxed/simple;
	bh=GYnHNUML77GQrGggzEp4DnJQEI752t2ZYn/aV6IL3KM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fDqgfiEBSfYWaeUNlctmbHj6H/3s0t34X/3IBaIzYhS8qgs6F+VGKEeF8i65YTzwoNyHKP/kMtiZwJ2f8W2+7imNgPPJFLhmodYy2nV/J//qmQwbhloMv9aN/iuATE/C+Hn8pq7p0cwkFDxpSimZaP+k5sVkQKb7yDNADwNS4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ0ZS3Wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ0ZS3Wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D81F000FF;
	Tue, 13 Oct 2026 04:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791864637;
	bh=luoTZ3x8DadDP4999uBCvznMeLY4XRsJT+8N1/TuOaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZ0ZS3WtZVfMsm2iLhejUXvAR8V5h4exYiX4klPaIX3RQK9jO6RjL041D5AXtX2on
	 9zxnxYACZ9vBSaPfd/KLJYIwTn6HT6cF0rlY3ML6LnotCCZPQeUCOauwEVuoBP7AJ3
	 DkqS3YWRODFPzLnNQVBfc8W4yDdvNmTFMhN6eJSxy+xuFcaSy4WpN+VsgCG36eoSLE
	 uYlEyuVal2coyW1m53hv8nt6nr2cw6ir7vP0bjGn0EXYeaCCZCaiH0tgbS0QD/j6lq
	 EPF2NeL0FLWMLYDOCwNX8sSAtB+rle3y62LBPNIDnkoh3DmBrijy3Vy4v7Hade4ac2
	 XG7lxZd2M4yBQ==
Message-ID: <sashiko-outbox-168963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] watchdog: Add ARM TWD (MPCore private)
 watchdog driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-s2-v2-7-94f8c0a90cda@gmail.com>
References: <20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com>
 <20261013-b4-cs75xx-s2-v2-7-94f8c0a90cda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:10:37 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] watchdog: arm_twd_wdt: stale clock rate causes spurious reboots
- [Medium] watchdog: arm_twd_wdt: boot CPU watchdog fails to restart after =
resume
--

commit 6655d83c448f4cf87494cf40f7b8891a218a895c
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

ARM11 MPCore, Cortex-A5 and Cortex-A9 MPCore systems have a watchdog next to
the local timer of every CPU. This commit adds a driver to program, ping,
and stop the watchdogs of all online CPUs together.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..a582234e3d953
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c
> @@ -0,0 +1,395 @@

[ ... ]

> +static u32 twd_wdt_ticks(struct twd_wdt *wdt, unsigned int secs)
> +{
> +	u64 ticks =3D div_u64((u64)wdt->rate * secs, TWD_WDT_PRESCALE + 1);
> +
> +	return min_t(u64, ticks, U32_MAX);
> +}

[Severity: High]
Does this calculation use a stale clock rate if the CPU frequency scales up?

The ARM TWD clock is tied to the CPU frequency on many MPCore systems. If
the CPU scales up its frequency via cpufreq, the actual clock rate will be
higher than the cached wdt->rate.

Could this result in computing too few ticks for the requested timeout,
leading to a premature expiration and spurious system reboots?

[ ... ]

> +static void twd_wdt_cpu_ping(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +
> +	/* In watchdog mode a write to the load register reloads the counter */
> +	writel(twd_wdt_ticks(wdt, wdt->wdd.timeout), wdt->base + TWD_WDT_LOAD);
> +}

[Severity: Medium]
The ping function only writes to the LOAD register. If the system resumes
from suspend-to-RAM, the watchdog core's ping worker will invoke this
method. Since it does not restore the CONTROL register, will the boot
CPU's watchdog silently remain disabled after power loss?

[ ... ]

> +static int twd_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct twd_wdt *wdt;
> +	struct clk *clk;

[ ... ]

> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +	wdt->rate =3D clk_get_rate(clk);

[Severity: High]
The clock rate is cached statically during probe. Since the clk pointer is
not saved, does this prevent dynamic rate updates if the CPU frequency
changes via cpufreq without modifying the driver?

> +	if (!wdt->rate)
> +		return dev_err_probe(dev, -EINVAL, "clock rate is zero\n");

[ ... ]

> +static struct platform_driver twd_wdt_driver =3D {
> +	.probe =3D twd_wdt_probe,
> +	.driver =3D {
> +		.name =3D "arm-twd-wdt",
> +		.of_match_table =3D twd_wdt_of_match,
> +	},
> +};

[Severity: Medium]
This platform driver appears to lack a .pm field or syscore_ops.=20

During system suspend, the TWD block loses power and its CONTROL register
is cleared. While non-boot CPUs are hotplugged and restart their watchdogs
via the online hook, the boot CPU is not hotplugged.=20

Does this mean the boot CPU's watchdog state is never restored after resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
s2-v2-0-94f8c0a90cda@gmail.com?part=3D7
