Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55439EF29
	for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426984; cv=none; b=R3mbLRwTxe0cjxg89goJZ9sqvUowVLVYA5DXF/ZK5MqpkcMBMz7LHnaAFLaMwuUnsPSw9aHP/rwWm3RduN2RcIe4x0fMSEyyTYRYgM2be0XuAq3jRhPs/v1bArIq1EPAzOsf0lQjdAJQ3GHQTfFSPs14PUewa7JjZEch63Z1g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426984; c=relaxed/simple;
	bh=VGhBlR4i0yiBkTCF4XD51IEzNUwKDosxwd/fQ1UG4tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwfFDwdYc6ZB8KvUz5qmlNJiFeRQxVqDxfGGqVTWHot0R5rhDrur5KQmN+R9hMs4UUWdLjB92103O23AXB7l3in0iWkFF/j7rluEN3EE+fA5HWPy6sOdNs8ko8uf0b8f1lHxJoh/pFGQjePv/hrTPpmRT8Tf/Bz16qVfMNjQjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pepBsWGr; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pepBsWGr"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4271954eec.0
        for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778426981; x=1779031781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qigH8lxO+eZS/TR71vYkcB8nPKNDMGG4EcHQASbQAqg=;
        b=pepBsWGrmAbVKZYsiVfg7DKy0Urzj0tyNGEP339/vLv/GqYzRTbZjOxlilxdsAvVbt
         yIulLNIPlBjBia5gPiUCu9Z+afINU4irsdhjZ2LeBlF3lP02+v74iMg0Rk7DFWd4Om17
         e+/Fzw6mNP0KBmeF1B4Hl2HsIXBieVbnEAEEj3cCUsAueWdhEQR6NtnjVW27O53Nu7ha
         nRRFmiH0+l3X3Ay5yaeH+7DMG6bLMgoXDIgaauUkCgJAXr/ZD/dPDsBT3SixngvgiqfW
         sATdsJQPTf5LcRL4oU5LPihftzRv/AjqvScXfjH0KjD91G5ftojUa2P3mibWMVA7B7IL
         98kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778426981; x=1779031781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qigH8lxO+eZS/TR71vYkcB8nPKNDMGG4EcHQASbQAqg=;
        b=GBsH/dITjvOh9iygijpLoUQkWDdVLYTbC6mPJSrUs0yj2l7zeEyNomKvcllEToLaye
         3t1mcq0kZhlSiS8F5TDGV4+bk4rO1TkfL6mxZSOts2F39y7RJ7Zv/gfBpyxr/pUz0t9O
         4GknLmXyAWL1lAXibU54KD9q6WfPcYI99m1q5/q2xiSKrM8Ag2mtFgwmwOK6kkj1Cx81
         Ld3+GpkHoYgyUfv4XtF9FdJl8ICIftBzMYK88UjZJOF/KNeuRF+8RkImj9xWu1oyL07P
         Bzi2ZfMVyOdyEQL53i1anDtFGn8F3A01FbRbE/4Ch4vKmEvgTs1hRdVqnEUCYGHE1OmM
         lBjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vuTlNq93tAeTYvgt2uM5kGQkvc2t94vgGNjGqOAWOCdlqeHNta6q7oaBLwS/+t/OFNzxHqsnY1Zx4PozcZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NPaqYMNSYbFjHw611ip/xSnazPol+MGgRMW/Mg35QfrKITHd
	LXa9wMSwQnos0Y6N4+OB/Hnx0mXcIUkGYmPcXlmv67OwhLgLCvkc9xjX
X-Gm-Gg: Acq92OGpjzixKEkYgfYIhTUQ8UfthVRa1LuB3AUgxBfn7nKOiF10+JJqPu5llSHkCVI
	i56FZuJgEQJ8x5eNV1YtiR5L25xydEDhn8/ZR+9nrdY+nLRVzl5JoVh6TMkXK8eoODeOMZXz7yb
	uNGNp6TSwbvSTya1a2eQI1TQnpALD7e2cEmxvMa6eiRTWB7nTc608xvSdZcO+cFskYojNPG16Oz
	TVfa6Gu4Qe88gNfMk1lbJnlMKYLWlrkdU9TGzNF1iGBPPFSTFRHQLDqWsFZuQDd8VrLkpFivG5H
	KZVP1erA1LLRNP79eXkEpIflueLjKby5f49YLiBQ7gNPWH0aFREhNqeE1IFYLQY1j22ZFvXpu3+
	P2aEn0AM/TdvT1/fDMEpT0OtDjtYRt0gcUh+T4Me5mnW2KhPtYYMAS47M8CBs24UOJOqGiRb7MT
	U1OXTidNIgmKdNSXpF4ydhdA3GmPKk3sbauCSBsUywxeUWxkU=
X-Received: by 2002:a05:693c:300b:b0:2ea:5057:a2f9 with SMTP id 5a478bee46e88-2f549f7c2aamr9650588eec.16.1778426981133;
        Sun, 10 May 2026 08:29:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm8525864eec.0.2026.05.10.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:29:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 10 May 2026 08:29:39 -0700
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
Message-ID: <85ea46a7-1136-4ea0-9eec-7dfa465df20b@roeck-us.net>
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

'"apple,t8103-wdt" used by the driver' is not true. The watchdog driver
only supports "apple,wdt".

> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
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

I second Sashiko's findings that the driver will fail to bind because it
only supports "apple,wdt". I would not mind and apply the patch anyway,
but the statement in the description is just plain wrong and thus
misleading. Please fix.

Thanks,
Guenter
