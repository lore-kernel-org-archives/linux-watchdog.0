Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD134F270;
	Sun,  9 Aug 2026 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292741; cv=none; b=aDqmzT4YE+29pArpCZ3bGI0rpkr12n4jHtzZZiDsT87nTfiASgHpUr3fcbKWQ7pK8e7MT6F51e6ZLc9v0qMq1hpOZfZ8Kki+pOFoOKyQn4HyPlGoCRASMx4SVuLweb3oAY/2ObT0WSYdcrbeLsNknFshu0gShUQ5SJ1ukwofKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292741; c=relaxed/simple;
	bh=1w8ukhpS9Z3Tx/0nKtKYRpbl0djxaC8+E8NH0+zvoCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f1Dc1DClu3H/ADQ5ZRJBxgxUwzlP/OJMRACckwIgPj3BbW0la+K/yvT0FRvLmdISicLYnGYce5W7QxZDdZFBPsNVNqQfXLPI59Odf92U/BSFk2+ZAjGGNR7kdl4QIiNffMj+q77QdQ0BfwkeUJtixOEaSTaOw+JWk8gP9thuDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSbKZdI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSbKZdI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4824C1F000E9;
	Sun,  9 Aug 2026 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786292739;
	bh=HY18+QoQ20o4RT4hZdPjAkg8U+GnvtJqm5BFmcHs9No=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSbKZdI4ZGN1l26qAe8kRuKb7PhX9gRnG0RIDzczRhTXEuamAC6YCoo4zt2gItaMk
	 zLHavSl6lPpJzMn9tJzxUYL5SGqB8KeGH/kepu4x/GUKyNCR5fWfEsPoHRDwP3IJpK
	 /UVtZGykHjzhLnsmy12XwFkVKmJjQFQvZH3VnpOHpFI+La+sSoGpj06ZMA+0z8IdQF
	 AhkV5U63Tl15q/+G05NrwdD7HxqiB5KrSueh8JNG0bo0sKRiRwEEijlzsV5wQ1ozVh
	 4dAwFXP3/Jp5jRcwgpPNUFQfnIXJuKHa1vFBIuMLRRNZOzHc4goe7yB0NF1xajqqJH
	 97yiuDXluSEhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: reset: Add reset controller
 constants for mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260809160643.33991-6-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 16:25:38 +0000
Message-Id: <20260809162539.4824C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `#reset-cells` in the `required` list for the MT8167 wat=
chdog and MMSYS bindings.
--

--- Patch [5]: [PATCH v3 5/8] dt-bindings: reset: Add reset controller cons=
tants for mt8167 ---
commit 226fd0fca4b3ef6d17665690b5633d8884780bcb
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: reset: Add reset controller constants for mt8167

This commit adds reset ID constants for the MT8167 watchdog (TOPRGU)
and MMSYS devices.

> diff --git a/include/dt-bindings/reset/mediatek,mt8167-resets.h b/include=
/dt-bindings/reset/mediatek,mt8167-resets.h
> new file mode 100644
> index 0000000000000..af8a3e499f8b6
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt8167-resets.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8167
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8167
> +
> +/* TOPRGU resets, these are actual bits in the register */
> +#define MT8167_TOPRGU_DDRPHY_FLASH_RST		0
[ ... ]
> +#define MT8167_TOPRGU_SW_RST_NUM		15
> +
> +/* MMSYS resets, these are IDs */
> +#define MT8167_MMSYS_SW0_RST_B_SMI_COMMON	0
[ ... ]
> +#define MT8167_MMSYS_SW1_RST_B_HDMI		27
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8167 */

[Severity: Medium]
Since this header adds reset provider capabilities for the MT8167 watchdog
and MMSYS, shouldn't the corresponding YAML schemas also be updated?

When a hardware variant gains reset capabilities, the #reset-cells property
typically needs to be added to the required list in the schema. Without
updates to mediatek,mtk-wdt.yaml and mediatek,mmsys.yaml to conditionally
require #reset-cells for mediatek,mt8167-wdt and mediatek,mt8167-mmsys,
incomplete device tree nodes will silently pass dt_binding_check validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809160643.3399=
1-1-l.scorcia@gmail.com?part=3D5
