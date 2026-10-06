Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3E4562A1;
	Tue,  6 Oct 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296670; cv=none; b=t3Xg1PuW3mOiTFqBx5L22zO1509facZoelft3CZNedB7zZSEodsm81zo0zX8sdRxsxeggBPN5l1cffrjiLsuhdTHmKG3VSvsaHZ8QwQxqb4bPpYjAXivGCGeinkL+yGKUJFzHs/9kTKeDvZZdA8oGKrrpJEGqkPsh8Ve5axEF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296670; c=relaxed/simple;
	bh=fPi8epO7yJlHHsk5AuTNADb/OtadeIq6J+dRUFs+XXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS+YknKUYv0wN//qcIngGuXliPg6WbZQ27wZiEpyb1ZvHPnWv/DboxR52se1/R0ceJzJiyJanmujMhRXqLChvf5taZsVyddBKWxiDgp2HQJTh8lXGnWhi9zVZYNwo/EtGr4wKE9Goh7xDBSu63x6xT6pjZdRA8lj2K0NFt+fVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERKNtpaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERKNtpaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29C61F000FF;
	Tue,  6 Oct 2026 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296669;
	bh=5OlYCc87wp/CStApp+F8ngdliW8zTXEjACzvvTWIchY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERKNtpaK7EtBv7RQHDLLnQDKl2arpKA4Up7gHs4bUVcw2jRe23plUY7y3RWl8a8S4
	 Q/fg77YHE7e40H5Me9BPSDet4zpn8ZOSpH0NteskXcgpnX+YRRvoMR2rJJMKCxE5p4
	 oU2+jg0oKl2Uw/mWtu2nfzRt5JuRXIWIkHbzpiRHuiZlC9YCTBtaYfLoRVBwWfGFiX
	 LvcZXNjm5wIPFLKq2me4OWLOSaQTXr1F/yj18EEYVYk0WsR9v71+tSIrMKJ5M8uvkV
	 7z9EjNfN1Ei0Pgx759EYdEJdKCRmdyQkkMMvPuq8BdcxDAl0qJ15IyQjXX9sw7bqFw
	 EOV1YEVDdNL6g==
Date: Tue, 6 Oct 2026 14:24:26 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/6] watchdog: w83627hf_wdt: Convert to platform
 driver model
Message-ID: <asUEmpUFDPhDpBJJ@google.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
 <20261004-w83627hf_wdt-improvements-v3-2-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-2-8e27b518595e@bootlin.com>

On Sun, Oct 04, 2026 at 02:12:50PM +0200, Paul Louvel wrote:
> @@ -29,6 +29,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/moduleparam.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>

Keep it sorted.

> +static int wdt_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdd;
> +	struct w83627hf_data *data;
> +	enum chips chip;
> +	int ret;
> +
> +	dev_info(dev, "WDT driver initialising\n");
> +
> +	if (!id)
> +		return dev_err_probe(dev, -EINVAL, "failed to get chip id\n");
> +
> +	chip = id->driver_data;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
                            ^^^^^^^^^^
To be neat: `dev`.

> +	ret = devm_watchdog_register_device(dev, wdd);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
> +		 wdd->timeout, nowayout);
> +
> +	return ret;

To be neat: `return 0;`

> +static const struct platform_device_id wdt_ids[] = {
> +	{ .name = "W83627HF", .driver_data = w83627hf },
...
> +	{},

This is the sentinel; the last comma can/should be dropped.
