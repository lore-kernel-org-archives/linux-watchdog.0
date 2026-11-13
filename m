Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577051;
	b=1g5ACjO8YAf2dqv6h34ZSqx2I2FLmsNtn2glrTN+TlgcWovA5nXhfe/O+Y0hgiYb2P8q
	 KWo1N1oVN/txAddvnNrLVwTbVV8jWbQM/1gB+uRmBcbQg2Vom1IOjZvQ2osCwfBLo0xjx
	 ysxOm/htc959607vvIFLqkupaDSmuOCGhhsbLj+40OTYUTFChuwIbHlPXEsKih7xHuhSb
	 3NWyo8EsaCZmzKwjY7yGRvK2JAKC5tDsfr3IOqIL1nkj5swCwe0pgV/w6XvHfIyMpXpuX
	 VNFHOAteQi1IirwZToVqrjaFnf2FLAXRdxdEilHVX7wl+vlUccjihm38tzq7iFYE5UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SxuVLN1oHG/NurNmo3Qw3FrBQYwjDqWRosKmz5NPFNo=;
	b=1o3bfAdKjt5Bu1UaiKAgrIQxGbVkxxvqUCCkhC6G81o5Hx8X7JbrVg7E9I9+agS7Flbc
	 ICLBW5/lvzee3LEwIs3wGE12pFujMzvnzuz+IBbbR6zhyMs3gMzSfl0ZaqTCZ30eFvUN2
	 Ya5lJ3ITURv5/ro9Jx/mvKLraU4MbpFK1JZZ9PPSClEe16W9ko2u3oBRPxP0H49op4rL+
	 iT6W29yVgqsyx/DIz0eLD4gpMkjoDSiG0zPb/KU8AUA8PFUBdWGnDm59U1wuYANR26ai4
	 ZpjywqK5u6C92zfyWAAJwJm7WZqwHb6tmWZjr9go3AWEYUmsZGJEM5YIAzylfcuY7MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIQz6alm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BF606A32D
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIQz6alm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3819A1F000C4;
	Fri, 13 Nov 2026 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577051;
	bh=SxuVLN1oHG/NurNmo3Qw3FrBQYwjDqWRosKmz5NPFNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UIQz6almt47H47VqnP4Ambj3sZ17qrD6ufzfWEK2tZggx6c31OcXJOIiMKAhi5OoG
	 I/7AchFAv/fQtVb008XPmeKQMvygJYDSAHfdA+54mjgGWwR6Keh/yGKux3bTLxiVmA
	 lcp3+gfXOS3nFU17DY70G78tVCc/NrItoT9Rx5hEPoKqa/9J8GTZ+0GvCQ8A0dEohz
	 gsq1C46j5duT7Sl7e8uj+2qPR/zCickTbZJ1wotGgArwxZ8SAco9o6sm/fT5pFrkvv
	 8MiIc5PQ4fS+fJ3nYBa1MVWhfICpx+Bdl0a4GJ0K7+yLNw0yS73BIwqNr/7nYrM3QI
	 r8SR10fCqAeOA==
Message-ID: <sashiko-outbox-212903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] watchdog: Add support for VIA/WonderMedia SoC
 watchdog functionality
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261113-vt8500-timer-updates-v7-3-a1dcc4031b12@gmail.com>
References: <20261113-vt8500-timer-updates-v7-0-a1dcc4031b12@gmail.com>
 <20261113-vt8500-timer-updates-v7-3-a1dcc4031b12@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:37:30 +0000
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

commit fecd9b898fc4c8ebc86ec22e46234b476572bd19
Author: Alexey Charkov <alchark@gmail.com>

watchdog: Add support for VIA/WonderMedia SoC watchdog functionality

This commit adds a built-in auxiliary driver for the watchdog functionality
provided by the system timer on VIA/WonderMedia SoCs.

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
Should vt8500-wdt.nowayout also be documented in
Documentation/admin-guide/kernel-parameters.txt?

Because CONFIG_VT8500_WATCHDOG is a bool Kconfig symbol and the driver is
registered via builtin_driver(), this module_param() (with sysfs
permission 0) can only be passed on the kernel boot command line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vt8500-tim=
er-updates-v7-0-a1dcc4031b12@gmail.com?part=3D3
