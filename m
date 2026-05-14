Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BB21638D
	for <linux-watchdog@vger.kernel.org>; Thu, 14 May 2026 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718064; cv=none; b=a69pFJKLgPEddJhBWVdBTxOR3vySBvmqNq1IsUZ/EFsQJSeINA78Y0hW/vUDgoAmYAF3au0eUFiqxQt84/psImxqOtO92FQxCiYg35uCh8JD8+DTKJsbTEhPBJeFXG/WOBtb+hTN7maHOj3J5ZmbdWa7VyZ52foWFUezsoUKTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718064; c=relaxed/simple;
	bh=WMYUE0CDI5Pvg7WlUNgdNNFgjC4PutXg54yMOphaCAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDsf1TDAv8xDzjhkDDXinTKA0HQUUc1jwoPtci4Y5Qm4FoZ0DxEOQn1iSUV4VIh5ABVUuNivzbxZ5uLmZ5PIA7OjEi0ARV8qGYc5Cu2kUjdM7gS7AMnPmT33Ajq9ijRzClrj/jWQfw/z1hWctKBuNua23z0bnNorFOvH/kJV0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpGwaZmX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpGwaZmX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so3319159b3a.2
        for <linux-watchdog@vger.kernel.org>; Wed, 13 May 2026 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778718061; x=1779322861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r2QZRuhZs/F6LR1h7UYVWvCz6VsrmPc9c5QbTNQ560=;
        b=BpGwaZmX9qaqY0ge1SjVTlXr9UuOLABFRGr/gwNAVGIysj5Y4SGMMf7d/LaSbgFvxX
         ON/rDz0zJhWISM7OWqK7kkaRuXw5qgqvC64wEALxQkhn+INNmJ3QTzBoPPxMD18Ah7q0
         jX4LwqiyrGkKp+/uJhdMUr8Wuy8vRxlzbzTXcXayHulg9/p8XXVIzimobqGLhHYhd9ti
         4uKIvM0gFPPb16HLV8Axtg9Cf2aD5ZFXcgJejUmeQiPfjHANCG0pilKqQiV3wjF4iiF7
         l1JGGLMBoUNnOWgcIq0iPqv/HHTlei+8BOOYzZnnxcTeKMT7LZlulqHlVtz6zmjg0RAZ
         C97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778718061; x=1779322861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1r2QZRuhZs/F6LR1h7UYVWvCz6VsrmPc9c5QbTNQ560=;
        b=mgOg2k/p62ta2s2I0cI9XJ1vIJK2IYk+i5bgE2FK63XqJaVsi+7VXYazUiLtGC8cHy
         orVXgkLsY4meBOSWZmSAgteYJNNeuzqejiQtbhzewzH/y5Zm6TOYLbAuWO+BespaNWip
         2IVDzBpsna2Lhd9x7V9tanUXmspPZvHY68sUKUlm9nf13kAV28ejl7xsbd52cz2EhjXn
         2sTC6UsYf0aGhAN1QQYFEtJsLtfEwuHgEvyebaY6RFMtNoKDTABsfpizYNlGiEraK20s
         lYyVbXPeBNu4srbNVf1eGZeYN2UrHV8C+RNASalCtxvJymb3+8x0Fw9bhoPCnmSvwhzn
         We7A==
X-Forwarded-Encrypted: i=1; AFNElJ/BYLclIYTP5VZRHhYhPFVQzYE6LiK3YzboMvgdcK1o7CiW+/CNMYlpGY3hVBPNWymfvaGFWtYtDkHl2TElgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytO2waQ+OiC6BsS9Wf8rXnlYoJL2yzwIHT7q4GOsx9o0nWsJmz
	D6Ec25vjt5Z/uLXZEFxRl5CCZ5fdxenpxpUw1+1goqXNPOSS/8hyCAZK
X-Gm-Gg: Acq92OFKTt3me9h/Z95fUQUgzw1hvyI7cwXyBPwVKYfpQg+8yWXNAmzBW7kTFPwNycs
	AzO5UEa2IIVEds2I5YLyKW3Ly93aFdJdVDn8ccLQU9hQ+8Bk/y+3qmoE5AyckCsDj7Yxcurx6S2
	iQrsEl8Hz+ALBKrTp5kSQ4FjdGcrSGdnlx61P1JGbJgv9n6ohzwkgzdIei/CC+J65f3O+TLCyyU
	pCnMZdNleJ8ula4iLjRMndjLnXj5AMOo76mobxKJim35287dZigpvjGAjjgQM7Wt9T4AXdzd+b5
	r1UCj4UsTZe9b9qeDkImCo+Cc3EBWrvOhUms53796BImblDQ0EWnKbptb/WkRwKyp427n34loX1
	UMvlIH8mLFnXgZ6xNjFhtAJUKlgCRtLhf1rfBvstM0YzsRUZV7dWj1YFs65a6VzoJrP3Z+DCqEe
	s1mh3tpzddNDCiiFMPWJA1QQZUEw6erIbj1HrDE5bnV3Xl06c=
X-Received: by 2002:a05:6a00:2195:b0:835:6bdf:c888 with SMTP id d2e1a72fcca58-83f03e94f92mr5702219b3a.2.1778718060763;
        Wed, 13 May 2026 17:21:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19778c87sm660537b3a.19.2026.05.13.17.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 17:21:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 13 May 2026 17:20:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sander Vanheule <sander@svanheule.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: realtek,otto-wdt: Add
 fallback compatible
Message-ID: <1be8c11b-a020-44d6-86ef-109418e1d968@roeck-us.net>
References: <20260512204854.8931-1-sander@svanheule.net>
 <20260512204854.8931-2-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512204854.8931-2-sander@svanheule.net>

On Tue, May 12, 2026 at 10:48:53PM +0200, Sander Vanheule wrote:
> As all known hardware instantiations of this watchdog behave the same, a
> fallback compatible can be added.
> 
> To remain compatible with existing single-compatible bindings, the
> current compatibles are duplicated. New compatibles should only be added
> to the list with fallback.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> Changes since v1:
> - Fix indendations
> - Add deprecated property to old compatible
> - Use two-part compatible in example
> ---
>  .../bindings/watchdog/realtek,otto-wdt.yaml   | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> index 1f5390a67cdb..e470e0fcbb2a 100644
> --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> @@ -25,11 +25,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - realtek,rtl8380-wdt
> -      - realtek,rtl8390-wdt
> -      - realtek,rtl9300-wdt
> -      - realtek,rtl9310-wdt
> +    oneOf:
> +      - items:
> +          - enum:
> +              - realtek,rtl8380-wdt
> +              - realtek,rtl8390-wdt
> +              - realtek,rtl9300-wdt
> +              - realtek,rtl9310-wdt
> +          - const: realtek,otto-wdt

For the Apple watchdog driver, the generic property "apple,wdt" is
considered to be bad and is not supposed to be used for newer chips.
For this watchdog driver, a generic property is introduced.

What is the overall logic ? Is there some rule when a generic property
such as "realtek,otto-wdt" is appropriate and preferred, and when it isn't
(as in "apple,wdt") ?

Thanks,
Guenter
