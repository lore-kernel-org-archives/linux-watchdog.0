Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C07282F15
	for <linux-watchdog@vger.kernel.org>; Fri,  8 May 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257947; cv=none; b=thDTiEQQcHOH5IyRIoCVpb3jV+0Fm9xbkZaaodK2L6W7YrcQZp6TgP6TzPrFy9LBxFEzf7nTdRZp2mCfJ0Exb5tj5ySDBolga/Q7wCmCkT1DutaxWKma0ZVcm/fImO/qCxABDoBccmYj0w1gxw23JneIQ55Pc4h2Nz3n1bdQvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257947; c=relaxed/simple;
	bh=GWIbRu7yojEgT6ggCcPoA5yjsOKw95UadSdJiJadnWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XapvFoEh0zm5OG6XhbjdHmq6Yt90LTw9Edz7k58c3e1xc69wntY86wMcNvlQX/wK++LLtqBcjtlXB0acEC+RcYLH5RS1VS5sjmn9wUm7J/LDLaGVGqcDvxDwUcIZrbTbnBIXHG9LjEEUSAVu41H8+8mo6/vp177fascpwCx8E08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riXHkQPD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riXHkQPD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-835b78c3797so1021933b3a.2
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2026 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257945; x=1778862745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI2eSrUIuw6745cX7kAtjWSrj9maOslSs37JhU20zZ8=;
        b=riXHkQPDRus6Byi4cR+bUex59EinOYk7putUMfhKHSxkW2c3Ey8tHuJo97YfIRV6Rf
         fKqKvur0kEBzZHxX8gxFhunGVs8dS6w8czyMuPmxgJpbsFDr0XFcyd3J+yPga13ZVJp4
         2eZ15ODNeb1VuJOe0qbHK7Sb6Dfm+4P8CKDpdTTQWriy8f1vihQuBv8ED+Remt4m3SZg
         7Z6Hj0iYYFu4dyQLqGGQZNGy72vhe2zgJn/T+Qo1tiaeh73hPA0byV1jbRyu9cmafRBq
         bna+7xxxi63j80sUEbga0OgISngHwarA0lUYYy50q4KwcVjY7UOtGmps3WTM3sCTylxR
         U19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257945; x=1778862745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qI2eSrUIuw6745cX7kAtjWSrj9maOslSs37JhU20zZ8=;
        b=nDPweyuygXEIKVj09MRoGWGGw5xO5IVCJrTWDMG8SHlW03fCItFV/OA/U5H/JiIvLA
         tNnd9F4kB3dDbg2XN9vYvcun17OzJ9bqCDHEhb1S2alXJxhqJExd0oGgvUfYZ6Oh0HOI
         iDBIBlhi1RPjNjxI0PVSw3B6GIfJ6blAnXQ/AY4+pAm8Gi50e3nTijT8rE+xGqY9+gvf
         HdPXP4VGMINQjqkJkrniRCquEHMaIMFMNu/zP3/vbQ8caWuHtamTVD2Us+Dkd7akxEHw
         h6V/2V2ZnKocK3RLxCJweMQzw7a7XHZlBZzqvIQcBn+jimgR8bHBRwlj2pRsfQgx+aNY
         nKaA==
X-Forwarded-Encrypted: i=1; AFNElJ+zE5y1iBMFF4B1xrhZTENFRorsCsoprVxOJQyx8JtqbPwOYkspkbgevahHaObcOowG0tYiOytt2mXj/fX4zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyItwp5b77Q+6SrXQ0nPKHhJ4ON9SIiyiVb16Zzsxu8ZmLJadNv
	oqYjb3gRuBH/i/d8F8wnBLiz/eaWgI2ATukJN9Ov1fiJMnPIJE/7s9HQ
X-Gm-Gg: AeBDietJUze/HH5amnZmM4k9rfGm/Q7H5OOw7QErFtNI4OFjBRco8Ai3h9JZt/+dyRr
	ARLaGsHBZNtj0Uyd+7qxs/Z5R2trZGxmPqV7LU8cdd01AYsjFj50mqZ9xoz0iiu2Ha1f0/Euxf4
	fad2fn+f8sbgSwX6bHqR7dnBhpWW/rV101TGB9wakQINtkiuZ20UEsVFbKtPD98LL2eCn8jWWI7
	Xb1bH79o9hU9Nvy7rGjOQ24FSXVMBH9FhaDiz9eSI0+EuLyfIpEjHa8RRaqIwSEU/oOB2/PKR9X
	PQwwGUVr/emxn5ZPrKWBjmCzsBbWyKCy/iDXS9pTrKbxixg4vUnENIV5uliABWZu5bCvsvbIOo6
	XwpqDkaBkjqLw+6DEK0ZlFJ84gMk3n/kuX9NVLnDJUVlE1qTrk4jKjW95DeymI9VtLTpxJpfsrz
	EGfLLbZ5zHw5N0A15g8CtquSZNUovtHGGjMlBH
X-Received: by 2002:aa7:8890:0:b0:835:685b:8e36 with SMTP id d2e1a72fcca58-83cf6a38ea5mr3684067b3a.29.1778257945345;
        Fri, 08 May 2026 09:32:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm12247875b3a.57.2026.05.08.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:32:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 8 May 2026 09:32:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: watchdog: renesas,rzn1-wdt:
 interrupts are not required
Message-ID: <72cb3b5f-f669-431e-a02c-81537045254b@roeck-us.net>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
 <20260507102410.43384-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507102410.43384-5-wsa+renesas@sang-engineering.com>

On Thu, May 07, 2026 at 12:24:09PM +0200, Wolfram Sang wrote:
> It is now understood how the watchdog can do its job without the need of
> an interrupt. So, it is not required anymore but optional.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Waiting for DT maintainer approval.

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
> index 7e3ee533cd56..0e4b5b529e9c 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
> @@ -29,7 +29,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>    - clocks
>  
>  allOf:
