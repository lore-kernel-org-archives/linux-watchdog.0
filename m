Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C14380FE5
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519604; cv=none; b=CfFrO8v0HIP7qPJhpACVII81oWYFMRUa9vSJuq/l3/NtBzLZEcdNfXy3TlD7LTxoK404cXxUVyGtpo+lvP7I8A357I9L1hsbTxiEfy+xmBNjlsBL8aX/J3mchnW3YWec4NgBz439b8+4O19yCKRuO9yO+FPvBt0BiGaJA/uZjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519604; c=relaxed/simple;
	bh=aXgo+e761iyuCc1PWGxqEqIs/mRUPjvJJfiris3RnFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brwnqUbPN7QQaaGoJ4J11WASaNNabqJPK+U3+RLn7JQ9M6ATudiwNhiHob2tR49G/FpoxmAKUCAA3HVuJtKcuZzyO/G+76lej8wtwR6rBCnu7FX0EMrtE/Ew2w1Jz6aEgKphfHGI1VzTKia23zRlxY6P6WwqROUxx4p9EE8qlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMPKnq0j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMPKnq0j"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8478fe07f65so747875b3a.0
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519600; x=1784124400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC/nOx9vHqaWylarfPd/ddYlW7L4srZulQ/ldH+lsnI=;
        b=JMPKnq0jiCYi6USc9opqn4orf8TejlWqhV8WUtXzL4E7ChcvnDEOngt24xVWSzTLM9
         iO/3QfNzt4p6sT0koxbOyUaufd7RmeG+H4nB8H6vnybDBRBWZDSIRhKCUX5MA8nC8UhK
         y8Hr1m91BJwtn3CwAnGR47gPChef/pVeUlVDl503VI3t9mK5HOFIXvTU0th/soo917Vl
         eBIiOxM/Bd7hNeXVFBNi5zuUGTPyq5g2y49Jo8NTqos1sQXdF1nW30QA8M7TnY2xAlxR
         XO3xngflFBIpdDizayszQYMc1lfCsJETPBlgpMIWcvanGWp8TXkBpuGg3e6vTMsXD7J0
         VBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519600; x=1784124400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dC/nOx9vHqaWylarfPd/ddYlW7L4srZulQ/ldH+lsnI=;
        b=n009Z2XBvRI/D8Kz2tjwMgSbXoaGJapTipEuS/CdN5ljoEowyzZbgvlEaUO1999PBQ
         c3kb8MT+5JzOafkiHWMQtLk0o3A5TlKdiUpoApkTzaBXmvw58/JuaBmAeZWCDc5PCUFS
         WctKs+0XFZ9ILPUlgua/6m4e7FRZYqX3pE/z+RP3sZf6TOWz3yALbCo5e/+MTYDTnCBx
         kFxA9NtZaqW3pedRAb4R0wcp7mB2sGZ+o7oXH8GhmBfk6gqQtkbuBtZcE5z4w6fBj654
         /rr+vdXwCBxn6vO7Jz6DXTKA8aVlp6hPnvM+3IHfioVMsVqj36nXgGx2KrWijcGqF8QG
         csWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqP1QKzzCdeN9OdL7WPfTqlOGEhPQvcXjdjr8Ms2mByicl9Pz0krtEFF/h0tciWElydiybP3alVxHTSfvjbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7N18uh0lz1KBmDZTMBpmiBdeKHbx8o3SRQMSNncKF50POuu9w
	KhJlhN6lBhzBE+qj/XDwH005pVy5xN65C2HgGr5EeC8RAkyLix6mCpEr
X-Gm-Gg: AfdE7cnOiLhy8oNnxqsedjMN4BF9kBxZ++mUp1L9W+5Q9KVZ9WOdLp4R6QMXXWFNzup
	0junBY8XdLFMA01UR9Axp2376pDmeIcSn6+wkX4dIdRNn2wZadI/hVQ2YqEomlCu6bZ7cv99JIJ
	uB/89FdZnZES0TevykiNpjI3k3ikX65bAlIWkKyMwSNdTA3lhaAP+wO5I2iw3MG72KJJZpe4Yi6
	nEbE2D/4HiuACKCDO9YIl4uD4WTYB+mM5PHkwd0y5SYVh3RscUCC9icpim1Oq5AU/uumBFIUvh4
	N6gLEjIHlRGiwoqsZJ4XkYTz4fL/2peln6qSWHhqctXT1sdRFN+OIUHcXGpLNkZlIZ50CzTxhYg
	g+oc9IzKk2AfmHif32KushpoGac27UVSQf8uTN2AAQrd7B4oRJte9Dgs9E3femUAHyTeGEgDOPF
	LXllx0gTUs0WofH6XJCMxq4iVpiA==
X-Received: by 2002:a05:6a00:928f:b0:847:949e:ea6f with SMTP id d2e1a72fcca58-84842fdf027mr2957927b3a.4.1783519600511;
        Wed, 08 Jul 2026 07:06:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483d117a1dsm1528804b3a.37.2026.07.08.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:06:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:06:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pretimeout: Fix UAF in
 watchdog_unregister_governor()
Message-ID: <736d014a-5ac8-4ebb-b621-b6ed92693c1a@roeck-us.net>
References: <20260707101803.3598173-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707101803.3598173-1-tzungbi@kernel.org>

On Tue, Jul 07, 2026 at 10:18:03AM +0000, Tzung-Bi Shih wrote:
> When a watchdog governor is unregistered, it updates existing watchdog
> devices that were using this governor by falling back to `default_gov`.
> 
> If the governor being unregistered is currently set as `default_gov`,
> the `default_gov` is never cleared.  This leads to 2 use-after-free
> issues:
> 1. New watchdog devices registered after this point will inherit the
>    dangling `default_gov`.
> 2. Existing watchdog devices using the unregistered governor will have
>    their `wdd->gov` reassigned to the dangling `default_gov`.
> 
> Fix the UAF by clearing `default_gov` if it matches the governor being
> unregistered.
> 
> Fixes: da0d12ff2b82 ("watchdog: pretimeout: add panic pretimeout governor")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/watchdog/watchdog_pretimeout.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> index 19eb2ed2c7cb..02e09b9e396d 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -167,6 +167,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov)
>  	}
>  
>  	spin_lock_irq(&pretimeout_lock);
> +	if (default_gov == gov)
> +		default_gov = NULL;
>  	list_for_each_entry(p, &pretimeout_list, entry)
>  		if (p->wdd->gov == gov)
>  			p->wdd->gov = default_gov;
