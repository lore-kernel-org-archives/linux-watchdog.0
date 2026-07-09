Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE03BB101;
	Thu,  9 Jul 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582924; cv=none; b=AaYCcnvrpA6FqjN2mwI4YliLbCYFv0D8oAomEwIgTr5AdDuIYV8Mr04XiOTWyC8WPzVykwlN+iubDTl5vbSzVeOWrd0SbGYRLpxUe+9OmSIy7X33U2DdI8rqXUwW4991VTcIiAGcTIwMF9l9qU7K4k8R2E4FZRbidKSFIZGONkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582924; c=relaxed/simple;
	bh=87WeVOORuzTpahjb77APHd4rpR1j9OlPTAyoi7iKB1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJ9L7Pon+ZFC/hKGuPq9XDzDtz674G4gON6K6nlUQRxm00K/8AkIyVvJuGBCaE+NGau1JRhFf8/MVgHPYCsQ2IbUtI5wVY2YB8ftOUCSCFrUesGX7oUCNB6GcaNmf7wlS3DfpnSU6TxDAWBSyK6gKcCsrMXLqpwzcfvYbkHPKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmtxrgqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmtxrgqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A36A1F000E9;
	Thu,  9 Jul 2026 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582923;
	bh=DcCAJUUdE2PH7v36Disc1MhOkmF26smewevRUweMx64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmtxrgqW/Pgj9gnceXMJFZU24nTouu/SMeRXIqdBGo9hmiLukbvy4ylj4x8FHZTW4
	 3BvdFedw8ggAX3Muhy5M/7vE+WqrmvnlFF1X8M+aSTa3/3WR76BMcukuOfGdr+xRWX
	 R7y1iAB5HtMLl0U0Fuz7C6I2o1b2KFBeJDmRB4F3/hF5Pcfg7DsexA74YdGkLP1A/a
	 SoFlzjrc82/A6kp3N91cB6auhkcBLd3MSz3zG8NqdNsSZ0ey9RZFWsvUrFZXQ+TJjm
	 8XFmmyg3ic+KB2d4Ir6rZudjraaifm5N2z/E1eRfRb8Df/GJiMM6L3kjN+xrce0eCv
	 Snd8+wx2E2UpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: interrupt-controller: apple,aic2:
 Invert #interrupt-cells condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-2-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-2-55b305833123@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:42:02 +0000
Message-Id: <20260709074203.1A36A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The compatible string `apple,t6031-aic3` explicitly referenced i=
n the commit message is completely missing from both the top-level schema `=
properties: compatible` definition and the inverted `#interrupt-cells` 4-ce=
ll conditional block, defeating the stated purpose of the patch.
--

--- Patch [2]: [PATCH 02/11] dt-bindings: interrupt-controller: apple,aic2:=
 Invert #interrupt-cells condition ---
commit 96c242a2f78e06c67eac2004fca37e5d7d112361
Author: Janne Grunau <j@jannau.net>

dt-bindings: interrupt-controller: apple,aic2: Invert #interrupt-cells cond=
ition

This commit updates the #interrupt-cells condition by explicitly listing
the compatibles used for multi-die SoCs and assigning them 4 cells, while
leaving 3 cells as the default for others.

>     The condition for 3 or 4 #interrupt-cells list compatibles for the 3
>     cells variant (not used in SoCs consisting out of multiple dies). This
>     includes the AICv3 base compatible "apple,t8122-aic3". This will match
>         compatible =3D "apple,t6031-aic3", "apple,t8122-aic3";
>     shared for M3 Max and Ultra based devices which require the additional
>     interrupt cell for the die number.
>     Instead list the compatibles used for multi-die SoCs explicitly and u=
se
>     4 #interrupt-cells for them.

[Severity: Medium]
The commit message mentions adding support for "apple,t6031-aic3", but is
this compatible string missing from the schema entirely?=20

It appears that "apple,t6031-aic3" is not present in the top-level properti=
es
compatible definition. Without being listed there, would device trees using
this string fail standard schema validation?

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,a=
ic2.yaml
> index d0d9a90e96e7b..a94787939d345 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> @@ -128,16 +128,16 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - apple,t8112-aic
> -              - apple,t8122-aic3
> +              - apple,t6000-aic
> +              - apple,t6020-aic

[Severity: Medium]
Does this conditional block omit the M3 Max/Ultra compatibles?=20

Since "apple,t6031-aic3" and "apple,t8122-aic3" are not included in this
explicit list of multi-die SoCs, they will fall through to the else branch.
Will they incorrectly receive a 3-cell constraint instead of the 4 cells
intended for multi-die devices?

>      then:
>        properties:
>          '#interrupt-cells':
> -          const: 3
> +          const: 4
>      else:
>        properties:
>          '#interrupt-cells':
> -          const: 4
> +          const: 3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-apple-t603=
x-initial-devices-v1-0-55b305833123@jannau.net?part=3D2
