Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E251C057
	for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752748; cv=none; b=V3erhXGp52pZReYXRJHBXFESZJuj7rJxWb32PkkecV6O6oITChyaAIgYESbrPBUeSRKbOwUNRKsgYbqlwMbcnI6VitC/Hbkcng4O17Z+ZeWqJHpl9wnyvQFyHapl2OffaK3fCH6rsDXPiulXdw4xSb7FN0sTB4tbxa2IZF08aP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752748; c=relaxed/simple;
	bh=6FfrmzjH54GEcJ1wWK2iIQb91lI6OlRWrtkK0i6oGQ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eftKNnKAvr64dAwStdUREHanqJh/L+0hgZVgL5oDwaJAXYIiAf0X51+7eKUYY3b0DpOI8DOqOsAI98U/cwOyjaqiI1GXrU+WAoIY9k8KABuVAMn2+0STiFV6q2lFBuMBJqTYFsESs8ZTP9D+peMovELa2oCinhpY/J1idegxmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0a8hqOj; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0a8hqOj"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso965870a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789752732; x=1790357532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBzAIA75tY6+1ABqxWJzAnAi665MvkZni2otJtamYAI=;
        b=Y0a8hqOjSpKfMvcts1WbdVVBbRVjZEtNxApeWheJ/K5qEtz/KckIyjlgbQMCR94Yz0
         sg+TomiPVw7Yk2wnXYXaQQPRszYK4gD5Sb/aQQ7ncrupdCD81CSA1YoqrRSEdM/+kMBl
         Y+ruEcV1KZXGTC/OqEUrXPeWj1eopkytFZX9uX/KVlBWKY+g+4LsPRUcYfz5NtrA8PI/
         5KpzV4ZAyIiFnhqjGpbJ76XvuWZicIv2BLETGz2FfmeUYqYuBh7rW8kwyYz97X+VM6lg
         CQCUEavsDvS0HruBHZ1YOLOHSUo1cl1gl3Jnbk/x8WkiI6WpLds6pPI+d5ZHuCkPugFJ
         RsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752732; x=1790357532;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:sender:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBzAIA75tY6+1ABqxWJzAnAi665MvkZni2otJtamYAI=;
        b=2BJyXq3RaZ5Se1aocKry/hzO0zdpFmCiiys3bghorzu4RivlmzRLtAFXyPBvddqAaj
         H8viik2zZ5CRQSBEniy6eGk6nXDYP+KQkgHBg/zh6pGFWKS7hqYFfTqPBHyAYSvYLynC
         PVODazLjFQJRxWhfQK2Ke5Reng/+gy21enEtCOB/TwxmSTho+i0QNFjGtiD+mW0WBqST
         not2R5OJ+BVcLGnm1yLfcRQ8cKzCigEYhksN8PH/LEMW1lL5MBI33Caoqq0iMx2pdsrF
         zknwU+gmUJOAJcBuSFRddiKBSCYYk5seWTDdeXaPyldpn83D+iVwYrza7oNASLHCu/FQ
         BD3A==
X-Forwarded-Encrypted: i=1; AKwUvBwvc0ANc+/EGE0dKFxCVMwMPf54clCZRSr/UmjH/t6yHbkkTLJxvcCeraU/UJH1uonTO9hqzaNo3EZC83k50Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kEVcj3/CPFLisHRgSrEdUmjK+cOy1IxQLM/KOWamvP+JvmgUee
	C0yVM+vLZ4ZQeLxmBaHwrhwqNLZgvzvwMdWtq+03QbpOphfZwUXWzTnW
