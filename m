Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAF3E3C40
	for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778952984; cv=none; b=A4RBHQerAhsDCK78f0hCqvekVRQ4kqcJKc76xVP85G0HxnjbhGj4WLsZF1gjxfr7n5THyaYU/OkJxtjQQpsSGotahdwZrJuBK3XFRu0QPL0U3gjDTjZ/102P+yJASco+2uUboPXN9Y+8WQ7UVQsGsOncFBVekjfLAmdy8p5P7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778952984; c=relaxed/simple;
	bh=p/wCw3Ezi8euJffv/ltOAFBUFOYKgI9St1IujayMzWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s87a6Zuder8vRGoojB00VfXnK/fNMZwPWFNKScMaxFft9mZVhxtbv17/52HN4s+iEEVszXDR4PD2S+RWclJQNldV7lX+W/lguVRGZ7yy7QlAB3L+3Bi3hE54PXt379WvQdx+a7/i85Z6jzS2iaqIa8cZ+SOXn5fFmJ0VxNJDr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGmXrJUa; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGmXrJUa"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ff5472f263so857172eec.1
        for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778952983; x=1779557783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MC8r6bgXI6I5tujI5ex6y8ZbxfPAMOjZH5GhOwbw7CU=;
        b=mGmXrJUanAnpOfzoVp54lyfrEhJ8dRJseGajRTYiCbs5xmijZI1E2EWf6OWDPGGH/B
         rn9iq3tP3K12IEtaABiXOqt3DG2GHgiLr4rXlwS5QWWRPv1uQH3f4wl7RUSSlGcbQ1le
         0mQYuyYIRSofWIyU4a2ioEf+3Rby2Z7a0pKA6kV6NcOoDRuFasRXEHLEgMumVKBZFH3w
         TQWPjTUlMKIz/TdftsZ+mZpPAeQ39bxwipCkpZpxEguVsXSoxms8a2Cn8DO5rABAKlo7
         G9cj0RRhKQvT2qPolXlsbMfl1ljmCrBmYj1H2f1xOkI1w+2LOk9Y52p8RnIlKH/e9/di
         /gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778952983; x=1779557783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MC8r6bgXI6I5tujI5ex6y8ZbxfPAMOjZH5GhOwbw7CU=;
        b=HbI4fU0KRKcxZJdh36ZMmtx/6JkTZSfay/XrzoH5eg5Sl6iIPyFhcZ9QQjYsrt0YIS
         pH7yu9UrW3zKj/jZblbV3Pu8naLffI+i/LD6sROZ0j1Z0SCVVmiXnIUMQ2Vev7OB4NDt
         Rq8mjKL0tI6MQPnTLXRXaJJdnmhiEIB8DeuRv+mZM4duq7Ez4YzlnXYEfiI6ELi3RgU4
         GKOa9l/XzvkEvWmyAgdLFbLtAXea4YnujWL7OqTn7IWu6PD+IMrCV8loc9a/cxuiCR1s
         aKKavqH8f/upvflK5U9auaPAfJhcRrU+A+I0RuecoU04ZI2tf6bEvKy5ZRECsT7AD7YM
         YH9g==
X-Forwarded-Encrypted: i=1; AFNElJ9SJ9iGMKExSzwheMsTPd0baoMO57c4ZAWzu8e71ntt8k7lK0pVZaECZlSMMa22sghvlIGh51m7CWYmEDgQ7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMjw7DZVhTPdjFrqG0Y7KiYOq00sp1E02GTORd2HPadvT2E4j
	teGyfO3UctlbRuyVzCiBqGa+o+9WwYYalWxYbEcUEk7wDavuvkGN2rhE
