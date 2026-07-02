Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A70480DC4;
	Thu,  2 Jul 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996297; cv=none; b=eMsIj6VyXQMCwqF8oG2WhzoFPGYfqfcCBEfy42ccwpnIn3r+sQB7pZhz7v56tm8jmVNX/eHY5pP6wv4WBf4kDGGjgYvCinorDasrs216P23EJrUiA60MgOuG+CNgBLiqrHvQp5XFn9Os1rGQy3JiKYNULvRTnfZGxxc7zdI1yFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996297; c=relaxed/simple;
	bh=6cgPhejUfVXrEPjqwpp2ynVTYCcvQ4BrOtZeweqsOVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuOKVgozyr/+VvpmDVD9Zfai2kd1Z7ez301o/GMc+nzF4QDjTxamPDK+xW+pgbt1fIgi4D8Qyo5/T4OroU1jTmW2yIwX4F2uwpEU/wRKW1pmqubaODTtP+M6It7ojdWJojyoVqa7IANlnREBI322JqUdIvrcoksAyBfs4V7wjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxlQLvmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxlQLvmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD01F000E9;
	Thu,  2 Jul 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996296;
	bh=bVlHfhnFKZio0CEVyLyDHlAdW0yRJtbWDG+DW8K6srY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxlQLvmVHgy54lNUxKowi+B6F55dMmonfTq2Wndj1uKAXQQRA0hoJpCzJ1vNlKKmQ
	 K2B08QUJoJdOV7qY5hCXCV7jwBME6DJExx6J4MLhxxWZ3tQie5KakakueSG946Gu+c
	 BMaEHQsX5Nl8XqcAkmCbvfrCnndxLhinKu1hLZkVGXSurLstVgADwW/lN4ecMy0Jc7
	 MWkTAWo0Xte9AwS5O6aIN7OJd3QMzt+Mzbu63eWQu3JekI1gWOf4TBg6F0airw4U/x
	 Dmphz7AJyypcqi8edCDlguucwCfh6OeVcORZjwHFZ8n+d6gufBB1rGY64k66UZeTsZ
	 gW4+I0uOPal/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 8/9] arm64: dts: renesas: r9a09g077: Use SYS
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260702123112.161160-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:44:54 +0000
Message-Id: <20260702124455.74FD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Transitioning to a syscon regmap introduces a spinlock into the wa=
tchdog restart path, creating a severe deadlock risk during kernel panics o=
r reboots.
--

commit f54f749e298c48411aae186783c11b3cc40d3738
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g077: Use SYS syscon for WDTDCR access

This commit updates the device tree for the r9a09g077 watchdog nodes
to use the new System Controller (SYS) syscon interface. It replaces
the direct MMIO region mapping with a "renesas,sys" phandle.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g077.dtsi
> index 208287f7b7442..ae69a01d60427 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;
>  			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
>  			clock-names =3D "pclk";
>  			power-domains =3D <&cpg>;
> +			renesas,sys =3D <&sys1 0>;

[Severity: High]
Does adding this property introduce a deadlock during system panic or reboo=
t?

By pointing the watchdog at the syscon regmap, the driver transitions
from lockless MMIO to a spinlocked regmap access path. If the system panics
and smp_send_stop() stops a CPU while it is holding the syscon regmap lock,
the watchdog restart handler could hang indefinitely.

The triggering sequence looks like this:

machine_restart()
  smp_send_stop()
  do_kernel_restart()
    watchdog_restart_notifier()
      rzv2h_wdt_restart()
        rzt2h_wdt_wdtdcr_count_start()
          regmap_update_bits()

Since regmap_update_bits() uses a standard spinlock, the restart path will
spin forever waiting for the locked CPU. Is there a way to bypass the lock
during the restart sequence?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702123112.1611=
60-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
