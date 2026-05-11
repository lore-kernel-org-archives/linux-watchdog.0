Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E93F7896
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508400; cv=none; b=KJelB4Pyqm8EjxFQ/izhvHTe+ACaoEjBUXrB5iwfruWwXb7/nVFsyuO6mrkWC39x0ACwAzXUUSZiGbmw+/nCsAc0cbIZ0au+xxJ1iqX5rhz8wo2KpSYhADgXnmUgM23g6WVSh4vTnxvD5tM7kPwreu/lPRez1fyrV1uFk9McyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508400; c=relaxed/simple;
	bh=7cxxZqN1g0qqNRtwUJmzJW5yzCgloqX4VcBEh/hoaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPUyL0o/wovkZLKAn8dt+8xT7099WTEe/zZHEaDZcpiKTJEt41cvjKk/Fk5exR0EUcWK8kKdBkh6eLfd/gZTg1B9NSmQkPa1Kiz/rjK31W1PY0aywka6XMbtVPlEqh9zKyQwNcHhMByZJ4CjZUQkPe0xoLDHGeUHDAZlJhemQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKTeSWEX; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKTeSWEX"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-130b2295ed0so11746444c88.0
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508398; x=1779113198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH/da57m9j66BBfxDcaOUHxrZwIbeRL1xLwNB3IDa6M=;
        b=SKTeSWEXI8xOklgjnsdTA4FFc2Az5uuSySfJDxW04LK2RR3bE3c21CmWqwjvb5EV11
         JA37LMcgHcqYdELPPjVvbCEihWiqu15VyeIYRcbal0WDusDny+wmV9qfH32mPCjcxOP1
         dBjbVyy5TKkbZoXdaX3AM6sUxoqkDo5NUoUdKZxDMUUBBMKVpoTvUz3dTboUz1fK9bT3
         ChpNeT60APhX8purJCLB+GCdI6hZJ21/UhQyRjeWt1+QajJXVdM217cGyAbGvcGb2bzd
         hlk7qcH1btT7rnMgYol8S/muWhsX/kdSxcL6vo3Duc4cnqkiO2919d3WIyJh89HYmF72
         aRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508398; x=1779113198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yH/da57m9j66BBfxDcaOUHxrZwIbeRL1xLwNB3IDa6M=;
        b=qGn+wI2RIFt65WcaFBQLZv8Dj6C3Sar9V+ZZYrqyCDvsfsK+JvKL0mxM3hDauou11C
         A22L2nxO6SujmFbEwXNKszLT4IHQchi6Fs+a9iKgPFW0u4dt5GX/VAzlSSW8KEFn61Ey
         PLkkl19ZrXaTiqFnWoYLh3GedWETaBBEam/R7VfP1LckKOP9tYu0Vkpy/w9XeJAOa6kn
         YPIru+j5bZ7P9oX/mRdzfQJiiSiTkbTha29BO6Kw006NUJyV3xKo7x1CC0gJxeEDAdFD
         IM390Ke0yU3xff2dk7cajstg5jVttBxxIdOh0bJNMiyOTHKj7tW0l9DXRKfmE1Fyn8us
         8j/g==
X-Forwarded-Encrypted: i=1; AFNElJ9sOzHf9dFOs93P9rxeTTX1ixbOH6eW6ry/1O3+Xmry6BMRd4qLK8tvho418eBYyyyONu8c5H+MT/isngvUbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4mPEmhQxP/bYfNqMYgeoA+taSsFDLVNZ/7clr3/AOst2T9e+
	H4AMHCsGzLViPDka+SH5/eE2tWESnR9e7CK7Pz2TUN6ZtOPppCiTlVkU
X-Gm-Gg: Acq92OG//jerozAHJUcLcDkt272xVbEgUVnTtDSKmYG+2isDm3lNK6B0gFeVeKehZED
	hKekEwkhKPzETVX119Ua5hVb+vTU3Dse8qw8gTn6Qd4IygIRm09cISh8GhqRjpJUYkCek3qQ1VB
	lAcYGsUL4AWJZ2oZv+CFd6d1Adukf+22kZYzfhVXZEhNa9xBM1+rsauLc7btmjkUtkrO1AyH2tp
	AaMhFvTD1lUFpcWQoQsnLwyj5OllCBDbkWr9fYPj54jvuJ4KfWaafAEE9vgqeudQUbDmeRr1bgN
	tQAgkcLR8taZdMeDovt0GPn+sGAm6G/IgwGg+YNYft84wxQV3axcwv7eM6nSMYPpI7OVzwXXPrm
	k4MFu7Pxu11ZMZTUr6l5nNueHPW/9t8+yrMSgASOtHbBTtB1exesJpSuZNorqW7UtA4h4E/fUyX
	0vzxaZKl6VXIDGNFi3cpbvKRb9kRNtd4L2ZETs
X-Received: by 2002:a05:7022:488:b0:12c:8e70:c33b with SMTP id a92af1059eb24-131852d2e27mr14527532c88.8.1778508397470;
        Mon, 11 May 2026 07:06:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13277bb2b14sm18610981c88.0.2026.05.11.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:06:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 May 2026 07:06:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
	Joshua Peisach <jpeisach@ubuntu.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Message-ID: <a3055969-31ff-4b33-b6eb-6418cbf3597e@roeck-us.net>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
 <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>

On Thu, May 07, 2026 at 09:33:08AM +0200, Janne Grunau wrote:
> The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Applied to my watchdog-next branch.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 05602678c070..845b5e8b5abc 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -16,7 +16,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: apple,t6020-wdt
> +          - enum:
> +              - apple,t6020-wdt
> +              - apple,t8122-wdt
>            - const: apple,t8103-wdt
>        - items:
>            - enum:
