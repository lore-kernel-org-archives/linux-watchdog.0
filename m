Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655699;
	b=iCzF97ZogTG4zX66EK9XFJO7CI7aCh6F4ClTCVppY5a8RWQkFSvxKK2nbybQQ578iS5f
	 a5ehtItJCfCV5nfLK/fJsHfjK8cLryD41Uu0xcB7Kc/yRwHME3488ImusnJAIbPvDMPqr
	 xNkNtTi8Lo29z96f0TVFqqJlXbWx9FmPehQRMvu9g4NIKiwP0BDY3Xza6PPXrUAelKoD7
	 4btfiMgLN6zcUxNEIzfvLRQOiZEscttv6vcaysv2EFrX9omWP5OP/H+3MQBfWQlSGdltI
	 mTNLZLuGZgQjuM5ISmA1ce0dgsBL/JhWqoBmPeH2peqvHPNsB31R4GBb4HNMvhOvBrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655699;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=oFHRZz4Mnxme6EdFwyBEJYjpmB7sWhTR8nS+YvGiBwA=;
	b=Mu70LNqsA5cRb1yAMu6ckcJKokvQiQIunA1RAbkgGbL4Kkx1cvznt9WoGPOz3dZVQgCA
	 25tB6TJNxjrkgZcCmzSvaBUYRJ7RVF0z7KuUfQUuFuFtiv7gFYzjIyWM+PQXZE0HqdtA8
	 t5auIK0P5S9IZAQq8mV4g0ZsV/kVxVAOIgCFoquwotOG2pBP1Nwwf1rUScgaIRollknXp
	 lCERWpNWeuWPsK8sCYM/Njy4uLWIMNUmNS0Y+8LJwJwqfivUmzkI3FFjbswOhR+1YOzvY
	 1y46+94AOUBstinJrgFdD9PpAYsHufeZELxs7OiLWP7oMERX2lF5s5cmdbjtHx+V67Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsocJCQg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3965606A31A;
	Thu, 22 Oct 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsocJCQg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88351F000C7;
	Thu, 22 Oct 2026 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655698;
	bh=oFHRZz4Mnxme6EdFwyBEJYjpmB7sWhTR8nS+YvGiBwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PsocJCQgNm2IGote4dwAFCSR+7CJxDS0Uy5EGnQzfktzgwSQBbB/OHzBjk8m5+aRX
	 pc0PgbwIWIA2mmzke7EqlfUs6MA29I0VbIYT90SPYHcJC1R3DdZBZVdKUs76MDSSa5
	 li3jNXyQP/mo9f5A14KE5ioLN/GVJlUMFszYIIf2oUSOTcDmw85rKXL1kfcYleJ493
	 M8cgDjvPsihbtyBuqITvmpEH0xx/GuSN1iM9g+ydQLtb5xoSnfCXa6ny4T7fuH8idN
	 Sn+1zlizIkcImM2GmNT45iAHn0jkR3Wab5ZruzM95lyZcNkREcsGmuewX9qpt22JFh
	 orhXtdIYsJFbQ==
Message-ID: <060c3f44-2567-4b09-8d00-f38b92339029@kernel.org>
Date: Thu, 22 Oct 2026 08:54:51 +0100
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] power: reset: Add PSCRR NVMEM recorder
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
 <20260914-pscrr-provider-v3-2-c45cb16542e8@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260914-pscrr-provider-v3-2-c45cb16542e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/26 5:38 AM, Faruque Ansari wrote:
> Record the power state change reason into a NVMEM cell (a PMIC
> SDAM byte, RTC scratch register, or EEPROM) and read it back on the
> next boot, so the cause survives a power cycle.
> 
> The recorder is implemented as an NVMEM layout driver: it owns the
> single cell described by its layout binding and adds it to the
> parent NVMEM device, rather than acting as a standalone consumer of
> someone else's cell.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  drivers/power/reset/pscrr/Kconfig       |  14 ++
>  drivers/power/reset/pscrr/Makefile      |   1 +
>  drivers/power/reset/pscrr/pscrr-nvmem.c | 269 ++++++++++++++++++++++++++++++++

