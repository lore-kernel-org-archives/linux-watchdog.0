Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E442FCC7
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559394; cv=none; b=IJ0fneVkcj15AiTwDmQQotP+QM+qB/SBgrpzl0yCjLCqETq1ScntUUTK/37OLnRNw38MqGV6zZ7Gunoj6U8yK4raEh29qu5kQjg40unLnIsPV4Xy7PegAa54I3CEhFHDUNetHURUnpFE/1MOU55kjMNF+A9bwMh8UpyhZoRrOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559394; c=relaxed/simple;
	bh=CzUkV1yWdw/cErC5nc9nd/oqrh/M2z9aTs8L/aar04M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN0XP8SjXzKi935As7H+4tGRLrG7gv+RYaDJpVN5JNbHwKSd9sxTJZimWoDuRxPS3dvJ41ifL5Cwmzha6srOWje6TGn2Z8/tQsH1P0MK50QuJgDEcMqlRE67PcSrrDAhYQeGCljKOxCtvvXF/3DxYpbI6cGIQMTZocxPvVYdLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu9IRVFm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu9IRVFm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso7271495a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784559393; x=1785164193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R1PkSh+baSnNLGTsjAnxNBp1u03aHJ383HYMyDZwWTI=;
        b=iu9IRVFmDdaZl4J1mXlvqGTfm1PyCggVqottxL2ccZu2IHYt/XMh6Szp2VEGsQhsbc
         nSj8vfTe2aSX0Zso3YNeEZqyuWUkEmD7f7bJ3OHPPPm7HIBPnqZSPyozU/k04rPU/4QN
         2eYbcSUP+4WKjNynyJjjX3Hczi1jFmFDZ+wOJykVDC2W0G2GMblHDvvgT/SQ9c0IGJNV
         jcyGD6ye+yvYGh76PcOYjrqMaB4RVRwpC1TKY47FGQH+50/6ydFJH0EHkksALWCfFOmb
         5q1GMLxdr8NIzDHf62QwvdEVqXCyjxCMparPOJ6oX2D/KARHQBCZonuwdoCSFx0BZyDp
         lz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559393; x=1785164193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1PkSh+baSnNLGTsjAnxNBp1u03aHJ383HYMyDZwWTI=;
        b=WbTwx1EsmTBG4CvJ87OP6tlHZ0HQAxr82e8Y4NFdwH9LgACsyJ36Tf4NLvLW9SdbSO
         Gz3U31z9oanGc0u5AHr3LsnUgUpA5k8SFuCgMjMolPYSy7/GcXucj0j5naqFy9nMNU8n
         X+8uibbhVE4kqZhoU46A+QWpPW2ViE7xzBWDi5yfBO/URhEv+AgXWvfuYdPFu4VwEMCF
         8qKcomBT3i8cXLmYLb0ehmRihXFKVrML+rDQJaP2pOyCLK1oqEtD+63sZPiuTV9ZoR1z
         a75GC4RSz3nXxtzxBU0yS6tepF8EudSk3MeKaMxDUgQP/ACaCSHldly2CaTst8UYz2MG
         F6NQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWvlqsg+F61eKlbRWmqBolhmE0z7MzTPWFk22Cbr4srsPDLbcnJW6SMq5r+vkyS9nvmQXxOvVfSFjCTfOijw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzszxLlQj6sfxKZgTwtEi7BSpHwoB9VlMJXtbrENbJI9XMxgvxd
	iAArV05xDQvkfCXYUoXSDoDWDQHdCpbx50+PVtrOKhobZaOj0y8pRAOd
X-Gm-Gg: AfdE7cmYyd8osqrMYggZ/q1EKVSlWzyzoQbOUG03r+TG0tgd6TP2Z75MRyobdq9aJcZ
	9ODINDU08x7PAjBbSq0YCxRa7eok1HPGdnfdJRy70c/Szb0JG6pnkvizulYHQ/orXYsAqCNSU7B
	LF52+yhdu/9aDTKL4M1zEkjdKSqmk7nf90bP775XIkwga40mGyuQ5dzctJJbdxIjasyfWyUORuC
	+rLzL+wjU7rfwE7vZ84vtvX03c3hluj0mGMvQU/03SVaBzMyitDT75yh49K776k6ihIUfoPcbgV
	3D57fWK/p91nzh88YxAM6EkklUfW23J4v6EaQZOs2VntnVYiHxKIloMPWUZEtEvteUs8RW9qCrR
	FxhHRch+0HX/Jy7jjAvjBb0ztpJdtqLnDKyqrzBz/MVRzEbRJoQFuTD1tXwkMMz/04+8ps6BKWm
	LUDtf3K+oU89LJ1Nw=
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:9a7f:7307 with SMTP id adf61e73a8af0-3c3ad7ec489mr16674248637.24.1784559392522;
        Mon, 20 Jul 2026 07:56:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm36893149eec.13.2026.07.20.07.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:56:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 07:56:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] watchdog: rzv2h: Convert WDTDCR handling to regmap
