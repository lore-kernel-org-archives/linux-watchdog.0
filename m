Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809521;
	b=ICWulQOdJ4udVuX2bcjzd0vn2id+3KXyJM680Vi7skBMkaHGiKvNuo4LgwGFsPMf5T6Y
	 v1W5gG3VF705/4CwsiZfQj92HrpEBqDYu8e1XWD7M+TX7qT/Sfuobv00ngC6KBg/vMAwm
	 Z+iO4l+v66hBk2YHj18I0CMyfChH6YqrS4t9/w0hzWhld1wLnL+SyonMhXHFKBczaMRNb
	 oFjCYJggFG5vVRmzkRuVT06qx+DdP2dW1CyWu3lHp1IjSghut5yY1Vv4uSjCOgfU0f/GC
	 4Zx+/DmalbHxQT++Jb6SSpf7ZmLgF3meODTC/3Ed0HNgyCPklO4tRMccGODF5rrpj3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jIHjFlO9+orZ5F5AEesuV3qicU6AOrVZslL2KTqrtuw=;
	b=mAI4KgeRzQRHYKhJPuR89aslz/tx0cZ+Bbl/1Lpjt40yaFlWzsIe6kp9FcUWmCM6rvmY
	 dI2mgT0le/6rPZDCsuyVvVZkTTc1AWQZbqFI5XqGXwVvB3c7Namftl5YQUJ9ooAuV3a5T
	 UpcNzs1zhqKk+tGCBDWHgFDFDHTmMOZ+vqUC1BtTMNtznknSzQl/dlVFkgyHUJq6Rvokj
	 YMRRCbSu1N8YFvn8jP9dtpAIMm2Ua1qa66k07XzbqVt9RR5C5i4VeZ1e+HY3PvaXh71MK
	 mwDQCAoRPV2fPBINi8Vh2iOZnSCdewRF5jHHE51P7vnTco+4b7oj1f/VBsy7XqqhODA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfvvjaVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E854606A32D;
	Wed,  4 Nov 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfvvjaVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669051F000C1;
	Wed,  4 Nov 2026 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809520;
	bh=jIHjFlO9+orZ5F5AEesuV3qicU6AOrVZslL2KTqrtuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfvvjaVnQSI2T5fsqdQL2bA4KCCvS35wYhGnRhLIJ9idGrsekYN9+1uS9khWEYr8x
	 CmC30tHRi82H3nAqSfat1EUROQdR7oJ+BuGuWDo/kFAmNmAncH/YcGtILCzhzzTBK2
	 5q+pvZwmBgmXgFJz2lVTQCWCYghwXSHxTKjdeQs5GjeAfUXUivDufIjSr6cqjG1gnd
	 hXZ9rYvIffpG6LJUPj2EDoNk6Ngz5PhTpJJKQb+1acUklrcVpdyUbKtPNeRvuxkIRo
	 1Vl9Sf8XgxO3tL0imWDqNX8RDgjb4Dcj6HsGdCeGUvzlOhypIcNHfoJu9OYYXm6HKS
	 R96SzYLjk13xg==
Message-ID: <sashiko-outbox-197603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: watchdog: arm-smc-wdt: allow a
 list of SMC ids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mateusz Nowicki" <mateusz.nowicki@posteo.net>, linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104161553.30115-2-mateusz.nowicki@posteo.net>
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
 <20261104161553.30115-2-mateusz.nowicki@posteo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:25:20 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: watchdog: arm-smc-wdt: unsafe SMC ID probing list i=
n arm,smc-id
--

commit dea383b087f6f2623ae4ede98f366e18fd9b9ed8
Author: Mateusz Nowicki <mateusz.nowicki@posteo.net>

dt-bindings: watchdog: arm-smc-wdt: allow a list of SMC ids

This commit changes the arm,smc-id property in the arm-smc-wdt binding from=
 a
single uint32 to a uint32-array of up to 4 items so the driver can probe a
list of candidate SMC function IDs in order across different firmware
versions.

> diff --git a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> index 8e9d0b7e82444..9844b23ef51ce 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> @@ -18,9 +18,14 @@ properties:
>        - arm,smc-wdt
> =20
>    arm,smc-id:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
>      description: |
> -      The ATF smc function id used by the firmware.
> +      The ATF smc function id used by the firmware, or a list of ids for
> +      firmware versions that use different ones. The ids are tried in or=
der
> +      until the firmware accepts the init call, so only ids that are kno=
wn
> +      to be this watchdog service on the platform belong in the list.
>        Defaults to 0x82003D06 if unset.

[Severity: Medium]
Is it safe to define arm,smc-id as a list of candidate SMC function IDs to =
be
sequentially probed in EL3/S-EL1 secure firmware?

In drivers/watchdog/arm_smc_wdt.c, smcwd_probe() invokes smcwd_call(wdd,
SMCWD_INIT, 0, &res), which issues arm_smccc_smc() with a raw function ID a=
nd
arguments a1=3D0, a2=3D0 without any UUID or version handshake:

drivers/watchdog/arm_smc_wdt.c:smcwd_probe() {
	if (of_property_read_u32(pdev->dev.of_node, "arm,smc-id",
				 &smc_func_id))
		smc_func_id =3D 0x82003D06;
	watchdog_set_drvdata(wdd, (void *)(uintptr_t)smc_func_id);

	err =3D smcwd_call(wdd, SMCWD_INIT, 0, &res);
}

Because SiP and Trusted OS SMCCC function IDs are vendor- and
firmware-specific, an ID used for the watchdog in one firmware release is n=
ot
guaranteed to be unimplemented across all other firmware implementations for
that SoC. Could probing a list of candidate IDs invoke an unrelated
privileged SMC handler on firmware versions that assign one of the earlier
IDs to another service, causing unintended secure-world side effects or
binding the watchdog driver to the wrong service if it returns 0?

Also, existing Devicetree consumers (such as older kernels calling
of_property_read_u32() on arm,smc-id) only read the first cell and will fail
if the active firmware uses a subsequent ID in the array. Since a running
firmware image implements a single watchdog SMC ID, should differences
between mutually exclusive firmware builds be handled by the bootloader
updating the Devicetree, a DT overlay, or board-specific DTS files rather
than encoding a trial-and-error probing list in the SoC dtsi?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161553.3011=
5-1-mateusz.nowicki@posteo.net?part=3D1
