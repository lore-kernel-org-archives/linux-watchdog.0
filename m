Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068F3502A9
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333975; cv=none; b=JKXJjxC79mlWC5SdIFSl7aoS2zrVv3UWUCN7o4ZLAe0BBDLxSDzqPL+17e5g3CReZvz2qPCC3v1kTOGm6IZlTjqujWeykDYCTVJQfpZ9uNd+RTyq5dnW9jOyGYWhVPr2SdXgTwF2GNwZGIwoM+fQWLhEvEzAb30v/QJCC9DUfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333975; c=relaxed/simple;
	bh=n6Ii23BVuNm7cdQfk+FEG9F615MDUH8FSE7s8GSvjRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsmGz+iRFAQ4cYT3YVX+CFdOR2DMBPKJfdO2UkZCbPguL4TlxmYUdWQRtRW+wXGetHIiTy0xAj6U4XPkcT9Kj6Fp6MahWR7+yE3hy7gT5ApZDa1G9Tv0SfagNdtEwjwr5HIl7zip4VAUK4sSY4EAkOLORddb0RMHaU6X+s5CDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjgzpB1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjgzpB1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2EC1F000E9;
	Mon,  6 Jul 2026 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333973;
	bh=axaIfOR7Ufe5+m2KM7Q34334t75IcJZ8RTlfr9KwFOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjgzpB1wEadwARb1didSpROVoj7dNyC1URbInNR5IBJNugB5JbsmnlTFOjigpzI3R
	 J651HD5fMOB5yxmoh10gUVzcxegIvRv2phLQ0PX7cfdge19whezUj/NC3uVRC8f2e/
	 k+j/5j5MDq88Zzdkoe5MEDMBFTgMXM+j5Yf1MtB42KcQpA/m+Irdc15ZFzDATYcBMG
	 wyyC++ryT2+2i0pW+B+jYMD83wabb+f6kVBCDMzVWniLSmRi7fcOmKt+eTL7vUAVK7
	 HsAzRkKMQk5cJvLfr8FRRpAvffMS5ZB4iIvVb45NCnCsXr3J+jxn9sB/2zwGFur+x5
	 y+l6JYpVKfuIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v1-2-c5b0d51691c6@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v1-2-c5b0d51691c6@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:32:53 +0000
Message-Id: <20260706103253.7A2EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the explicit watchdog timeout reset while retaining an un=
conditional switch to a seconds-based timebase severely truncates the remai=
ning watchdog timeout, causing spurious system reboots.
--

commit 8d12d1780388b6b4befd25bff1a9eac5e3d4130d
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

This commit removes the manual watchdog timeout reset during initialization
for an already running watchdog. It instead sets the WDOG_HW_RUNNING flag to
let the watchdog core handle periodic keepalives.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 9533baa453841..067831caa9648 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device *wdog=
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

[Severity: High]
Does removing this timeout refresh introduce a risk of spurious reboots
if the watchdog was originally started in minutes mode by the BIOS?

Just after this block in w83627hf_init(), the driver unconditionally clears
bit 3 of cr_wdt_control to force the hardware timer into seconds mode:

	/* set second mode & disable keyboard turning off watchdog */
	t =3D superio_inb(cr_wdt_control) & ~0x0C;
	superio_outb(cr_wdt_control, t);

If the BIOS originally configured the watchdog in minutes and the unscaled
counter value is small (e.g., 2 for 2 minutes), skipping the timeout reset
here means that small value remains in the register.

When the timebase is immediately switched to seconds, the remaining timeout
will drastically shrink from 2 minutes to 2 seconds.

Could this very short timeout cause the hardware timer to expire before the
watchdog core's ping worker has a chance to execute during a heavy boot
load?

Additionally, if CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is disabled or=20
overridden by a module parameter, wouldn't the watchdog core deliberately
avoid pinging the hardware, leading to a guaranteed spurious reboot in a=20
few seconds?

>  		}
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-w83627hf_w=
dt-nct6126d-v1-0-c5b0d51691c6@bootlin.com?part=3D2
