Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD0179A3;
	Wed, 13 May 2026 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631172; cv=none; b=oP7M7vkl16RU1VJbNj4WQyfcdQL/oMyl13eSXiPMqIwRMqcKGzQOu2zqlVT/y9yGBZijAcemIE4nsZ98B+WDqXeqiX9EK373vzxlOTLJRwUTstDp5XAU6+jvbMZeGySOmoFRY8/FPcHZM1UkyHtFYU9K5UyI+5qytt06hTUrhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631172; c=relaxed/simple;
	bh=8KyXjjxQbRpENVbsYeAgqrKcdZGC9XI/nrq6QNY8kx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IaVm3lGKqJJjFvE0bZ1Ar7boNplNW5sddbbYnMzDHwbacsdXP2Qp5XxbFVMECEobPpiaFV8O+6A1xELmF29RheK5pY2KVkB6OF/7ZVOaS2zLm9jDAQ0As4/e+3CExFoQ0ghcoi4ge5wPZfEJGGABYLIpATF6xhFTlypWzt4mK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DijTexcQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DijTexcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A99C2BCB0;
	Wed, 13 May 2026 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778631172;
	bh=8KyXjjxQbRpENVbsYeAgqrKcdZGC9XI/nrq6QNY8kx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DijTexcQExMvee6AB5FhL32DRwLwd+T/CC+EqxJf7WH0jB6AsIi3qtLTNm9XHlwQ4
	 E1IYmuCev30Cx6fRW/umG5D3L5vS9STTtJG8GQKFQ5oIAnm5N12WfnVh0hCpcaT5vI
	 NdPbbPot+u9d/zVlwRnEXgCav3ckDkgX6CkDLOWOxA/N+KljQ8vG4XmxnyCmYaTTui
	 276EewymZJOm+OWTwCFyTGPSlQ3DoLlC/YmBcEXp4UuuXi+veEqzkjJShPadFFQCSz
	 rJlq7m89ndXuUF1/25xlcFwOSDMt0I1sLDIBgM/XQUpaFcEC5nWug4UucgpYbbCJ8W
	 VWgtd7fbSDsdQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/9] clk: renesas: r9a09g077: Add SYSC regmap
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, krzk+dt@kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260511185058.1926869-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:12:51 +0000
Message-Id: <20260513001252.12A99C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free vulnerability due to globally registering a devres-=
managed regmap.
- [Medium] Memory leak of devres allocations for non-matching child nodes d=
uring initialization.
--

commit 42e8a93f573528685964e7e4e8583fa90ffb5b6b
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

clk: renesas: r9a09g077: Add SYSC regmap support

This commit adds System Controller (SYSC) regmap support for the RZ/T2H SoC.
It implements support for creating regmaps for SYSC blocks defined as
child nodes within the CPG address space, and registers them using
of_syscon_register_regmap().

> diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9=
a09g077-cpg.c
> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c

[ ... ]

> @@ -514,6 +514,172 @@ r9a09g077_cpg_clk_register(struct device *dev, cons=
t struct cpg_core_clk *core,

[ ... ]

> +static int r9a09g077_sysc_init(struct device *dev)
> +{
> +	struct device_node *child, *np =3D dev->of_node;
> +
> +	for_each_child_of_node(np, child) {
> +		struct regmap_config *regmap_cfg __free(kfree) =3D kzalloc_obj(*regmap=
_cfg);
> +		struct r9a09g077_sysc_reg *sysc_reg;
> +		struct regmap *regmap;
> +		void __iomem *base;
> +		char *name;
> +		u32 index;
> +		int ret;
> +
> +		sysc_reg =3D devm_kzalloc(dev, sizeof(*sysc_reg), GFP_KERNEL);
> +		if (!sysc_reg) {
> +			of_node_put(child);
> +			return -ENOMEM;
> +		}
> +
> +		if (!regmap_cfg) {
> +			of_node_put(child);
> +			return -ENOMEM;
> +		}
> +
> +		if (!of_node_name_eq(child, "system-controller"))
> +			continue;

Does this leak devm-allocated memory for every child node that isn't named
system-controller?

The devm_kzalloc() call binds the memory to the parent device's lifetime,
not the loop scope. When the loop skips a non-matching node via continue,
the sysc_reg allocation remains until the device is removed.

Could the of_node_name_eq() check be moved above the memory allocations?

[ ... ]

> +		regmap =3D devm_regmap_init(dev, &rzt2h_sys_regmap_bus, sysc_reg, regm=
ap_cfg);
> +		if (IS_ERR(regmap)) {
> +			of_node_put(child);
> +			return PTR_ERR(regmap);
> +		}
> +
> +		ret =3D of_syscon_register_regmap(child, regmap);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}

Can this sequence cause a use-after-free if device initialization fails lat=
er?

The of_syscon_register_regmap() function adds the regmap to a global
syscon_list, but there is no corresponding unregister function to remove it.

If a subsequent step in the probe path fails, such as of_clk_add_provider()
failing in cpg_mssr_common_init(), the driver core will tear down all
device-managed resources. This will free the regmap and unmap its I/O memor=
y.

Because the freed regmap remains in the global syscon_list, a subsequent
syscon_node_to_regmap() lookup by a consumer would return a dangling pointe=
r,
leading to a use-after-free and a potential MMIO page fault.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511185058.1926=
869-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