X-Gm-Gg: Acq92OE6pdBHmDBaeOefn5zHA60OcGUo2WkLgB087U7ql7wjeKpEuLwKuFci6ePcUfA
	jGQcyrWBV5xj0fyJs6fZu0lwBAAT/Lxu+16EicfdYjlgMpobVF0kxwTjskFGJ8/WyHd3LLja3if
	RmNbliKw8e5RLpx1tJDb3p3Zsl+K9FJS0/pI3jol7fANz7WltnHKfS6xkP5Pje/Oy/VooQK3Cg1
	FZhGoRIwpzGZ8HqCeePsulu81ieu102YP7f6matP0bOc/6NX71bzbz/HRLdQMQV4pdi0vaye635
	BpAnxMRLRcBNLQGDUGzGDDI/sVnZJKFGk7wQimp7gk0LsiQ40mju8B+6F86aotST0TCObk4BQit
	f8PPvuE2Dl4SQ1FUvqaSIzEjQxaXjIpH2rJMdbvvaOssputnWIOpgyIa5QkTW2T9izy9jVJr96w
	wgAdRT9kPf6bPj+5Za0q+Ie/4hOVfQ+n4UFLw0
X-Received: by 2002:a05:693c:2c97:b0:2d2:d7b7:5c61 with SMTP id 5a478bee46e88-303982bd1afmr3865753eec.14.1778952982541;
        Sat, 16 May 2026 10:36:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6e9sm11890934eec.16.2026.05.16.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 10:36:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 16 May 2026 10:36:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sander Vanheule <sander@svanheule.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: realtek-otto: prevent PHASE2 underflows
Message-ID: <3a83103f-f389-4cf5-b566-ce34d795ef8c@roeck-us.net>
References: <20260515212351.752054-1-sander@svanheule.net>
 <20260515212351.752054-2-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515212351.752054-2-sander@svanheule.net>

On Fri, May 15, 2026 at 11:23:50PM +0200, Sander Vanheule wrote:
> For small pretimeout values, ((timeout - pretimeout) / tick) might be
> rounded up to the same value as (timeout / tick). As a result, the
> number of PHASE2 ticks may be zero, causing an underflow when
> subtracting 1 to configure the hardware. While this results in a
> longer-than-expected time to system reset, the duration of PHASE1 and
> minimum ping interval for the watchdog would still be correct.
> 
> As the watchdog core ensures pretimeout is strictly less than timeout,
> ceil(timeout / tick) is strictly greater than floor(pretimeout / tick)
> and the number of PHASE1 ticks cannot be 0. So instead of rounding up
> the number of PHASE1 ticks, we can round down the number of PHASE2
> ticks, maintaining the current behavior while avoiding underflows.
> 
> The original helper function is now inlined, as it doesn't save any
> duplication anymore.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/watchdog/realtek_otto_wdt.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
> index 2c30ddd574c5..1495e8a8cbb5 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -114,12 +114,6 @@ static int otto_wdt_tick_ms(struct otto_wdt_ctrl *ctrl, int prescale)
>   * the value stored in those fields. This means each phase will run for at least
>   * one tick, so small values need to be clamped to correctly reflect the timeout.
>   */
> -static inline unsigned int div_round_ticks(unsigned int val, unsigned int tick_duration,
> -		unsigned int min_ticks)
> -{
> -	return max(min_ticks, DIV_ROUND_UP(val, tick_duration));
> -}
> -
>  static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned int timeout,
>  		unsigned int pretimeout)
>  {
> @@ -140,9 +134,9 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
>  			return -EINVAL;
>  
>  		tick_ms = otto_wdt_tick_ms(ctrl, prescale);
> -		total_ticks = div_round_ticks(timeout_ms, tick_ms, 2);
> -		phase1_ticks = div_round_ticks(timeout_ms - pretimeout_ms, tick_ms, 1);
> -		phase2_ticks = total_ticks - phase1_ticks;
> +		total_ticks = max(2, DIV_ROUND_UP(timeout_ms, tick_ms));
> +		phase2_ticks = max(1, pretimeout_ms / tick_ms);
> +		phase1_ticks = total_ticks - phase2_ticks;
>  
>  		prescale_next++;
>  	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
