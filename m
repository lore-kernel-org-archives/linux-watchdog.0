Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352825A2A2
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459851; cv=none; b=RyfvdGzgeRvGqU61LPKUVf9BrPGOHa+20fhNie1opQZSFQP6ik6d7zCVEMnwRmDY0Orb6DDARAwPTlpjjGejZyduo2rBmPR+EQrJgVNGLBq6dKlln0dKlOdT8c3VPOyZ/H3Ym1rF8NlTs2WXisWQxLPEBSGHkyA6ZspfQer3zNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459851; c=relaxed/simple;
	bh=PBtqhXof4uE0LDtp6XyhYr0g5QvQCrhiHyqpb+U2T9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MB7YPIkPCaDgjcPh1/wHxtgfy2WZ2VL7R8oXH0P4/Vx9QL+zRGGbqpZlupNy5g++jLt40/LWGtDZvW3vT422G5CpUi8uXlA4VFpWjRiK+9divC/3wVggqrY5k4bj0RwNGW2QX+LjAoBh5c82hwILzWG4RA9kh11yb4+jTVBafqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxbO1s9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxbO1s9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CFD1F00893;
	Wed,  3 Jun 2026 04:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780459850;
	bh=uPWJ7UbMnWqCa/hgGbN87Iz0oHud4QTw7q29/T5+y6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fxbO1s9LyVCS8Lie6SX10ET8j9pxakWhUCmuowTHamvcZQ3MEYQAhqYh84EgAwLNX
	 UddoAYtI4zSJnOgCgr07qCbKo4hzFQ6VeeoFW7zmPZbiWPgQIwmg0gFgKi1O5m8RI2
	 PkzkV1iL7FNWYNBN2rsZrFERn1ytS7J8Dw2mHNHUXYfF/5BpN0NqVwv3cD+CXbdpMP
	 1T3vm4E+DamctBwQTY7Pvbq/PxSepprTcKZbf67/mk68207yK0Kl7kuzEfVuR4qgz1
	 M28qFUNHeVFHJRti60wTprjO97cX2X1ird83kXEEUZdxwpKGtsiTgiM+J63j6AaRFp
	 +yJPuwNJGOitQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: pika_wdt: fix timer leak and close
 race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260603040230.318998-2-rosenp@gmail.com>
References: <20260603040230.318998-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 04:10:49 +0000
Message-Id: <20260603041050.54CFD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Moving `clear_bit()` before `timer_delete_sync()` in `pikawdt_rele=
ase()` introduces a race condition with concurrent `open()` calls, leading =
to the deletion of a newly-armed timer and a spurious system reset.
- [Medium] Module teardown in `pikawdt_exit()` uses `timer_delete_sync()` i=
nstead of the mandatory `timer_shutdown_sync()` API.
--

commit a45c8a04ae522cdde52c3ffa747d60e630a011a9
Author: Rosen Penev <rosenp@gmail.com>

watchdog: pika_wdt: fix timer leak and close race

This commit fixes two timer lifecycle bugs in the PIKA watchdog driver. It
adds timer_delete_sync() in pikawdt_exit() to stop the ping timer before
unmapping the FPGA IO memory, and replaces timer_delete() with
timer_delete_sync() in pikawdt_release() while clearing the open bit
earlier to avoid a race.

> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> index 87b8988d25206..60a846cb36011 100644
> --- a/drivers/watchdog/pika_wdt.c
> +++ b/drivers/watchdog/pika_wdt.c
> @@ -127,11 +127,12 @@ static int pikawdt_open(struct inode *inode, struct=
 file *file)
>   */
>  static int pikawdt_release(struct inode *inode, struct file *file)
>  {
> +	clear_bit(0, &pikawdt_private.open);
> +
>  	/* stop internal ping */
>  	if (!pikawdt_private.expect_close)
> -		timer_delete(&pikawdt_private.timer);
> +		timer_delete_sync(&pikawdt_private.timer);

[Severity: High]
Does moving clear_bit() before timer_delete_sync() in pikawdt_release()
introduce a race condition with concurrent open() calls?

If process A closes the device unexpectedly, it clears the open bit early.
Process B on another CPU could then successfully open the device and arm
the internal ping timer.

Process A would then resume and execute timer_delete_sync(), which deletes
the timer that process B just started.

Process B would believe it successfully acquired the watchdog, but the
internal ping timer is stopped, and the hardware watchdog could eventually
reset the system.

> =20
> -	clear_bit(0, &pikawdt_private.open);
>  	pikawdt_private.expect_close =3D 0;
>  	return 0;
>  }
> @@ -291,6 +292,7 @@ static void __exit pikawdt_exit(void)
>  {
>  	misc_deregister(&pikawdt_miscdev);
> =20
> +	timer_delete_sync(&pikawdt_private.timer);

[Severity: Medium]
Should pikawdt_exit() be using timer_shutdown_sync() instead?

Since this is the module teardown path right before unmapping the device
memory, timer_shutdown_sync() is strictly required to permanently prevent
the timer from being re-armed.

>  	iounmap(pikawdt_private.fpga);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603040230.3189=
98-1-rosenp@gmail.com?part=3D1
