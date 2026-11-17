Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893444;
	b=L+eTJJmBAacUoLBhD0fo7qfSa6mL1WpA0H97gr5/N9DlbETMFfSIFSrw2xsYqgA2IwjV
	 MwRLAjd5MPSlWQh5dk+XXU6o5l1ZMAckPvCkZ4BFglY/kuHJC9B1iEMV/2llY7Cv9CU/I
	 hurWrH44a+xc2W6aA4dAYomC0hw20Y7gQZjvMC3dJFKy1E37106/enaTeElNqXiTncN7+
	 f1yqRG8XPWWPWf3M+6J1hgZATK/cQQc5wa7CN964kuQx2hH3yie6MR716T+Ze5NltHnRf
	 UgWBtCFCrjEbFIAOklLYapumyMbN1K8fgK/oX4AUUxp2ljSa1hWFsHwHpeYISiX4l8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kIAvslGIGz26KiTObfr5XZM247DFbxXRTcH4PvS8dNM=;
	b=0jQ+8SL8vwxtU+PsBwomwm/VKSphdeGESqjeEx8zaJDpSEIO58+jo3E8BjaMlgSu4XK7
	 zZMw1xglPtaS61b6mg6132Y3uIIMJLrqH/Z5XllW+bo1ZuM1OV2DDzm2YUIFBvC/6YX73
	 61vnNJn5QUEt8cywcOr6M+M+1lECvNphdNi+MQyQIJEJP1IPRvtQtYWJjC0XLT+wzaAJ0
	 9++m/RaB850nEpXF3l9B7d1QfXhFB7YgwitrwTjIu2KLBVFMCoXIfHZLO3ZSCgIsSoGYc
	 U6ZPys/rxZ2DjqB3I1Pm1RW1qBcK42iMmzZ+SZN/wKIKeF78ey32w+JsD/DVPaALOJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zf4QXcp8;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E5606A32C
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 05:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E70E5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zf4QXcp8
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e795af1d4so401189eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 21:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794893443; x=1795498243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kIAvslGIGz26KiTObfr5XZM247DFbxXRTcH4PvS8dNM=;
        b=zf4QXcp8BIXJgVQ932XNIbJBipZ7OOoNr+x0JQwatdUhWjptVB1cVAQ0I4et3Y0vLk
         Kc5yATO8atKFXpKmIe4fY5otpiE5bqcdClrDQWlHVlVda9SUDWarzKu87gUOjbat0Li9
         WxQtTjeTyS+x2LvSFJqGQIpR56cZIlPEO0QOTBQyaJvjDAzOudqDA/LidrE18foibQG6
         wpZO5e8Euu7p4lT/S270Os2CbQ9LyPAVZTkasmQAo+YAC045V1r+v6F8x+uZcLD/4kPT
         /4RKjLFxYSj53EqbIDhapPSb08DghVty5keXFjLHVWPUEoeKTZH3qwCoRpdiArHiY79w
         Plbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893443; x=1795498243;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIAvslGIGz26KiTObfr5XZM247DFbxXRTcH4PvS8dNM=;
        b=PKZ3/zWtrjUGKTZqcWzadGzotC6y+8zkLGLfd1HUqC3Yrczhx/MoqZOEtl3svA1uqk
         LNVfYQOrWgnLCTRFXoenU3HeOjeoOJ+HkAqoRC3sJsIJz8prdFmN1sgtDXmdQcABuOw7
         kA/onHMp74v0Z7r22UDzwR2oR6sSq4BfTJD6daEO3g6EGc/rfu+5zIUkzgKaAQb8QKiF
         FQVozgdNJJl17qPmhP7VzvMpM4NsKKyVuyIHLgVfZ3HL+nvpz14ignmaKyomvwpbDB3X
         B5f1swekbvrpV1KhTHpG5zHQRs6PrM3lzNAEvYvGtkK0s4Lkrxrr+jIgoBetx9L8fJhA
         y7Hg==
