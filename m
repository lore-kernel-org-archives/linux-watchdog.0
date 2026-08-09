Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405C3612F1
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287625; cv=none; b=eTkN3+9Cf4ZHHTTWt5gjU9KTmhpm6T8qEQvbK/QSPKESJ43aSYJOJpPgGzH+5SjGuuERBq/nUwjChLpd/FszXGe3zoO8edGHPkvO0Rd735TOTK2lhSnkzO61MN/jNALGPw4XdliDnFiCFstrQO6HEv7dnnErvDN0mqZe9WmvWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287625; c=relaxed/simple;
	bh=++2CDr8sslAi9FkAF5CJbSrtCQTx4S/16bfjERCe4qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACfy1+VFKOIfBNw4gcVMV3qddFSTQOicYAreqVf6HpvyUGNe455Vx/E9SThardaGR1L6cJSKekbmpAfcz3DPir4d1ABME74y1rtqtUg7S4NdNSTPpNRBtY41Q+8+a/O5Y0Xil79USv+bB1SGDBFHQrcywUw45QmU8h1Xh/z8u1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc5i4eUm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc5i4eUm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3900e39d935so1008981a91.0
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786287620; x=1786892420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lTzrk2R8kv6gXqCQ/BV0ySdWUtQekk7wApQHuKS3F5E=;
        b=lc5i4eUm2lKKGaSIbAb3UYaFCfFiN0LAuO9CdSu7mcy7dMfpaEnLH9fVgl/UHwC/f9
         qHat+EhlGb8F2W/ON1O2rlhBeHQ6cGXw2kLbMZSw4plqJmIyNGYaX0txa395vSoQd0e1
         a0TMX9x8C8bEBX1gh3LhPE6kG35+KdLOOHIFq5gVNh44Ht+2n0r29MeRqmQeRhstzQ63
         L28sIj7KR/J7lFiVh5a1g5055IymnS6pVJiLQKgzhOlH43U7kpTqPJy4hzBVolOp4Aph
         yKmDN6ixeJEO+i5pEtHn649N8m+EhUdLZRdhrGQWfG/CE4FJQrqjMW4bke723zAnTLXg
         MRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287620; x=1786892420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTzrk2R8kv6gXqCQ/BV0ySdWUtQekk7wApQHuKS3F5E=;
        b=DZCsgQBIbNQqYLCx9Bimq6BbGv7SYDZdVbmVevBFbPJC9HGXTm6FCxcNzPpwlhaf4Q
         DaWOvpxd1QCONw7MouUTZKnhbUEsif+ZKsLjdw9AWMoOKRUo9432+k13LFdl0Q/uNWPt
         Ai92EtN8McPfYxspcHydzuQ6dUxhvgp1m+aYnJx5Zsle305qhsAbogA4IXKSrbm/+lxT
         zGRm9srYcyaKDk4uXkcH1PvWR1fy26K2Zko8seqfgyiy7Xu39XQnrqftx+O4pqmy/vhA
         XeSgsYSE7R8HxPaScT6CydWMmy4MANois27X8C/xoHgbI97FoDV6Hronl0Uv73hG5kQP
         GUaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9A+lqLc0Iw+DqGrQ7DrqYrg4XKEX49xJKxr3E6MfqBRWztjjaDD8e31fB5NywJYW75uhjLaRb8ZrHoJRcAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UDPtrGzCVJV9yAX8w6e7InTeW9LVQm6l/JfrAddkFCfp+8/t
	0NQkY3A0fFumCa5jMHbD1dOnTh3Fj/ga5YzRJYVGwuKWU0ZgRpKBuPKt
X-Gm-Gg: AR+sD12SCUhegVnDbwHa2rMC+o1mwVdasKmFLHw5nW3FvvhUDRmsDWT/LulHA6xE9g1
	yWMVqr2rwDh7wityexq0m78ajZ3wrP79Usqv9aaQ0De3K/snQdmmUlGWzDgibUu4kVtkq3AMiLk
	TpmC0QgWlvcNH15sUbkvZqLTm5Q61ltVsPUHNwO+0uBbrG/oX5hVdq5LZgaI+20A1RUYHyUis0Y
	PiDZKoLOy38kI1rHrv6vIFlitkP4LV7rUf5EbAawZJ/oVEWKkcl9qSL9gS2orPE//Pcilt+cwLi
	DAyeR5U9KWMQravXc8X/nciOrWOj1i1znS3aOT7ZpZdoobdp+j43i3t40js7U/3Pw0ULFYmigk7
	fP5RLqd+XUNRsTZDxTOj6inPg7/OTg81noSIVZ8ghUxtFlUymVJwCXgt1yddmBiyi4+IRT4drgC
	ieA98/6iPQBAjcsVg1mSxD2ip4C6YvQ+zI4zbr6VdtEYrCIXzbFZOX3uqKDLbVhCkWPiR/s/ASL
	oiaU+irMfzsZg==
X-Received: by 2002:a05:6a20:6a1f:b0:3c6:61b9:917c with SMTP id adf61e73a8af0-3cb85e2b463mr38599908637.11.1786287620225;
        Sun, 09 Aug 2026 08:00:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm26361846c88.14.2026.08.09.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:00:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 08:00:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: apple: Constify some structures
Message-ID: <50bec487-2900-47df-b9ae-0ff13791f4de@roeck-us.net>
References: <99019b7e560c2d9c087be340e68f9cce4db1988e.1786283336.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99019b7e560c2d9c087be340e68f9cce4db1988e.1786283336.git.christophe.jaillet@wanadoo.fr>

On Sun, Aug 09, 2026 at 03:49:10PM +0200, Christophe JAILLET wrote:
> 'struct watchdog_ops' and 'struct watchdog_info' are not modified in this
> driver.
> 
> Constifying these structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    7319	   1768	      0	   9087	   237f	drivers/watchdog/apple_wdt.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    7543	   1544	      0	   9087	   237f	drivers/watchdog/apple_wdt.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter
