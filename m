Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625742048D
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378390; cv=none; b=FVE6qKDDRt4kjyhrPtRc9/doUpbew+yUYM6ECfT0yHOM0VNH692MePuYJXPB8vsYyQQO5OEmAfShg0OKLg8FQwlp0gvvnwQmMj/7let8k9CuWGu6jqmHyrAIPSSTkQEMfuUuS4HVKz/5ZWXjiuy0vLE1Cikiq4g73dqxUS/VHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378390; c=relaxed/simple;
	bh=NbrahKs/T7g9xM0ztO4MU7OnigdiBcYwwkh8SAoqces=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZoKfCLCoTjf4WinsWbvTGFZB54x+I/PIG7PrvxxuuJTyMcfJHOHuVvZk33oCRnBX0EI8iqKDN+UO5QiH5Llu4TMQ2MBTAEo+hh4MlFboBnc0RjEh++RA82psWrLx2memulDICtwKvAOyghTcwSkqabBLRguyTyMCQOR/1p+NcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj6ouL4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj6ouL4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251281F000FF;
	Mon, 14 Sep 2026 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378388;
	bh=wrYN3/QqP16NVBJeacplwwGk8VuEoB6AyKBfjexDDdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kj6ouL4gpPUdgFqh3y1irhficJ9EAStc1YnsWFI5fLQlGM2psQOiC88fyG63sL+5l
	 e6yiIcl0hdDCGep6Zk+i4nvnvq8k53eStcOztiQmqGRIzdEyHW9nsCR6O8drqnMXYW
	 HSsd61HFG7uR0WdjHlp6QppQGpkUrrZ6JtEO6MCtatC8rVz04NXWKD48vEVL7lGFgo
	 SQ7Ee5s5+ZMh6y0mLnp5GBKzOcQMJDXW/Hvcn1W7bqVc1A0mA5ataXQeW+jfK/jwkA
	 1WztSa0SdLzgWhpzBTS6jdfA5RUtH6klHPOigs6fKfdk4pznGdgNE1RiILXAXLYmWN
	 GbIUXuuVuKX0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] watchdog: pm8916_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260914085451.891675-7-triet.hoang.dev@gmail.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
 <20260914085451.891675-7-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:33:07 +0000
Message-Id: <20260914093308.251281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The watchdog will trigger a system hard-reset during suspend if it=
 was started by the bootloader but has not been opened by userspace.
--

commit b8ef3a1624c2c7748578b550a5051929133ba830
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: pm8916_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_ptr().

> diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
> index 007ed139ab965..b97c132de3216 100644
> --- a/drivers/watchdog/pm8916_wdt.c
> +++ b/drivers/watchdog/pm8916_wdt.c
[ ... ]
> -static int __maybe_unused pm8916_wdt_suspend(struct device *dev)
> +static int pm8916_wdt_suspend(struct device *dev)
>  {
>  	struct pm8916_wdt *wdt =3D dev_get_drvdata(dev);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
in how pm8916_wdt_suspend() handles the hardware watchdog.

Could this trigger a system hard-reset during sleep?

Looking at the rest of pm8916_wdt_suspend(), it only stops the watchdog
if it is active:

	if (watchdog_active(&wdt->wdev))
		return pm8916_wdt_stop(&wdt->wdev);

If the bootloader enables the hardware watchdog, the driver's probe function
detects this and sets WDOG_HW_RUNNING. However, if the system suspends befo=
re
userspace opens the watchdog device, WDOG_ACTIVE will not be set.

Since watchdog_dev_suspend() pauses its background ping worker thread during
suspend, and pm8916_wdt_suspend() only checks watchdog_active(), the
hardware watchdog is never stopped.

Would it make sense to check both watchdog_active() and watchdog_hw_running=
()
to ensure we stop the hardware timer before sleep?

[ ... ]
> -static int __maybe_unused pm8916_wdt_resume(struct device *dev)
> +static int pm8916_wdt_resume(struct device *dev)
>  {
>  	struct pm8916_wdt *wdt =3D dev_get_drvdata(dev);

[Severity: High]
This is also a pre-existing issue, but the resume path also fails to restart
the watchdog if it was previously kept running by the kernel without an
active userspace owner:

	if (watchdog_active(&wdt->wdev))
		return pm8916_wdt_start(&wdt->wdev);

Would we need to check watchdog_hw_running() here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914085451.8916=
75-1-triet.hoang.dev@gmail.com?part=3D6
