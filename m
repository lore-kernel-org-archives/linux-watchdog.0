Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929741B8F4
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051453; cv=none; b=Re1bAoJQwqG3Po4QpFUONr7IIq6P222sHKHBwezxPKdoMePqPw1yJpB9xomzi7o/0sgYGhQQO+wcawKtELzbGSvXVmPhIWzyfA0qxpeEcG3apeIsF8CL8WAVJc/EfpnZfv/Vx90ehomrgkVJNrJdpi35Z0yFQASwxBoyoRQB4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051453; c=relaxed/simple;
	bh=C2WZoaoDuHCP38nsBoVwpLeugZGKNY5n0XDjDjiuNag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc0XocEvPmiNC9lCsvq/x4oTxqoCVoxADB0A8hM59T/2KhqLKl21dtk5Zr7iJn3ArDh6axjMlI9lrUgnAgmaeyLjMPJkgbfMxRWlexQJ73V2cJr008AsLgVFBzBbGqHW8rpR+SVhiy4BQ8+69wLd9xva/AmWyG6+XqO/nFw2pWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTjJH6OC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTjJH6OC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3812740b3a.3
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051451; x=1786656251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zwZ9QBMqGE2tZiVXNSVp3vvHqmz+exr7B1ifk8CdFas=;
        b=kTjJH6OCGG+4+Z8EdoQo9wIsIhMikcYg0dH+ruu2EyvftM7AaUpG2CSgJPhi/i79Nd
         SxbhrIOj7MdTzbqf62pHhxmH8GPKMLIJXy0GbNTzP/pyj/qAqEE911OyT3jfbS9Qj/HQ
         B/EW27oTABR4C3Shd0oIZYSE46xBxV9Zc+2FJx8Xr18Q2Hbqn1nxdLAl2Xdf+56gtC8N
         Gl/bhMkaaPaOL1sQL9+ftFF9u0JXQhU1k3poBFA1Wwum1jp9DvXqxS0uXf3dxGK4HIxr
         hT2coJvzzWHcPX+wO/0g2XQaTn591KCJDorxo4Cpzvk5DlkwKFC4XgwUkV2nHSaY5BHE
         lzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051451; x=1786656251;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwZ9QBMqGE2tZiVXNSVp3vvHqmz+exr7B1ifk8CdFas=;
        b=AhSqCXdh6/JWSi8XNlOtOuXeQosUA+InCVe4cGgU37MgeR2ndJ7eDbR92rgPeJDdYs
         ILn8iwtygjMkBA2x/wXGVKEiUBVhuZAdKLErRFWf74q/5Ek3Ve0ap/jIZaYnQsyhMugr
         Vuq5KMWkKxuCY6ZSWu601XiKVacmbX4dkmlnZYM0bG0vOkpwTeLc1JOLhbsaIJTe9XrZ
         q/FXMiCWrdbHqwOhGjS22tgkEqK2HZzqw+3rKyamAc5bZi2nB5vWgKDdrdsgCYlWzxv6
         jOknakYrFSITkF1ssQ5M/afW9Xr1BT50ifQOfeCJMa1iWkwLzBKJTYoaYfJQeJ4Za6+W
         2mfg==
X-Forwarded-Encrypted: i=1; AHgh+RoA/lsdywwUpKkiFAy+VVQ1bpzP12ESIlsxtIffNL+j/gJ+5N5IeHXc3Q7uLUdkZSOXOrHajt9RDemywfH2sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwprwAiIapu2vrt6iFFxucmnfZGQrlW4tPv5i75mrY1JEKRSmO5
	53ZIS1veFcdj4FiAf4NHOQy1r6pq1fIRYijVaAVSCS4FOCGbYYH4yO9O
X-Gm-Gg: AR+sD117nx9PpQK6CZ0wwpLzXNI4spIlPDTZNyDIk8Kk5EgKjnhKZEA4ynnllekegWe
	KhMIsZY9zFk+00bau+dImxeRtfmkw1I/ywV02qcqOTpZ24iG7pq/STc9SiiwKh+1GRNGWRm/G5f
	nPMH9t0B7cl81No5T0XsDe5Lp/sbtJwym2iuMJGsmUUEK399VqdBGtosHI/pnkF0JPYVJqoCGdz
	KAxalhiRLrQI/jwok0RMO4TXX/iZTmDljhD9AP7Y8F8c93NMUiM9EcLq9lASlklI0bevDhbgqK1
	3pFQIdbh0MwJxwteW4Y89PthM0wDibzTzWNep7pUAKJ0QYCkMiKuV1tlNfLxj1yzHGErFy3m4NX
	ai+U91XTtPSgUcVcbZBELcqpFtSBuqZwa/9bM+zpYM1VhIpIRWwmbtFjwPk3NUPKocKUrcfTjDX
	qaxdnfn5YfHhz/rA1ANAJGqj88YdXAkjEhG5ni36qGzKLUue7vDC2za64yc4D9wteRBdCNoYPUF
	eJqJBxB9HQq5Q==
X-Received: by 2002:a05:6a00:2d0b:b0:848:5c00:fa91 with SMTP id d2e1a72fcca58-84f2e0ed967mr19698345b3a.38.1786051450767;
        Thu, 06 Aug 2026 14:24:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a188esm10061b3a.5.2026.08.06.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:24:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:24:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] watchdog: at91sam9_wdt: prevent timer rearm during
 teardown
Message-ID: <70f6bc97-a82b-4d9c-b3cd-79cbb4cf7866@roeck-us.net>
References: <20260806060613.1830-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806060613.1830-1-getshell@seu.edu.cn>

On Thu, Aug 06, 2026 at 02:06:13PM +0800, Hongyan Xu wrote:
> at91_ping() rearms the watchdog timer from its callback. timer_delete()
> neither waits for a running callback nor prevents it from rearming the
> timer, so probe failure or driver removal can leave the timer accessing the
> devm-allocated at91wdt after it has been freed.
> 
> Use timer_shutdown_sync() on both teardown paths. It waits for a running
> callback and rejects any attempt by the callback to rearm the timer.
> 
> Fixes: 5161b31dc39a ("watchdog: at91sam9_wdt: better watchdog support")
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Applied.

Thanks,
Guenter
