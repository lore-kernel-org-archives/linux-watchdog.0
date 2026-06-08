Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D0369D7C
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958679; cv=none; b=Oqepw51lE9fp6IZ9CK/ve1sFHYVjcZiOYBpUdH1AgKGr75QgBMQw/XCUfkZ1Rt5wzjIj4EBdAvuBsplE7kqzu54FO+n7Fyhb9Y7x1ZXHKyM5YlfxJ8A262C7wc4CREfZ8PiGmVL7d0iFBfVEdYasX9jiDwYcNaHm47i/jvShPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958679; c=relaxed/simple;
	bh=SY3ZDi7rqYk0SDGx+YG6HBvYvM6fgMrPZitm3e1lvFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3qPTF+n76l+xTeU7FB7jChQi4CnhE22W/uxHA9kdhLkEeAO+9B77SS2wiDokknuLC16eZo88HqWcaccvAnQW7FXQdqiTTfXjN72RyQrhNrmeOqr2xnxbk6jNHj1bLcnfBQJSAGgIgkhxOeZxMYFjxm1HAD4yDDYnIDw/C2lKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7T9MMda; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7T9MMda"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c855599a77aso2362407a12.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780958678; x=1781563478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8162lNHsWpqaubi3mJjKtZ4gQWpHDXaDerX/XR2Loaw=;
        b=q7T9MMdaybzTnm63ITlyQJQgIv+f+XV0B1zX5JFnWUFmXq4IJpXxx4Dbxc8gZaYo+V
         +75SpptDZQSclqgdnosGyHu2IZ3p9DbqruZ+vJePoeGpnZr4zGrSbDAk3SE/N+1JLi2M
         /pDRkktjzJGXwdOUE00S1VkGZKZfpw7KlNVz4yNa2iH7g69LDC92Rg66tb6GYRpn+B6c
         NAbem/jmo4FZ8HVKroHP/tIQ8HbRER+WgIKT0VH9ls7iuyd8aoJhpuThKLiSuXOmCPWe
         lGC7njaSs4tQxZvZ9BbLRGRz8o59bMGOXexqgX1GOl+LDFpF8Gqy9ZfC3YwSSvIu/HES
         p4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958678; x=1781563478;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8162lNHsWpqaubi3mJjKtZ4gQWpHDXaDerX/XR2Loaw=;
        b=r+X3AuJRI6GyisUdpRSJjzEIpUkaYS4htZ0fQgJv/N5nQQumj2quxzss1EjhUsLOGP
         JdqD/olnb+AmRnFHEqDRUv0pCJLZrXk3QUJSHGgSZr7Y1kzvky8ELdGKqGsGyN7UVm8a
         uGn6hNGrDP5HT9sCv9ZuKsGJflQFgdkLj3igVwMjbh04qKH3tuf9CsDEn9AnUgEc6Rz2
         Sf7QOI4NCpDH6wYB3jb8KhHyWclSbbiIbfsNh0GPcbrF99VUeGJqV6ekBig0+07IF84C
         bfoLmdbw2v2YWAqe/F0BzgFsemQ/9LPWt4wAUf24iEA6HtkNTF/TK0prQpDIwdqgw0Qn
         OnpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nD8eLXrYyrHshfgT8wLXQVlidMX3iwRhpCuhYjYGfGlAnoo1P6nxB1xgF4J7ylxQmVHIlAObDSCCEpfF7Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSftR99e8sAHHZf7YkbrZEKZFcYkD7LbchZjIX4vLC8BvWKQRR
	UqtaDQoJquFyTMSq9s1ssxuYkbfn4OjwG+BrZK3LjgFlRFSjG6efX0Zu
X-Gm-Gg: Acq92OEPaxzpR9dc28DwibFRFS2fryJh13UUp8lQQnkL14EQjlRGD1NWdanr+cQ/oXX
	gM2Kp/sy29YikEV6WzcpkuOUl2A9cc3Z9CqxoRmyqLzhrhK7ISALUDfZwB6DM8jJNEy1Ezqxexu
	CbCco+yD8plHpmpIYQuGIOzKXOd304zcxqXEqsoA8ppa0mSOTfqWAZjZEq4pm0vp29dsQeRkZ5o
	jV6PezYVjz+VtvKrgeT8QSilVqdLskalP9lKN6Ys5joFxsj44iAaNmEFc4Chl67WXUhxhEKvMaB
	i/sm/PIivdclN6t9TJQEknLBMvIYNj+rwxATPFeROS5wBGsjRWiUfpt9CCTaaIOIRqK1abVzT3o
	dRoaSkLQZSaPBrs6TAoEivVc18OzpUP0/ArkNORV/kXNTLnebcSoeSAFedPkxBgj75mft2H/NYk
	/CdsWALIA5UkDcJzugRSYG5m5ARYMTIb3Jyukr6MfCNhdFHiD9K53AQgGQ6xWQOz+cw/4147mUa
	usGg9u+PMQ=
X-Received: by 2002:a05:6a00:8006:b0:842:5bf3:c53c with SMTP id d2e1a72fcca58-842b0e1dd7fmr19184385b3a.2.1780958677698;
        Mon, 08 Jun 2026 15:44:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221cc3dsm19099500b3a.1.2026.06.08.15.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:44:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8f5d6e37-2334-4eac-90a0-8dedf90d7890@roeck-us.net>
Date: Mon, 8 Jun 2026 15:44:36 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] watchdog: sama5d4: use platform_get_irq_optional()
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260608200933.18669-1-rosenp@gmail.com>
 <20260608200933.18669-3-rosenp@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260608200933.18669-3-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 13:09, Rosen Penev wrote:
> irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
> bother with it as platform_get_irq_optional() doesn't need it.
> 
> Also handle EPROBE_DEFER.
> 

That is misleading. irq_of_parse_and_map() did not return errors,
so this is not an "also" but made necessary by the use of
platform_get_irq_optional(). That means that replacing the
call with platform_get_irq_optional() is not a 1:1 replacement,
making its use risky without extensive testing.

A much safer solution is to add a call to devm_add_action_or_reset()
after successful irq_of_parse_and_map() and to call irq_dispose_mapping()
from its callback function.

Thanks,
Guenter

