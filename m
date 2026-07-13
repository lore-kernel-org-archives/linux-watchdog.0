Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A423394D
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957694; cv=none; b=T+6d24+PNjCLxBNxvH96y2Y9q0+Wt20NYPKrq3X/iL7rP4qHB0/vDip8YRD6U4WyRwuwi7aCmbzIzr3lYsAkBILurAjXwZI23zgEP9mSLvNXxRTBn7cfqNkcs+JlNAF0qtBupD1JHdFrmLrTZ0DbFmXSwC0LnbqAV58Fhi1hgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957694; c=relaxed/simple;
	bh=svsZAaoQ+MNjSHcsDNYtIIzO7xIvyQXL2opu198pg6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+/U2YmcU3lyaNkyvKevNpS3unjjqOEAUl6iLQvIibCHsVwDXU/H6lhAOMbn8b+XXX4QxkfonIWQcTtRNzq0ePBF0JDoNCwDMuJgOsomb94+zvKUzzKdbInNJmeXsSFSDFKnqfEnTsROJb54vy3T45IBhnmPm9rS9yEYSnGnA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f11piZiF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f11piZiF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso34051455ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957692; x=1784562492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tVvpXOZY51JwxCIfA7gwTwe53KV+LdpZ3t75oW/YAsg=;
        b=f11piZiF43G7ZI5h1osn1qGoab03sDyDKAne/X6NrG761MYrRVI63yVtJPXPM5d/DK
         g2B/rpwS+8Y5ubBj80+adzM5ca9b3NP5bEKhmuXDOttGdtW+x1dqUXEJD3xZlSDlaxj2
         wq0/JxIQRVFjYwtqve1ec2ORpvWEP0tId7pgmRhpRlXZ1KiPfR2kDM0xxI6vAX4tHtRI
         XaV/Xsyg9R4jlTx9h6r4znCERcXMOahETYxUc+OhrPl3HWo5qRwMvOkdc2g82GBPNiZ4
         wJU9W0YPlwsqp3CJUFDvoMhIYNWnMgo1EShAdoP+7Gt1fSMIEYf991sph5GO5c7Q/7yl
         Gy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957692; x=1784562492;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tVvpXOZY51JwxCIfA7gwTwe53KV+LdpZ3t75oW/YAsg=;
        b=TMkFkZnvLU58m0/X/VMKB8o6DbcwOCX92lINN5IbQ8DzX/8bXWlYb39T7WiEYcF0Qw
         4eKnKhKpj3F9im9SNvbBL7G3YhMxhlNwOHhHWHG4LXJHSvhgiiMb66to/uX2ypvl0QXb
         4iQIaRxpXGuDfMeFutvgQENYALeuvvfnT/s9bYYX1gmENCDVWeKL1dpYpRiqDp8P9YMO
         fKMIaXew/wbYbtbFyIf53R7nb+tH7Q3Cs71BlXjpX3KT8+gDdNqDuZDRa2l8zbLuJ902
         5DH9mgTU1CurjhmM0JTwRKJQp7j6iE1FGpeTve6oK9R6+V0tJJS4FAzDzIpYAq1twbDT
         0SYA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7eazXIDMyiBQ8fXpD0vm3uwoTl8LmXaRUON7nCYDmAsw9D04/TH/TFx10iJ2iEVCBHpL1PX7Zz3CZIO/umA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLZIxrL8znGkZaNqbAdnikQL7FIoZ8Js6WLU2tVRdMTc4ftuI
	5fvi8hHGzYCbw3Lq1U9Jqx+uf+kslA3JivVTkF/Unq3ZNuve6UY/xH0P
X-Gm-Gg: AfdE7cm3YtbdUog7lYk9aY0iJJcv8d9UnFB/eVuC3WcTYv8iVJmV24Msn6KPJFHA3SJ
	CIWSRFTKLVjrgnVlMU2nh1cCI24vfI8GT7f7zCiu2IXh1NECEkL+hGKmM8BWwtHqEyAStSq+6Wf
	mc5DH2JD448W1JPWFP1XQKEPkvbJqA+uO7uSuSzE0rW9QPHhHaJi/UdFDm0DnhHA2ur1V21vc4F
	pGDmipMrHSBKg4UKku9YdOqDfO79hDW57EZPI5841Y4x5YD9Qd160mtHWqYmwFpUNv0cs6C52qa
	2qvD4EzyJgdy/Dqp+kly7vX3iu63zTGVebGC8lk6t7TDbe+jQi8/DnhB6L5masuD1fzQWPRdAOB
	sfWeXS9hgzrZ3QCo7qHlXRUznOWFVEGJeeWA20Mz/eRCYeHfNxJYkBZj2f9rKV2ZNRrTrlKlRfN
	1LsCc6ySwMuY3q8uo7CXPr+QdyscvfeBM4m3BgMp8u2qkOV20x1rvCxnkgb9IFjg==
