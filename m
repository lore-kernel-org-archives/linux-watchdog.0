Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CE3B71D9;
	Mon,  6 Jul 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349578; cv=none; b=UsAyGPczFWmZJUoInrtcN/Btdz9mmBhGQdIcSzQpDIVDMIgWhJ4SA1CXYeO0iSCXkDIF0FLbgFS5fQ8Fitp4MpHK9Nn3NnVQ5E4sqPZHJ+8byuCZ/hyxGEK+6GZLlMoYJWC3Mp+sv+58rjoghJYwE274G9L4rkISZpgx06Xbeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349578; c=relaxed/simple;
	bh=fTjQ4VpOSgf0OrPwTtb9MoYA9rYbCZjloKo0XmiVoAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KhGdzzvRQ2TNLyu+LilNMXg/Ckz+Rdmv/ZdQLWLFFa+YTMQ2Pqz3/2+eEtqgsXLByHCsjN9qIhrfUZrO9720uRpv6tO84NEggYP4nfxuYcSIZ8Qhel0PviYGhEKtlj0sWBO1vkOU4UuadqQnqaOFlyilS80LKlfGcDJaoLpxNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1JuHjMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1JuHjMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924A31F000E9;
	Mon,  6 Jul 2026 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783349577;
	bh=LE66o9ESc3h3y4DqLpR6+pwwqZGeIzyvKWdNsjQ/KdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1JuHjMgK5wuNhWNzyu0uyUCoAFDLTKvrcBHd6mJMzHD32nMNZJrbtVu6WByvXNx2
	 fxv7gv2ymIhEpTip+fEwoBeoNxZfAWI0vSZpxJOtVlcnJicf2NeOkIo1BglNEsiXmQ
	 Lgn/UJPPx1b/UDzBegKDzNsZT1D4BkSJWEfm4aFQhLF9zv1ahlQEeN3J9mdGoSyuTj
	 wBugR7yfaSf5u4qN44AsAE3IxlGd113wtm4qvV8XbS9ZVxZMZQKlfdgFRNMKr+L5je
	 Zopw4ng2EPArd48RUeTrdOjXaJY9bKgnaTBOJoQ12l3nfsJyBhMijEGuAYPRvqNyBH
	 LSY/UM9QZlxIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] docs: watchdog: npcm: Add reset status
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomer Maimon" <tmaimon77@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260706144828.3517631-3-tmaimon77@gmail.com>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
 <20260706144828.3517631-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:52:55 +0000
Message-Id: <20260706145256.924A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The documented reset-cause mapping hijacks standard watchdog boots=
tatus flags for unrelated SoC reset reasons, breaking UAPI semantics.
--

commit f4b3dfdb40f0d729f339392746d12863cb907b7e
Author: Tomer Maimon <tmaimon77@gmail.com>

docs: watchdog: npcm: Add reset status description

This commit adds documentation describing how the NPCM watchdog driver
reports reset causes on NPCM750 and NPCM845 systems. It details the fixed
mapping between SoC reset indications and generic watchdog bootstatus flags.

> diff --git a/Documentation/watchdog/npcm_wdt.rst b/Documentation/watchdog=
/npcm_wdt.rst
> new file mode 100644
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
Does this mapping redefine standard watchdog bootstatus flags for unrelated
SoC reset reasons?

Standard watchdog UAPI definitions expect WDIOF_OVERHEAT to specifically
mean a reset due to a CPU overheat condition, and WDIOF_FANFAULT to mean a
fan failure.=20

Mapping standard power-on resets (PORST) or core resets (CORST) to these
flags will cause userspace tools and daemons querying WDIOC_GETBOOTSTATUS
to erroneously report critical hardware failures during normal boot operati=
ons
or software resets.

Is there a way to expose these SoC-specific reset reasons to userspace
without conflicting with established UAPI semantics?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706144828.3517=
631-1-tmaimon77@gmail.com?part=3D2
