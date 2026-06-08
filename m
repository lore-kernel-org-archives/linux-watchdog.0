Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955233FE36
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953218; cv=none; b=qhNIlTWCiKDPCF/j62hMz3Ld6+8MfbYopQvfRykG5blR1WM+1CRBACo3NSUpIJ01r1wV00sqNNKg4/SnVYGN2URyq4BmUzV/bXLFo65QOC3K4S4L/tzk15VV31oOgiR+1VFIhqtBAlsSpMTwq4A4FTUAuTPyqx1n7ZOs0QeIS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953218; c=relaxed/simple;
	bh=gKjg8V3TlQWL+TVdkdPKyJ+XGbHccFJPgW4nNepvi1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ouT6UJ9h7Jc5zqkZCtKOj4RS3PgLcwJp9Est/qRrXYhkmVJxRz8OUF/BM+x3ARGsWRV2eXzYAAEzL8GklPQeqquZVQuoKgFzfZDSmks5wLeKXESwrh4oujT7acrc/WRE/NneYxmesyNP/TTJ3u/z9tMBpHzgybdFDjbMsxOUR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1xQr79v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1xQr79v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8AB1F00893;
	Mon,  8 Jun 2026 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953217;
	bh=8zxc7RrJ6V14e8uouT0lsPWeirMWp7vrZ8h4KCeaG0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1xQr79vHDIm1KFT5ZN6D7ibqb8BC96ExumeI6fPNLGbQo+gPAvw39rBtBRu3mDLk
	 09hOaRxp/rtzlP0c+2kgfVAF+I5YP52DoXPwdMEKUXGYRqtxd15baycXU6/qm2OJqJ
	 JKma1oE/PccznowFLP0a48TfOWhn7uzZdgYzduB9nCzFDyoHpxMyuPrdBDmmy72Zqq
	 d9MckBQ+VScdID00dxQdkXoURdNNmklBaGp/j22mu+ypsg4JFBt2lI2fdLbkfI827G
	 2bwxKLj6dNTi3KfIqshvMvz+x8+6OXwJsXYsaYq48y7u6E5vAUAqWqP2gR2gg9FgkG
	 u7oaq56+AoE2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 2/2] watchdog: pika_wdt: enable COMPILE_TEST builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260608210402.31545-3-rosenp@gmail.com>
References: <20260608210402.31545-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:13:36 +0000
Message-Id: <20260608211337.2B8AB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `timer_delete_sync` in the module's `__exit` function lead=
s to a Use-After-Free and kernel panic on module unload.
- [High] A race condition in `pikawdt_release` using a non-synchronous `tim=
er_delete` can resurrect the ping timer and permanently defeat the watchdog=
 on unexpected close.
--

commit 6bf97a13e2f6f235845375a27efabc19c1cdb946
Author: Rosen Penev <rosenp@gmail.com>

watchdog: pika_wdt: enable COMPILE_TEST builds

This commit replaces PowerPC-specific I/O accessors with generic ones in
the PIKA FPGA watchdog driver. It updates the Kconfig to allow COMPILE_TEST
builds on other architectures and adds the required HAS_IOMEM dependency.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d..c458f60f26696 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig

[ ... ]

> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> index 87b8988d25206..2d3c201540a9a 100644
> --- a/drivers/watchdog/pika_wdt.c
> +++ b/drivers/watchdog/pika_wdt.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this driver
I noticed a potential race condition in the watchdog release handler:

drivers/watchdog/pika_wdt.c:pikawdt_release() {
    ...
	/* stop internal ping */
	if (!pikawdt_private.expect_close)
		timer_delete(&pikawdt_private.timer);

	clear_bit(0, &pikawdt_private.open);
    ...
}

If the device is closed without the magic character, pikawdt_release()
calls timer_delete(). If pikawdt_ping() is executing concurrently on
another CPU:

drivers/watchdog/pika_wdt.c:pikawdt_ping() {
    ...
	if (time_before(jiffies, pikawdt_private.next_heartbeat) ||
			(!nowayout && !pikawdt_private.open)) {
		pikawdt_reset();
		mod_timer(&pikawdt_private.timer, jiffies + WDT_TIMEOUT);
	}
    ...
}

Could timer_delete() return immediately while the concurrent timer handler
is running, allowing clear_bit(0, &pikawdt_private.open) to execute before
the handler checks the open bit?

If so, would the concurrent handler evaluate
(!nowayout && !pikawdt_private.open) as true, re-arm itself via
mod_timer(), and continue to ping the watchdog forever?

Should timer_delete_sync() be used here instead?


[Severity: High]
This is a pre-existing issue, but I also noticed a potential
use-after-free during module unload:

drivers/watchdog/pika_wdt.c:pikawdt_exit() {
	misc_deregister(&pikawdt_miscdev);

	iounmap(pikawdt_private.fpga);
}

When the watchdog device is closed with the 'magic close' character,
the ping timer is intentionally left running in the background. Since
misc_deregister() allows the module reference count to reach 0, the
module can be unloaded.

Because pikawdt_exit() doesn't call timer_delete_sync(), won't the timer
continue to execute pikawdt_ping() from freed module memory and attempt
to access the unmapped pikawdt_private.fpga I/O region, leading to a
kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608210402.3154=
5-3-rosenp@gmail.com?part=3D1
