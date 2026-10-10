Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF03955C6;
	Sat, 10 Oct 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652367; cv=none; b=owITvI4QBMSXHssMwQnmKkR+c/rs1fXO6xIA6E2gl1CAn1IrS55gvye/5qEioJtGR/TRCu1g+BdvP5GghYDEuq5TMTeGqEw99v5jLvfJtjVnUPAMTTotoLyVG2/35CIzkkbe85wI7EuVzyDr+GoGkdd38tpKTc6AMp9D/OjK6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652367; c=relaxed/simple;
	bh=+5H7yiIEi5Q8OLUtHlffSAEI6hXwBQ5sls6nR4QlOnU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l2WhngFEzj6l45j1967fkWxZnnZBvQQGVO1INogivFsmgC2U9uMNIXJ+oJ/R41D9NM/32RVut0+dT8UcjwobyrMNZCfv9Tkj9AbV58vE2MDW6hOIdsJ2zBW7N+oP7pYLMqxXzd6sWnUXjQiJYnNer/NjbgIe0vnSnWFMW753Yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTIxu9Im; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTIxu9Im"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209EF1F000FF;
	Sat, 10 Oct 2026 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791652365;
	bh=zvAq8zd2quCIhs8nIAwwz5nsasE7YMQo5SRBtNa7Ztk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTIxu9ImZUS08UGL7lVhWQy5aHyHe/kCzqgIqcqCb6AZp0xLlEFIhqpHEO30f0LBP
	 drVUBIal14SnpHn9duXchJc4ZDxxAlbvjyEDHCXm1gNtlQcSn3kp36mBE00ajqLfjL
	 91Lds4niyxZfhvyaB5mf0czbxJNFlAs5cV1iDVCxp/LqgEf3ycfMzJn1FGw5vPUAmK
	 SOm7OFzNG+yh7vGR3+PErJmsKfFrIftaaBmoaheLT4sgi1Lft/id8z/5XtzwytsGYn
	 SyLh58E/uN1753I4Tdq3tsCbzn3YO3bERksZHtHIAUUDidRNmEuKRK6O5KDJc1y23v
	 vpMgJtFyvEMuA==
Message-ID: <sashiko-outbox-166773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: arm: apple: Add M4 Pro/Max based
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-9-781fb3f2d9f6@cyberchaos.dev>
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
 <20261010-apple-m4-pro-max-initial-devicetrees-v1-9-781fb3f2d9f6@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:12:44 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] dt-bindings: missing blank line before M4 Pro/Max list in descripti=
on
- [Low] dt-bindings: orphaned t6050-aic3 compatible in aic2 schema
--

commit fae2108ff5a60b40ae253b364d3bc3ad16bac012
Author: Yureka Lilian <yureka@cyberchaos.dev>

dt-bindings: arm: apple: Add M4 Pro/Max based devices

This commit adds device tree compatibles for the M4 Pro and M4 Max
based MacBook Pro, Mac mini, and Mac Studio devices. It updates the
top-level device listing and defines the required matching properties
for these platforms.

> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documenta=
tion/devicetree/bindings/arm/apple.yaml
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -144,6 +144,14 @@ description: |
>    - MacBook Pro (16-inch, M3 Max, 2023)
>    - Mac Studio (M3 Ultra, 2025)
> =20
> +  Devices based on the "M4 Pro" and "M4 Max" SoCs:

[Severity: Low]
Is there a missing blank line before this heading?

Most prior generation entries in this description block separate the
generation heading and device list with a blank line for readability.
Adding a blank line before this heading would keep the text formatting
consistent.

> +  - MacBook Pro (14-inch, M4 Pro, 2024)
> +  - MacBook Pro (14-inch, M4 Max, 2024)

[ ... ]

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,a=
ic2.yaml
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> @@ -134,6 +136,7 @@ allOf:
>                - apple,t6000-aic
>                - apple,t6020-aic
>                - apple,t6031-aic3
> +              - apple,t6050-aic3
>      then:
>        properties:

[Severity: Low]
Does this compatible string also need to be in the top-level enum list?

This compatible string was added to the conditional block here in an earlier
commit in this series, but it appears to be completely missing from the
top-level properties:compatible enum definition.

Any device tree attempting to use apple,t6050-aic3 will fail schema
validation at the top-level compatible check, which makes this condition
effectively dead code.

While t6041-aic3 correctly uses 3 interrupt cells and does not belong in th=
is
4-cell branch, the apple,t6050-aic3 string added here has no matching
top-level enum. Should it be added to the top-level list, or was this string
included here by mistake?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-apple-m4-p=
ro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev?part=3D9
