Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503875;
	b=TFURoEXW0rklk/kug5k4r9hd8sPlD1XCy4gqofQsnxcAKxJxs76iAziZpNop7j4yOLh+
	 WIVcpRxGteqj0Z+jtZ6uHmpOqhNf348c4gAgdH/7OzgjJtAfA+vlsoSbPpzcMsWBrJCLO
	 5Z2lhO89s2GmxdWIyKC0PDwRH24g+J7TNPFtF5+UZAuSiN1AxJh6CWnhqoVBlTvu7jRje
	 3CjCAbqcIV/0ykss8Yj2aU68Cwm9t0koH0cNVvPHUOB7QjBhUrtf+yujFMAJ+2S2DDlnX
	 UgFMfm+sAzIH0u/A44YaSMf6eGPGtwOorl4x0XNu/2J+mNMW6FKCQpmC1mtwoc25C2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503875;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JufSvahKYBxLNaiAOPVVDwJMshwclOuxobT+p8WRgM0=;
	b=iLDyPBS2zp7JoZEmdsB0oIyRSu1Uxr3za3IQUJg8kxUyVIPhHQSGAI1S3coQlI2JB0mT
	 2bdQ61NtdPXQDw1Ei+njyxT4GMo/zimm3vRTQKpdF8W2j9f4IO3pmcjn6UEoE16XwOy8f
	 CG+853Z37Rec+42Vb0YsRLkn4KpHGeknQoOYWzcfU3P4n0vCg6GdVLLSAc9Y6f2Zu0tRr
	 qAJwuNhkho8uuqymbSa61Y/KL6VNKO9cvTXOIVb/9ppQUfgARQTlgccK8+cmM3BYQrODk
	 xlkynoqeNPP5sfqO9Tnw2Kwrm2Yqh+iNmO+3WVbUq0EI1rJBd+MpPFG/Dj+TKDvnGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHKKnATg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854F606A31C;
	Tue, 20 Oct 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHKKnATg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1061F000C5;
	Tue, 20 Oct 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503874;
	bh=JufSvahKYBxLNaiAOPVVDwJMshwclOuxobT+p8WRgM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZHKKnATgv1lPZHDP4orTmrcvYRCz7vKql41RMzrFxxaZqBF+SmiOSsI/GkzXMtlmR
	 1uYcLzxq2vKKWTUzW7iviZbkBJRQOhMCgYFmJVbwQoteq+1RSx4PnRtVCCqJ/xfLZM
	 ukYfmbUSBDhYwAjDru/gu45C5/LUkJF2ADPnS9GFrYxYOyc+AkaXL2jCTN6x63P3MJ
	 hm79SsFgQDAAHFo1Htsam0dzXHe1wmZUITcwBYbJX+5jW61ZoCdp6JOpilMEqj5fPW
	 EAbRHQc/Ja9+pLEm5CYNS3JTypkm/7jtEapu+OwKQ5kRTI6soeYfrhESddU7uvsXKy
	 TLRsj6Zebe9kg==
Date: Tue, 20 Oct 2026 13:44:31 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 3/5] watchdog: w83627hf_wdt: Move register offsets
 into driver data
Message-ID: <atdwPzZNF61JjOKp@google.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-3-90b226684fc7@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-3-90b226684fc7@bootlin.com>

On Tue, Oct 20, 2026 at 10:11:56AM +0200, Paul Louvel wrote:
> Register offsets for the watchdog timer, control, and status registers
> differ across Super I/O chip variants. Store them in the driver data
> instead of global variables.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

With a nit fixed,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

>  static int wdt_io;
> -static int cr_wdt_timeout;	/* WDT timeout register */
> -static int cr_wdt_control;	/* WDT control register */
> -static int cr_wdt_csr;		/* WDT control & status register */
>  static int wdt_cfg_enter = 0x87;/* key to unlock configuration space */
>  static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
...
> +struct w83627hf_reg {
> +	int control;
> +	int timeout;
> +	int csr;
> +};
...
> > +static const struct w83627hf_reg w83627hf_default_regs = {
> +	.timeout = W83627HF_WDT_TIMEOUT,
> +	.control = W83627HF_WDT_CONTROL,
> +	.csr = W836X7HF_WDT_CSR
> +};
> +
> +static const struct w83627hf_reg w83627hf_nct61xx_regs = {
> +	.timeout = NCT6102D_WDT_TIMEOUT,
> +	.control = NCT6102D_WDT_CONTROL,
> +	.csr = NCT6102D_WDT_CSR
> +};
> +
> +static const struct w83627hf_reg w83627hf_w83697xx_regs = {
> +	.timeout = W83697HF_WDT_TIMEOUT,
> +	.control = W83697HF_WDT_CONTROL,
> +	.csr = W836X7HF_WDT_CSR
> +};

To be consistent and neat, I'd expect the order in the declaration of
struct w83627hf_reg to also be: timeout -> control -> csr.
