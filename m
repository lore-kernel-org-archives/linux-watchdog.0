Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A628725F
	for <linux-watchdog@vger.kernel.org>; Sun,  3 May 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825409; cv=none; b=aVXQKjlsVSJMMog9YU2CFjbebRIP/0IYl7R8b3lF4kvy6E3YQ9xFqS+uSZZrt1mE62sd0GOPwTWSplpjiCtjQ/Z2BpbplUbsvqRQneZ+Rt3Kd62lIZvCDc2cnioZJ8tUqJwD3hWzfw+C3OWm6K+VpZBjClb4YkNlK19VgIzBQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825409; c=relaxed/simple;
	bh=AU8uX/9QIZh+nkXVC8vazf5SRa8LZmsjPkn0h7pKYG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKUz5DhNisk/DGpunaUhR31P8Jx4H4AgN2w7ghMiZElU0v9BEHikrKZCPc1tsvymZs9vhLIxSAyUUnWeUWxBNwLo4eabi6ld0WZDhhLPXxlBlDrODb+nQGVDKNeA5VLIAdxANpzylROAPwezP7V93nKDLVl3QGpK1TxIkjV7ILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj/Wb9IV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj/Wb9IV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad4d639db3so13886405ad.0
        for <linux-watchdog@vger.kernel.org>; Sun, 03 May 2026 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825407; x=1778430207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5xiDZPBkQgeFtdiERgaxOn/EIewBOTyO0UzdhSq+3D4=;
        b=Hj/Wb9IVemBNJIa3qgDWGAHImmznuqKEHlqWxvUslVkNaWc1bSaFGUVIemroR3Ipum
         yc+MC4F4Ble8uTsMAdiael9coQe/leJ9LUvbjt3X3JzQN1OVv/5km6mzJZIXKq1dwmfJ
         JanKVXaMPUAuMbrlbmCl5LiGcfL5Azzj6toR0tqPEum8st5j9a4N0jEZuQkscutKCyIE
         UOVpYmHiap9AnvgfNX5VzaJQo7cB8OfCf7e1kpA4qWD1zDmTkwwtc7/24Z3hab8b/KEU
         HVpRNaZF9lcHWFFspcPG8G4JjO8akwUCqEuv8eqdaZsUfB2qMw2bMxrt6qh6mpJIQF4Y
         fOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825407; x=1778430207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xiDZPBkQgeFtdiERgaxOn/EIewBOTyO0UzdhSq+3D4=;
        b=RFeNCXyO1e9o9zMju4hEjiYSyyI03zXwlFwEChuLH1bm0wohoKIFJ+UmpgTSiOKsYE
         3OIqtaQEwX3D34Rnj993SoI+reqkyCj1E9KbWQaZ2NcR1MobYGH8ub917TfFaZE/VRg8
         bDZsDzQ1Z08tA9CUFPQrzUZvtojOByWNmjPhtMZUxjGlIMpNK39YTMbm2nW/2Jfs2Pjs
         1lxc0r8pzcgAd//96/hpu0tL7cew9jXUq6zzOw7Vi0OHKW3bY5ZIgd3nadbz1xEXpoRw
         eTPoKok6afK656Yq00rINu7B+JtTvTGViwlOy/Lxt4VX3btsC55wwRY2Qo8/ywgIv9sX
         +Q8w==
X-Gm-Message-State: AOJu0YwBRAU3Sviz1T48Lv07FH3jTMYlq6pnjyplVeghCphds2jpjXqx
	nKDr0CjhmNtmZ+ZBHAMcsYrgAyNWSHYktF5O22TjM5zAVnVkE/Tlux5/
X-Gm-Gg: AeBDietwXmjPOu88gIQs8jn4SPL+OK4n/yYuAh2it+X7X8MlNEGrVRiwuym5xtUA684
	efrNoyK0aYlrVuiV2umHHXw35kvlwfGhcGkrOtKcQtBRbie0cjkjmkqJYWHesum6R90eOsyYCF+
	NBYVdCTo/hSSEFsv/9qi6PcKM2jmYbrr60Z2G82ojeWm/DhwghyqahQ7Wt7G4hhwhAGtnE5ejaS
	iDm9wY3gXfHupca18bQ/jAco8Mjnx7xEj5cVxPG6GM4u5/8gFC6edAfmKoUdiZ1gRSEW57xyR6q
	NWPa0CxXArY8DhEdMAd03CbJp+AEbvuCy6hqEHJGuiBXkvsBJPjGEh3rXr/49NRrTOMUa75GDng
	Ge3AxHz1u2n4+V8bvplh/7jsPhzd5vlq41fTSSfwvp32g2du80uFe1/7sb/CZjyFQF25GyUwkV+
	Wh0A5f45nzlI1Uw3lhz0JIsktC/YcVSufMibiEmkDqvFk9W9HgCCsxhD68mft6QGcNnHmCZZ0Zz
	ttYKK8lmxg=
X-Received: by 2002:a17:902:7086:b0:2b2:497e:3f60 with SMTP id d9443c01a7336-2b9f2618a69mr43689305ad.33.1777825407477;
        Sun, 03 May 2026 09:23:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6ac32sm80739445ad.83.2026.05.03.09.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 09:23:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <25916fdf-22e2-4884-a78f-a7926a99b63e@roeck-us.net>
Date: Sun, 3 May 2026 09:23:24 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] watchdog: dw_wdt: reset clean up and pm
To: Artem Shimko <a.shimko.dev@gmail.com>, wim@linux-watchdog.org,
 p.zabel@pengutronix.de, Sergey.Semin@baikalelectronics.ru,
 mika.westerberg@linux.intel.com, andi.shyti@kernel.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260320135624.223863-1-a.shimko.dev@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260320135624.223863-1-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/20/26 06:56, Artem Shimko wrote:
> Hello maintainers and reviewers,
> 
> Patch 1 moves reset_control_deassert() before any register access to
> ensure the watchdog controller is properly taken out of reset before
> configuration, fixing a potential hardware access issue.
> 
> Patch 2 adds proper error handling for reset_control_deassert() to
> prevent probe from continuing when reset deassertion fails, improving
> diagnostics and reliability.
> 
> Patch 3 replaces manual reset control management with the
> devm_reset_control_get_optional_shared_deasserted() helper, eliminating
> explicit reset_control_assert() calls in error paths and remove.
> 
> Patch 4 adds reset line management during system suspend and resume,
> asserting the reset before clocks are disabled and deasserting after
> clocks are re-enabled to maintain consistent hardware state.
> 
> Patch 5 is a final cleanup of the resume function error handling.
> 
> Thank you!

Please check the AI review feedback at

https://sashiko.dev/#/patchset/20260320135624.223863-1-a.shimko.dev%40gmail.com

and address the concerns.

Thanks,
Guenter

