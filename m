Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460248;
	b=TerFkAiq+1huUgTrFvg9SNFsmCds7jhpp4Hi9NRwj13ZhvQvMeidbB0Wpx+2v+0rlVXa
	 yL+4Ti3c/bgk3XGe0uSrwYtYq/nUPukQlNoqgJ60pUoLoBAN37yJmVuDCbiPhy6GcIcGk
	 urU/7ri3IXj3ZAi6DoIYiqsDMcpEs9wq8bJk2ZhbUnlsaMnBQw54GTTk4PAE+l8yXgvo4
	 6WKBrHTFH24pgD+mGdKNT+hUphzN2Q3S8r08fqU2PhfHCYKAlIjr8M/C7sJ/zrNY8Tskf
	 i/K/SDEjgBt2R7+QWEIZUajdsOn4HZ8nRwVh0gO58L1FWt5ssnv2dnFPszysUIelEKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
	b=E1GusOnEVP+lK20Y4LLgopsSZXrWVJKA3i/0vKMnLR2Mftnwo68lGpJ41ETFKqmdqEzR
	 q8Z36VbWEKLAB1baa0xhYPbD3HIPI8Z8ikXfzFhSSZ17YyJup967DQy3zEDCyto9qhQpF
	 8i5EcLkwPO583hGIUL5Spoqf4vj36cuEBgc4g8uIyZUbwf6Ecs2LQlu9gQaAljOTkTBhE
	 kPK14uIZR64SrtgEBw4mZMJcyfUbIcplajlPx5xcm9jj3uIY1AThf2RKCn+qwlprha9Kg
	 C2ow57QruROzZVYGrcKeW8IZu20rT7wLQ2GmtYQECiYsPcYVTxOLgzD5+EHHyE7bZvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecmXx3NR;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF8606A31B
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0AF8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecmXx3NR
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so954977c88.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460247; x=1793065047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
        b=ecmXx3NRtnKBb0bx3OKSgxIGlOywd+JyxPJp60E/ketB3hMnkmpLkH8L4kcdJeA6Jl
         EMv31nRk4M5/ktlcZJcz0TUpYNZrDTjGmjF1tedEYBM7w+6xPr+Lrn+qPR8G3QZ6JbhG
         NESF27cdh0velfvj+2DrkT1yLnB/vDSgAZOY4mATGCWkyZKYKXVEe9SoJOmfeDb++d4E
         LsU8MtxwGj6M2KGicp3ue91OsgkOef1ZKEnqKl5cto1+sEfHdlu/c4CauXWRFZ7L2FpB
         5HAi4OaYB6E5btRgmlcTXLc2QOcDGhYjgeNwmoMugrTDSGeJXWNPju0Z3o0fQLnWuN15
         jnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460247; x=1793065047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
        b=WMWQ6nGnv5d2eBSWk/8Xhh9xHtvk6ujiZENRyHiftala8BpSSaLtlIb5v/G7tp6LJT
         TDWVCQNwAome0WyzlY0Gcf7HF+SSnnKeRBTERbj5CWkIJ6RwtYAlF66396QX1noMn4/I
         qz61Cmnz10wwG6Wf42rHCrJutHbLfEX5EPbzqPPSsjt3wMqTxS3/AAxyTFAD4rYl2OCT
         6HQIoyvNKP638dbTbKvWgGBt7qcS9GbqIqFsQ7G4OWd5jPlLVuYWSM7XiHNHly1N2eFx
         GiICMwVvy7A2Da5vTqnieRr3vc/vmjWhFt1r2X/+oBNx5q0sc0Q7pgvJidgusOq6DLzW
         BuvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzknjzxfRlTYNlzyXSpCSoeUEX1VISdwzqm3ZDCJM9KWYyj+SKx6qgHkRfzP0w7UWXZckLU/VHKgMdwzZipoA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJLUbnjJ0mbln0Iw9nKCeknZmFaluFdVwLKGXtfI2oflaV6ERqB
	Izt3fSB+K1kSsTQaNRqx4KGH+SnHmnDubZY3vgvQrl1oeNJc4z9eZFiw
X-Gm-Gg: AYBFou01T97M0iR+FHJa+D3DeT2IyACFTqAqTqS29f/SX6OEXnNxUt+ehtavrWx13WV
	SvIclHChgTXR8cigu5760izSrCHH6V0pR0QUybsTbk9SVmXlPGpJ+tR5vA8/8BQedotZIDQi9tw
	3RPoPNKmuJMOEWu2+KX8HLZYfwyFOb4P1boymchTNml0Cn1Uh7xr4X1jqIOWbRMNRpZHdksQQsu
	685aP78pR5IZvNJHo/VLV2PIIwCx46Arp+sOOK3ImvyfI29KhinbpjqU7SGiY6wa4aYScHsxQvJ
	4CvLeC03fC+0nR56Bf8/83RdCBoaecAuc3N5crbmy9vju9fxfgUt0KOpuPA/qkCCTsg0vqUxI6t
	p7DADXWSiZnlBbllbissvEKT0F387yRznPdFgpcwJfiIguvmjNrgGCfU8dKH6jQusUqx3IJRWT4
	15YZ0TAVzpEuTBXdZSGvpjBJ4yfcs/qlEAkJviLEUpqijKsHVL6QmXInv1xEU9GROW2kjsU9XuF
	+RqFDjdIcwu
X-Received: by 2002:a05:7022:120a:b0:171:a066:938e with SMTP id a92af1059eb24-18512c384b3mr12193156c88.21.1792460246891;
        Mon, 19 Oct 2026 18:37:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm37626819c88.0.2026.10.19.18.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:37:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:37:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: watchdog: apple,wdt: Add t6041
 compatible
Message-ID: <1a720dcf-9f67-423d-b998-d0db73f82899@roeck-us.net>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>
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
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:08AM +0200, Yureka Lilian wrote:
> The watchdog on the Apple t604x (M4 Pro/Max) SoCs is compatible with the
> M1-M4 SoCs. Add "apple,t6041-wdt" as SoC specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
