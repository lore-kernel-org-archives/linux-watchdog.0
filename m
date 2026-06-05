Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB840E8C4
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665804; cv=none; b=YNJjJXymvU7DWYTJVuuObmBA0N/mGWlgCAybYzRXIUvaqv6qCvO+J/3znFjscvEYkGDGB+UmFTNyZBuyxkmoyQstMcfFJgdC/WV0QfwPQ4VKYZOIC11+ctqG6xrrLmYljQgSNn+ZIJ/+scHPMYCmU3suqPkHXbECZrzPk8MwHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665804; c=relaxed/simple;
	bh=O/bXRqFOP3c9yxB9+PyRc1GoeAqsBJnxMhiRfK//Pv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQ4eNF/AkY2n+PPW/Ix/BlyqeINAApNYBn2NAlWTiy1L5q90VRQPkUDqFdgHpNh+YAD0iQVk7I/TGmdJyLP+rz5M/FlNX3o+GbHOSfE7t3EYmsTbKT50gp3QXVdQEaKC1dYA/WzJS2zPYKdc/Y7bLrprdFGef1CZHnRG5yFd2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcKvBddG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcKvBddG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF1F1F00893;
	Fri,  5 Jun 2026 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665803;
	bh=2HuH9GL3lxuzfjWwK4Xl16mrak23IDOUSDdkBqaCIwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcKvBddG+sBNH7r6F05jPLTAvLg3sqMVnVXtYcbqjfaQnNNKraQaYXDnUMZPaO7fl
	 ylEBXUx/XTx/qs71Es22fUEzmXc/brocVuWJpgDaBAHtIhhNT5mkBH3mNRLpce2+et
	 9UrThS3qCf7iD8kH4dlXHWvE7uX1+ODbKwo13WUQCX1Zo3uBulMHZYnJsCnCF+GNgL
	 1x+6QRXjBBaCh8czOU/M3t2eai4938r4t7dMxFOmHs3oJlyPhYAwg/vFYJvE/3hlcE
	 FylSplS/IWii++9f02thXl7i2G4/QyWYDGe6NSo8Sw4crdhw62zfETT00pt8EiXbQL
	 qVRJa92nINanQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] watchdog: starfive: balance PM refcount when
 start operation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <ea696db2019b0548b3956fbb84104b12eacc94eb.1780664848.git.william@theesfeld.net>
References: <ea696db2019b0548b3956fbb84104b12eacc94eb.1780664848.git.william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:23:22 +0000
Message-Id: <20260605132323.4EF1F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware registers are accessed in `set_timeout` and `get_timeleft=
` callbacks without ensuring the device is runtime-resumed.
--

commit 634df4af4e48b2df41f8b9f5b5a99c2ef88e4d38
Author: William Theesfeld <william@theesfeld.net>

watchdog: starfive: balance PM refcount when start operation fails

This commit fixes a PM runtime usage counter leak in starfive_wdt_pm_start()
by calling pm_runtime_put_sync() if starfive_wdt_start() fails. It also
updates the resume call to use pm_runtime_resume_and_get().

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index af55adc4a3c69..ed8c5711a3853 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -371,12 +371,16 @@ static void starfive_wdt_stop(struct starfive_wdt *=
wdt)
>  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>  {
>  	struct starfive_wdt *wdt =3D watchdog_get_drvdata(wdd);
> -	int ret =3D pm_runtime_get_sync(wdd->parent);
> +	int ret =3D pm_runtime_resume_and_get(wdd->parent);
> =20
>  	if (ret < 0)
>  		return ret;
> =20
> -	return starfive_wdt_start(wdt);
> +	ret =3D starfive_wdt_start(wdt);
> +	if (ret)
> +		pm_runtime_put_sync(wdd->parent);
> +
> +	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying PM
runtime handling in this driver, does the driver safely handle hardware
register accesses when the watchdog is inactive?

The watchdog framework allows ioctls like WDIOC_SETTIMEOUT and
WDIOC_GETTIMELEFT to be called even when the watchdog is stopped. In the
inactive state, the PM runtime usage counter drops to 0, which suspends the
device and gates its APB and core clocks.

In drivers/watchdog/starfive-wdt.c:starfive_wdt_set_timeout():

	starfive_wdt_unlock(wdt);
	starfive_wdt_disable(wdt);
	starfive_wdt_set_reload_count(wdt, wdt->count);
	starfive_wdt_enable(wdt);
	starfive_wdt_lock(wdt);

And in drivers/watchdog/starfive-wdt.c:starfive_wdt_get_timeleft():

	count =3D starfive_wdt_get_count(wdt);
	if (wdt->variant->double_timeout && !starfive_wdt_raise_irq_status(wdt))
		count +=3D wdt->count;

Since these functions directly access MMIO registers without ensuring the
clocks are active via pm_runtime_resume_and_get(), could these unclocked
bus accesses trigger a bus fault or panic if called by userspace while the
watchdog is inactive?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780664848.gi=
t.william@theesfeld.net?part=3D1
