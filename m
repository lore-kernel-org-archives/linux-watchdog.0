Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409231B101
	for <linux-watchdog@vger.kernel.org>; Wed, 14 Oct 2026 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018115; cv=none; b=Hxjq9HB8uerKUNxpSGSYtEMx4JuoQQBUWBqN400BJ1isSZfSzNf3wNVBF8nd6jz222Wxji3cRqBBJ8C57hXPLQGQOASpgC18lA04Uzzj32aQYn1OuBu4H4r/ESqohCz5/SF41MDdTUAqDFzUsm4ukQ3/8nYZN7SFyRIms9mRPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018115; c=relaxed/simple;
	bh=6hh1v8EA5d+dQZaaczzJePCW4SQIb60zzTdqMu692wA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ANgq6xINhz+ZaWKYtzKeY64nERwprgGB4CoTcgScEtj6gtAkRpotejP3DVB3qJYaLdTDDpKoDWCHsCiQAx9V9Dq0etX964dy/LVRm9b1ScNw+hWD+eaB7UnsbiM6plVlJu7kop8nL5GQr3CymsXkYI292y3ECkqQGhq2kPBj0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY3sXUvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY3sXUvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479031F000C4;
	Wed, 14 Oct 2026 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792018114;
	bh=D13AbjQ5bnKUyXHjREhGP87+Lf1Pl1lNX55V8FgjkoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OY3sXUvB/UU5dyETqJTvqwt+ZGlWSl8sfBHloHFqOf73x6J5QyKaG4ervARhZjCoZ
	 ADc2JIOm2ABAocDmneinDPv9T95baP2+ZnxCASKwhK8NBaiv/BhXMb6bvoQgjNuLyY
	 qij32m3XXUEcM0GXlhluLoEC+M6tZJiUs6RKNudlQZrU3zUUky36RZJZJJeFwFV17k
	 Jh/moWs5qFwVmxBGLXCWHS2JZQ6tzmcq70rnTA/nKvo2F4FaibIwlFAyE5gUGV3YPB
	 9VH4nwhsdlcpVoCGLpQ7MTNjbrNhsyLvEhg2j3o2Upn6vGmfPjBURYz3kyoGvFPJm5
	 9XWoLlFvfUEZA==
Message-ID: <sashiko-outbox-172006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: bcm7038: Add a restart callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
References: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:48:33 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: bcm7038_wdt: missing spinlock causes restart failure on =
panic
--

commit 6002003a9fe5a5243c56c551564e6ccb85d21046
Author: Linus Walleij <linusw@kernel.org>

watchdog: bcm7038: Add a restart callback
   =20
The watchdog in BCM6846 can reset the system, but bcm7038_wdt
does not provide a restart callback. Add this. The vendor kernel
also uses a short watchdog timeout to reset this SoC.

> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wd=
t.c
> index e038dd66b8198..1637e32ac02e8 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
[ ... ]
> @@ -113,6 +115,32 @@ static unsigned int bcm7038_wdt_get_timeleft(struct =
watchdog_device *wdog)
>  	return time_left / wdt->rate;
>  }
> =20
> +static int bcm7038_wdt_restart(struct watchdog_device *wdog,
> +			       unsigned long action, void *data)
> +{
> +	struct bcm7038_watchdog *wdt =3D watchdog_get_drvdata(wdog);
> +	unsigned long flags;
> +
> +	/*
> +	 * Prevent runtime watchdog operations from interfering on
> +	 * uniprocessor systems where restart handlers are preemptible.
> +	 */
> +	local_irq_save(flags);
> +
> +	/* Stop the timer before changing its reload value. */
> +	bcm7038_wdt_stop(wdog);

[Severity: High]
Can this restart handler execute out of sequence with other watchdog
operations?

If a panic or SysRq interrupt preempts a ping or stop operation exactly
between its two writes to WDT_CMD_REG, could the hardware state machine
become corrupted?

For example, if bcm7038_wdt_ping() is interrupted:

drivers/watchdog/bcm7038_wdt.c:bcm7038_wdt_ping() {
	...
	bcm7038_wdt_write(WDT_START_1, wdt->base + WDT_CMD_REG);
	<--- interrupted by panic/SysRq

And then bcm7038_wdt_restart() executes in the interrupt context, it will
call bcm7038_wdt_stop() which writes WDT_STOP_1 to the hardware that was
expecting WDT_START_2.

Would this cause the watchdog to ignore the reset command and hang the
system during reboot or panic? Additionally, on SMP, could an
smp_send_stop() IPI from a panicking CPU halt another CPU mid-sequence in
the same way?

> +	/* The watchdog does not fire with a count below two. */
> +	bcm7038_wdt_write(2, wdt->base + WDT_TIMEOUT_REG);
> +	bcm7038_wdt_ping(wdog);
> +
> +	/* Flush the writes and wait for the reset to take effect. */
> +	bcm7038_wdt_read(wdt->base + WDT_CMD_REG);
> +	mdelay(500);
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-genexis-xg=
6846-watchdog-reset-v1-1-9577d65223d5@kernel.org?part=3D1
