Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959448;
	b=eCEZmIUMg9x1sib9KulG2Gl1PpXFDLPoj0EyPvXI1UVGK4Wllv54qbteZe6RXwhAcrqK
	 fP35r1IGW9W9G42A3Avi4+E4ixzPGExv5v5QSUy5yyfi5iecsThhwmYNG3Z9NgQB3yR1s
	 lVVmJTQU7YxfGG+LDRcPfYu80jd2jBzSQZ7IIFaYCco7rzQ8aS6CmsyOIeufzw8hkPyfG
	 yYZWR5tfNCsfZigNFMKvXsgR/YUkmz8KZbcgxNJC5nNl+lc27zB+QKhdjhd6yVK7Zaevj
	 yZlaH7wQ9Rgac+TxnWb147vayI8LZ3sU4ycQqrA+c39hGnURzrzFVs/vmVK/6H7tmzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dgrHCuDJnbtPR7u+3NWd60PWg1h/9OvoC3YLPNhdMoI=;
	b=5NqiuZYc9rrGWEdBFHpevetvsKnTqBJNd/ldhPzQpThquj7s2dgB1nTC8u1Uzd2HyM2d
	 4M+lOGsT3nUOUoEii2n6TwvTk1KUDVX0Nkd7Stj8zRiRAGRk4IW6vBgoouPLrl//oAlJb
	 kBl3tuCg62mww1t6cuowXWD6eFY14bJxQ/gxiEPAj+hwxjdp7sP+PyPYwjJZKdItWSQKv
	 vdEWaZbqAAeQG2fHYNMT7fYKkltHviUGTW+GNY+qCO+ZjCPebcCGLgPDalVpT0NwEHiUQ
	 XnFG6p+oRjD8he5DqJyToZn966SEm+F+Q+sFH4wcOkIrdN7NO7NLJIyD4JWGKqMXIJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkxdlxQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E54606A326;
	Fri,  6 Nov 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkxdlxQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00A51F008A3;
	Fri,  6 Nov 2026 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793959447;
	bh=dgrHCuDJnbtPR7u+3NWd60PWg1h/9OvoC3YLPNhdMoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkxdlxQbTEqcGLzcidDZF0+I7GkyRxa/iObrhwLPl+BTpsjPOyMapF4t5BghYMtuL
	 qHL2tbL0UvrtovSKpLbLY+PfVWgC8MM5nM+jpx6X4A0XlRWVnEyq3Nmdy2rXBMvHc7
	 0FMPFp1W6djUzyBkwPyPb5Q58WQqRK+2YgbBRpjs5y8pDyW5iE7WAJDI24VuDVS47j
	 gseHJvRWOdfPbvu0tjOTuRRmHYsBd3+SNfFgJrzwWO9e1jDkB19UpgzUrkhCgoajm8
	 jQu3SXEKYJgZAXPJTU/EoWbcqBMBMW3mqQaRyt9xH4wKhFDmoFv0QrM9uJbPta5Uxg
	 fDqk2gU5mlA+w==
Message-ID: <sashiko-outbox-201169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/25] mmc: sdhci-of-dwcmshc: add MT2824 support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261106-mt2824-v1-20-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-20-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:04:06 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mmc: sdhci-of-dwcmshc: missed reset in
  mt2824_set_uhs_signaling()
--

commit f6f9a7802c2857e3d3e847c6a2b7339cbc357a08
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

mmc: sdhci-of-dwcmshc: add MT2824 support

This commit adds support for the Synopsys DWC MSHC controller and PHY on
the Metanoia MT2824 SoC, including card type probing, voltage switching,
and workarounds for HOST_CONTROL2 writes and clock stabilization.

> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index 09702022e7087..cb248fc572e21 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
[ ... ]
> @@ -2108,6 +2122,470 @@ static const struct sdhci_ops sdhci_dwcmshc_k230_=
ops =3D {
[ ... ]
> +/*
> + * A timing change must write the new bus speed mode to HOST_CONTROL2.
> + * Reset the CMD and DATA lines after the write, while the card clock is
> + * off, so that the next command gets a good response.
> + */
> +static void mt2824_set_uhs_signaling(struct sdhci_host *host,
> +				     unsigned int timing)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv =3D sdhci_pltfm_priv(pltfm_host);
> +	u32 reg =3D dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3;
> +	u16 ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	u8 ctrl;
> +
> +	ctrl =3D sdhci_readb(host, reg);
> +	ctrl &=3D ~MT2824_HOST_CTRL3_NEGEDGE_DATAOUT;
> +	if (timing =3D=3D MMC_TIMING_MMC_DDR52 ||
> +	    timing =3D=3D MMC_TIMING_UHS_DDR50)
> +		ctrl |=3D MT2824_HOST_CTRL3_NEGEDGE_DATAOUT;
> +	sdhci_writeb(host, ctrl, reg);
> +
> +	dwcmshc_set_uhs_signaling(host, timing);
> +	if (sdhci_readw(host, SDHCI_HOST_CONTROL2) !=3D ctrl2)
> +		dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +}

[Severity: Medium]
Can a driver strength change write to the low byte of SDHCI_HOST_CONTROL2
without triggering the CMD and DATA line reset here?

In sdhci_set_ios(), the updated driver type bits (SDHCI_CTRL_DRV_TYPE_MASK,
in the low byte of SDHCI_HOST_CONTROL2) are written before
set_uhs_signaling() is called:

drivers/mmc/host/sdhci.c:sdhci_set_ios() {
    ...
			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
			host->drv_type =3D ios->drv_type;
		}

		host->ops->set_uhs_signaling(host, ios->timing);
    ...
}

Because mt2824_set_uhs_signaling() samples ctrl2 after that write has
already happened, changing ios->drv_type via mmc_set_driver_type() while
ios->timing is unchanged leaves SDHCI_HOST_CONTROL2 equal to ctrl2 across
dwcmshc_set_uhs_signaling(). The reset is then skipped and the next
command (such as CMD6 during HS200 or UHS-I initialization) gets a broken
response.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-mt2824-v1-=
0-86087eaf5af4@bootlin.com?part=3D20
