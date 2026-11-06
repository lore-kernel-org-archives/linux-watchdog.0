Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988824;
	b=DtrGanO9CqosXXoixSY8Kwgc1u1fx6Q3IPmPoOnSPiqBDcBo6tg21DHqvneXeaBt/sH8
	 HkwYmONYYeqVEXhbBHPS/+elRQB5+zdbzkDX4L1wKzF7OMEgAL/tJwIofObAnHyZwj2DI
	 AsL+hiJwCK4PpMT53BdO5e8V/OnQf7Vfus1IP8mKLPJxIUUqDXJpkzOq8fSYv8R9BJ9GS
	 4ej59ZHFUKVj6dBf3CioZ0+y7P4BfKTDlOVnGh3EtyNDXKTxsK2A0CDF9DUgUo/xWXzXI
	 4DiM0XWo3s/KiIhqKhl6vg+A0K0hyLivuDXdOzm85OasBmxdyZYOirutWc7oOL1c2SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KMQDum6ro6+38J8GrwMjdFRm/rqOA0moDhFDYguzWLU=;
	b=zKqBcv4MxrLcIiMWxiPzXyueg1P/hH0sMgjTkdGjE/Hcn83e02b72gY1PlwpjM7MMikP
	 b1fRQIoE0F/nQxvGlnS1Rj/MyLW60UVA/eSRPjf0e+3Ng5l9UiSPtV7Y8svaK5tAEplrP
	 73AMFJXNy+FO/IoQ9ni3C1STld+ehoZB60tHxDLuc1V5kzXfPTYDjWB2E2MkUXRu+8Zrc
	 4UJJFtQS6dd18DiAMJZYRXR4dkyDKQHvhsxtxaPEUlri5rMQzm0DQ2WbUMC7w5MTFelPo
	 6FGQRTL9pziOoaUVW03qHLzttkUlMQz86/X4T+06Lwt9FU0ONK2GhSuPQHTvRvKjQqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTB8Cbwt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075EC606A326;
	Fri,  6 Nov 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTB8Cbwt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5CA1F0089F;
	Fri,  6 Nov 2026 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988823;
	bh=KMQDum6ro6+38J8GrwMjdFRm/rqOA0moDhFDYguzWLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTB8CbwtC4uPmCt6p2VeAkonRR/+2WCGOCmXPSVjGk5MopoLe4purDz0Pa+ZWc3PU
	 Z1a0z7d0FQ9Xlsxd18h9hR+qIngDahAeNAGphHfOqij4wXRenO5/Cv418BB5esX/Cx
	 sqHEAvqMAyFWq95EBo/CCDv/9E88neFw54GCKXyAifHILHygqC5vNTFJqDuYr0D6NT
	 qmNL2zmW87pCzg0Yb1sEB1I+j3knkCCdyFLtJbukp1gr4MtqIlifb3O4jrR+4DeJ9q
	 5neAYdxKECSPgAgoXQ5E46vB78gCH6sW6ENazYShMNGKpSn4s8pyHN1RLQbCeZ8y+G
	 3Zzc45Q0lNJDQ==
Message-ID: <sashiko-outbox-201998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] arm64: dts: st: add iwdg1 and iwdg2 support to
 stm32mp231
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-12-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-12-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:13:42 +0000
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
- [Low] arm64: dts: st: undocumented access-controllers in st,stm32-iwdg
  binding
--

commit 93c31545a492246bcc374e2c2022c94ad8a0467c
Author: Antonio Borneo <antonio.borneo@foss.st.com>

arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp231

This commit adds the iwdg1 and iwdg2 watchdog device tree nodes to
stm32mp231.dtsi.

> diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts=
/st/stm32mp231.dtsi
> index fefbf6f4f1537..db19429896eb3 100644
> --- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
> @@ -724,6 +724,26 @@ rng: rng@42020000 {
>  				status =3D "disabled";
>  			};
> =20
> +			iwdg1: watchdog@44010000 {
> +				compatible =3D "st,stm32mp1-iwdg";
> +				reg =3D <0x44010000 0x400>;
> +				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&rcc CK_BUS_IWDG1>, <&scmi_clk CK_SCMI_LSI>;
> +				clock-names =3D "pclk", "lsi";
> +				access-controllers =3D <&rifsc 98>;
> +				status =3D "disabled";
> +			};
> +
> +			iwdg2: watchdog@44020000 {
> +				compatible =3D "st,stm32mp1-iwdg";
> +				reg =3D <0x44020000 0x400>;
> +				interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&rcc CK_BUS_IWDG2>, <&scmi_clk CK_SCMI_LSI>;
> +				clock-names =3D "pclk", "lsi";
> +				access-controllers =3D <&rifsc 99>;
> +				status =3D "disabled";
> +			};

[Severity: Low]
Does adding access-controllers to iwdg1 and iwdg2 cause dtbs_check to fail
against Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml?
That schema sets unevaluatedProperties: false and only references
watchdog.yaml, neither of which documents access-controllers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D11
