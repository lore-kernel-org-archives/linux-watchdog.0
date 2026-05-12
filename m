Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826C3A16BE;
	Tue, 12 May 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626089; cv=none; b=TKFavKgj4sXd6u9fGKUTO0PRLqSXhcjgGbQNAlIIxQaOKkaKRqooeNLHASr3H878iRAuMJvwFI1bYCQ2Sbq89rMiSseltV9FAFXstg+lD6VWbA5XRq2XzwcNxTwvyNUrfLkAdsOJSACiFLF3neScxz580NeX5wG5NNItRiWCtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626089; c=relaxed/simple;
	bh=z6PvjeK1otOugzQmMUi5HP0ZdFxp7kZwc4I5hH8Y1O0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqWipBi0se7ZM3Ko87WDwixhdCzjpbem7fPsiQFHhyl4HSqWUM4unMVhV+EjQE5dlyn3RtEmWOmmf37n+8htuXEsQq0k1YZcOTNeBPJdgIe9rh64NJ8zXsnfpZYkm+TWwLq888R/C6uUJhgIMUO4g+XkakzaSZM0hgoM97wNKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEQ26W2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEQ26W2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C83EC2BCB0;
	Tue, 12 May 2026 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778626088;
	bh=z6PvjeK1otOugzQmMUi5HP0ZdFxp7kZwc4I5hH8Y1O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uEQ26W2XEJuMy93LrSFUIRuymYBnT2wJ7NzEC00LnsdvTzqZHvJKV25wfGfmtquqx
	 LWJN88uk1z3Cdlswc8fjTNhAwgrvpOO7i+lUqjKKN3QSFUihysQwtHWipYO+xQbqxx
	 inSXqoLs95S2tdu8hBmubU+nAY1N9ROjwAkkYhZeNaRZZ/9b/Q2YG5l6eBxvPUqdeB
	 bvUtVX5tLc0OXXWHDVgVFoYRp9fymYmV4aCy5cEj9QHVi79J2bkwwePO/caNOWREOs
	 PTRUf/tPoSh5MrFbCi9GuuAr/bAqfte4e5H9dfXT0vsf1ysshdNbQTKgD8dvDxKXYJ
	 VFRcH9JqAicJw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] dt-bindings: clock: renesas,cpg-mssr: Support
 RZ/T2H system controllers
Reply-To: sashiko@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, krzk+dt@kernel.org
In-Reply-To: <20260511185058.1926869-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 22:48:08 +0000
Message-Id: <20260512224808.9C83EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `ranges` property is not restricted in the `else` block for =
non-target SoCs, violating the commit's intent.
- [Medium] Properties explicitly documented as required for the RZ/T2H SoC =
are not enforced in the schema's `required` list.
- [Medium] The commit message scope contradicts the implementation by silen=
tly including the RZ/N2H SoC.
--

commit 05c781ffa6d79749c3fc36af69e7b0775046bc24
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dt-bindings: clock: renesas,cpg-mssr: Support RZ/T2H system controllers

This commit adds support for system controller child nodes within the
CPG/MSSR address space for the RZ/T2H SoC. It adds #address-cells,
#size-cells, and ranges properties to the CPG/MSSR binding and restricts
them to the target hardware.

> dt-bindings: clock: renesas,cpg-mssr: Support RZ/T2H system controllers
>
> The RZ/T2H SoC features system controller blocks for low-power management
> and access control that reside within the CPG/MSSR address space. To
> properly represent these hardware modules, allow them to be defined as
> child nodes of the CPG/MSSR controller.
>
> Update the CPG/MSSR binding to support child nodes by adding
> system-controller child nodes using a patternProperty, requiring a reg
> property and a renesas,sys-block property to identify the controller
> instance.
>
> Restrict these new properties to the RZ/T2H SoC to ensure existing
> bindings for other Renesas SoCs remain unaffected.

This isn't a bug, but the commit message explicitly claims to restrict
these new properties to the RZ/T2H SoC. However, the schema conditionally
allows these properties for the RZ/N2H SoC as well. Could the commit
message be updated to mention RZ/N2H if it is also intended to use these
properties?

> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yam=
l b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> index 655154534c0f1..ec13fcaf763e7 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
[ ... ]
> +  '#address-cells':
> +    description:
> +      Required for the RZ/T2H SoC to define the address space for child
> +      system-controller nodes.
> +    const: 2
> +
> +  '#size-cells':
> +    description:
> +      Required for the RZ/T2H SoC to define the size of the register
> +      blocks for child system-controller nodes.
> +    const: 2
> +
> +  ranges:
> +    description:
> +      Required for the RZ/T2H SoC to provide 1:1 address translation
> +      from the child system-controller nodes to the CPU address space.

Since these properties are explicitly documented as "Required for the RZ/T2H
SoC", should they be enforced in the schema's required list for the target
SoC? Without this enforcement, incomplete device tree nodes missing these
properties might silently pass validation.

[ ... ]
> @@ -126,6 +161,10 @@ allOf:
>        properties:
>          reg:
>            maxItems: 1
> +        '#address-cells': false
> +        '#size-cells': false

Does this else block also need to include ranges: false?

While #address-cells and #size-cells are correctly disabled for non-target
SoCs, ranges appears to be omitted. This could globally allow ranges for
all other Renesas SoCs, potentially letting invalid device tree
configurations silently pass schema validation on older hardware.

> +      patternProperties:
> +        "^system-controller@[0-9a-f]+$": false
>    - if:
>        not:
>          properties:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511185058.1926=
869-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
