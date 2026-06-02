Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E338D6B8
	for <linux-watchdog@vger.kernel.org>; Tue,  2 Jun 2026 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373439; cv=none; b=oEyXhSvoMyBcZUrRtJdxwQbO965BmJvFdgCLFUqi9m7c8W4KOg47LCv/w/lf/yflT3i2pTFPcbs5s/uXDap4x43lf0bCBBNesjkMM3FJ0hPssCWHS5q/V2O2zONz6i8pNrB+pC5zSuLlNsRydz22rf/AWVRZel10wJJ9u6Drueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373439; c=relaxed/simple;
	bh=5dp1kowQepaLrd1ltqfnHWJkiePnD5GMMGlmEePhoQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YWXK/FjhHzdxFnbuLb6Qo3gZJXHzKQIgeaLm3EOleCvCw4/gDclKXRawdBGyNyoM5zcdMgyRWA1eelXjNe0ZGVo82KYimtA93CKJmT8leXBd+KEKbjfRlV18AM35h44O/DGh/+Rq9aEnYcaWc38tuD/1G87jJeJCPfmEq9v4/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbpS2c72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbpS2c72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EA61F00893;
	Tue,  2 Jun 2026 04:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780373437;
	bh=Y+6CrsqqxJnpnq46Bs4iZigbhC7WGZaqEeErx/ex0RE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbpS2c72u3oytwGwiYh2iLCOUOoEhp9LmVzH2an6z3+BBzY+vornPj/Jlb/038NOt
	 po5D+90DmrWe4FwJu62ERhUxVnaqg0CLsKyaxe+FfF7nFcA3CTlzEu27umitIImpjr
	 OpL5tI2qIPmZ8M3xfbak5ZMLkf9H1lyvDxS5M5vO6Vt/CqiS0ecs1GvwAEK93YRTxz
	 qdTMrv1zLu4JEoWVD/BTECFjA44Dp2JnVf+iZXd53z/CBz2Kn01xBnB7k4WIlK174v
	 sE99eVmUl0fwftjqk3k17uB9k+8RGxs/WH22EClG9I1RNI73HcnJpXf1F9ilj7Swcb
	 g+1ZVoOdAKAyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: pika_wdt: replace in_be32/out_be32 with
 ioread32be/iowrite32be
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260602035620.623085-1-rosenp@gmail.com>
References: <20260602035620.623085-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 04:10:37 +0000
Message-Id: <20260602041037.B5EA61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Relaxing Kconfig dependency allows compilation on unsupported archi=
tectures, causing build failures.

Pre-existing issues:
- [High] The module fails to delete its background timer on exit, leading t=
o a use-after-free and kernel panic.
- [High] A race condition during an unexpected close allows the watchdog ti=
mer to re-arm indefinitely, failing to reset the machine.
--

commit 432026085d9a8c09851b8a2cd20ef5d62df73ad1
Author: Rosen Penev <rosenp@gmail.com>

watchdog: pika_wdt: replace in_be32/out_be32 with ioread32be/iowrite32be

Convert the ppc4xx-specific in_be32/out_be32 to the portable
ioread32be/iowrite32be. Also relax the Kconfig dependency from
(PPC64 && COMPILE_TEST) to just COMPILE_TEST to get build coverage.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d..a7e53091f27c5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2065,7 +2065,7 @@ config 8xxx_WDT
> =20
>  config PIKA_WDT
>  	tristate "PIKA FPGA Watchdog"
> -	depends on WARP || (PPC64 && COMPILE_TEST)
> +	depends on WARP || COMPILE_TEST

[Severity: Low]
Will relaxing this dependency cause build failures on architectures without
I/O memory support?

Because the driver utilizes memory-mapped I/O functions like ioread32be()
and iowrite32be(), removing the implicit requirement for HAS_IOMEM (which
PPC64 previously satisfied) might allow it to be compiled on architectures
that lack I/O memory (such as S390 without PCI).

Should this include a dependency on HAS_IOMEM?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does pikawdt_exit() leak a running timer?

If the watchdog device is closed properly via the magic close character,
the driver leaves the timer running in the background. If the module is
then unloaded, the exit function doesn't stop the timer:

drivers/watchdog/pika_wdt.c:pikawdt_exit() {
        misc_deregister(&pikawdt_miscdev);
        iounmap(pikawdt_private.fpga);
}

When the kernel timer wheel expires and attempts to execute pikawdt_ping()
in unmapped memory, will this result in a use-after-free and a kernel
panic?

Could a call to timer_delete_sync() be added here to prevent this?

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
during an unexpected close that defeats the watchdog reset?

In pikawdt_release(), an unexpected close attempts to stop the ping timer:

drivers/watchdog/pika_wdt.c:pikawdt_release() {
        ...
        if (!pikawdt_private.expect_close)
                timer_delete(&pikawdt_private.timer);

        clear_bit(0, &pikawdt_private.open);
        ...
}

Because timer_delete() does not synchronize with concurrently running
handlers, if pikawdt_ping() is executing on another CPU, it can evaluate
its condition as true and call mod_timer(), re-arming the timer after it
was deleted:

drivers/watchdog/pika_wdt.c:pikawdt_ping() {
        ...
        if (time_before(jiffies, pikawdt_private.next_heartbeat) ||
                        (!nowayout && !pikawdt_private.open)) {
                pikawdt_reset();
                mod_timer(&pikawdt_private.timer, jiffies + WDT_TIMEOUT);
        }
        ...
}

Since pikawdt_release() clears the open bit immediately after, the
improperly re-armed timer will evaluate its fallback condition
(!nowayout && !pikawdt_private.open) as true on subsequent ticks.

Won't this cause it to pat the watchdog forever, completely preventing a
system reset during an unexpected daemon termination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602035620.6230=
85-1-rosenp@gmail.com?part=3D1
