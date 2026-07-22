Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3703E2751
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710700; cv=none; b=E2kuaprWEpsZAV9QZHAIvpVjnfT0nAAA9W+E+NUNOn3vkfpTlrbEbJytq95Qbw7odclWZWEI7akoEJV36kb2+7WCHv9x3L01RT9Qqf7X2tb2L44uK5cCbljPjEVYIycvSH1wv7qDHWg0UVkqVKf7n2RsnAh6Ajb8Rx47RJZvniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710700; c=relaxed/simple;
	bh=8anSYao6XeEfoaWhuA3FdRVYpj8+077IolBHdrM5bnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcwRvz+syvpOY8rKjy6NyPr7d45ussTd7W72CE/SvF9yVKAY+HENIRLnZerQWbnw8r5gV1/t2AbO5LzRvjFF9aL/7CUdouzIhIKcDUBz975R+3gBsqGaROiNeBV8Il81AJKNUQ5L+Z+7x8jI93xqXSYAzs4aa+HvMTvNUv9UdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt7CfHvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt7CfHvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495211F000E9;
	Wed, 22 Jul 2026 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710699;
	bh=ot0+dExQmFuCU44QUYf42O+fjvAbhKxFnCKaAkP7d8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bt7CfHvbpYYCnrttWpeTQk5JTtcB8IhO4N3YfUj1kTvsB57AS77zdm7v4l9fPSLZ5
	 TqI8FOyHRlb6LFN2hRkiBHXBO95w/HvMdUTIZ1iJf45IgN91qagdehA4pWrLfRzam4
	 +FZ2ZlQ/QXm/gv/j75GpTghCz7HXIpvh+vKUvZsjruIyELICPypnPefv9QWgNIjny/
	 6Dvk5Szw+oJX03dHIE7QCYdWQW+FO2yJ8d4HxlPU43BAjVsNxAXM6NLC2T5O2ksm4o
	 9X4dEsSnpOYAw0OA17nd0GpgycW2sdIEbThXdfqoda3rT06DIdvCM4URWgCGs1e0R8
	 dqzY3Zpek7J8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] watchdog: bd96801_wdt: Remove redundant
 dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-2-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-2-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:58:18 +0000
Message-Id: <20260722085819.495211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect unit conversion drastically reduces max_hw_heartbeat_ms,=
 causing excessive I2C traffic or unexpected reboots.
- [High] Missing NULL pointer check for dev_get_regmap() leads to kernel pa=
nic.
--

--- Patch [1]: [PATCH 1/9] watchdog: bd96801_wdt: Remove redundant dev_err_=
probe() ---
commit e5ff79584985ca3f41c7aadbe71a7bb46a6c07a7
Author: Pan Chuang <panchuang@vivo.com>

watchdog: bd96801_wdt: Remove redundant dev_err_probe()

This patch removes a redundant driver-specific dev_err_probe() call from
bd96801_wdt_probe(). The function devm_request_threaded_irq() automatically
logs detailed error messages on failure since commit 55b48e23f5c4.

> diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wd=
t.c
> index 12b74fd2bc052..6a1c5a4d39bfd 100644
> --- a/drivers/watchdog/bd96801_wdt.c
> +++ b/drivers/watchdog/bd96801_wdt.c
> @@ -390,8 +390,7 @@ static int bd96801_wdt_probe(struct platform_device *=
pdev)

[Severity: High]
This is a pre-existing issue, but does this code cause a severe performance
regression or unexpected system resets?

Looking at bd96801_set_heartbeat_from_hw() in drivers/watchdog/bd96801_wdt.=
c:

drivers/watchdog/bd96801_wdt.c:bd96801_set_heartbeat_from_hw() {
        ...
        w->wdt.max_hw_heartbeat_ms =3D (fast << sel) / USEC_PER_MSEC;

        if ((conf_reg & BD96801_WD_TYPE_MASK) =3D=3D BD96801_WD_TYPE_WIN)
                w->wdt.min_hw_heartbeat_ms =3D fast / USEC_PER_MSEC;
        ...
}

When the driver probes and the watchdog is already running, this reads the
hardware timeout. The hardware value is in units of 100 microseconds. To
convert to milliseconds, it should be divided by 10. However, the code
divides by USEC_PER_MSEC (1000).

This reduces the reported max_hw_heartbeat_ms by a factor of 100. If the
value rounds down to 0, the watchdog core will incorrectly assume the
hardware can handle large timeouts and schedule pings based on the user
timeout, triggering a system reset on boot. If it evaluates to a small
non-zero value, the watchdog core's worker thread will aggressively wake
up and ping the I2C device, causing extreme I2C bus contention.

[Severity: High]
This isn't a bug introduced by this patch, but can a missing NULL pointer
check lead to a kernel panic?

Looking at bd96801_wdt_probe() in drivers/watchdog/bd96801_wdt.c:

drivers/watchdog/bd96801_wdt.c:bd96801_wdt_probe() {
        ...
        w->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
        w->dev =3D &pdev->dev;
        ...
        ret =3D regmap_read(w->regmap, BD96801_REG_WD_CONF, &val);
        ...
}

If the parent device lacks a regmap (e.g., due to a malformed device tree or
a parent driver initialization bug), dev_get_regmap() returns NULL.

The driver unconditionally passes this pointer to regmap_read(), which will
dereference it and cause a crash.

>  						IRQF_ONESHOT,  "bd96801-wdg",
>  						NULL);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, ret,
> -					     "Failed to register IRQ\n");
> +			return ret;
>  	}
> =20
>  	return devm_watchdog_register_device(&pdev->dev, &w->wdt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D1