X-Gm-Gg: AYBFou3tz/Sbm9WkmGF/TZrkjJcWAxEtLxC4rKsrmPMRB8zgXMNUDVFnJM9OqzjHY7/
	Xg3xfJfeTUafgqzBbkTjCgDoLDEmiO5zFx1O/B/SaGZZwFVPrrqaT6TSl2Xf5McBmFwPMUXmVtK
	rKaqJza9n1yowwKW1X+PXWBUydfbb3ECPrZKjpjZIchxWdvyClxCnHy7Vefl+Vojk7HzjUAlEq0
	J7TdwjywVy8KC5ztQ3R47TL+YNK+WSgym7cFB+57GXdJjPCRKwqRyXhvMII8SRG33qwjtSa11ae
	UvBqSpQxp4tJwUiR6wVx4ZY27H8Zjmx0jfPmskpfPqlGYgxSOUkBwqKBKmU1tTw3rhUGC8Pt2pk
	GmC1/mnjXxWTsUuFoxjRWM62GPshVenOWM6rP0HWUTVqTPQ0YdLF64NEU4kG8X81JilM2IAnb1N
	Uy6awc7x3DZTm99Y2oX6+7D1bWkSvTNkj5j+rx9P3s1U21BMC0lJvWZN/g8ttNZsTOh8E1beD07
	sztv2I+vz8Q77FCRbSOAmXcBbn4l8KaHlb8lgOt5YXMaAtg
X-Received: by 2002:a17:90b:2f47:b0:39d:eca2:5c81 with SMTP id 98e67ed59e1d1-39e54b19f9fmr7592828a91.8.1789752731861;
        Fri, 18 Sep 2026 10:32:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c8e7sm465970a91.9.2026.09.18.10.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:32:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a81ad111-43e7-4afa-8b2f-f75f5b47115a@roeck-us.net>
Date: Fri, 18 Sep 2026 10:32:10 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] watchdog fixes for v7.3-rc4
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <20260918162041.18444-1-linux@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260918162041.18444-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 09:20, Guenter Roeck wrote:
> Hi Linus,
> 
> Please pull watchdog fixes for Linux v7.3-rc4 from signed tag:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-fixes-for-v7.3-rc4
> 
> Thanks,
> Guenter

Hmm, that was supposed to be copied to linux-watchdog@, not linux-hwmon@.
Sorry for that. Copying now, and, yes, I know, I'll to fix my scripts.

Guenter

> ------
> 
> The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:
> 
>    Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-fixes-for-v7.3-rc4
> 
> for you to fetch changes up to 7cb575b71ab98194d2e040bded3a7281e089c5ed:
> 
>    watchdog: da9063: fix suspend/resume handling of HW_RUNNING watchdog (2026-09-18 08:10:45 -0700)
> 
> ----------------------------------------------------------------
> watchdog fixes for v7.3-rc4
> 
> * da9062, da9063: Fix suspend/resume handling of HW_RUNNING watchdog
> 
> * digicolor, rtd119x, and rzv2h: Avoid division by zero if clock rate is 0
> 
> * msc313e: Fix premature reset during timeout update, and propagate error
>    code in resume()
> 
> * sp5100_tco: Fix pci_dev reference leak in sp5100_tco_init()
> 
> * starfive-wdt: Fix runtime PM leak in starfive_wdt_pm_start()
> 
> ----------------------------------------------------------------
> Li Jun (2):
>        watchdog: da9062: fix suspend/resume handling of HW_RUNNING watchdog
>        watchdog: da9063: fix suspend/resume handling of HW_RUNNING watchdog
> 
> Tzung-Bi Shih (5):
>        watchdog: digicolor: Avoid division by zero
>        watchdog: rtd119x: Avoid division by zero
>        watchdog: rzv2h: Avoid division by zero
>        watchdog: msc313e: Propagate error code in resume()
>        watchdog: msc313e: Fix premature reset during timeout update
> 
> Wentao Liang (2):
>        watchdog: sp5100_tco: Fix pci_dev reference leak in sp5100_tco_init()
>        watchdog: starfive-wdt: Fix runtime PM leak in starfive_wdt_pm_start()
> 
>   drivers/watchdog/da9062_wdt.c    |  4 ++--
>   drivers/watchdog/da9063_wdt.c    |  4 ++--
>   drivers/watchdog/digicolor_wdt.c | 13 +++++++++----
>   drivers/watchdog/msc313e_wdt.c   | 16 +++++++++++++---
>   drivers/watchdog/rtd119x_wdt.c   |  7 ++++++-
>   drivers/watchdog/rzv2h_wdt.c     |  7 ++++++-
>   drivers/watchdog/sp5100_tco.c    |  6 +++++-
>   drivers/watchdog/starfive-wdt.c  |  2 +-
>   8 files changed, 44 insertions(+), 15 deletions(-)

