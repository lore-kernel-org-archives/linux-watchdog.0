Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC953ED5C7;
	Tue,  6 Oct 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296738; cv=none; b=OZ02ad6VmEyMDZq69MLXuRuXB+4WoGY1FxsR9ibBrNc6kRBEp2fKDjMZWdkKCVWtBBx+6Tey6Bp4hx+dRZvjKZpbrNr+oYUtaeFh6peAfcJ7D+q2HHNO8N0tDBd32PFrYb/UXtG2hRhmdoO3WFgFpLIQJV7Cc3ZS1v/J04mQcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296738; c=relaxed/simple;
	bh=cH31KJNtFqKfhJ8QOpRkzSmgEsfnsX89101lKtLjcrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUG7M2W0f1JVkQixOOw5oKyeEvx84N6bg4i25DRGQ9BjDsRuJCrzBDj9Cj5j/ZjB2gOU0C/U7gnvcFmyH/vQW2xOsvTy1sIaHCTMNKCctMXzpt+q8lsouykMZw665bIL7LW2WchhSNskN4zbJlFl420dZczizhDF8jImqSjnxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BffnwVkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BffnwVkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B45B1F00893;
	Tue,  6 Oct 2026 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296737;
	bh=gg9008wzWmEgZCQ+eKSCzrV5u4w0KPs4qKkAVZ4gstM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BffnwVkdmFbxCCUmvCPMGdRxQkdYOsWYGQEp6f+xYlmd5Xb63vhXq/ZRRdusDSQKt
	 VnJvH348QZFGRPPNTaGTPWMjgZeDDv6ro9UcLGAouZe5YfPyBZf/v2sPN83m3qbWCy
	 iHgN4ouQZo5pLRNExNU/9AW+JRgUqFlokX6Te0TyPI3DyJZqlTkOLflAd/BRyJMssM
	 bCpMLu6ondVeY1zIspZ2BLlD+OzOUuBIPRI9lqXtGNmhBfitILUfJFZo0oPAXu4/zG
	 qyQQVth7n+hGJZrhICcl1wBj42acwfB6qsbJZ6nc36SJhIUShGYhuN/ZOhwpooV97/
	 E5B7lZ+NfKpQg==
Date: Tue, 6 Oct 2026 14:25:34 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
Message-ID: <asUE3iFZBbl8fVcb@google.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
 <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com>

On Sun, Oct 04, 2026 at 02:12:52PM +0200, Paul Louvel wrote:
>  static int wdt_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	const struct wdt_pdata *pdata = pdev->dev.platform_data;

Use dev_get_platdata().

> @@ -522,12 +533,16 @@ static int wdt_probe(struct platform_device *pdev)
>   */
>  static int __init wdt_use_alt_key(const struct dmi_system_id *d)
>  {
> -	wdt_cfg_enter = 0x88;
> -	wdt_cfg_leave = 0xBB;
> +	struct wdt_pdata *pdata = d->driver_data;
> +
> +	pdata->siocfg_enter = 0x88;
> +	pdata->siocfg_leave = 0xBB;
>  
>  	return 0;
>  }
>  
> +static struct wdt_pdata pdata;
> +
>  static const struct dmi_system_id wdt_dmi_table[] __initconst = {
>  	{
>  		.matches = {
> @@ -537,6 +552,7 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
>  		},
>  		.callback = wdt_use_alt_key,
> +		.driver_data = &pdata,
>  	},
>  	{}
>  };
> @@ -581,27 +597,33 @@ static struct platform_device *wdt_pdev;
>  
>  static int __init wdt_init(void)
>  {
> +	int sioaddr;
>  	int ret;
>  	int chip;
>  
> +	pdata.siocfg_enter = 0x87;
> +	pdata.siocfg_leave = 0xAA;
> +
>  	/* Apply system-specific quirks */
>  	dmi_check_system(wdt_dmi_table);
>  
> -	wdt_io = SIO_REG_CONF_ADDR0;
> -	chip = wdt_find(SIO_REG_CONF_ADDR0);
> +	sioaddr = SIO_REG_CONF_ADDR0;
> +	chip = wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
>  	if (chip < 0) {
> -		wdt_io = SIO_REG_CONF_ADDR1;
> -		chip = wdt_find(SIO_REG_CONF_ADDR1);
> +		sioaddr = SIO_REG_CONF_ADDR1;
> +		chip = wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
>  		if (chip < 0)
>  			return chip;
>  	}
>  
> +	pdata.sioaddr = sioaddr;
> +

`pdata` is still global.  Given that there are only a few settings, maybe
we can use the same method I proposed in [3/6] patch, and use
`dmi_first_match()` to avoid the global variable.  E.g.:

    struct w83627hf_sio_pdata {
        u16 sioaddr;
        u8 siocfg_enter;
        u8 siocfg_leave;
    };

    static const struct w83627hf_sio_pdata default_pdata = {
        .siocfg_enter = 0x87,
        .siocfg_leave = 0xaa,
    };

    static const struct w83627hf_sio_pdata alt_pdata = {
        .siocfg_enter = 0x88,
        .siocfg_leave = 0xbb,
    };

    static const struct dmi_system_id wdt_dmi_table[] __initconst = {
        {
            .matches = {
                DMI_EXACT_MATCH(DMI_SYS_VENDOR, "INVENTEC"),
                DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Symphony"),
                DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
            },
            .driver_data = (void *)&alt_pdata,
        },
        {}
    };

Then, in `wdt_init()`, it can define a local `pdata` and initialize it
based on the DMI match:

    const struct dmi_system_id *match;
    struct w83627hf_sio_pdata pdata;

    match = dmi_first_match(wdt_dmi_table);
    if (match)
        pdata = *(const struct w83627hf_sio_pdata *)match->driver_data;
    else
        pdata = default_pdata;

    pdata.sioaddr = SIO_REG_CONF_ADDR0;
    chip = wdt_find(pdata.sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
