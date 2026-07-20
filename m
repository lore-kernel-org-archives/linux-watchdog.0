Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF62395AE9
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564175; cv=none; b=gJu0A0JgBCEJp5Y0QC1LH64LLLHcakk/KrKFHODqTJJop1W5cVkFwC/slmZy+JQ6fEFc3mjqeRoQoEoro/Akict+tOrbnex/zbBUh0usC+jznj1gRgVSkhPi9oGF4B/imoeRq9BqXcW60XqzOvk1PGuNIQx3C0Zovc+AyTPnCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564175; c=relaxed/simple;
	bh=085MF/GevoRaxgn2oNQBqmCbgD1r21gndgud8mN5OxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNYm1g4Y2aB5R6DtzrngFjuLb7fmJ6M6ZqPVifslpGC3K8mEjPKr4Bgzi3MKTstsNKCzrdH8uVrqvHiJFXb00AtbLWqGN5Dv5Hyt59WHugu5LmmuBOASD9zadu5aYwCwGK2+DuMP5p8sO0VG3Bb3qbkq2jkfVO633iFM9MTWq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT8Uk+Be; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT8Uk+Be"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e08baf860so7891205a91.2
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564150; x=1785168950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3tTr+RGt8QXwsbvuUoMSTPv8PVwzNX3CqkyBWX78eok=;
        b=YT8Uk+Beki5+Jxm7y5dKc0r4Yk2OPRb0xq3qh3JiqLwZvPpiLZruiCNGQyAuu2esmx
         D2z9d0q3OHSllaFH+T9uFdcbnA0v3Pu3i+Vz3TMwN1d3D3wmr5ETNjkKPVi6gbhUru2+
         3plHbYoC7Xz8jxN10nTmJJ4io+Vh8rBiQueIfFNqHCDCPOlzcpmmAmUf/sFN3t6UEgNu
         d6s9Sf4TmTnoKsnrxCttcpqFG2ff+fwA8XYHOOTsxKXsYKquaD02+VOu/PnYru9JEA5/
         BznnzGA2IWhX5SaeDiWZus7RhqEmWL4wOCwyJ70g68/WpbjIQ7MG4EyZwU5qEZhvlMtj
         HWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564150; x=1785168950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tTr+RGt8QXwsbvuUoMSTPv8PVwzNX3CqkyBWX78eok=;
        b=PvAmhl9/dfAVncsrsvMAvJujrJrdXrQhDPopMgNaB8BK8OwUAP1VNhwq2dbRrkyze+
         xa7okyOkKxUlrj8D/z/PcRWGzlbQf4bD3Knl7IQDYIYLrVdhjbMtEdYscQts1+MCYloK
         9kzOwKP0+gGLvjjkBBOTM+CiFLlUFgvRXEXRb+4IWZSQ7cLCEkpsHawFhTVhSKAZiBlD
         yLlyrqlH0Swp78aCM6wSP7SggdfgkUWv4w1CHLrY8If1+ySC9x84cpk4oJ4KZ1E8CtAa
         YiMc67k13VngQkdmQ9ADY/+2mcOAw1KU5C8ix1ggET4/a9lxwiYB5YASYUgAbgphNfHd
         y6Fw==
X-Forwarded-Encrypted: i=1; AHgh+RrITWX6TtbFDZJC8rfCreZFGdYBGKFb5IwSk0VobWHSRy0UTOulmLZgH56r954h/kV6hf5rti/NYJNhrPhmjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbnWgxqFO8tju9TRIrOzrUPT6LmUwH7Fk7Y+NzkARLdgyi8We
	45m47/WzvOmB6pFB4zF9Fsi7koANznim4jbzxW0oISOMlIMAYXLdwuSI
X-Gm-Gg: AfdE7cmyuaaxhtagFPcXatuc5XRLsuAP8T9BpbiKZVIB12JcT1ax6oQi+hdp1HIJLL2
	8vtpcA/abBVxh1FZG7sX6WYwu9CoWzTYWtt+i0Jz7aDeVGQsRtdB0RTdpe+UCj6DvQ8nj8Fq4uD
	DNwlVqcA0986IzczCuGGiMk16DE1DGCWh2Ns+oZeGJFjAdnRL/4IyhoIrz/8VBa8P/58T/EcqDF
	vTsLNl3B6bJNw9atAbYTElIDZw9LouwF39rjoIs7SaqFWfTrXw8wN+S+n7022To9TREMRqz6ncC
	n2cgcElQg8ZojwCRrgBpROgJ4AkYQrhdXVhS6O0Qcs88Z4fwcj8uJNwRMl++H1Q1RxyRQfLl79V
	oDRZr4S2CbiZ1HIZBEHX2Xhc0hLP9aXWiloa9mZExMuRZPY+7TZE6mNXR9FFASRKOZUAA95gwnZ
	oBJvhMPoFAIUn3wl8=
X-Received: by 2002:a05:6a20:914f:b0:3c3:ad17:eded with SMTP id adf61e73a8af0-3c3ad947d8amr15223942637.36.1784564150015;
        Mon, 20 Jul 2026 09:15:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm45298283eec.5.2026.07.20.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:15:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:15:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Simon Glass <sjg@chromium.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jamie Iles <jamie@jamieiles.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: snps,dw-wdt: Add RV1106
 compatible
Message-ID: <434ac32d-9f3d-4b5d-aeb2-91ce317f8e70@roeck-us.net>
References: <20260714131856.v2.1.b5339e64b3fe4338b3924ebd9dc0096904699744@changeid>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714131856.v2.1.b5339e64b3fe4338b3924ebd9dc0096904699744@changeid>

On Tue, Jul 14, 2026 at 01:18:57PM -0600, Simon Glass wrote:
> Add the compatible for the watchdog of the Rockchip RV1106, which is
> compatible with the Synopsys DesignWare watchdog.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied.

Thanks,
Guenter
