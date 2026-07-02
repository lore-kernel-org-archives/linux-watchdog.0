Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A520431E5B;
	Thu,  2 Jul 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996503; cv=none; b=ajbbU+/h7/kno2qKxpiG+30MIeXtoCUeZqUEHy8uc04ZrilP9wzmpWB8YloiwyH1UKUdNTJynZv5I5hEyfXVa4g80Hs6v/2hronfavFtURq3lQOPrAgrdbu0NII5EsWB8z63oP7r0J0FSAuuvE5TY/+w6d3S6q4mX8auJrwLc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996503; c=relaxed/simple;
	bh=g7TjNTM67Xpdul/ROc1W9DFiqNC3L8ojRae16cGX9eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVkRqRQc8H7mXJcU2vb8Sb8WPS99Oe+u3rJXQtFLlkZCvNxLLYDfcIhSixTdyonorNYnmzQq1ZtHMCfWkUIgWJl8/KuLsOUypiJ6unjGVfjb8kXAz3U3LZEp6McDqyDQJafBVQL0RfiVjo9dx8RICk0A+DWAeBXTW/1CcGAhRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1PnXlC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1PnXlC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045D01F000E9;
	Thu,  2 Jul 2026 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996502;
	bh=IAPEUqxh/3TXXQMx85kkuQrK8pLxgA0XcCdqj5b9bQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1PnXlC1xxT2dlKK4QopmgIPf0DUlJWWIeL1khKclpkfCKByRaDm4HOp+q8dkmYrZ
	 UBv/8zUDZ5SJ9T7qKHe6sf3SkT9E4pBDG37Q2T588jOw/LsAXDcibIOrE1kGZiu/Dd
	 h0pbWVkFavOM5DtuYx0Y5afjJ7o1kOvrjYlapcnAMx/kASAIPhvkZb+qO1ACJPZza1
	 Ri+scmn0Md2Y9t6iJCbJWUw13t2rXzHYO44VErQBMy+243wjh5t0hAv3DDIVaLVQIy
	 4iHKhsjTQ3Hod+aoUtC6EAOrzvTACT7zdwkU2nsaLoBEEG/UDslasrL/GoeMt+N0Sn
	 Q31oOuZLkLy/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 2/9] clk: renesas: r9a09g077: Add SYSC regmap
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:48:21 +0000
Message-Id: <20260702124822.045D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Registering a devres-managed regmap with the global syscon_list ca=
uses a Use-After-Free upon probe failure.
- [High] Missing of_node_get() before registering the child node with sysco=
n risks a Use-After-Free of the device node.
- [Medium] The commit message contradicts the implementation regarding whic=
h device node the regmap is registered against.

Pre-existing issues:
- [High] Failing to explicitly remove the PM domain provider on probe error=
 leaves a dangling provider pointing to freed memory.
--

commit db570cc0b618206556f7cc6978347f7824aa7f3f
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

clk: renesas: r9a09g077: Add SYSC regmap support

Add System Controller (SYSC) regmap support for the RZ/T2H SoC.

The RZ/T2H SoC features two System Controller (SYSC) blocks that handle
low-power management and access control. These blocks are defined as child
nodes within the Clock Pulse Generator (CPG) address space in the device
tree. Implement support for creating regmaps for these SYSC blocks.

> Register the regmap using of_syscon_register_regmap() against the CPG
> device node so that consumers can access SYSC registers via the existing
> syscon phandle.

[Severity: Medium]
The commit message states the regmap is registered against the CPG device
node, but the code actually registers it against the "system-controller"
child node. Could the commit message be updated to match the implementation?

> Add a sysc_init() callback to the CPG/MSSR core to allow SoC-specific
> initialization of the SYSC regmap.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9=
a09g077-cpg.c
> index 5640c2035e5a4..33aec2f272df4 100644
> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c
[ ... ]
> +static int r9a09g077_sysc_init(struct device *dev)
> +{
> +	struct device_node *child, *np =3D dev->of_node;
> +
> +	for_each_child_of_node_scoped(np, child) {
> +		struct regmap_config *regmap_cfg __free(kfree) =3D kzalloc_obj(*regmap=
_cfg);
> +		struct r9a09g077_sysc_reg *sysc_reg;
> +		struct regmap *regmap;
> +		void __iomem *base;
> +		char *name;
> +		u32 index;
> +		int ret;
[ ... ]
> +		regmap =3D devm_regmap_init(dev, &rzt2h_sys_regmap_bus, sysc_reg, regm=
ap_cfg);
> +		if (IS_ERR(regmap))
> +			return PTR_ERR(regmap);
> +
> +		ret =3D of_syscon_register_regmap(child, regmap);

[Severity: High]
If the probe fails on a subsequent step (for instance, during the next loop
iteration), devres will automatically free the regmap since it was allocated
using devm_regmap_init().

However, of_syscon_register_regmap() saves the regmap pointer in a permanent
global list (syscon_list), which has no unregistration mechanism. Does this
leave a dangling pointer in the global list, leading to a use-after-free on
subsequent syscon lookups?

[Severity: High]
Additionally, the child node reference is borrowed by
for_each_child_of_node_scoped() and will be automatically dropped at the end
of the loop iteration.

Since of_syscon_register_regmap() internally saves the raw device_node poin=
ter
into its global list without incrementing its reference count, could this
result in a use-after-free of the device node if the device tree node is ev=
er
dynamically removed? Should we call of_node_get() before registering it?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas=
/renesas-cpg-mssr.c
> index 4ed056b18d31f..a46ea82ed85e0 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -1415,6 +1415,9 @@ static int __init cpg_mssr_probe(struct platform_de=
vice *pdev)
> =20
>  	error =3D cpg_mssr_reset_controller_register(priv);
> =20
> +	if (!error && info->sysc_init)
> +		error =3D info->sysc_init(priv->dev);
> +

[Severity: High]
This is a pre-existing issue, but this new error path exposes it more easil=
y.

Earlier in cpg_mssr_probe(), cpg_mssr_add_clk_domain() adds an OF genpd
provider. While devres is set up to call pm_genpd_remove(), that function
refuses to remove domains that still have active OF providers (returning
-EBUSY).

If probe fails here in info->sysc_init(), devres will proceed to free the
cpg_mssr_clk_domain structure. Because the domain wasn't actually removed
from the global lists, the active OF provider remains pointing to freed mem=
ory.

Does the driver need to explicitly call of_genpd_del_provider() on error pa=
ths
to prevent this use-after-free?

>  reserve_exit:
>  	cpg_mssr_reserved_exit(priv);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702123112.1611=
60-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
