Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E6440631
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231188; cv=none; b=arDBAkZs9Ucwv9wWDD4uz0CgmQ8GERtaMqF7mDXAPqHzKHUM2oQX+tmY1d2oCBHXaz88U+SeF0we+sBeZiYDuqy0OeQLaVrQ8OWXhLrtbgo4qEmL/laC0YKvO4edQirFIljW7MWH2aNxt13xrCmLhZu1wQsY3xJeaNAV6VLg7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231188; c=relaxed/simple;
	bh=q7dgXHSGLlOKzHO91t+3Cb7xgI7x/MbkuJKlEFgXCks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jKKdE79DlY/aZFdL8KL2/CLa364yq9lJuCArY4IjGICIJT5yydxou9TBAW4XpffWsLDu4V6nBKbzN2uaf4Gdp6YrHm5xMGiPonHiiiA0rHIDCD/lyn4K+4WXp9U2++zO7Oq43g+u7G4it6RZgsJ/6cMfLWWOPPqBgJVVMGOF7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVdlHxlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVdlHxlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7101F000E9;
	Thu, 20 Aug 2026 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787231187;
	bh=JJNptfP1QDUjA9jaVkDBdN4MDc9EJZOcAurrcgk1+hU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVdlHxlGWw47DWqdw8FxZ8OTpVXAKz7+MZKv9s/aRWryRfhXCj88x3oiHshHUCB+Y
	 9xUI6TgDa0i4ycR1ZUTMW0OZNh3CMhMt4MsSrbHaPfbS2AVZX06tKVDd8YQy3oNxaf
	 v0AEyFgrbOe++JEf2/DXzihFnJQDuEz6MZwA14tgxd4OemmQr6ps/MpKHM5D74unQa
	 dRwh+1fxkcDeI4xjwWLYBxBH7BGteoz/ofOfQZLZ680pOIlnjTvMXDxv+r66cF8Hq0
	 44snFGtD+nZNEWrTlUzPGHWz7ICWhv7vVrnK13lecoQ74WK/1YeMhERFrnCT4un/kc
	 ItFB5FrwbPihA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sunplus: fix sp_wdt_restart spin loop and
 timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Gaylard" <ag@ffroot.co.za>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260820125304.1583383-1-ag@ffroot.co.za>
References: <20260820125304.1583383-1-ag@ffroot.co.za>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 13:06:26 +0000
Message-Id: <20260820130626.DD7101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The infinite loop in the restart handler permanently deadlocks the=
 restart notifier chain upon failure, preventing fallback reboot mechanisms=
, and introduces unreachable dead code.
--

--- Patch [1]: [PATCH] watchdog: sunplus: fix sp_wdt_restart spin loop and =
timeout ---
commit a82fb222c63d9d961d7ca0c200d75e43dd479310
Author: Andrew Gaylard <ag@ffroot.co.za>
watchdog: sunplus: fix sp_wdt_restart spin loop and timeout

This commit increases the watchdog restart timeout to ~1.5s and introduces a
spin loop in sp_wdt_restart() to prevent other CPUs from petting the watchd=
og
before the system resets.

> diff --git a/drivers/watchdog/sunplus_wdt.c b/drivers/watchdog/sunplus_wd=
t.c
> --- a/drivers/watchdog/sunplus_wdt.c
> +++ b/drivers/watchdog/sunplus_wdt.c
> @@ -56,10 +56,16 @@ static int sp_wdt_restart(struct watchdog_device *wde=
v,

[ ... ]

>  	writel(WDT_LOCK, base + WDT_CTRL);
>  	writel(WDT_RESUME, base + WDT_CTRL);
> =20
> +	/* Spin until the watchdog resets us. This prevents any other CPU
> +	 * from petting the watchdog.
> +	 */
> +	while (1)
> +		cpu_relax();
> +

[Severity: High]
If the watchdog hardware fails to reset the system, does this infinite loop
permanently deadlock the atomic notifier chain and prevent machine_restart()
from falling back to other registered restart mechanisms like PSCI?

Since machine_restart() explicitly disables local interrupts and halts all
secondary CPUs via smp_send_stop() before executing restart handlers, is the
concern about concurrent petting from other CPUs applicable here?

Also, does this infinite loop leave the subsequent return statement as
unreachable dead code?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820125304.1583=
383-1-ag@ffroot.co.za?part=3D1
