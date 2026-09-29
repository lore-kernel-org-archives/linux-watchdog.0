Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D40513554;
	Tue, 29 Sep 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678364; cv=none; b=D7fGOXOq7jaXfiediNkU6QaUBTS8Y3XvKFWf6cEbNWTrRCATmBLaCnZYZgSol3GCDJLCC9ch4U5N1nxMbR1temp2MJok5VNacIdmPlPkxtRyurmQwBfpqrpnSX2UAcM8t3l3dNro046/uEYd/O8nunFB6vT+CZOv9KA8AIqMtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678364; c=relaxed/simple;
	bh=balYX3oKk5D17UFdL5o8wY8VFyGajw8pYqgdGfXVZ84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SC+xCa4j5KF9+gvS8DpUEVYWQT5s7LRCD4hPbaBR/xWD68oIqwa2i1Bnwl6knmWz9yiUgu1BVG3rmkbuHDiRrRqgPGffvQxXAgJ+v2+7Lgjsu01EnK9mfZuDuuBgWvqvuuW74TLx1Ct6pSv4KCme66Oig4eSR+lm+xzTMroM1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdNYeeCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdNYeeCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22291F00893;
	Tue, 29 Sep 2026 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678353;
	bh=6KYk/aTymFcCdGtwMjDqi5Esf3NOvgoJ11PlfInhxLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdNYeeCtpHj+T31LWGoxSwZtw4aMHWJPQvDDbVU+G8X8wuUkfBnZdIvV3uOFFuhnB
	 VVCZFfDc5kBgiOdoxxx8lFPY7k06NhFGsgVEB+qM0Ahrc9jnlooHj64ItyD4pumWIh
	 gMuqBMn/6HimqFkDPUObJvUKVRxzh5MvFctQgjPBlrPPVvXXGGyfb321OfFTREZ9vN
	 3ql6+JclMnEeJzW5pygIiDx4lT1J4QENyDSfIr6VOvvdJz36bxlVKXECVjg93I/dwd
	 qTt+TeByxw7taDxglmknT2coYdubscmB31J2tXCHzsJ0aSuefP2Ux3O/E5fFNnFARO
	 8LahKRKM2I1Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Add watchdog node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Komal Bajaj" <komal.bajaj@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260929-sm8750-watchdog-v1-2-ea06d5dc7e54@oss.qualcomm.com>
References: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
 <20260929-sm8750-watchdog-v1-2-ea06d5dc7e54@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:39:12 +0000
Message-Id: <20260929103912.C22291F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt: incorrect node ordering in sm8750.dtsi
--

commit 807aba78b66c219c014d5a42b4b7964dbeb6b207
Author: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

arm64: dts: qcom: sm8750: Add watchdog node
   =20
This commit adds a device tree node for the watchdog on the SM8750 SoC.

> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/q=
com/sm8750.dtsi
> index 8ed5fa4d24fcd..53125e5dc4cca 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -6006,6 +6006,13 @@ cpucp_mbox: mailbox@16430000 {
>  			#mbox-cells =3D <1>;
>  		};
> =20
> +		watchdog@16410000 {
> +			compatible =3D "qcom,apss-wdt-sm8750", "qcom,kpss-wdt";
> +			reg =3D <0x0 0x16410000 0x0 0x1000>;
> +			clocks =3D <&sleep_clk>;
> +			interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
> +		};
> +

[Severity: Low]
Does this placement break the ascending unit-address order convention for
Device Tree files?

The new watchdog@16410000 node is being placed immediately after the
mailbox@16430000 node. Should this node be moved above the mailbox node to
keep the children sorted numerically by their unit address?

>  		apps_rsc: rsc@16500000 {
>  			compatible =3D "qcom,rpmh-rsc";
>  			reg =3D <0x0 0x16500000 0x0 0x10000>,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-sm8750-wat=
chdog-v1-0-ea06d5dc7e54@oss.qualcomm.com?part=3D2
