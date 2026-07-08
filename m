Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0F3FBEC4
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519221; cv=none; b=nStJii9TdzJj2IiKYSu6ZZJKmh0ggfJvYXFarm3KL0kIuhabu4q8FWRmQvywsrBI21JUcdQZ3NK2Ec63hsOkxyIfCjj8R6tzpiQbEcPTWHOhBlSOz0XF7aesXsrUHp7Pc1nrtGI+rXN8MtMdhTWT1uK0YZ79Yer7nmXLAQrlXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519221; c=relaxed/simple;
	bh=+v9vy7krakGFeXF6TzAUAnw0/rePpUUz3AXWVtluiys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9BJNeCwaqmlP2QKKezVlezUFlCqk24H+WHS4TF+zufAzqP8PHEw2gnAy5xY2pVNs8oe1xZh9iP04xe4uqwIstyWCWaJbdMd9tZbYeciaMuSwTb0O55qzRBg3uBq/5Bwm3f6Yq2P8+aTZmP6eLbjESSDMsP6i4Tgj1wqlYvq74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkgCQ1Cm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkgCQ1Cm"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9d265355so737649a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519219; x=1784124019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MXKeSE96P/DSTkSX0hfZLI8OogkntC/gTUwapWrQ2Q8=;
        b=mkgCQ1CmdnIweyRa4WhpzMCueBmIKRUM6wi1Isnd1iWqA1FPSnSJg54FDGYWG6Z4iy
         HDlpifybzxvrVq687Fjz3r3RSoRFePAxf3Gx0zTNDLbrfZcorj1kug5UH68tOWnspxUT
         gR/0B6cZDpiJ6s70n7Kvy6XyaWH95+svuBhugOEdxmt6WxHReE/XSTzjOMy7qxGTY0FV
         9HHuS95GEE4IGTmO3jgkw+oq5ngFjc80PA5jyiLbKivWL+1UjspBLSX6WAThfchxLdqI
         6qqE0n+hN9B9i2RpRne24V2WwpfZJrTnVUQVFF41/L+9n7Aqw+GcSSg6SHa4WyR6pQdH
         Ltag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519219; x=1784124019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXKeSE96P/DSTkSX0hfZLI8OogkntC/gTUwapWrQ2Q8=;
        b=gZXZFbMk/vByxxQMkHWMoV6yK+cmK62FfBLlSozykcGSejsNfKFZkJ3fXVJ56rHO2c
         AM8pbQEpraebNhutndxBjo4rszOlM1ot2Uf6uXL1/cVr55+FXWtIjCScKeIeuUxgNiUs
         UWZoK2GpXSKetCXWYgSgx/4rMqCiOv4HAQZEcxRJ9xNNolGBw1xJ4x3xW+0afz4BU2pY
         nUce4wz6N2fgcS0l1LjaPKXrG19QrLE5vNTybKLqvruxhRlTH2wba3xZS8VHkNlmoHDG
         95vCAYd7mMRGkAyBk+PrErve0jAugbjzd5ylMjG3kgMt1hBPVQuVJw7wqbwvQRlCqL6J
         eLtw==
X-Forwarded-Encrypted: i=1; AHgh+RrsoKDZv3RmrlUFXfWfFGaTciyZQgKDjL/IYLiQ7JSeBmB2DM1gmv7Bp0Arz6BIeWzRGiPPSesg18ffV9WBgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cT38RRq0RNEJtadIjmF4HWL/cRQ1oBXZUgple9+abUuVVv5F
	OA/nX2WRWnxgXdid5s1za+A50XhS8Hsj0suvLGhGotydQlme172lQzaB
X-Gm-Gg: AfdE7ckDqkNj1fC8XE/hV8NvE7DL8ctcuvIZ7RftwQCcwv0s00WaYoUt/2MQTeM5zFW
	E6Q6gqBTRztL0A2Ov6/ihFJltIniJEWKhhndecXc/UXt6YeNiftgz/egCK9ATw5auL0wfnfqs44
	ZgjKfeOUBBz2WEtfnaiuBJSnd+9foGdyOpGSow7/WAS4gFdVhRzjNV+Mz0wDDEF4q7oRuJks8nq
	YQZLSyZ7fu6S57u67XXXBDFBoadlVPPMlum9fy5sBLznyZjSTLh7aC3/RUXyK5omBzFWPwJeQXg
	19lIuCPJ9TM0KAMiTSrDeAd4M1dfdeWGKW2boTSToGGVMpPzOBUdWkG7QOGQ4+wuvbSNvKdlvCw
	xGNWxhmF8qZURVMz4MB3QyrKuserbbWJ0XUUqLlG3/Td07lXxJn6dS9cRHFE443HgtGICLC930L
	bj+pMby5EFJMbeG2rauhDMmBYHFg==
X-Received: by 2002:a17:90b:3512:b0:37f:ec5e:12d9 with SMTP id 98e67ed59e1d1-3894034404bmr2572315a91.16.1783519218978;
        Wed, 08 Jul 2026 07:00:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-388fdc9a066sm569937a91.1.2026.07.08.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:00:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:00:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: watchdog: apple,wdt: Add t8132
 compatible
Message-ID: <a03c19ee-cf74-4f26-826d-f2bfb816fb3f@roeck-us.net>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>

On Sun, Jul 05, 2026 at 03:17:22PM +0200, Yureka Lilian wrote:
> The watchdog on the Apple silicon t8132 (M4) SoC is compatible with the
> existing driver. Add "apple,t8132-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> The M4 wdt block additionally has a secondary watchdog, which is
> disabled by m1n1 and can safely be ignored by Linux.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