X-Received: by 2002:a17:903:468f:b0:2ca:ecf4:e200 with SMTP id d9443c01a7336-2ce9e9b97ecmr105622275ad.11.1783957692316;
        Mon, 13 Jul 2026 08:48:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm100914545ad.53.2026.07.13.08.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:48:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cd80d204-5daf-44d6-9b02-f11919d3e3ae@roeck-us.net>
Date: Mon, 13 Jul 2026 08:48:10 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: take all OF aliases into account when assigning
 id
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
 <XobowKxdtG0mvqTiTZwSy1NPXSqtqQ8RTLdptdSlr8eYOPRHb5vtY7LlqR2d1K52jmreEvSFNhVkmbyOAvW9JQ==@protonmail.internalid>
 <15a059c9-b922-4d10-9ee2-3f362b5b603c@roeck-us.net>
 <87se5nrm90.fsf@rasmusvillemoes.dk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <87se5nrm90.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/26 07:35, Rasmus Villemoes wrote:
> On Wed, Jul 08 2026, "Guenter Roeck" <linux@roeck-us.net> wrote:
> 
>> On Mon, Jun 15, 2026 at 04:57:59PM +0200, Rasmus Villemoes wrote:
>>> If some, but not all, watchdog devices have device tree aliases, those
>>> without aliases might (depending on probe order) be assigned an id
>>> which would otherwise be assigned to one of those with an alias.
>>>
>>> This is problematic when for example watchdog0 is an alias for an
>>> always-running gpio watchdog that userspace must handle, but the SOC's
>>> watchdog device(s) get probed first and thus one of those become
>>> /dev/watchdog0.
>>>
>>> Ensure that ids for devices without a device tree alias are allocated
>>> from above the highest numbered alias, if any.
>>>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> ---
>>>
>>> This is similar to how the mmc, i2c, i3c and spi subsystems handle
>>> device tree aliases and avoid using an id that might be assigned to a
>>> device/bus that is probed later.
>>
>> The patch makes sense. Unfortunately, there are systems with aliased
>> watchdogs which do not enable "watchdog0" (e.g., several Nuvoton based
>> boards). On such systems, if they do have an unaliased / auto-generated
>> watchdog, /dev/watchdog0 and with it /dev/watchdog would no longer be
>> created. This would result in a ABI break.
>>
>> On top of that, the patch only affects systems with both aliased and
>> un-aliased watchdogs, which makes me even more concerned.
> 
> Well, yes, the problem only occurs on exactly such systems.
> 
> - If all enabled watchdog devices have DT aliases, they all get their
> assigned id.
> 
> - If no wathcdog device has a DT alias, they'll just get sequentially
> assigned ids in probe order, and none of them will "accidentally" get an
> id that should be assigned to a device with a DT alias.
> 
>> To apply this or a similar patch, we would have to ensure that there
>> is no enabled watchdog with ID == 0.
> 
> I'm not sure I completely understand your concern(s), but I can see that
> if there is any watchdog DT alias, we'll never use id 0 except if there
> is a watchdog0 DT alias (and that device is actually enabled).
> 
... and if ID 0 is not used in that situaton, /dev/watchdog will not be
created since it is tied to /dev/watchdog0.

> What if instead of assigning dynamic ids from above the highest existing
> alias, we assign a dynamic id as usual, but skip existing aliases? So if
> there's a watchdog1 alias, but no watchdog0 alias, the first unaliased
> watchdog device being probed would become /dev/watchdog0 and hence
> /dev/watchdog. Would that work?
> 

Yes, since that would not change existing behavior.

Is this an problem that is actually observed on some system, or a theoretic
one ?

Thanks,
Guenter

