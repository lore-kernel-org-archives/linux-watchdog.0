Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B4233938;
	Sun,  5 Jul 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260379; cv=none; b=dw7CDppjUMDwy35KoQl/usVpMqKmNFXi12jhXJtYoiPGWMtJazYkdMlZlptLosQGs59s3F6Gs4fWEOKxseT/KJa/mHUsLZPc3wJPQmUvCZVVC5CkXVbXOlojMmlNh+haMIzQ8sE5c9tvSk6H0ejzJ3RU8yQJ0qeIxiBlUtUSq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260379; c=relaxed/simple;
	bh=AXJAPl4qtYVGmi+05KI0F4lhFuy2oMWru53vv2rqF1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMjJtPuZB+SAMiOSgGINEC10Y6tudkGMzD/PdTlGIf+ee55oD8XOVWTMNrCknoIFNtyCKCAYXwnDp7ztULqLGjhlIw9tkCSChJfhjBig0SbpfP+5pXMMma7VApuzTc55WR3Pleplc8jtb8VFPNCMmOCkXiEQydxTAUH6/5sUbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i02XO/A8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i02XO/A8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F11F000E9;
	Sun,  5 Jul 2026 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260378;
	bh=AxuOFNxtff0DzaY4iDpxVkzLbAHB15KRQQYRVxBrlj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i02XO/A86Ga5dv4fQQRgMjvsH7kNZa1t6xhCrNbCA8CJAvi5v3AwpcUYBy4D5vgDU
	 FFtLlVo2qJfNM9QjoURIPZpqQujNmHHK4c1S6FGYfXfenzt45+CVtXBv/D34m5pjJ7
	 DCyAmkjWYzHoJnOBl73WghiXOGydWTM26cSGYh9GpibSfPJQCBOrl8O1W0UApQIlyo
	 c/ZPd0pAWZ6Y3zmtONFfugNq3CGGauNash6e5sky7x4EFsNFnZl9Gr2N/QyWp8NyuK
	 IbHKzPVjDLbXf8KosSQW5zjhb8imgF/RwHfneK1E+a0Ey5xzIbaWB74iDf0o09tyw7
	 0a4ZGg9V4amPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] docs: watchdog: npcm: Add reset status
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomer Maimon" <tmaimon77@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260705140100.1543486-3-tmaimon77@gmail.com>
References: <20260705140100.1543486-1-tmaimon77@gmail.com>
 <20260705140100.1543486-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 14:06:17 +0000
Message-Id: <20260705140617.A71F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The watchdog driver abuses standard Watchdog UAPI constants to rep=
ort non-watchdog platform reset causes, violating the userspace ABI contrac=
t.
--

commit 72fd6c8b87d96376853f3dcd5ef1597495cf9817
Author: Tomer Maimon <tmaimon77@gmail.com>

docs: watchdog: npcm: Add reset status description

Add documentation describing how the NPCM watchdog driver reports reset
causes through bootstatus on NPCM750 and NPCM845 systems.

> diff --git a/Documentation/watchdog/npcm_wdt.rst b/Documentation/watchdog=
/npcm_wdt.rst
> new file mode 100644
> index 0000000000000..cdc45ade9e0d9
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
Is it correct to map generic Watchdog UAPI thermal and fan failure flags to
standard platform reset indications?

The generic Watchdog API defines strict semantics for its status flags.
For instance, WDIOF_OVERHEAT means a reset due to CPU overheat, and
WDIOF_FANFAULT means a fan failed. By mapping standard SoC reset causes like
Power-On Reset (PORST) to WDIOF_OVERHEAT and Core Reset (CORST) to
WDIOF_FANFAULT, might this break the userspace ABI contract?

During a normal cold boot, reading the SoC latch would unconditionally expo=
se
this to userspace via the WDIOC_GETBOOTSTATUS ioctl or sysfs. Standard
userspace monitoring daemons (like systemd or wdctl) reading bootstatus
might erroneously conclude the system suffered a thermal event or fan failu=
re,
potentially triggering unintended emergency actions or false alarms.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705140100.1543=
486-1-tmaimon77@gmail.com?part=3D2
