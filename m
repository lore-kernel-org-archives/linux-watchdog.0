Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989498;
	b=baUD9PIRQ9Ig60+l9DNokc3gILAt51zo+d6wckTny8itnBcvrPicQAeuuzFrFU+2inx0
	 pzarY/dFDY+qfQjP0TTto4NpE0SEIe9vBzDUhbSjhWuUPjy1OgKklWDMkzjltw5h7xgqI
	 ty+kzVTM+4bdoaT7zwdPy7Hld8rLVPIHUebNa8SYTEBprCUPgKNUpkWG/8KTxP1xSSyxA
	 8ldsQPk0i6b05I3mEI+EnNrtlueEAvkqoPfaNIeG7+4UurwNtPZvLHtei5QGNxp/fpBBn
	 tScFJGPG8LvT+Iny8Rm3tZDPtJ3sYKZBuVOGwzjoWSszjhXgJQPDjOoqdny++1B6UzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/YUawSo1A9/TsR4bHyYTtKTT0r+C7FLDSJpMmO+HqIk=;
	b=r2vX2+B810j54Ov8b8sAVZ8v/5PShSuFFoX7ywmWK2vYR7p8cWOv73YB84eJsLQrZGod
	 1caL2h0tv3B50NHH7IfkdEbZS0ma2l/xLtrKsbGX4j8ITIyEGIZsAxD6MWb2+r//eZGIX
	 XRW+ITh6YEuUvQoMw3vBjQdJHhv/ACCM8MsiMv/mvvesNH8GZps55Kki4PcIFYiPJ3DBH
	 5y4cGycbxlcZU4jAdi2JRsxBmSGSrowlGBCjKWqonCC+A78nbUlpOu/yMzSywJ3zLys7G
	 HDeSZ97Sf/Dy2H6WlExGm7Qs90SXqm6DML5QJW33BlNMFRJR/XWkV2D3fnLXfcs3Wfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hexLl1vU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA46606A330;
	Fri,  6 Nov 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hexLl1vU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B59C1F008A4;
	Fri,  6 Nov 2026 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989497;
	bh=/YUawSo1A9/TsR4bHyYTtKTT0r+C7FLDSJpMmO+HqIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hexLl1vUD5l8wSXLH/f/cWAEzfWdtILKHGXBJfI2ls7w+hXT8BZkezwG6xa5eyWhJ
	 pDFNiO6mpAA1KszWt3FUzCbCsOqZ0eqfXjndeNF90TmArq3NFWS/jCOlwYmwdJdmYk
	 JOklpT+5cnpAklOp2wAX2I7XyCuPMQn39UdbvwbMselHjbfyLPCuEQvDGWJkHWQQGP
	 rSHX0GUw6KK5za6J+76IwmX4VMpTHTxfqgxjU+Y0yZvHqReYQNTU10wYAdvKdZXhyz
	 sirVfYV0rZRbI5JAtNVME0q3bpcojUYscbh0+puBz4C7QX2Qloq2S/q/h1IbWzi6EV
	 wPVLENCU3ggLQ==
Message-ID: <sashiko-outbox-202022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] arm64: dts: st: enable iwdg2 on stm32mp2xx ST
 boards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-14-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-14-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:24:56 +0000
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
- [High] arm64: dts: st: unresolved rcc phandle and clock macros in
  stm32mp215f-dk iwdg2
--

commit 7a43e1911df9f04894384d16f6721b48e26c2793
Author: Antonio Borneo <antonio.borneo@foss.st.com>

arm64: dts: st: enable iwdg2 on stm32mp2xx ST boards

This commit enables the iwdg2 watchdog node and assigns the watchdog0
alias to arm_wdt on STM32MP2xx ST board device trees.

> diff --git a/arch/arm64/boot/dts/st/stm32mp215f-dk.dts b/arch/arm64/boot/=
dts/st/stm32mp215f-dk.dts
> index a1285abc80ca5..c7ab340a7e4dc 100644
> --- a/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp215f-dk.dts

[ ... ]

> @@ -48,6 +49,11 @@ &bsec {
>  	bootph-all;
>  };
> =20
> +&iwdg2 {
> +	timeout-sec =3D <32>;
> +	status =3D "okay";
> +};
> +
>  &usart2 {
>  	status =3D "okay";
>  };

[Severity: High]
Does building stm32mp215f-dk.dtb fail with syntax and unresolved phandle
errors here?

The iwdg1 and iwdg2 nodes added in commit "arm64: dts: st: add iwdg1 and
iwdg2 support to stm32mp211" reference clocks =3D <&rcc CK_BUS_IWDG2>,
<&scmi_clk CK_SCMI_LSI>, but arch/arm64/boot/dts/st/stm32mp211.dtsi
neither includes dt-bindings/clock/st,stm32mp21-rcc.h nor defines an rcc
label.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D13