Message-ID: <0eb41a71-a013-4686-bd9a-4f4df5acaa3a@roeck-us.net>
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715133922.2129340-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715133922.2129340-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Jul 15, 2026 at 02:39:21PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert the WDTDCR register access from raw readl/writel variants over to
> the regmap framework using devm_regmap_init_mmio().
> 
> This conversion serves as a preparatory refactoring step. It allows the
> driver to subsequently support syscon-based system controllers natively
> by passing along alternative regmap handles without forcing messy
> architectural branching at runtime.
> 

This patch does a bit more than just converting the driver to use regmap.
It also modifies both reset control handling and runtime pm handling in
the start, stop, and restart function error handlers. Those changes need
to be implemented in separate patches and explained. When doing that,
please address Sashiko's feedback or explain why the issues it reported
are of no concern.

Thanks,
Guenter

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Switched to use regmap_set/clear_bits()
> ---
>  drivers/watchdog/rzv2h_wdt.c | 75 ++++++++++++++++++++++++++----------
>  1 file changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 3b6abb66a1da..0f951219caf8 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
>  #include <linux/watchdog.h>
> @@ -67,7 +68,7 @@ struct rzv2h_of_data {
>  
>  struct rzv2h_wdt_priv {
>  	void __iomem *base;
> -	void __iomem *wdtdcr;
> +	struct regmap *wdtdcr_regmap;
>  	struct clk *pclk;
>  	struct clk *oscclk;
>  	struct reset_control *rstc;
> @@ -89,18 +90,14 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
>  	return 0;
>  }
>  
> -static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> +static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
>  {
> -	u32 reg = readl(priv->wdtdcr + WDTDCR);
> -
> -	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> +	return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
>  }
>  
> -static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
> +static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
>  {
> -	u32 reg = readl(priv->wdtdcr + WDTDCR);
> -
> -	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> +	return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
>  }
>  
>  static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
> @@ -150,8 +147,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
>  	rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
>  			WDTCR_RPES_0 | of_data->tops);
>  
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_start(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret = rzt2h_wdt_wdtdcr_count_start(priv);
> +		if (ret) {
> +			reset_control_assert(priv->rstc);
> +			pm_runtime_put(wdev->parent);
> +			return ret;
> +		}
> +	}
>  
>  	/*
>  	 * Down counting starts after writing the sequence 00h -> FFh to the
> @@ -171,8 +174,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
>  	if (ret)
>  		return ret;
>  
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_stop(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret = rzt2h_wdt_wdtdcr_count_stop(priv);
> +		if (ret) {
> +			reset_control_deassert(priv->rstc);
> +			return ret;
> +		}
> +	}
>  
>  	pm_runtime_put(wdev->parent);
>  
> @@ -188,9 +196,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
>  			     unsigned long action, void *data)
>  {
>  	struct rzv2h_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	bool active = watchdog_active(wdev);
>  	int ret;
>  
> -	if (!watchdog_active(wdev)) {
> +	if (!active) {
>  		ret = clk_enable(priv->pclk);
>  		if (ret)
>  			return ret;
> @@ -234,8 +243,17 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
>  	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
>  			WDTCR_RPES_75 | WDTCR_TOPS_1024);
>  
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_start(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret = rzt2h_wdt_wdtdcr_count_start(priv);
> +		if (ret) {
> +			if (!active) {
> +				reset_control_assert(priv->rstc);
> +				clk_disable(priv->oscclk);
> +				clk_disable(priv->pclk);
> +			}
> +			return ret;
> +		}
> +	}
>  
>  	rzv2h_wdt_ping(wdev);
>  
> @@ -253,24 +271,39 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
>  	.restart = rzv2h_wdt_restart,
>  };
>  
> +static const struct regmap_config rzv2h_wdtdcr_regmap_config = {
> +	.name = "wdtdcr",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = WDTDCR,
> +	.fast_io = true,
> +};
> +
>  static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
>  				 struct rzv2h_wdt_priv *priv)
>  {
> +	void __iomem *wdtdcr;
>  	int ret;
>  
> -	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(priv->wdtdcr))
> -		return PTR_ERR(priv->wdtdcr);
> +	wdtdcr = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(wdtdcr))
> +		return PTR_ERR(wdtdcr);
> +
> +	priv->wdtdcr_regmap = devm_regmap_init_mmio(&pdev->dev, wdtdcr,
> +						    &rzv2h_wdtdcr_regmap_config);
> +	if (IS_ERR(priv->wdtdcr_regmap))
> +		return PTR_ERR(priv->wdtdcr_regmap);
>  
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret)
>  		return ret;
>  
> -	rzt2h_wdt_wdtdcr_count_stop(priv);
> +	ret = rzt2h_wdt_wdtdcr_count_stop(priv);
>  
>  	pm_runtime_put(&pdev->dev);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int rzv2h_wdt_probe(struct platform_device *pdev)
