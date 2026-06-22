Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6813911C0;
	Mon, 22 Jun 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117288; cv=none; b=hYhzvMOYDOoH652XQwu5BvbNhQhgxtsrUO1Fb3ad553ET0NWgqShJvbv6KdUmkqNn9raYCUxsgnkkD0YSDe69qoRCgkDogZPTSJEstO72tlx/kc8hgGUFzn5EUiKsdPF8qW0GYKng6Frg1Ja///lHAiYMdFe7iQCM1rM/pfxcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117288; c=relaxed/simple;
	bh=j/lXFKUMsuTeZ5R/UV8o83CDSnOABuWBcRNX0fjjQS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OIL7Nt2A97w7Ke6DwQAVZZr3ghZubqzny4JtaWbWdcYsFu9EdfPISml3snpkQ/s0qylJsyZIziDxj62cCkitpoV73b+/LsCLGI31Sj+1u2lVxwpVkwjx8xxz/Mc/sZ52cjNggZLlZE6hkhOMU3c6gRX+aiVpBqSlgarQeF+V5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/huIBEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/huIBEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33041F000E9;
	Mon, 22 Jun 2026 08:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782117286;
	bh=uLfh1SfGoYiSG9XOLWN50gPnkQ+85oUHs0wzG/ObWx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/huIBEtnItICjHFuOyWS/0htLIwYjUp10MBWkKKOX8S0mSAF+UjXpHgIbEC9QWzk
	 SStBMUtCirGkhwySh5tvMgSMzS76oYwj/qZwRkFgxmS0WIlZLTyqP8eEWYAAixDoZT
	 Fy+f+oz+p83D97IVP8GezApUTpHtEodcCm2CCJD518t/kK9LFlfKVeB7gn5SYdHv3P
	 GxqBqsks5JFFEg2f/lSYlSpKf3BxwXOQxlUUS9oEuQ4YMIWuZnhx1PebNzVa7kaW4h
	 JT9KnregpdXeFN05yUyGCz3KLVW+rb+IBqnjRYncQKEJ4arh+1IR7y4bXtNyIheSTj
	 qBCmInlwTQGyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] docs: watchdog: npcm: Add reset status
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomer Maimon" <tmaimon77@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260622083046.3189603-3-tmaimon77@gmail.com>
References: <20260622083046.3189603-1-tmaimon77@gmail.com>
 <20260622083046.3189603-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:34:45 +0000
Message-Id: <20260622083445.C33041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] UAPI Semantic Violation: Overloading generic watchdog bootstatus f=
lags with unrelated platform-specific reset causes.
--

commit 622b044102abac9e6e33a21b4739ad90ba16eec5
Author: Tomer Maimon <tmaimon77@gmail.com>

docs: watchdog: npcm: Add reset status description

This commit adds documentation describing how the NPCM watchdog driver
reports reset causes through bootstatus on NPCM750 and NPCM845 systems. It
documents the fixed reset flag mapping, watchdog instance mapping, and
sysfs reporting behavior.

> diff --git a/Documentation/watchdog/npcm_wdt.rst b/Documentation/watchdog=
/npcm_wdt.rst
> new file mode 100644
> index 0000000000000..48f0c7920c112
> --- /dev/null
> +++ b/Documentation/watchdog/npcm_wdt.rst

[ ... ]

> +.. list-table:: Reset-cause mapping
> +   :header-rows: 1
> +
> +   * - Platform
> +     - Reset indication
> +     - Bootstatus flag
> +     - Reported meaning
> +   * - NPCM750 and NPCM845
> +     - ``PORST``
> +     - ``WDIOF_OVERHEAT``
> +     - power-on reset
> +   * - NPCM750 and NPCM845
> +     - ``CORST``
> +     - ``WDIOF_FANFAULT``
> +     - core reset

[Severity: High]
Is it intentional to overload standard watchdog UAPI flags with unrelated
platform-specific reset causes?

Mapping "power-on reset" (NPCM_PORST) to WDIOF_OVERHEAT ("Reset due to CPU
overheat") and "core reset" (NPCM_CORST) to WDIOF_FANFAULT ("Fan failed") w=
ill
cause generic userspace applications, system managers, and monitoring tools=
 to
misinterpret the values. This could lead to false reports of CPU overheating
or fan failures during normal cold boots.

Should these hardware-specific reset reasons be exposed via a dedicated
reset-reason framework or custom sysfs attributes instead of redefining
standardized generic UAPI flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622083046.3189=
603-1-tmaimon77@gmail.com?part=3D2
