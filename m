Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E53BE633
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334412; cv=none; b=XyDCeDfk1Bkl7uiaBggNHHrenaJyiNIzdUCNTCpTuD+BnRPvw2pzRU5z20siBk8hpU9vK0iwq2nNEQTFtd7zrGPWBUmaln87+UgiXJHlyBdeKK49xny+TQf4rmyapAUIEM6kb+E7BCPmuMh6Pv1eGFTAvGC5zHGl0NYbw9KaWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334412; c=relaxed/simple;
	bh=PmZr1Z7vWlGUH7WlLErUi8I7+X2l3ZrhMP61dK6VLFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTMBFL7o7V6y5BeEfB21seX4KtZeX1dpaZCfEhwL0NlOV4Zql0roJnTPrIiksI5+v+wsTSw8gt0TfbH7Rx/cixCpTR2pFvxF2nD1yBLFuYBY5d7o2vEpnYVnBhnX8SHyg7htMUSAyUNJCnXjSbhfAT8tW0v6VIZS2XGZWI4DFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJR1w5Oy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJR1w5Oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A345B1F000E9;
	Mon,  6 Jul 2026 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783334410;
	bh=N0P9pBnetxSooSoidsjJwCpTvlq8Aw8Sv55bf2RD5Mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJR1w5OymfOdvYiFfH2RAkgl8LRFdeZOVkFT2AfkNp6FJw+ex7W6ilizEYq8HmVhC
	 pgL7l1q1Ql0t89yAr257af+EYQvGg5ynBedJ1fKYkQ+fw710D5tMf81eH92CVXZIsK
	 fUajRwv61K24dKIbAO8R7Nw8ThD3dEtfNIFFSq68VTrPHHbRWA2+tWwLkoYVFXga3Q
	 q3XgsLYM1NqLWGS4FeQb7LNwz4O4OHKWNuuof5YtZwbuxShk7HQECmjkbvZn6jPkK7
	 hyajCk8KlWk1IfFS/7Rd3yN46lLIMRfFFVCy6QUuu/PDKbqp7GKQTXfgLngw2Sr9Lb
	 FeLevlyVJk1uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:40:08 +0000
Message-Id: <20260706104010.A345B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the manual hardware timeout refresh while still unconditi=
onally switching the hardware timer base from minutes to seconds drasticall=
y truncates the remaining timeout if the BIOS originally configured it in m=
inutes, risking unexpected system reboots.
--

commit 0014048ec369e2a09098aa033aeb725449e2fd67
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

This patch updates the w83627hf watchdog driver to rely on the watchdog
core's WDOG_HW_RUNNING flag to keep a running watchdog alive during boot.
It replaces the previous behavior of manually issuing a single keepalive
during initialization.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
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
>  		}
>  	}
> =20

[Severity: High]
Does removing this explicit timeout reset create a risk of unexpected reboo=
ts?

If the BIOS originally configured the watchdog with a timeout in minutes
(for example, a timeout of 5 minutes), the hardware counter cr_wdt_timeout
will hold the value 5.

Because this patch removes the explicit write of wdog->timeout (which is
typically 60) to cr_wdt_timeout, the counter retains the raw value 5.
Just after this block in w83627hf_init(), the driver unconditionally
switches the timebase to seconds:

w83627hf_init() {
    ...
    /* set second mode & disable keyboard turning off watchdog */
    t =3D superio_inb(cr_wdt_control) & ~0x0C;
    superio_outb(cr_wdt_control, t);
    ...
}

This immediately shrinks the remaining timeout from 5 minutes to 5 seconds.

If the watchdog core's kworker is delayed, or if the system is configured
not to ping the watchdog before user space takes over, could this unusually
short timeout cause the system to reboot unexpectedly during early boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-w83627hf_w=
dt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com?part=3D2
