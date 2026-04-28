Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117638DD3
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Apr 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344676; cv=none; b=nPRr8C8xkRD68Z/Qat8YLVwTecJTzo+GNappvJ2fiy9XPrTfDuhGXEF7vRCpHzD3wabVwRc8bFLLKKB34XzbVKINbb3oBQdHjaweQzKrEvub7ZHQtj9+gQ8glQ6j7bXlzb0bowfqQk8qRPT6PhzfIgwAMtQumdb1gui8T3j2UEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344676; c=relaxed/simple;
	bh=5tAsicEN9TVt+IvhjOKJUDCTMN/dMWKyeKNyaXDwWHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqDy3gw6vv6pP0OdDXG5mG/sPGuEBO3eMYJFeuBDUSzgUrHwlon3bz1ChabPtNBs220REoHyWMIrYqwvczZ7cUJoL9Cn2WtX3WsBJr2aKPm4mDUBcXs14qGASXW3Rcb5XFNVboJpHSDd1npwI/EXXJj8PCxpQLgY42vzZmybLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpdyZdO/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpdyZdO/"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso4176022b3a.0
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Apr 2026 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777344675; x=1777949475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzt3pC4zStkp/GC4Vrd+1imFmAV4J33ni2HfXNqbHpQ=;
        b=MpdyZdO/08yjGAAup5IbR1MX7jMWqijxvDzzFL4RFLFbycVzXCXf/9lwXKTLolRQsi
         zHl1wIv1rZHf0+55hpquAa1DoXXfQl8QlapWPeY9ctMtdXEpXiK85JtLdNryT4kSFPHv
         A3xaTzxZJTVI+oLXcViTohBlWA3eXySFWKtrbwdg7PC8nvcAF1ca5MEb/ZvSDkqWJvqP
         EpGqOugLhpU4ueXB9PDXDr+BiUDW4at+LCzvPuUfhV4WKGzVV1MI6KVUkxAukdwWmgd6
         F2wj83BaMGkztmboFbsw/DgDkBKZgXBZ33p0/TaLUK0onDeWn9L73JP1fvB7gTWvJJJa
         AEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344675; x=1777949475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzt3pC4zStkp/GC4Vrd+1imFmAV4J33ni2HfXNqbHpQ=;
        b=FqGkpmD7aP3meWaYua+0f9oG8YUvR1hRn1vyZYlxjpgId4bE7Qz1JDHEX9rSNhBO6U
         7JDq1ygGKvQ1FLpjF/YPMC/6zeb+2MGjytGLMloFzgwY2Z6X7Lv2kdGndxNht5VAf76f
         c/lcSdLVUYg9XY8oA6qNrGBnOhYOhNGUqj5/7It1zHu6IQ5avA2q/l667In6p0RiWhGQ
         9vAq9bm6znYaWlhnfAvdBH2nJnAYP4CMQUnO6QIpSEqH0qGQ8SRa8YsveZp+ukUhntT0
         r0qvueTqk/9Jz726IUwsBzUoLgr0mXDIzqgxkhkG7yu6TfEdo6+L1RZ0bH4UzqO9LUsG
         uRKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2Ow5mIduCQxDx3e5qlO1gq07m3ozDiyYxbYeJFnZGNZfrkme2Js+D9eeM0zBDx1UuYlwVlDw+dRSl5AsrtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNT/qwdum6hCvayGrM3VVrtQigUF/6LYrGYXXCbiu9SlfaT/2
	4Y4UqAPUiCmJ3IaV0T4yRDISJBsMlnFGxM8QSkfe3sB0gP6tpOgKjjkI
X-Gm-Gg: AeBDieuZIubohROR5TRzHvgJZGxlDceKZXPe9CkIwPUstCRf4oEcWpCvBPtUBDMK8KI
	LUHXulFmJ9HVvlUb0xrrCNZSqvgqNks20VtjNwl4voQpfHbj7bpTemZBRDj6nQx0HUiHQhcutXE
	/N0gm+AoVkJE2fYptGt8unr15pBx/71JJvh5fuICz0JbFZ67w4IZ5aqtzO/xrV7U9mRDtc5zpDd
	h7+qKPONT9smfKqonA0vNgVI0cC/d1EYSsHD5iI3HchpcJuVJ85t6T8jKr20xU32eSbtrqNenDw
	hWcUco8HbZn3Pjkpd4WBHr5NZvCvGRXB8MMuOqmo3kO0pslPwHBjdJD8TrVm2q9uyuExfap1gXM
	lg6CGGAWIbOO800GYbMbGYLoMvnOIma1S7r1IH2p0tjBs1paWYYhwpcZj/r+3URlK4IF+Da9GsI
	0q2/6ejIMR+aGwyb+3zpTozs/mA392wMJdM09ae2ht9s/5DFbi2o3UPBR36n7abXBLQg23juqnG
	s0lo2vdfnM=
X-Received: by 2002:a05:6a00:2d85:b0:82c:dd31:b83d with SMTP id d2e1a72fcca58-834ddc5879cmr1097788b3a.38.1777344674276;
        Mon, 27 Apr 2026 19:51:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf6a41esm897453b3a.49.2026.04.27.19.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:51:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b00aa24c-b399-42c0-85b2-6aafb1618331@roeck-us.net>
Date: Mon, 27 Apr 2026 19:51:11 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: remove driver for integrated WDT of ZFx86
 486-based SoC
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260428014806.35400-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260428014806.35400-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/27/26 18:48, Ethan Nelson-Moore wrote:
> The machzwd driver supports the integrated watchdog of the ZF Micro
> ZFx86 SoC, which contains a 486-compatible core [1]. Since 486
> support was removed in commit 8b793a92d862 ("x86/cpu: Remove
> M486/M486SX/ELAN support"), the driver is no longer useful, Remove it.
> 
> [1] https://www.zfmicro.com/zfx86.html
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

