Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D3366567
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305918; cv=none; b=ViPa27CnXPO4BHKV4HE50vc31tbbZRBWABIn6YHqEgHEfJRGfCY+/LqCJzbF3us9A1sIaxeQH8SwpUoK0JVlDkgQCB/qMpoeolXaatz+k1xDLCG4c+ZzWUr7aTgFrBiDN3A64lBqYyLy+xCJnhtvxZYtzRQEAcE5OAdxnA8++dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305918; c=relaxed/simple;
	bh=d5X+0mGIr5O8jmugP6tkVpOw8QahBvvE95JE3VMBuPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8jGX7xAgmAY15FJuIUDT1pLKqseYCm2zZXZI1m1zZCYT2OmoZp87DEQqCi6HHPaUfiHO73aPFTZdxSG/55M6uQ1zOjIVORnfC0faO59iQfkoC3Ws5upu3ApcQOSayKwtOdmZHtqbUZwUG0D+qzzEjEpgdJP5Ls/Wgihp79+qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCnhSAUt; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCnhSAUt"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25187so221532b3a.2
        for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790305916; x=1790910716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f3w6EdTSd+zhzF1B+kjGs8/3o2x5L8y3XOkHxN1oQgQ=;
        b=BCnhSAUtt5+w6FB06nYONsG8FmUCJKrkGgmstKRysKI/xfVA+9NQoJBgysI8mgZeZ/
         2EzCIEGJtupU0LNKRUB8chQb/hklFmaDDJjVhQnqzC4F7gqd5uEug4ULEH/g+LxqQCG6
         vdgJECUfqELCpbRjREKWwOvBNYuYXpeERgdvLT9ggTAAkHddvZs/8PZiTh8fgS/Ybu8V
         Ws8+g0z1bY5zhJxhbrS6v3KZQe3PTu4KHm0ckb/zWbd5P44RTrlj9GZX+1xZ096Ihwda
         J0ZSi/STWj5SeQCtIV1BtJ5IULq7T5+0HfjNl+mVdPw/RbyRQRmhypBrXul0XKWNv9Lc
         QuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790305916; x=1790910716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f3w6EdTSd+zhzF1B+kjGs8/3o2x5L8y3XOkHxN1oQgQ=;
        b=QDEN0wzdcvVk/ju882hahzAw/y1qOAWzRfYJmovXoPr7GSvi5qDXnLvw01oIDzL1QD
         Rh5Gu+rr5SnbVZIHK+XwkJ0y7UbtCqMmcSPoBNMv2+zgUqYS39rbWxdm6iDfANuYCFpM
         4gcsugQKFUPiuuXpMeMNpDoWvXIwNiDoQD1PsLNaVlkbH2KpZWc7z59fqtJrohLJMpzV
         Xpytfl6Ylqf8y3n94dr2SVErgKazJ/DE2iWdj5gEiv2PBnQBNEYr8YZZHxICAITGlkhp
         b2Nzo7a4w+qbyJsvZtmEAgWg5y70viPvX8jgHM0uU7w3K9udP15LAZ91Jmm6LrhB3i7n
         Ml6g==
X-Forwarded-Encrypted: i=1; AKwUvBz07zeT2Mk8WmZWQorJKo04p1b14WYQiMLeyL502LZF4XaMrogLiAsBLHqxr7vj/+3rEAOqhzOmeJ89ol1KEg==@vger.kernel.org
X-Gm-Message-State: AFuF++krhrMm2a1bzqq7Ly2+dVb2mPHw3/+vCcpBuyKG1Dh2XHz8YJGL
	5onN91xRpJrNeeKNNLWzDadByY7unlfV69JbrnbVIKXfdylVjlm9zhFnE8xwnYQx
X-Gm-Gg: AYBFou3UqUi/z3ouN8BD5iCNza34jP/B+eVTE8UicOyFXu0rnJ/cMInYDeBiUz3juwO
	6bWuN+HOinJm3yepgLoYDDGJ4A8TdkRmtUe0G5YOatYQaZVBYhNDJoGMbpwlIc5HOyTZ8AlVyXL
	UYzFWFYI9NHHVxeTQc2/DHqCUvEX2L5yzTtP/wp9sBpJA4iKqAEeYkl08s1S9Znva//mnIllTHU
	z6iW4PmqNSHaqcjadD3FFdbRbjPeaUk/3DsANcp7D4v2Y2GFsDyAC5fH0Asfi8bCkMVW5FhxpMn
	3tjXdHGXMTXfjIfQuY3L/PknSY9xOf63T23HqQXpAOasJSqYLC/fJUcfx3OfTXnu8wyxlAg3THY
	Qlt4EM91G+DmjxmzlPXY6zdzjmX4QXq83afObtv8nftjWMZoMNX12D+KwO6X2DYrl7OdLil0R1W
	yEBA/1DdP//4TokMfapCn7FI2xD4VhemrmNOmzvTktWndlD130CkVnCYBt3gXMZRixehsvbUa5W
	S8ILbDy0qj6
X-Received: by 2002:a05:6a00:b4a:b0:857:7384:b5fd with SMTP id d2e1a72fcca58-87e9995cfdamr3809048b3a.25.1790305915932;
        Thu, 24 Sep 2026 20:11:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fe82eb49asm408300b3a.3.2026.09.24.20.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 20:11:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 20:11:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: watchdog: apple,wdt: Add t8140
 compatible
Message-ID: <381005d6-0aca-4d71-a08c-58aa7da7196a@roeck-us.net>
References: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
 <20260924-apple-a18-pro-initial-devicetrees-v3-5-94f7ea52cc64@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-apple-a18-pro-initial-devicetrees-v3-5-94f7ea52cc64@cyberchaos.dev>

On Thu, Sep 24, 2026 at 04:17:09PM +0200, Yureka Lilian wrote:
> The watchdog on the Apple t8140 (A18 Pro) SoC is compatible with the
> M1-M4 SoCs. Add "apple,t8140-wdt" as SoC specific compatible.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Applied.

Thanks,
Guenter
