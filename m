Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A435456E0D
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823572; cv=none; b=WgQSVGfWiMMJYLC6/IqXxlDk4qRajBjvh64CikU3QwZ2+MKao7zZ8qIHI9MPWaQdstU7zUH/IFUTxSnfbwj8EHllJAr6bPCFIsQOvNcdaI6Jm0unc9GuFJesU1l1ht5ZoaxFH+dXdgMgEx1x3o645/QTmG+TWjzQpBzN0jmmPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823572; c=relaxed/simple;
	bh=afZbLmW2qbI6zHiItmWqH2rOCIy96NhGa37gdDw3YQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gt2wBJdKFQGR9UJX4Q2LaK4N8DAeXvWquO3FRRlhBgQeezdFNRYMFEXyVIaSmuE1Z0xsWJ2oeBhCI+QlINAXtnrW5jAbfhBkkKEzdKpNXQ3fDU5tAjcLNiReAUVq15G+VHT8vbOK9j09eiL1U3nXGiF/aVrLH0lcK6RNhDf73es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4sb0uhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4sb0uhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CF51F000E9;
	Thu, 23 Jul 2026 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784823565;
	bh=Hqlb0sALBZIUCOCQF+qxuHh8fiM/RmPDc3SCC9j5p0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4sb0uhdtn0wj/D2gps2Tsv6rw0rkkuwBn27Wvd29ud+PS03gPEODRgxZ+hBKkIA4
	 I/ZG7AUvJeJDcWYBB8fXz6WM+Xqgs8Z1eHYS4WrDYef/rIizVuxuPmFayi5oyD4PoL
	 SG5q/BDeTC2aFBCNfYJiLeMOWtYarsw27Gw4Ppf1AieF79Epc0awPigcV5tZ48Chlu
	 zi5ASgc9gCU+03Ob0HMivi30BmoAItxzDAWOdApH9tDXBqWWh/vD7PsgGgJ1iHw5In
	 Scbcu6xIIJxGVx7bN08BDYXpGWObItBwOlx8EHqiXZ6kwkAxC88YgDKx5Q1BupE2Ds
	 POw4SwD+tL4nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] rust: reboot: add emergency_restart() wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Lytkin" <iprintercanon@gmail.com>
Cc: linux-watchdog@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260723161529.23759-3-iprintercanon@gmail.com>
References: <20260723161529.23759-1-iprintercanon@gmail.com>
 <20260723161529.23759-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:19:20 +0000
Message-Id: <20260723161925.24CF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` annotation on the `emergency_restart` abstracti=
on function.
--

--- Patch [2]: [PATCH v2 2/3] rust: reboot: add emergency_restart() wrapper=
 ---
commit 13ef5d00452d4b8320913eb2ed361d92083a6263
Author: Artem Lytkin <iprintercanon@gmail.com>

rust: reboot: add emergency_restart() wrapper

This commit adds a minimal reboot module wrapping the emergency_restart
function. This allows Rust watchdog drivers to restart the machine
immediately without syncing or unmounting filesystems.

> diff --git a/rust/kernel/reboot.rs b/rust/kernel/reboot.rs
> new file mode 100644
> index 0000000000000..f98a85d19f85d
> --- /dev/null
> +++ b/rust/kernel/reboot.rs
[ ... ]
> +/// This is intended for situations where the system is in a state where=
 an
> +/// orderly shutdown is no longer possible, for example when a watchdog
> +/// expires. It can be called from any context, including interrupt cont=
ext.
> +pub fn emergency_restart() {

[Severity: Low]
This isn't a bug, but since this function is small and forwards directly to=
 a
C binding, should it be annotated with #[inline] to match the Rust subsystem
guidelines for abstractions?

> +    // SAFETY: `emergency_restart` has no preconditions and is documente=
d as
> +    // safe to call from any context.
> +    unsafe { bindings::emergency_restart() }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723161529.2375=
9-1-iprintercanon@gmail.com?part=3D2
