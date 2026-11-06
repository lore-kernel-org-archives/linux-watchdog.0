Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986170;
	b=JNzsJ98ZUYbgqokMVcx8VUunMiqkpVFiuCM611GeDlrFvy3bTY6bCIagHFV1tqfmjIYV
	 aDKvxdyOuYTIhxFy9iZkfams90I8nuUSK8Rq8n+Cwu5ratx/Ue+8BLSRmJ8wjcjB6vmJO
	 8znMHIzXDC5ZTM2+Ghf7zAT220nMt7ofHGI8JiqMQxequsVaIppCLrLW7mCUV0rbc6L8A
	 GyQLO7tgTZpRTGdvfvpAC0i/WH0NUSIWHJAo5NRFrm7yeCllyx+qguwzgZAwXAZlBt3K+
	 mZrwFWLju8u0PF+pMmWdGhweew3ms9OfYrhoVUIDPH1jOTxaohT1UMy17CROWbggUxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jGTmmR/p+YLGnuQFBuxzGyIPCjh49a4vMSauj7YkIFs=;
	b=B8+8Y/PWTUBZGPnbkNjJXrwnUTJsXS2/kyboUVjWxUTZr8dinMBcmWhnPElp34Rqnzkw
	 +3sE71k1rrZQzBOrKXO1gGvi7Uf0/PuuAlBUdtMF5TfxVVpb3e2kRn8ynVGrU32jskTgP
	 Pv76I11eqwW7+pQ2cPb0Q0xdV1f2ClpQFddyQlJ9Rvz3wL8gEbWdAmtvyDDNC1+dKxRJC
	 +dzWYm1LuazSPHN///nBzsj20tZmBMKNGUxdZTs+N9gxMcaYZOjckYRXT18RxIr8p2ZKS
	 QTVrzQepdRx/Ig12Fti57Fta49tIYtHno2w34N6wlUIJZosWqf85vfblf4Xjv/pPwLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN6hKtgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7C606A326;
	Fri,  6 Nov 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN6hKtgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1D21F0089F;
	Fri,  6 Nov 2026 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986169;
	bh=jGTmmR/p+YLGnuQFBuxzGyIPCjh49a4vMSauj7YkIFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZN6hKtgvxOFnwdgxoILA9LLWvzrjqz25/9VyKbqcCPzuF2KmwPLJgte31H4Gq4M/b
	 Hw8NJe3/zBz780V9ZJ39OF8iS98oBHNMBIc8yTBXs0vcIT/lKz3T1PHLYCZga9m11U
	 WTUhoWg4c1Ynyh+NCwOGe6/Mb1WP5OQuEu8rcWXqRXdxF/75eSmkHv1fYSK1RGhdn5
	 0NzuBBxTca8/CVI/qlOzH3QR3wEZNvQEWNK2zxpIRbKDFXeUq0pnU2NWk6qqlM0Jni
	 HmTMq+gmDm9QjFlXVDqSWFo8HESGL/iGkVgL4WvxrW076fY2kpZGVk7FsdRkeqIz0z
	 wlo2/4G34JM2g==
Message-ID: <sashiko-outbox-201933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] ARM: dts: stm32: add iwdg1 node on stm32mp151
 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-6-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-6-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:29:29 +0000
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
- [Low] ARM: dts: stm32: undocumented access-controllers property on
  iwdg1 node
--

commit cd231cb7c5edc8f540770e41801f5662a93d156c
Author: Amelie Delaunay <amelie.delaunay@foss.st.com>

ARM: dts: stm32: add iwdg1 node on stm32mp151 SoC

This commit adds the iwdg1 watchdog device tree node as a child of the
ETZPC bus node on the STM32MP151 SoC.

> diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/=
stm32mp151.dtsi
> index ae31883732388..e71b2ab58aa54 100644
> --- a/arch/arm/boot/dts/st/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
> @@ -2037,6 +2037,16 @@ i2c4: i2c@5c002000 {
>  				status =3D "disabled";
>  			};
> =20
> +			iwdg1: watchdog@5c003000 {
> +				compatible =3D "st,stm32mp1-iwdg";
> +				reg =3D <0x5c003000 0x400>;
> +				interrupts =3D <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&rcc IWDG1>, <&rcc CK_LSI>;
> +				clock-names =3D "pclk", "lsi";
> +				access-controllers =3D <&etzpc 2>;

[Severity: Low]
Does adding access-controllers to watchdog@5c003000 cause dtbs_check to
fail schema validation?

Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml sets
unevaluatedProperties: false and neither it nor watchdog.yaml declares
access-controllers.  Should access-controllers be added to
st,stm32-iwdg.yaml as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D5
