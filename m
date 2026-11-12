Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510530;
	b=NrLZWvj0G3cWIbmDfy6eBofqQpBo++izdspjzU/Dp87z91vpF2HKTMNWIEfV/zQDt1ky
	 GCoKsqki8GUYaS7hoY63sdh13Sfh7Me03/MILfgnatVW1Qtg59xnbiamfC4R6eadkDqkr
	 8FHAZ95GrP8JwuKxtct+vNhgJeOnjzgIOkQWxl6PbAsJYHhzS7rCMqUjy9URjBhZI3csx
	 DF0Mfebw29W30PwN+EFT9SHGUZZ5uvEI/0nnDIgo3OVArq/+GfeMmcbjurRAACVK3O+x1
	 HGbYPv61WJ7E/ailB4qr8uNTV5TQcFm8ydZ2rNbBCon3SSgXjhKRHj4P0zEBuRVXYig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510530;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zird+bGTUn76i8w5AEW1N81iN1cukhv9oAt0+Fy11bY=;
	b=p2QzHLWveae0NCEt6T7rhuKG2I4nfEVy4AELd3PfjRGmqkLTz2ldi7fCwC5o/s0zHKKq
	 xn6MtgP89O+izaCItGB6Z3W2YRIkvzzYuj/jojIUO1HV+Gap/omsNhIdWfbcFI6nlimIo
	 Q4r4QkAVkHtUymwPMii6zz0oxF2RzcIff8QbuIZLxDak4s4NEok/EVeZ5JV53X+FK7dCq
	 n+g0htqHFSKYL5dPLuw61NI/P+6Fseq4l+WY3TA3LsM0yHbuoW+LUTk0nWGH4VrwfCsXf
	 QDQOUn04ueu6emlDXlYjvcpqkLCN3y3Ps0v3bW8J3JAykDkHgcD59SuyLVD4//tuDrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFSoIYU9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C6606A31C
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFSoIYU9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751E41F000C4;
	Thu, 12 Nov 2026 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510530;
	bh=Zird+bGTUn76i8w5AEW1N81iN1cukhv9oAt0+Fy11bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jFSoIYU9bVSD9lYzuNwvqdIo6R0eQRNo4VupIVkawx4kqJW2XD8Ns6T9ShU9P12bF
	 +937jb+PGnRbgUdJTS5E9u9+5dCoU992s7CgxteadxaDJnetKhBcVfsCiDYUKzK4Bv
	 7nyurIjMrof3xVDd6+1vOq+uOyaz2otz6DXmst0eNhlYcoaNmfCc7wfic4ZLvVHjnp
	 vodHIAo+aYkLSnYP2gRWX6ojbRUd4rLH6mSE0oDCutu4bZj7kgMS7HXVmK73MzN+ni
	 ets9EvEVsssZv8dKyo5Lmb+/SMlKMZ7SQd2nPUIUe8vvasaw5Yl8stuYTG4HYxCw68
	 NMR+PzBnoKmEQ==
Message-ID: <sashiko-outbox-211746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] watchdog: Add support for VIA/WonderMedia SoC
 watchdog functionality
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261112-vt8500-timer-updates-v6-3-fd1cea645d1f@gmail.com>
References: <20261112-vt8500-timer-updates-v6-0-fd1cea645d1f@gmail.com>
 <20261112-vt8500-timer-updates-v6-3-fd1cea645d1f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:08:50 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] watchdog: vt8500-wdt: missing kernel-parameters.txt entry for
  nowayout
--

commit a5067e39729d1dac5a691d15d6ebc0e129c1a8a6
Author: Alexey Charkov <alchark@gmail.com>

watchdog: Add support for VIA/WonderMedia SoC watchdog functionality

This commit adds a built-in auxiliary driver for the VIA/WonderMedia
VT8500 hardware watchdog using the system timer's first match channel.

> diff --git a/drivers/watchdog/vt8500-wdt.c b/drivers/watchdog/vt8500-wdt.c
> new file mode 100644
> index 0000000000000..e0f838fd1d507
> --- /dev/null
> +++ b/drivers/watchdog/vt8500-wdt.c
> @@ -0,0 +1,132 @@
[ ... ]
> +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (def=
ault=3D"
> +		 __stringify(WATCHDOG_NOWAYOUT) ")");

[Severity: Low]
Should vt8500_wdt.nowayout also be documented in
Documentation/admin-guide/kernel-parameters.txt?

Because CONFIG_VT8500_WATCHDOG is a bool Kconfig symbol and the driver is
registered via builtin_driver(), module_param(nowayout, ...) only acts as
a kernel command-line boot parameter rather than a loadable module
parameter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vt8500-tim=
er-updates-v6-0-fd1cea645d1f@gmail.com?part=3D3
