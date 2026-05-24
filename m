Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5623019DC
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630066; cv=none; b=kOyQamWSCLspbvzl1uEty/hafHoj51J+MtZeFBWql1ZmWA9FS4OYHRTN4FTx2t60BJ5uL34fVQsjN3AmVKBvbmiF6yVtbs+5LqjDxe5dhjtE3NkviVpb1qDNcHNYFh5VtgOZvVtGQ38xWxqorpSNi7UpTfnhJH5FQXx+zCE43Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630066; c=relaxed/simple;
	bh=YE2D6Yx62HegRB7eePV6cqqeBT2hshb8Xv6lGQTskJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuTn6Y1QjJ7Al27P3jwCSXXx03MGWnWC0ufmJVWSYdPZ74t+9CHYsaSJiVN8myNkbz8gYhW5QxwcftUI0/RH/uly2XySyvK7eRlQaVP7Aqsg9Yqc3zB1xcJTbjFW8dkJQJntxBJoPP38xRRHnnLkU9LNYyyTC+BVEWpqwlq4vQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwQpmRhr; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwQpmRhr"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-136b46c3540so582327c88.1
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779630064; x=1780234864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tM8HwzBz3kh3Ztc0WAojlw6GmamMdNrpGEIg2fiOLS4=;
        b=WwQpmRhr4CbgpSAc5N9eed3uGi0W/jvqqzrxX0yxkeUAtUq9XINYgKVXD1GUZtzbXv
         3KG/R8gTSxgUZtZB5uHfSAjbui7KHMRyF6/Vn0JovE5oEdAU5D1THPj43LBzl3sF1/YL
         WAbO7ro9UgPjzItBsUXYd4O0EIVdIy1iqveSvDv1g22F7Y/Xvnk+e2hcqgD1wGRYTnkQ
         FBIA98lNMOuHCceMNBKIBK7Iq90KyQMQCG7eEymEOygQ1zG9VmK7nH3r4cNVo5WQJbin
         LA4ht00uz8uS40G5Cdg9wcgDyLzTr38nbOw/aYlqQtwiI35tyCvSPNZqUsGZRXtCbtuh
         P3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630064; x=1780234864;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tM8HwzBz3kh3Ztc0WAojlw6GmamMdNrpGEIg2fiOLS4=;
        b=NX1E+w/WiZLr2pa8oNe2Hvt3O7INWTIjnmGWCnPaVkbxv49O03qGm2mj+U1MoxpiSa
         m3PxABNzWXos73nkNxsKX+cZrI2ncUO83K2OLvhLkoXo1suoiqcgI+14TF0Vek6JmXY9
         hkK7Zn7XQ2FjezoL3cDIMPNegasfkrl+YHsYO92Pwv5yPHK/3xyks8X30mT64yHi+dfH
         dZmDcfhltCqVjzmIDXVuYkJZSTqiBiGoy38jD02peqP++qV5+iSRVs2wyqy9NAq/1dwf
         PcFdsoctFCKE7AntUGnUQ7zCRiFSe2JYzywh5Pv81ubAMLHuXJln6P5H9gVd+ElQwgXv
         uYkA==
X-Gm-Message-State: AOJu0Yyz166jKq6WkB46SLAmijcG7jTBoh3UEDqO9Kt8NdDl5eL7uPwq
	4xTKMPCvNpH0zHtwHGzBeIJdOedQyBjAcUUrSp5VMCdSozFEPLG6hLdn35vj23TA
X-Gm-Gg: Acq92OG0zKdVsgaXZRf37NoCGGY+T9v2T7hgzH9jVBGmH+rr74c8zkhDJf32yet3nJO
	9jCDRkRxyW3bBiuhbH62fNqC7KzFpTiTF7EyimvXjTcgLPO7bx3QfmSu8ONvZxPx5qAV3Lphm7c
	V/8EnYZhmaWH6aX/RXjJWeBSBy5+2P5/zFx4kvBjcsL2CY8Idf0DhHrcNHehWNXDRZhZDKl8e88
	2FNWlmy2p8OQP1iCfOhamZ6l3DAkkz3LYhrrSYRa9iXmpJ/AG6HuNsSCr2SblnjAooa/X2lnUWj
	IX+TnLXspUTu4hw8wbu6jGIdR2np7omjB7S3CwP4L3R6m9GxJj1PNIGl87R9zHfPBwYlOFthcii
	IA4xMUN0i8IHtK5grprMXIOJeCPbLMsjJFb2MVrZmIymxHYF8GssFEi37a0jXkClb4mK5detuEr
	PKt/ppYfnhDc33TecEj9fHV4EPHDGMeVZ7y/oLql2UdsgqmKhhFNoYP8/O/2mAgC3UgVdPdb8g
X-Received: by 2002:a05:7022:2528:b0:135:a6a:fcb9 with SMTP id a92af1059eb24-1365fb5a001mr3618351c88.28.1779630063581;
        Sun, 24 May 2026 06:41:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a4011d9sm4570047c88.6.2026.05.24.06.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 06:41:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b3e2188c-064f-4c43-bb9c-cfabd8be1380@roeck-us.net>
Date: Sun, 24 May 2026 06:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] watchdog: ath79_wdt: select OF and COMPILE_TEST
To: Rosen Penev <rosenp@gmail.com>, sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
References: <20260524015042.175271-2-rosenp@gmail.com>
 <20260524021121.7236F1F000E9@smtp.kernel.org>
 <CAKxU2N_jsxv0Zre0FJUGFc=YRyB3Ww8bWxvgwYp0RFaM+Hn3mg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAKxU2N_jsxv0Zre0FJUGFc=YRyB3Ww8bWxvgwYp0RFaM+Hn3mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/26 19:19, Rosen Penev wrote:
> On Sat, May 23, 2026 at 7:11 PM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The global pointer `wdt_base` is assigned during probe but is never cleared on error paths or during driver removal, breaking deferred probing and driver rebinding.
>> - [High] The driver fails to prevent concurrent access from open miscdevice file descriptors after the device is unbound, leading to a use-after-free or page fault.
>> - [High] The watchdog hardware is not disabled during driver removal before its clock is disabled, potentially leading to uncontrolled system resets or hardware locks.
> I am getting fed up with this garbage.

I appear to be missing something. Which one of the three reported issues
is garbage ?

If you are really concerned about garbage, I would suggest to
- Only submit patches which fix real issues.
- Do not submit minor patch fixes for a driver to fix one minor issue
   while leaving all the major problems in place, even though they are
   known.
- If the AI feedback really produces false positives, help doing something
   about it instead of declaring it all garbage because some of its findings
   are wrong. After all, you don't declare a human review as garbage because
   it also contains false positives, or because it doesn't find all problems
   in the code, or do you ?

I am not going to apply this patch. It has little if any value and does not
fix major problems in the code.

Guenter

