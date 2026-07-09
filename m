Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92B43933F;
	Thu,  9 Jul 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583060; cv=none; b=tirLSe/KlIPZyELApoH1wfolcp6ZD3k5f4qdNF3OIsVPMVGHHC4aal2Qvt6QgymD+Za/TXYn4rXc5Sexk1kj9tlc+bGCNGVq6W3W69IUSwPxHK/BmNiqC9MU/Y0JsM8M9AnAp0rOJIaWgH/5/JEF3yyDYP4dBO//5IwboQXx89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583060; c=relaxed/simple;
	bh=zjaVX1nh9jUyOYhnWPmq81TKk7/d5DznNgwkuXAw/uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XI15FD+q1alKSxbsa2R4eemE00kBZxJRmc1IPm68enBXwTMaX2pPwmbSQAKBMloi29uFgeAGr3TPDHKR9TaPid03M5VBBYI5rfTMYOj6tJbk7psGGosMX0V6hLZcg694Ln5VQqHOHUDr+yNCGbyITVaHmOEqrd2GgUdu0wwP6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQPcTkEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQPcTkEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D9D1F000E9;
	Thu,  9 Jul 2026 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583059;
	bh=oh8xQoOOgY4Sfb3BAb0eeQpNdISArl5kdH4cYEwLLjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQPcTkEcFQU0AjohYO7kGiE53gIrFeOdxhIWgVqUFhGeelsBnjJiKyAlKITR+hppe
	 tWJepTqFj0fAaoXTkllOAKOFR1YjgWfhtfsfJeRSHJcskVt1f7rWmFTaXhB1LM1tN1
	 IJQ3rq2HKJC8XEa/XK1fTKDudNtv9XScVmmU30s1hQFHmVt22XFW0c7qgZeDHkvGRy
	 fNlZtQbzQe6IIP60oXDqYLwC2SIuylmEpcR8VpMIj+JGiJgXSTV4kOnxv+WRYBc2id
	 Wp9YsK4LXWR+smJiduzIIgdIO3TApeyrWrW7HJQLeACWc44ZCAlA1KQsCGPvZAPeV3
	 g++NPNgJtkdog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] dt-bindings: arm: apple: apple,pmgr: Add t6030
 and t6031 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-4-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-4-55b305833123@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:44:18 +0000
Message-Id: <20260709074418.A8D9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing corresponding power state compatible strings in the chil=
d node binding `apple,pmgr-pwrstate.yaml`.
--

--- Patch [4]: [PATCH 04/11] dt-bindings: arm: apple: apple,pmgr: Add t6030=
 and t6031 compatibles ---
commit 70fb3d6202b1ab439abc072cacf0b78492449f42
Author: Janne Grunau <j@jannau.net>

dt-bindings: arm: apple: apple,pmgr: Add t6030 and t6031 compatibles

This commit adds per-SoC compatible strings for the Apple M3 Pro, Max, and
Ultra PMGR blocks to the apple,pmgr binding schema.

> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml =
b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> index c67b67ba065af..1d2001836eb48 100644
> --- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> @@ -38,6 +38,8 @@ properties:
>        - items:
>            - enum:
>                - apple,t6020-pmgr
> +              - apple,t6030-pmgr
> +              - apple,t6031-pmgr

[Severity: Medium]
Since these new compatibles are being added here, do we also need to add
corresponding power state compatible strings to the child node binding?

Looking at Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
under properties:compatible:oneOf:items:enum, it lists:

      - items:
          - enum:
              - apple,t6020-pmgr-pwrstate
              - apple,t8122-pmgr-pwrstate
          - const: apple,t8103-pmgr-pwrstate

Will device tree schema validation fail for M3 Pro, Max, or Ultra device
trees that define power domain child nodes if apple,t6030-pmgr-pwrstate and
apple,t6031-pmgr-pwrstate are omitted from that enum?

>                - apple,t8122-pmgr
>            - const: apple,t8103-pmgr
>            - const: syscon

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-apple-t603=
x-initial-devices-v1-0-55b305833123@jannau.net?part=3D4
