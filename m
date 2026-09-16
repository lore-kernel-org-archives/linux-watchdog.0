Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C74A8A2F
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551577; cv=none; b=j5OVAGLCqk/O2710xqZPc8ihuyvlasaIRmnXTxIC5Sgm4TeXSWavtflp25Zs1jJWac7f/6znu9PDDV20XHxmVGgHX+9YmYMk6Try+mPC73AdA3j4lR7TE3X0uRWyv7iGFT4rx80A3njLd2jeK+bmFbtbxcZTKg+Nb2N5Ttjevqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551577; c=relaxed/simple;
	bh=zNCmfBxQjE7eMMWgWhxZR6Qphj8bPhySbup6/eW9C9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ugj7yRtryAleYr/VF7jUvz/1/HRm6GcNoIbC3nW8bdmwt/PKld+U2t90+B33m+mkRRg4jGAmjDo6h1cnWQPBZLEmRoqQvbA8aoOtghHpVjrwOMRceDLKKkwYeam8XeEfjdaXPmq/qbkTKc8DRKrE8fOVKw716Y2MlKURTUdOMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFdu7rXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFdu7rXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D49D1F000FF;
	Wed, 16 Sep 2026 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789551566;
	bh=b/9Iwl1NUNzpOzQSKk37cmxJYbSB5HRBLAjbgiOk+FA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFdu7rXDI021EZ1orln4D71UA+GWh+5k9XaqaybcYUEYgixE2eSIbwPJWW1S8LpDD
	 oPu4ZBMJHN5Dpkmd7ro+h+1nd0MIVYY/W9UK64FFZSkQeZ/UC5qCk3r3AxWoQXcclN
	 svlewJH4HOBM3NpBv4gsPQNBOhkZloZlg3kV04TTVyBaTqUyEXXvRQzk5hHCvx5FcV
	 bMMf7NDI7LUK0wjSMnpUCxlbY2P0uKcky8arb5H+jdch0pdsM7j4bmMqpt2kMSCm4Z
	 IIhQ5e4SHybk5ge5X1KYgqHcQ3nxkGNpMJdGSezQcF4SiTfJTp4xokHSpf5Rz113eQ
	 G69wQQaxHjI5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: npcm: Propagate errors from clock enable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260916092753.187583-1-triet.hoang.dev@gmail.com>
References: <20260916092753.187583-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:39:25 +0000
Message-Id: <20260916093926.3D49D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] watchdog: npcm: software timeout desync on start error causes unin=
tended reset
- [High] watchdog: npcm: aborting restart handler on clock error hangs syst=
em reboot
--

commit cc8288f5db182802c807c8255052dea000706adb
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: npcm: Propagate errors from clock enable

Check and propagate errors returned by clk_prepare_enable() when starting or
restarting the watchdog. Also propagate errors from npcm_wdt_start() through
npcm_wdt_set_timeout() and probe to prevent the driver from silently
continuing when the watchdog clock cannot be enabled.

> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 51348969bf492..0976a580b9f21 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -149,8 +149,11 @@ static int npcm_wdt_start(struct watchdog_device *wd=
d)
>  {
>  	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
>  	u32 val;
> +	int err;
> =20
> -	clk_prepare_enable(wdt->clk);
> +	err =3D clk_prepare_enable(wdt->clk);
> +	if (err)
> +		return err;
> =20
>  	if (wdd->timeout < 2)
>  		val =3D 0x800;
[ ... ]
> @@ -216,7 +219,7 @@ static int npcm_wdt_set_timeout(struct watchdog_devic=
e *wdd,
>  		wdd->timeout =3D 2750;
> =20
>  	if (watchdog_active(wdd))
> -		npcm_wdt_start(wdd);
> +		return npcm_wdt_start(wdd);

[Severity: High]
Does returning an error here cause a state mismatch between software and
hardware?

Earlier in npcm_wdt_set_timeout(), wdd->timeout is modified before
npcm_wdt_start() is called:

	if (timeout < 2)
		wdd->timeout =3D 1;
	else if (timeout < 3)
		...

If npcm_wdt_start() returns the error from clk_prepare_enable(), the new
timeout value remains in wdd->timeout while the hardware continues running
with the old timeout.

The watchdog core's keepalive worker will recalculate the ping interval
using the new (potentially much longer) wdd->timeout. The hardware
watchdog, running with a shorter timeout, could then expire and
unexpectedly reset the system.

> =20
>  	return 0;
>  }
> @@ -234,9 +237,12 @@ static int npcm_wdt_restart(struct watchdog_device *=
wdd,
>  			    unsigned long action, void *data)
>  {
>  	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> +	int err;
> =20
>  	/* For reset, we start the WDT clock and leave it running. */
> -	clk_prepare_enable(wdt->clk);
> +	err =3D clk_prepare_enable(wdt->clk);
> +	if (err)
> +		return err;

[Severity: High]
Could returning an error here hang the system during reboot?

npcm_wdt_restart() is invoked via watchdog_restart_notifier() in the
watchdog core to handle system reboots. The watchdog core maps any non-zero
return from a restart handler to a notification value that aborts the
notifier chain.

This causes atomic_notifier_call_chain() to immediately break out of the
restart_handler_list loop in kernel/reboot.c.

As a result, not only does the NPCM watchdog skip its attempt to write to
the reset registers (which might succeed if the clock was already enabled),
but all lower-priority fallback restart handlers are preempted. The system
will hang indefinitely instead of rebooting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916092753.1875=
83-1-triet.hoang.dev@gmail.com?part=3D1
