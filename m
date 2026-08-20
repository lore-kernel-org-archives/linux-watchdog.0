Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76764734DF
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233356; cv=none; b=c6FxLqVq8QbuUCNdQqe+uj+a7LqetQ0ck9gYQXyrzMniXFejjeUdDN1H+77VKu0fs+y2PKJau0RNCgcjknoI3K5PltfKmBVogJgrhfQysI47UR4Uh673Gu12VDoRVi9zDmJe2FMI3/2Clw3CSezevvMxcpKjMKxPy/uVow21Svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233356; c=relaxed/simple;
	bh=L7Bv81RmoiSiT2vUtiN4ZpSQg8KKQt9B+XWNGGdsC3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o09+GgXHc4lZlNG/FQE2Sd39omMYuQcYdf6Rl1TkkCRBf+6hq+qoOOU3ckMTbbYllAqW0vk9Chbl9a7EPtfzWGjdIccSvSmvncIgBbTaq9RmcEdewFY378KmcMt0dQpPpqCDWfFN1MS11hOljKmWd1naWR4aVY+Mt/LCRKKchqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oppmkPv3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oppmkPv3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbee846deecso2309786a12.1
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787233352; x=1787838152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZzDGLOhyyHOVxqLci+NY5sFlFPDajvKknZysF/tnk9w=;
        b=oppmkPv3cnc5AQaWMfFAXhVAzRw31PcGMrvoJo0LuzInV93gbeuDerDLDQo/WWATHf
         L3Yxnn8Xfzh7AtYGhiyJpCLiTCfXbzgXnbBC6ethEmMMMIbCzBle6eY4zmshn4Aolq83
         AHNzsAEGxLOvGuMWHYxSzLo3g2a2Tsjab9OCIjptZWaxlwu2FlwRt1mpdCFoND9cxLyj
         uq/i2z4xDqUo3sHdziWQFY6qQeCERmsTmIvo7rXyksVaChWWi/rfpZGQiHd04GSEi9qo
         yiDDF0s+dJ0ITKvFC0JXDeEk3uanjVDxFCjK0BYrO9Xc6iOhga1HPLdxdc60AQG8j5Pk
         uuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787233352; x=1787838152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZzDGLOhyyHOVxqLci+NY5sFlFPDajvKknZysF/tnk9w=;
        b=BCiugDtUwj+oaqpM0o5f9ZzvBibHq5UGKttdA+/k7AFx1mvGqgIdj5TA246bkCXn2h
         D6CKeD3vdxNQhVlYIJawl2zfeyPjP/BM+gx8hWO5Jkn0iOwEU+aIDI035OXPXPS0tJB7
         J0OrT08aRj+cOPmGNOfmJHFnx4GBIIW5C15p8CZmQEoOFXg5iRHxbjMuG3WP5hgAd4KQ
         /opIkwK5ziYdGlMNsIZtNzAYonbjvzPAGANlE+1sznROX8FCHHzDO3TOhYv321aLwsgR
         FHGW4x4L6Ca+ID6z7aYDAn2RbO+6b+rrm6HE/EjMRZ5eSNywEgrj1p9wurGJsvFhi5PS
         WmGA==
X-Gm-Message-State: AOJu0YzHI5Lmlapee/Q1HU9LujRPUjMxUum50hcDXiebVXF/JDPhF40D
	15+dpzgFOue58lUdF8LuZqmeUMT1s7AEX9U2AJP/M0LB9ch5i4xROZXNf1obnw==
X-Gm-Gg: AR+sD13blvjeNHaqA6Am6xPCCG6gXrdlLriUxehL/+YVfmajhkbB+88aOY8ZTyIxiWe
	EDXBw9No/YJj5QhnBizapytehNYWLN/8g9LLhq4sD71s66puK37m8GGAs9Y/CgOl9NM1kXfIzAb
	Ua2ZvUiloLLqRiOOt7FN3npJffe0XA/fqyshCXfLnZEvHBqCNw9GqYrwLwl0W89iNItD551QqxR
	UKnzxM6A3MClDi1Dfki8P3IbiGiiEHOiIOf91pwhe26NnO8VlbG9GHU157lOONkMDoxkUADYZdw
	zYJWHVj1ve9/Of6oIRdW5vi/iu5bQvwlt1iWIlQfq7FyK4Zfg5QpLrnqTjBQAckOwuvPep8nYaT
	bay319I49/0EALvlTvjp2LLjsBiYMqrE1XNOOEcBIKGUEk1EcvY/AWcVxXWK9+q26r3g25DIaqc
	xWODnl3+VFdLtEIgTgkkehNvocVwU/5AYFiyiOxR5CW1xYXo0vZNhqO5eChQeFCN2fTTNjvIpES
	Q==
X-Received: by 2002:a05:6a21:748e:b0:3c4:1493:6822 with SMTP id adf61e73a8af0-3cd0127962amr27198270637.18.1787233351830;
        Thu, 20 Aug 2026 06:42:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10d497sm27937690eec.14.2026.08.20.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:42:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Aug 2026 06:42:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Gaylard <ag@ffroot.co.za>
Cc: linux-watchdog@vger.kernel.org, xt.hu@cqplus1.com,
	wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunplus: fix sp_wdt_restart spin loop and
 timeout
Message-ID: <d37eef21-a877-4500-a280-493e98c68701@roeck-us.net>
References: <20260820125304.1583383-1-ag@ffroot.co.za>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820125304.1583383-1-ag@ffroot.co.za>

On Thu, Aug 20, 2026 at 02:53:04PM +0200, Andrew Gaylard wrote:
> sp_wdt_restart() returns immediately after writing WDT_RESUME. The
> kernel continues executing and the watchdog kthread could pet the
> watchdog before the short timeout expired, preventing reset.

Is this observed behavior or just an assumption ?

> 
> Add a spin loop so no other CPU can pet the watchdog while waiting for
> the reset. Set the restart timeout to ~1.5s.

I understand the first part, but why delay the reset by 1.5s ?
That is a functional change which needs an explanation.

Guenter

> 
> Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>
> ---
>  drivers/watchdog/sunplus_wdt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sunplus_wdt.c b/drivers/watchdog/sunplus_wdt.c
> index e5212f3d2e24..b44dcc307634 100644
> --- a/drivers/watchdog/sunplus_wdt.c
> +++ b/drivers/watchdog/sunplus_wdt.c
> @@ -61,10 +61,16 @@ static int sp_wdt_restart(struct watchdog_device *wdev,
>  
>  	writel(WDT_STOP, base + WDT_CTRL);
>  	writel(WDT_UNLOCK, base + WDT_CTRL);
> -	writel(0x0001, base + WDT_CNT);
> +	writel(0x20F5, base + WDT_CNT);	/* ~1.5s at 90kHz */
>  	writel(WDT_LOCK, base + WDT_CTRL);
>  	writel(WDT_RESUME, base + WDT_CTRL);
>  
> +	/* Spin until the watchdog resets us. This prevents any other CPU
> +	 * from petting the watchdog.
> +	 */
> +	while (1)
> +		cpu_relax();
> +
>  	return 0;
>  }
>  
> -- 
> 2.53.0
> 
> 
