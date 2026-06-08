Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AC37267A
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959346; cv=none; b=kTydujZdthMcreATpnbPPt+yOu6vXULbTvVvCzcj8CxF/cVmXOT9KMNh8v3gn6OcaBYDGWYCnDauFN7abO+EpqruARUek/22xmTFebwnJg3diAGrBAtry2YVsXqzJ5l7f/tKtlagQHcEDcFTwK3pvz2BJOf4TCK1XuoSCvd4jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959346; c=relaxed/simple;
	bh=Djw+oaf7OP9L34QfGFckj2YKnOZbQulpOVzeGZ7CG3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHuOR8RQEnGxgltihFEScBrfcyS2o9ZaGTfzPXwETuCVDK/yfBW0m2pcIxu/WNqka806YFRrnsm0Fr/uOH+Dfj+Z+joZEBikIzwK0MWV2pPuIXWjq2xZM6Ntb1w2smej7i6Z1br+qHzrsbYcI7n/PUxTQ0SKS8JL/a9DLUA2KY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezYDyf/l; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezYDyf/l"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1872447a12.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 15:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780959345; x=1781564145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y7f67F+Ppl/bhn7KZd/symHKmu/z+TRszUA+smEd8A0=;
        b=ezYDyf/l/fbpuMuHxwZUlzl/Hl2rzuc9myr2u+IlGAfMHRtZRx8GzpXr05kZGCHXbM
         klrzZvpUMLfZAQM6ZolU7p2p7LlFY1Xww/gB1rmBdngVf8vtvxgdThLoIp5uH5Tgoo6S
         yrQ9HY9sebBW8NJv/S08mRv7GLKfhLUgw4xNwmkxaBhuEBvIQw14vTX81oy7v/9JS7/l
         1Gh+sslPdZda6uBdx2LA9amd1u5lhucfJd56EIrkiZDJ3Ki6zatmaiVrhCovv0Rc9j92
         7Cggk7d1Z3/9jCeIaN5xyh/1ndEYFfhxBmDHFaLeLED2ONmxa7aXS5Ishv1nU564a3rG
         eFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780959345; x=1781564145;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7f67F+Ppl/bhn7KZd/symHKmu/z+TRszUA+smEd8A0=;
        b=nvzY9wW0Sl2QNK0JFyOPlIQIiJJHVSY7MZOJ0JKS8JJOwvk/RzwtOrL4z0KThftvW6
         Mw43N1h4hmukUG9QonVBSbUoL8Jf0UdxroctSlBXQhUovVT5wR3UMFxFwXmtX/+MYM9U
         GKLpu5LC5t3j2RMvYyXCAjBdXiP6XF8jPb8l2wVJu/yc58JpNDeqTajZLH5j6saFw5Rt
         zKbb7okt3AR1cTtWl29ZkPHFe0KilIx56bRH+/kg0SrQpe5VYa/751WNJR+XFSO5htaC
         WaheGSlkuXnIoxWYHRWONme5J0J97bTiVxgMmdVLlP6z0Dd2YloAIGOP/0OPLBJyGBMM
         eVag==
X-Forwarded-Encrypted: i=1; AFNElJ/Zs2aoTYsCmYc8dOsXyNjPTphraTytpvDCkkBaHNE7hH6ij3YYK3cESL7MxTjL+wfgYWwGmxBVI/gIPcATWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHapzpNFhWL4aXZyu1+6SjNEKJ3cyXTfmR2wL6tnJ67T/bwNI
	rG5uYf9WyikkLDaBH9OJl9Vpq4pDU7HzABiVceh+DNiq7Qks2fLVF+jr4VkeWkfB
X-Gm-Gg: Acq92OGI5mX5QYCGq2VJBVqlNQAfTwflCrlwnw0k/GMJuQdXfTlrWlRGmWL6oFDuftJ
	Qj+E5Y1tlCaC7m5UsBSIPw43Cb40H4tg6mrj6we/vdiqDsIkZK+jPAJKdC+VeyRhzm8bBjHyXra
	Zoc8Dkd8AGC3NFmZ8rRyYXEM+gYssfs85chNiIOorQiu1ok7YFKNei6WLwSF0sHQIkVaSWDbKzP
	PHbfbf71EBWJTaVjPAUVUfsf6Hsvj1iLANG9meJG/nLjmMlAHrnmHsPSwPLRtjYy34BWzROmDqH
	VoHo2HQkEj9Vl2L70JQhd3D7frEsCyQOvxZWakb7r/osxvoNUCJbNR9pwHOwBldkh+e2EXBPcxX
	qPj00iOP3zn5y6T9ffVevfH5iqZ5cxPwrZGvUagROL0C6MWkK1fUdBoHJi9fBC2VZRlyWVaAWvA
	VQzzQG5oVSUD94iy/2E+3xC4NPPBJxCktGlhg45lafH4REGBuzgi2T9v2xxANzb5yGpWFI+bmQ4
	ldRoaGZiitA8XgVP4be9Q==
X-Received: by 2002:a05:6a20:db09:b0:3b1:80c7:5f8c with SMTP id adf61e73a8af0-3b4ccf3c4b2mr21051571637.28.1780959344839;
        Mon, 08 Jun 2026 15:55:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bdb98sm15635837a12.31.2026.06.08.15.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:55:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <235a947c-b95c-4de6-8ca6-5656b5358149@roeck-us.net>
Date: Mon, 8 Jun 2026 15:55:43 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] watchdog: pika_wdt: enable COMPILE_TEST builds
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260608210402.31545-1-rosenp@gmail.com>
 <20260608210402.31545-3-rosenp@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260608210402.31545-3-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 14:04, Rosen Penev wrote:
> Replace powerpc-specific I/O accessors (in_be32/out_be32) with
> generic ones (ioread32be/iowrite32be) so the driver can be
> compile-tested on other architectures.  Relax the Kconfig
> dependency accordingly and add the required HAS_IOMEM.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>


I really don't think this is worth the trouble just to be able
to support COMPILE_TEST on all architectures. This is an old watchdog
driver. It should not be touched except to fix bugs.

Didn't I say that before ?

Thanks,
Guenter

