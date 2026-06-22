Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6983B1014
	for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133614; cv=none; b=UslDWG4XL85sLLEumBpeyOsTPBQYnwPIPAWnSE2tl9ZhKYkChsXgBSgSw+JUMT5Ap1iYNW+GG8RmKW0j3wqf43WGQM4MgfpnAgvAZ3rvZra0xN3JR87l/bgRPLCaN7wfKp8LK84Pd6ehIBJT0D+ryu1tRpc80/MNYC7jcvcvN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133614; c=relaxed/simple;
	bh=rEgomYeES1303/3+oBxWiEtLOZncEUHVqywFcqqxico=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqFFAWj+w7zl6I/GwM1uJK+YXoRWay+mFrbiwIFrYvPSc0XhHJtlLQzMX+B3qy4ehmtEdgV25hiSPQyhBEA3XDp85Za9vWFo+SVpsIiar3KuUPGwe6Wp2k1k7GNy4hXEbv/gVyg3EpBS3/eJCMIspslfPUZTZzWVR8Ch+6XwnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2JNRoN9; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2JNRoN9"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137eb0d76beso3730195c88.0
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133612; x=1782738412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JzlovJlGJX04+5z99oBQpaTuexgmdv5pr10RaNussdc=;
        b=m2JNRoN9kMMFj4TrOwgFeJgxLdCM8rbBv7wI1kppwdO6aCijke7MWma8ucG2MugTpY
         F24uOWg9t2NXgM7B2grdN/XYLur/IResnkx5dcKZO6E/omsb+oulW5jhgcCVD8RSI4jH
         Xi9AUbR4RhqpLnzN+XrFI/dE0JJMXkT7ydgfv0E4Hm59urLeJeEJEx0fu5RkMXLq0slZ
         3AEecywPLoYMQ6aeXoMYtjk/veSHhCHfkMH93K8mQjdg4VBWW+7LPZb7ZqaFvewM0hJu
         hOKwQr7HYBt955AucPeHARwOt2oKdvfBfdyrK7OvTr866onTS2vUMVDBebMPaBagwW/S
         PI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133612; x=1782738412;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzlovJlGJX04+5z99oBQpaTuexgmdv5pr10RaNussdc=;
        b=f1iWiHjkwnViQ5E/plN0uuNbHItHowrcsc0kI0inmiyHvQpabVylSDAea/oumVUJ8W
         gelkIJ/WPgv7xvkBItNPTtMomU+K8foKSrTBZeij/ENP8JANPtAzeaTR0BTYp1OncI3c
         c/nQS8H5TVApRSJRF8lweYQA7kRkILT0SYJ5Y/r48R0Bm58yYAPTBLeZzjHcNPNNpoY9
         P8MBBJWVBZ0Bmy7eFiysjQ/cu0uUkIuqAJ6O7ynbEEBOIfKfwhwjtY3UtyqWvnRN4oZg
         5F60TonXB0fZjmhZu9xbDHZGG0+MuhwwK+LUFin0QS+V4EPduJ3a17kmypfhVmaCGqwe
         Etvg==
X-Forwarded-Encrypted: i=1; AFNElJ93tNbtbtwuOom8l09ym2jCetiGJA+MRv32AuKdZShI7BFPuHbpFZVjQsw2DdlxnT0qYmfzUVGE2nn5pmdWWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvj0XkAsjN+pFznXBuzLE5E4qJWx41jGvDoT5vYPW50ib5e1PN
	0fWJ2xYZTtNKBFbgK9TSAqOBxMyf0qHDKphye3tsBfcofCDcArbu3gq7
X-Gm-Gg: AfdE7clhHDnKA+oiIE+E9ugqAdI6yBQ1h6s5VYoxy19fsf4PBsQMq+kCmuUrEfgciGx
	nbWNGx12snmXglV0aIHkcRvwCz8Jb5e8Y8dQ5lJR5nFMIe/CJiCMqTGBwZ4FFAfgqRuXWFUjav3
	keBk2fsne+5J7Ew++zsHgLo+acJC+ysOjWETvVb8Jj82UUHMVLkQQCpAdVta+sIpitKtE+7SFDC
	5TlkHBXsJMlCuJdNyY0uBUahYUU2QyK6yLREMWmy0PqEGWwbiXIgWTPYKbPcN7B9MrnMP05XWta
	PqYNTh+eRipkkB+EQ6Ji6aX/2pcHdTYrOCr9OpQnz01y3ovtVgR2l7SSKqfQZKNTmkR4DGywsIN
	OG+OkElKm6bSNDIIAi7gli/W2xVnpY/dw15QFNc7tZDXvKKNyd/QP5//GmrmtuImD9xCisw5WKy
	Qs4irdlRd/aow4uf6TME/7nkGJvzriJD3QpD4fc7zQz6FDhfYtGnN412k0xvFSXg==
X-Received: by 2002:a05:7022:e998:b0:136:bb14:b0f8 with SMTP id a92af1059eb24-139a3051a57mr7768480c88.5.1782133611333;
        Mon, 22 Jun 2026 06:06:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adccb622sm8183703c88.7.2026.06.22.06.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 06:06:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec74f1b8-cf7f-4b33-9157-1fd0bb7da7ba@roeck-us.net>
Date: Mon, 22 Jun 2026 06:06:48 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: db8500-prcmu: Fold dbx500 header into db8500
To: Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ulf Hansson <ulfh@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-sound@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/26 13:27, Linus Walleij wrote:
> Move the DBx500 PRCMU definitions into the DB8500 PRCMU
> header and delete the wrapper header.
> 
> Convert users of simple PRCMU wrappers to call the DB8500 helpers
> directly.
> 
> The dbx500-prcmu.h header was the result of an earlier attempt to
> abstract several DBx5x SoC PRCMU units to use the same abstract
> header. They are deleted from the kernel and this is not just
> causing maintenance burden and build errors.
> 
> The stub code is using -ENOSYS in a way checkpatch complains about
> so replace these with -EINVAL while we're at it.
> 
> Assisted-by: Codex:gpt-5-5
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606180825.vUSQntkJ-lkp@intel.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>   arch/arm/mach-ux500/cpu-db8500.c |   6 +-
>   drivers/clk/ux500/clk-prcmu.c    |  20 +-
>   drivers/clk/ux500/u8500_of_clk.c |   2 +-
>   drivers/cpuidle/cpuidle-ux500.c  |   6 +-
>   drivers/mfd/ab8500-core.c        |   2 +-
>   drivers/mfd/db8500-prcmu.c       |   6 +-
>   drivers/regulator/db8500-prcmu.c |  12 +-
>   drivers/thermal/db8500_thermal.c |  10 +-
>   drivers/watchdog/db8500_wdt.c    |  22 +-

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

