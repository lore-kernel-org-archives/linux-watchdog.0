Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958648;
	b=IAxCgYFDjqO8wtv6TcDdhEeyJVPLcjLTz/dMhOmuZm5ZAOPT5CpdXzvi5HkgCZkHFuqP
	 D1vj5PY7UR3mIaEMywzYXTOUSyABqmFMuyNRY71lMEchBzNSUKdMBEYi+3NfQB/ZlvR5V
	 YyqrPgg1iYsljleMoSbRS2i7F71GItNvsAPFQSmt0ZPRK9hr/h45sjXt0XAv8YXCjK+3/
	 wtNh7ionAtUonF8wGVSrWb8zMZdzPcvRzI11oQbEiabK9o58kccRzVXKgM8odpxycMibT
	 xjbjNsGyEF8RdytS6JgJ3A8L1Ywir/bYs2fthMuq4mYd6wGO2HY4n7vNrc4YQnt/S/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+PeAqe5CPXxdSOZLrj9lW/HMctWWJka2EQwhjd7PBpk=;
	b=QF+uaDwAp/zaXbxuTygDu+Sdk0mkTvrcRaBX8ujDKXHjxsqLsAC5P3sHTojXVS+nxsRy
	 7SfmYP/miWpCBoC3+zi3k4e4US/hxt7osSeuTCV/u8GoVndmQ5nDJ+NBA+vd7T7EFLHxF
	 d7PZbVOTjEfvUPq9z450gx+Rkf0nO4W5IpXoOBqgPmNewcI/GpXVt0Kg9Mb0HI0oKdHT8
	 vsHoEQrMPaWqKANA4ECmTvo3C0mKDi8Y1Vyd9UfgqlOoOOIG9S2Vl/EnUrxOBisEPDkqt
	 Tx/aquEwnQ0BpTtaIAPB67Wynbxxe4HAaY6lHAeJwrICB8zyB5t4LKPaRfxZTU27KKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ki2Y6VM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E226083608;
	Fri,  6 Nov 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ki2Y6VM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78831F0089F;
	Fri,  6 Nov 2026 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958647;
	bh=+PeAqe5CPXxdSOZLrj9lW/HMctWWJka2EQwhjd7PBpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ki2Y6VM1yJg+RmSJZlGbytEO7ho2Ewa2faoib1xLWl/f4rDtUZ5yg9+dxnsnMYUXx
	 r/FE9kk7ay4zXyc6Fe05bsAtSnag8b1NzupzBJJ5t/pPmq4bd+D1SK5LZpfSmZx1uY
	 Md76NMuFif5M5bdZ4fU0kTIULQpj5hbJsEOhpEgJcW7AVh7xEUvL7MaBPSaJzxGvLu
	 MTgjsyjPYI4OHeiBqmgMUQn8i27NUw3Ww08NtSziesS/jhfIjxvQ5Fn7djTb4BuoVG
	 G3koUXls1RxaSEZDlPGO5oGJWQWH8UEjCmZ+fcGcz9+uPnc7C8wqpnnPwEiaI1tQwz
	 ZDGZlrk16KRLg==
Message-ID: <sashiko-outbox-201154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/25] riscv: add Metanoia MT2824 SoC and MT5824 EVB
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:50:46 +0000
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
- [Medium] riscv: dts: metanoia: invalid uart0/uart1 aliases in
  mt5824-evb.dts
--

commit 9f82e60e9d27daf0d2b50c91457b33d4fb60e507
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

riscv: add Metanoia MT2824 SoC and MT5824 EVB support

This commit adds device tree files for the Metanoia MT2824 SoC and the
MT5824 evaluation board.

> diff --git a/arch/riscv/boot/dts/metanoia/mt5824-evb.dts b/arch/riscv/boo=
t/dts/metanoia/mt5824-evb.dts
> new file mode 100644
> index 0000000000000..d0e8eb0a49a43
> --- /dev/null
> +++ b/arch/riscv/boot/dts/metanoia/mt5824-evb.dts
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2026 Metanoia Communications Inc.. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "mt2824.dtsi"
> +
> +/ {
> +	model =3D "Metanoia MT5824 EVB";
> +	compatible =3D "metanoia,mt5824-evb", "metanoia,mt2824";
> +
> +	aliases {
> +		uart0 =3D &serial0;
> +		uart1 =3D &serial1;
> +		spi0 =3D &spi0;
> +		spi1 =3D &spi1;
> +		spi2 =3D &spi2;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "uart0:115200n8";
> +	};

[Severity: Medium]
Should the UART aliases in /aliases and stdout-path be named serial0 and
serial1 instead of uart0 and uart1?

The devicetree serial binding (serial.yaml) requires UART aliases to use
the serialN naming convention, so uart0 and uart1 fail dtbs_check
validation.  In addition, __uart_read_properties() looks up the "serial"
alias stem via of_alias_get_id(dev_of_node(dev), "serial") when assigning
port->line, causing the uart0 and uart1 alias indices to be ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-mt2824-v1-=
0-86087eaf5af4@bootlin.com?part=3D24
