Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342842E004;
	Tue,  6 Oct 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296646; cv=none; b=IphM4w6W0qSoszjIGolhqZky2v9Y8viEg0VFohvnhCtCndLffq9N2QVCgG1Mf9OMs6eSxBMLTZKh6WknJiD0fj7MjUiw7DunFTbwA5PGebdmxksVSSjM3u/vpaGemQ0hvbOLef6Y287d7d2tNWsOhNcnFLKqgTOh5Op9AQlXxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296646; c=relaxed/simple;
	bh=F46wmeq8sgiFcW6ENmE+0VuKM656ynw9mex+LuVjaKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRtDVCEMxEvWvVTzkGRxroJ6S5Vlqd0G2na/EFismdjeK3Iqs7GLGXAdI24oJ/yLXfsH+4wTTAr/orUcfXFIVx3Acwu6DLmClB3acrDBsq06n4erGzoanxgOiTak9xMGQLTmmfFc6CoT0mCY+TpYhCynsXKfqdRFDiMWNKldWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTukRynv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTukRynv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359DA1F000FF;
	Tue,  6 Oct 2026 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296645;
	bh=7b6as+N11WBsROO8ecGTfwqyF1FOsBi6gKzVGUGTDSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTukRynvJ+fSwq3KuJCpdeAmT2t2cbGXxGTzCCtgS/2s82m6WUmpafvc4hhGPYv68
	 L4t6POmSKjq9bNmQ40+zB3y3Xnenp6WgWiwMgcaou0eL6Rtd/NzETUgdow/3QYrFTW
	 OVL8/heemX14zNW/ErVECE1yfJYxaAhJzwcr4XgvrQ87Zo1mRs9haN/w1AMnC/azof
	 8jKGnTJee0t0+efYwx9b3e7Pr7Nf0TmGRyqQ9Pwi2kR0n6pDfIgQYMEjJnGjB8bsLc
	 zRW5d2hnoSqKu5kDoQxZjLATB0F+qW7nYljR9iaKcTOglPI/hUO36sYSQlzYbUCbGW
	 NaFkT8jaFU2fw==
Date: Tue, 6 Oct 2026 14:24:02 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/6] watchdog: w83627hf_wdt: Replace magic numbers
 with descriptive macros
Message-ID: <asUEgunBdF6N9LCA@google.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
 <20261004-w83627hf_wdt-improvements-v3-1-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-1-8e27b518595e@bootlin.com>

On Sun, Oct 04, 2026 at 02:12:49PM +0200, Paul Louvel wrote:
> @@ -71,6 +72,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>   *	Kernel methods.
>   */
>  
> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
> +#define SIO_REG_DEVID		0x20	/* Device ID (1 or 2 bytes) */
> +#define SIO_REG_ENABLE		0x30	/* Logical device enable */
> +#define SIO_REG_CONF_ADDR0	0x2E
> +#define SIO_REG_CONF_ADDR1	0x4E

They are actually I/O ports rather than SIO registers.  SIO_PORT_2E and
SIO_PORT_4E (or SIO_CONF_PORT_*) would be better names to distinguish them
from SIO_REG_*.

> @@ -248,16 +258,17 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>  		}
>  	}
>  
> -	/* set second mode & disable keyboard turning off watchdog */
> -	t = superio_inb(cr_wdt_control) & ~0x0C;
> +	/* set second mode & disable keyboard reset turning off watchdog */

This is confusing.  How about:

    /* set second mode & disable watchdog reload on keyboard reset */

> +	t = superio_inb(cr_wdt_control) &
> +	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
>  	superio_outb(cr_wdt_control, t);
>  
>  	t = superio_inb(cr_wdt_csr);
>  	if (t & WDT_CSR_STATUS)
>  		wdog->bootstatus |= WDIOF_CARDRESET;
>  
> -	/* reset status, disable keyboard & mouse turning off watchdog */
> -	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
> +	/* reset status, disable keyboard & mouse interrupt turning off watchdog */

Same here.  How about:

    /* reset status & disable watchdog reload on keyboard/mouse interrupts */

> @@ -513,11 +524,11 @@ static int __init wdt_init(void)
>  	/* Apply system-specific quirks */
>  	dmi_check_system(wdt_dmi_table);
>  
> -	wdt_io = 0x2e;
> -	chip = wdt_find(0x2e);
> +	wdt_io = SIO_REG_CONF_ADDR0;
> +	chip = wdt_find(SIO_REG_CONF_ADDR0);
>  	if (chip < 0) {
> -		wdt_io = 0x4e;
> -		chip = wdt_find(0x4e);
> +		wdt_io = SIO_REG_CONF_ADDR1;
> +		chip = wdt_find(SIO_REG_CONF_ADDR1);

I noticed the 'addr' parameter in wdt_find() is unused.  We could consider
removing it in a later cleanup patch.