Consider moving this to drivers/nvmem, as this is an independent driver
and no dependency to drivers/power headers.


>  3 files changed, 284 insertions(+)
> 
> diff --git a/drivers/power/reset/pscrr/Kconfig b/drivers/power/reset/pscrr/Kconfig
> index 72de82731b53..459b05ba32d3 100644
> --- a/drivers/power/reset/pscrr/Kconfig
> +++ b/drivers/power/reset/pscrr/Kconfig
> @@ -31,3 +31,17 @@ menuconfig PSCRR
>  	  unless hardware provides the reset cause.
>  
>  	  If unsure, say N.
> +
> +if PSCRR
> +
> +config PSCRR_NVMEM
> +	tristate "PSCRR NVMEM recorder provider"
> +	depends on NVMEM_LAYOUTS
> +	help
> +	  PSCRR recorder that stores the power state change reason in a
> +	  small NVMEM cell (such as an RTC scratch register) and reads it
> +	  back on the next boot, so the cause survives a power cycle.
> +
> +	  If unsure, say N.
> +
> +endif # PSCRR
> diff --git a/drivers/power/reset/pscrr/Makefile b/drivers/power/reset/pscrr/Makefile
> index e5530a858971..95c80c80c7da 100644
> --- a/drivers/power/reset/pscrr/Makefile
> +++ b/drivers/power/reset/pscrr/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PSCRR) += pscrr.o
> +obj-$(CONFIG_PSCRR_NVMEM) += pscrr-nvmem.o
> diff --git a/drivers/power/reset/pscrr/pscrr-nvmem.c b/drivers/power/reset/pscrr/pscrr-nvmem.c
> new file mode 100644
> index 000000000000..64f67f0521e0
> --- /dev/null
> +++ b/drivers/power/reset/pscrr/pscrr-nvmem.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pscrr-nvmem.c - NVMEM layout driver for PSCRR
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * Copyright (C) 2025 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/pscrr.h>
> +#include <linux/slab.h>
> +
> +struct pscrr_nvmem {
> +	struct nvmem_device *nvmem;
> +	u32 offset;		/* byte offset of the cell, from reg[0] */
> +	u32 bit_offset;		/* 0 when the cell has no "bits" property */
> +	u32 nbits;		/* BITS_PER_BYTE when the cell has no "bits" property */
> +	enum psc_reason reason;
> +};
> +
> +static inline u8 pscrr_nvmem_mask(struct pscrr_nvmem *priv)
> +{
> +	return (u8)GENMASK(priv->bit_offset + priv->nbits - 1, priv->bit_offset);
> +}
> +
> +static int pscrr_nvmem_raw_read(struct pscrr_nvmem *priv, u8 *raw)
> +{
> +	int ret;
> +
> +	ret = nvmem_device_read(priv->nvmem, priv->offset, sizeof(*raw), raw);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int pscrr_nvmem_raw_write(struct pscrr_nvmem *priv, u8 raw)
> +{
> +	int ret;
> +
> +	ret = nvmem_device_write(priv->nvmem, priv->offset, sizeof(raw), &raw);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int pscrr_nvmem_cell_read(struct pscrr_nvmem *priv, u8 *out)
> +{
> +	u8 raw, mask = pscrr_nvmem_mask(priv);
> +	int ret;
> +
> +	ret = pscrr_nvmem_raw_read(priv, &raw);
> +	if (ret)
> +		return ret;
> +
> +	*out = (raw & mask) >> priv->bit_offset;
> +
> +	return 0;
> +}
> +
> +static int pscrr_nvmem_cell_write(struct pscrr_nvmem *priv, u8 val)
> +{
> +	u8 raw, mask = pscrr_nvmem_mask(priv);
> +	int ret;
> +
> +	/* Sub-byte cell: preserve the neighbouring bits, read-modify-write. */
> +	if (priv->nbits < BITS_PER_BYTE) {
> +		ret = pscrr_nvmem_raw_read(priv, &raw);
> +		if (ret)
> +			return ret;
> +	} else {
> +		raw = 0;
> +	}
> +
> +	raw = (raw & ~mask) | ((val << priv->bit_offset) & mask);
> +
> +	return pscrr_nvmem_raw_write(priv, raw);
> +}
> +
> +static int pscrr_nvmem_read_reasons(struct pscrr_provider *p,
> +				    unsigned long *reasons)
> +{
> +	struct pscrr_nvmem *priv = p->priv;
> +
> +	/*
> +	 * Report the reason latched at probe (or overwritten by a later
> +	 * record); the cell itself was cleared at probe, so it is not read
> +	 * live here.
> +	 */
> +	set_bit(READ_ONCE(priv->reason), reasons);
> +
> +	return 0;
> +}
> +
> +static int pscrr_nvmem_write_reason(struct pscrr_provider *p,
> +				    enum psc_reason reason)
> +{
> +	struct pscrr_nvmem *priv = p->priv;
> +	int ret;
> +
> +	if (reason >= PSCR_REASON_COUNT)
> +		return -EINVAL;
> +
> +	ret = pscrr_nvmem_cell_write(priv, reason);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(priv->reason, reason);
> +
> +	return 0;
> +}
> +
> +static const struct pscrr_provider_ops pscrr_nvmem_ops = {
> +	.read_reasons = pscrr_nvmem_read_reasons,
> +	.write_reason = pscrr_nvmem_write_reason,
> +};
> +
> +static struct device_node *pscrr_nvmem_get_cell(struct device *dev,
> +						struct nvmem_device *nvmem,
> +						u32 reg[2])
> +{
> +	struct device_node *layout_np, *cell_np = NULL;
> +
> +	layout_np = of_nvmem_layout_get_container(nvmem);
> +	if (!layout_np)
> +		return ERR_PTR(-ENOENT);
> +
> +	for_each_child_of_node_scoped(layout_np, child) {
> +		if (of_property_read_u32_array(child, "reg", reg, 2))
> +			continue;
Please explain this, why are you ignoring child with reg? to start with
are you expecting child nodes without reg property?

> +
> +		cell_np = of_node_get(child);
You are getting only the first child? Please explain why this is not
inline with the bindings or vice-versa.

> +		break;
> +	}
> +	of_node_put(layout_np);
> +
> +	return cell_np ?: ERR_PTR(dev_err_probe(dev, -ENOENT,
> +						"missing pscr nvmem cell\n"));
> +}
> +
> +static int pscrr_nvmem_add_cells(struct nvmem_layout *layout)
> +{
> +	struct device *dev = &layout->dev;
> +	struct pscrr_nvmem *priv;
> +	struct device_node *cell_np;
> +	struct nvmem_cell_info info = { };
> +	u32 reg[2], bits[2];
> +	u8 val;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->nvmem = layout->nvmem;
> +
> +	cell_np = pscrr_nvmem_get_cell(dev, priv->nvmem, reg);
> +	if (IS_ERR(cell_np))
> +		return PTR_ERR(cell_np);
> +
> +	/* The reason is a single byte; a bit cell still occupies one. */
> +	if (reg[1] != sizeof(val)) {
> +		of_node_put(cell_np);
> +		return dev_err_probe(dev, -EINVAL,
> +				     "unsupported pscr nvmem cell size\n");
6 such instances with same exit point, consider using label.
> +	}
> +	priv->offset = reg[0];
> +
> +	if (!of_property_read_u32_array(cell_np, "bits", bits, ARRAY_SIZE(bits))) {
> +		priv->bit_offset = bits[0];
> +		priv->nbits = bits[1];
> +	} else {
> +		priv->bit_offset = 0;
> +		priv->nbits = BITS_PER_BYTE;
> +	}
> +
> +	if (priv->bit_offset + priv->nbits > BITS_PER_BYTE * reg[1]) {
> +		of_node_put(cell_np);
> +		return dev_err_probe(dev, -EINVAL, "bits exceed cell size\n");
> +	}
> +
> +	/* PSCR_REASON_COUNT must fit in the allotted bits. */
> +	if (PSCR_REASON_COUNT > (1U << priv->nbits)) {
> +		of_node_put(cell_np);
> +		return dev_err_probe(dev, -EINVAL,
> +				     "too few bits for the reason range\n");
> +	}
> +
> +	/*
> +	 * The cell survives resets, so at boot it still holds whatever the
> +	 * previous session recorded before it went down. Latch that as this
> +	 * boot's reason, then clear the cell back to PSCR_UNKNOWN: if this
> +	 * session is later cut short by an abrupt reset that never runs the
> +	 * recorder (watchdog power-cycle, sudden power loss), the next boot
> +	 * reads "unknown" instead of a stale reason left over from an earlier
> +	 * cycle.
> +	 */
Looks unnecessary comment tbh, has no value to the user.

> +	ret = pscrr_nvmem_cell_read(priv, &val);
> +	if (ret) {
> +		of_node_put(cell_np);
> +		return dev_err_probe(dev, ret,
> +				     "failed to read the pscr nvmem cell\n");
> +	}
> +
> +	priv->reason = val < PSCR_REASON_COUNT ? val : PSCR_UNKNOWN;
> +
> +	ret = pscrr_nvmem_cell_write(priv, PSCR_UNKNOWN);
> +	if (ret) {
> +		of_node_put(cell_np);
> +		return dev_err_probe(dev, ret,
> +				     "failed to clear the pscr nvmem cell\n");
> +	}
> +
> +	info.name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
> +	if (!info.name) {
> +		of_node_put(cell_np);
> +		return -ENOMEM;
> +	}
> +	info.offset = reg[0];
> +	info.bytes = reg[1];
> +	info.bit_offset = priv->bit_offset;
> +	info.nbits = priv->nbits;
> +	info.np = cell_np;
> +
> +	ret = nvmem_add_one_cell(priv->nvmem, &info);
> +	kfree(info.name);
> +	if (ret) {
> +		of_node_put(cell_np);
> +		return ret;
> +	}
> +
> +	return PTR_ERR_OR_ZERO(devm_pscrr_provider_register(dev, "nvmem",
> +							    &pscrr_nvmem_ops, NULL,
> +							    priv));
> +}
> +
> +static int pscrr_nvmem_probe(struct nvmem_layout *layout)
> +{
> +	layout->add_cells = pscrr_nvmem_add_cells;
> +
> +	return nvmem_layout_register(layout);
> +}
> +
> +static void pscrr_nvmem_remove(struct nvmem_layout *layout)
> +{
> +	nvmem_layout_unregister(layout);
> +}
> +
> +static const struct of_device_id pscrr_nvmem_of_match[] = {
> +	{ .compatible = "pscrr-nvmem" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pscrr_nvmem_of_match);
> +
> +static struct nvmem_layout_driver pscrr_nvmem_layout = {
> +	.driver	= {
> +		.name		= "pscrr-nvmem",
> +		.of_match_table	= pscrr_nvmem_of_match,
> +	},
> +	.probe	= pscrr_nvmem_probe,
> +	.remove	= pscrr_nvmem_remove,
> +};
> +module_nvmem_layout_driver(pscrr_nvmem_layout);
> +
> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> +MODULE_AUTHOR("Faruque Ansari <faruque.ansari@oss.qualcomm.com>");
> +MODULE_DESCRIPTION("NVMEM recorder provider for PSCRR");
> +MODULE_LICENSE("GPL");
> 