X-Gm-Message-State: APuU4Z/rePee367V1G4uLbQUz0TrcIGQGdOUKKeAfUZoTKF626QZWlCy
	VqQ0zUb32Jfn+DU0amLu+worw9zrXOKXkb87qW04lJDWyrAATNsG/ySRzVAqBBVerY4=
X-Gm-Gg: AZFdTZe9R7poWRCSo28f6iZ5mkMN9atw5JfqzVfGEPbaPQfJDVrwpO63jnWd3vXgykZ
	KwBSOI1XGAZG5T10yd6SYM4urCZx+CB6XqvgZQpf9qmcwG8zZlylCK805vy+57DPlEUG6R3Ke5t
	p2cId/19q/BYTNSA7Ot+bEyvOs2rBkM5vz9jf8RT+UjBBttqPvAy/GHHqTaqen9Gvy3cNel9f4B
	48iCRTPfmkQQpu4stBU7WR7iuv0yHJhQLuUfFZzIRHa0nV/Aa9bjHCBJ+di6/2qpCX3r4Mak+Cy
	ClDiK8f0xYG1RKUzlclF5vd/kI2h/5RrEeFsuA8IJc0pwqT4K5F2PK7/9XZ/J6TqnXpz1AD2grv
	chJ+LNI0MHcS7tPMMUjbSzmyiRjt9aADdHRCPHC6tMw8voRcgeiXtak9grgAgVoSjCRQUCva9i4
	nGKPYzrfL/I1ClXDLOUyTy58VusRgzzuu5v+/yA035TB4XW4nRQWYiwFntT2kS1GBoImU7+eyT/
	AWMS98+wD7PbcJ5wsYbNSHsPTLMyF6wITrITIBFprLqe47XUnvwtjwQzqwr9SyAn3anPmbcNbuu
	lu8YP5kvfe5sNw+cOjEjAb5ikI5hUw==
X-Received: by 2002:a05:693c:83db:10b0:381:761b:f335 with SMTP id 5a478bee46e88-381761c0832mr629547eec.6.1794893442481;
        Mon, 16 Nov 2026 21:30:42 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795533170csm40154597eec.7.2026.11.16.21.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:30:41 -0800 (PST)
Date: Tue, 17 Nov 2026 11:00:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: David Yang <mmyangfl@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: arm,sp805: reference the
 PrimeCell binding
Message-ID: <avvmf71B4E2mKrgN@vireshk-B250M-D3H>
References: <20261114184257.535546-1-mmyangfl@gmail.com>
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
In-Reply-To: <20261114184257.535546-1-mmyangfl@gmail.com>

On 15-11-26, 02:42, David Yang wrote:
> Unlike the other PrimeCell bindings, the binding ends in
> unevaluatedProperties: false without referencing
> /schemas/arm/primecell.yaml#, so arm,primecell-periphid is not an
> evaluated property on an arm,sp805 node. Two nodes in the tree carry
> that property regardless -- watchdog@a2c000 in hisi-x5hd2.dtsi and
> watchdog@8000 in mps2.dtsi.
> 
> `make CHECK_DTBS=y`:
> 
>   watchdog@a2c000 (arm,sp805): Unevaluated properties are not allowed
>   ('arm,primecell-periphid' was unexpected)
> 
> Add the reference so the property becomes evaluable; both nodes then
> validate.
> 
> Fixes: 73d3e43f9813 ("dt-bindings: watchdog: sp-805: Convert to Json-schema")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> index bd7c09ed1938..690456839fcc 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> @@ -16,6 +16,7 @@ description: |+
>  
>  allOf:
>    - $ref: /schemas/watchdog/watchdog.yaml#
> +  - $ref: /schemas/arm/primecell.yaml#
>  
>  # Need a custom select here or 'arm,primecell' will match on lots of nodes
>  select:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
