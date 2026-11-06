Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988124;
	b=scFU7xe7R556ZPhcnhy2WkRP976OSB8rJZORvva2M1o8HknkdtKb8U1013laOUlJ4BQf
	 8S+mEpDhb1YEIoeVUucVvsw0Vk2x8CFnfV8Dz76m9eEkxBaTtC/kv15aOpjTzif80ZZ4G
	 K2xGoNv5xqeJMfjvcPH58D4XgVqkIGIdRB3ON3kJNdgtuUH7hjNNNk53rST6oAmIgbqDi
	 T6GYTXgLzfwkLTBSWF9wJK2ZC+jOy3JLW5kUp7fD1Z0W3bBqK4ivTvVlf9iHQTtYx/cQk
	 o/Dht/c1/Ddzi9zZ/VJvN3wmQjSfenMerEeIfR5s9tnVNODp1S+LGkbJSp57h98ZQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jmvWuYHAFAPV/Hy8jIbpazz0MJiKZY43IXcatMzZ84Q=;
	b=GcFkQyD+DYeQ7mm0yp9FvC/c4IOlJKYjZ0hKdtfrPrtPOr+7OTUoRtSXVkehlYmzoFd+
	 h34x2ho19JYZoWp0kHOZdjirB0be5WapkTnRyd9r7oVJfFLQo2uSUtQJ6be9U+VVlzF4i
	 ky6SYaKg2F9Z7ax/YvXyzG09/UsorcSGcz2MxzYpH+9ZCYSjq/7h6moO9MypUwzyOxdUB
	 pbC0WKvpU2OYkkgC/RkdpDqh4qvrVsb1J6AlOJR5dzTOngtlMk2uMv0ehD+JIpHDFmjVJ
	 SyYVWXGDh0bN8Ewo0WuWfbLtRx3oyRlo7e8TpbAPEtmEH4vgHSdxzYsyAad1z1OWlIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjLyhLfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFD606A326;
	Fri,  6 Nov 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjLyhLfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6C51F0089F;
	Fri,  6 Nov 2026 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988124;
	bh=jmvWuYHAFAPV/Hy8jIbpazz0MJiKZY43IXcatMzZ84Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jjLyhLfIOGz0Aq55BcSPPp+8/i5pmQe9cevaFULjeH1+LFMI+3L1xHmPUxk+Xs9sg
	 YJmAPaLRmyeKLe4rZzO082o6tAyh4S8D4JEttnLSW8QnJQjeHPFgsFszDxF3N4UlT1
	 SuHdWdFEEVLxP87hH3ytZ2Od6KlHaOyz9Tv7Kfzk5bRAw625IYtQ0+ITmP0qjMJ0qJ
	 o0W4fm2vF+JxpNZaSHAxOdJYq1Jf5VtD362wB11nGpMUNOffGeXBFlKni2gMl5b/hp
	 1rUsBAXm/JUnHMQiT6SxU2h2/oti4TnEjysIS+K8Qfjf8SeSFW4D5Dbj5x5hMCEIop
	 YayxOItTO7B7A==
Message-ID: <sashiko-outbox-201985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] arm64: dts: st: add iwdg1 and iwdg2 support to
 stm32mp211
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-11-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-11-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:02:03 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arm64: dts: st: broken stm32mp215f-dk.dtb build from missing
  rcc header and node
- [Low] arm64: dts: st: undocumented access-controllers property on
  stm32mp1-iwdg nodes
--

commit 67f7dc5ddb768e993fdbc244a39bc4cf2ffdfc02
Author: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>

arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp211

This commit adds the iwdg1 and iwdg2 watchdog device tree nodes to
stm32mp211.dtsi.

> diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts=
/st/stm32mp211.dtsi
> index 4bfd58b26b51b..7ad1c3c304dea 100644
> --- a/arch/arm64/boot/dts/st/stm32mp211.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
> @@ -110,6 +110,26 @@ usart2: serial@400e0000 {
>  				access-controllers =3D <&rifsc 32>;
>  				status =3D "disabled";
>  			};
> +
> +			iwdg1: watchdog@44010000 {
> +				compatible =3D "st,stm32mp1-iwdg";
> +				reg =3D <0x44010000 0x0 0x400>;
> +				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&rcc CK_BUS_IWDG1>, <&scmi_clk CK_SCMI_LSI>;

[Severity: High]
Does this break building stm32mp215f-dk.dtb?

Neither stm32mp211.dtsi nor the files including it include
dt-bindings/clock/st,stm32mp21-rcc.h, leaving CK_BUS_IWDG1, CK_BUS_IWDG2
(in iwdg2 below) and CK_SCMI_LSI unexpanded.  In addition, both nodes
reference &rcc, which is not defined in stm32mp211.dtsi or its include
hierarchy.

> +				clock-names =3D "pclk", "lsi";
> +				access-controllers =3D <&rifsc 100>;
> +				status =3D "disabled";
> +			};
> +
> +			iwdg2: watchdog@44020000 {
> +				compatible =3D "st,stm32mp1-iwdg";
> +				reg =3D <0x44020000 0x0 0x400>;
> +				interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&rcc CK_BUS_IWDG2>, <&scmi_clk CK_SCMI_LSI>;
> +				clock-names =3D "pclk", "lsi";
> +				access-controllers =3D <&rifsc 101>;

[Severity: Low]
Should Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
allow the access-controllers property?  Because that schema sets
unevaluatedProperties: false and only references watchdog.yaml#,
dtbs_check will report access-controllers as an unevaluated property on
both iwdg1 and iwdg2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D10
