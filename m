Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245018FDDE
	for <linux-watchdog@vger.kernel.org>; Thu, 28 May 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928631; cv=none; b=uE36BjtofzfKJuosnC4kjYW4JcduGzuN+jnifHuMWxVbNpMr1j3d3qE4rCJqY6eohXZq78y4hRTiaMif1MCPFs8K8pvx/JCwUXD6uNi7nzDSNI6rUdNAzJ6JawWcyw75E2ClBG/mCjtzElS3FxobDM5cjONjJ1FijKPaQqA6DEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928631; c=relaxed/simple;
	bh=PSk6BtcAK408G85XW4XkH4K1kF/DiC2WsFRbI7xrsew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jglx6RBko08cNAyVAeMwagLT0HTnZCiEHkNoE0T0QhThej6pA/MCXd8haFggwYXAXFG/gO0nuSww7OAVAWPbjZ61xKlWZznlah6thWxE/X0y7sGD/kWkGiK+ypRzHpjOs6QImd42NpstmSWxyqZ4EqyP+0TsiYnm1b+0rs0l0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxayAwje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxayAwje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3681F000E9;
	Thu, 28 May 2026 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928629;
	bh=pQf2juxEKbANIeMxZMV3ruTOZqaRKZfmd4VPACsZAmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxayAwjejEUfzycI4HF2zyUAPstYNGsnQ2wxW/J6MJtV+n7J69YtmX6dmS20AO6mC
	 e8SSQkGCvpqrbvQ+E+Mu6TJFyuAhcwyfMuGowXROcBBCypEj+qyiG739JMVXCUiAWC
	 haMIUlmCjyDifGzIQuWqIS+YER0O42gQ03RKs3IbGnHDmpCUYZ1KrnAwU6dhCNiupg
	 CkyZMZETVR7OD6cAlC8Wg+uIrWdoTxtRBuGfD5ZcrUOdFOgcu+biPlmMZfluw/C15Q
	 4K6HlHic51KBDj+hczYH4zpvm9El66tsLsiYrdo6xasgwRVfQRsoWCk5FoeKERis7E
	 ETVrznIakC+9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] watchdog: uapi: add comments for what bit masks
 apply to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260528002803.1260126-4-rdunlap@infradead.org>
References: <20260528002803.1260126-4-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:37:08 +0000
Message-Id: <20260528003709.AA3681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added comments incorrectly describe the constants as 'Bit=
 numbers' instead of 'Bit masks'.
--

commit e1ceca9084192292295862799b05158c88be7e2d
Author: Randy Dunlap <rdunlap@infradead.org>

watchdog: uapi: add comments for what bit masks apply to

This commit adds comments to the watchdog UAPI header to clarify which
bit masks apply to specific watchdog options and ioctls.

> diff --git a/include/uapi/linux/watchdog.h b/include/uapi/linux/watchdog.h
> index b15cde5c9054d..0d70a150809e8 100644
> --- a/include/uapi/linux/watchdog.h
> +++ b/include/uapi/linux/watchdog.h
> @@ -36,6 +36,7 @@ struct watchdog_info {
>  #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
>  #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
> =20
> +/* Bit numbers for watchdog_info.options, GETSTATUS and GETBOOTSTATUS io=
ctls */

[Severity: Low]
Is the term "Bit numbers" accurate here? The constants that follow
(0x0001, 0x0002, etc.) are actually bit masks.

In the kernel, a bit number is typically a zero-based index used with
operations like test_bit() or set_bit(). Describing these as bit numbers
might be misleading. Would "Bit masks" be more appropriate?

>  #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
>  #define	WDIOF_FANFAULT		0x0002	/* Fan failed */

[ ... ]

> @@ -50,6 +51,7 @@ struct watchdog_info {
>  					   other external alarm not a reboot */
>  #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
> =20
> +/* Bit numbers for WDIOC_SETOPTIONS ioctl */

[Severity: Low]
This isn't a bug, but this comment also refers to the power-of-two values
below as bit numbers instead of bit masks.

>  #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
>  #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528002803.1260=
126-1-rdunlap@infradead.org?part=3D3
