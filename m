Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB4390615
	for <linux-watchdog@vger.kernel.org>; Sat, 12 Sep 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231343; cv=none; b=oUZsure/2B8AP8H/uVgqZnj7liHoMYQT3jKKUmnmz+SB5IzzWtXAeEAXiGSkYAI7imJHnVYLQXdckOVxF5P7BB5qwNerjk7tWyhf7vrgk3kFBJRB5I2BCP2yHqpoJkXBoRLY7kccfvI8MRyUwODBwUo5S8rjKV3C0E6e5XbF6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231343; c=relaxed/simple;
	bh=OTPmDJum8M/3Sl5AL8bowZlE6yUmvEAqWdcnZwF0/+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N9z+fDvogzhLELM7Z6hcAshoSMPsBbwJ8wYdt34Wn7tvuMdIHVjzOpFXacYdKPontDxfM+N3huBDLO6asP6b9bapcBqecyGwAcwuhiVyA3fFl4GjgoR0TjVdF9BljbdqYczBcE7sFMK6DDJWZPLDSJGrwpNhIItHp7gh+sK0/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8+iL8+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8+iL8+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966851F00893;
	Sat, 12 Sep 2026 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789231341;
	bh=dMjaN2z/GYXZ4ojhbJlFexzLEg7MuSBK48qb7teOhms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8+iL8+nZpptvB3Y3XSw/Fq7nFKYGtiyvjsB0pDgfiQXBRik1HzQtMGkrOxQaFLhH
	 wVTxQaqDknrgjgL2VGnzFnrjOhcf+rW5/LIKzLXAlmVIh/CEE32mXFEPhmvH3QBY8G
	 de7fFpS2vcHmjHtlJnVzMMRWXpNVAsIUGKBwmqfMg93OSpgutFpZX8xFVuOjG4LxgF
	 vmDeweUSWlOjfK1S6587EzekDGPrKupuZt46tGXE+Xc9MROzWHmkxHkDI58zjZlWow
	 l1N/bD7x0xkeULox+xtSa2UU/82Zcm3GfOHt0NR4y7TJ82Yu8gY7AG3ZxoLawuRlk2
	 t825zZULoUL0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] watchdog: msc313e: Propagate error code in resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260912163334.28636-1-tzungbi@kernel.org>
References: <20260912163334.28636-1-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 16:42:21 +0000
Message-Id: <20260912164221.966851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `msc313e_wdt_start()` fails during system resume, the device's =
clock remains disabled, but the watchdog framework state flags remain uncha=
nged. Subsequent watchdog core operations (e.g., ping, stop, set_timeout) w=
ill attempt to access memory-mapped registers without the clock enabled, le=
ading to an external bus abort (kernel panic). Additionally, a subsequent `=
stop` operation will cause a clock reference count underflow.
--

commit be9325a33db039f8043de74057aabb9bbaef3593
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: msc313e: Propagate error code in resume()

If msc313e_wdt_start() fails during system resume, the error is
currently ignored.  Consequently, the watchdog isn't running without the
user's knowledge. Propagate the error code and print a message if
msc313e_wdt_start() fails.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index f5a5afd91b987..dc7bdd5660e65 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -191,11 +191,15 @@ static int msc313e_wdt_suspend(struct device *dev)
>  static int msc313e_wdt_resume(struct device *dev)
>  {
>  	struct msc313e_wdt_priv *priv =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> =20
> -	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
> -		msc313e_wdt_start(&priv->wdev);
> +	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev)) {
> +		ret =3D msc313e_wdt_start(&priv->wdev);
> +		if (ret)
> +			dev_err(dev, "Failed to restart watchdog (err=3D%d)\n", ret);

[Severity: High]
This is a pre-existing issue, but does leaving the watchdog framework state
flags intact when the clock fails to enable cause a system crash?

If msc313e_wdt_start() fails, the clock remains disabled, but WDOG_ACTIVE
and WDOG_HW_RUNNING are still set. The Linux PM core ignores device resume=
=20
errors and proceeds with system resume.

The watchdog core's PM notifier then calls watchdog_dev_resume(), which
immediately invokes msc313e_wdt_ping(). This unconditionally writes to a=20
memory-mapped register:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_ping() {
	...
	writew(1, priv->base + REG_WDT_CLR);
	return 0;
}

Can accessing these registers with the bus clock disabled on this platform=
=20
trigger a synchronous external bus abort and a kernel panic?

Additionally, a subsequent stop operation unconditionally disables the cloc=
k:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_stop() {
	...
	writew(0, priv->base + REG_WDT_CLR);
	clk_disable_unprepare(priv->clk);
	return 0;
}

Since the clock enable previously failed, would this extra=20
clk_disable_unprepare() cause a clock reference count underflow warning?

> +	}
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static DEFINE_SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend,=
 msc313e_wdt_resume);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912163334.2863=
6-1-tzungbi@kernel.org?part=3D1
