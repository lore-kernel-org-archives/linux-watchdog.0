Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80823E0082
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334230; cv=none; b=umCT5TbkLs/zJtdf5S8yHxVerh2DdePMMFu+xd1WlcDQml5j28cBTnXlIJ223eEWblfVyASLc6T93VL4YGAn4cx50KIQRslvyTiUvXfRp6WLLs/OmyARuZHBseWEVrXZhqm5QG2oOo2bLNzABtMzpaN9s1/cXc60nPybSpEFAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334230; c=relaxed/simple;
	bh=xlumgWaP6shBAtCt3nEZyWD4Bk/sJA2A0ObN+iZ3WdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kSHEBFV44m5unnv7GkZ1WfCMfT+gRGcwT7H+boKlITEBh0A+oBlUKfPIMw0FGYWmsJA6SqN7QdRqX1ZbVzYnic2YPPNevBx5F7VHTn9mVJMb2T8w96TABK3iZNtpgphFJq9LtbBql9qyy5iak8A5sKJBiPQ39AFPrx2BN3EFYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI9NZPPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI9NZPPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333311F00A3A;
	Mon,  6 Jul 2026 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783334228;
	bh=74EVbeMv+8TYXUme4O66w2i9QY857XHse5E0vL4ja+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nI9NZPPWfzIJ1y9rcrAkqsE3RSusUSvzC4Dzm8y4v7tcZ8Gn9L6MNWUqP5sZZcBui
	 ghRPvQl98fKEZbPrdUkuHvBOD0v4L+UA9STY/VRMCYjZdCAD39cGpw0tTK/B9R/zwX
	 c2QNOu9dBhSja5oATMxBdJ/VWJT14TNOByU9G9qx6JOVlRw9n1z0OL8AXO5MfVJQez
	 Py71tuLEtGNEPraHqCQwaBunMeHGBK1eMQTSZhhLR3I42zueawTAoygQr4Q0wTo5Am
	 4thlA+yqh8K4T/Vd8barcsvcBsRwUsOxq8hb1Cmb3P8UY6YykLRGP0jW2NOXyNnZon
	 RSt27ClO+aXQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v2-2-77af74af88ae@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v2-2-77af74af88ae@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:37:07 +0000
Message-Id: <20260706103708.333311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the manual watchdog timeout reset during driver initializ=
ation while continuing to unconditionally force the hardware into 'seconds'=
 mode causes a severe timeout truncation. If the BIOS left the watchdog run=
ning with a 'minutes' timebase (e.g., 5 minutes), the raw hardware register=
 value (e.g., 5) is preserved but its unit is instantly reinterpreted as se=
conds, leaving a window of only 5 seconds before the watchdog fires.
--

commit 41d13e5a4078e3d18e184d179b1d408461a148bd
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

This commit replaces the manual watchdog refresh during initialization
with the WDOG_HW_RUNNING flag. It delegates keepalives to the watchdog core
when the device is already running on boot.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 1f649fda8a813..5348c0f79de8f 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -240,9 +240,8 @@ static int w83627hf_init(struct watchdog_device *wdog=
, enum chips chip)
>  			pr_warn("Stopping previously enabled watchdog until userland kicks in=
\n");
>  			superio_outb(cr_wdt_timeout, 0);
>  		} else {
> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> -				wdog->timeout);
> -			superio_outb(cr_wdt_timeout, wdog->timeout);
> +			pr_info("Watchdog already running.\n");
> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>  		}
>  	}
> =20

[Severity: High]
Does removing this timeout reset cause a timeout truncation issue?

Immediately after this block, w83627hf_init() forces the hardware timebase=
=20
into seconds mode:

	/* set second mode & disable keyboard turning off watchdog */
	t =3D superio_inb(cr_wdt_control) & ~0x0C;
	superio_outb(cr_wdt_control, t);

If the BIOS previously left the watchdog running with a 'minutes' timebase=
=20
(for example, 5 minutes), the raw hardware register value (5) is preserved.

However, because the timebase is instantly reinterpreted as seconds, the
system is left with a window of only 5 seconds before the watchdog fires.

This can lead to spurious reboots during the OS boot phase before the watch=
dog=20
core or user space can issue the next ping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-w83627hf_w=
dt-nct6126d-v2-0-77af74af88ae@bootlin.com?part=3D2
