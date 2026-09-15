Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669433ADB1
	for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443975; cv=none; b=GN011K+8kEaz3b57CfLQQhEl+O1RjN3em0+OBiPyEE8n5D5T39s1PyCJiRKn9Cg2g42BJoIa9koIA0sNeT1aRpi1VzPK6k/0kod/uHzpXZARkPjLVGj/GEn42Ymk5cxihwU8Bm3pNhezpZy77u8NjcRKTpS9QjFTz794VQqjMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443975; c=relaxed/simple;
	bh=Rk2+fOE5KgAtRJVquq4yLgBaVLkXRGPSoIYM0ZKmm4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HksHn9RpxFzkOFQqocUaApp4miEj6HVyaMo2G9CSFRN71IFPabUJfhRN22QKWj57TnKvMvdJmrgHLSnmDRuoaahEO6JFry73WmkAttH1bpdL1L5zcIxfzp2jzFCVAC6ksU3k4sK2DHshxHwNkEWMmX96g2aQalmyUGgcko6Gt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIhd9U9r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIhd9U9r"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398a5aad413so3964612a91.3
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789443973; x=1790048773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9xUSer/IeB4JO3MW1K6IRBMq4yOCTNbup2h4OtNttE=;
        b=KIhd9U9rN0CzfNLc4+6B4gKRzjsevJL5I58ez1uBD0EznhiONJdOL0pJZiKDT9qyDB
         gkAurdKk72A+xpKhKd8avsCeKbmMCq3ePoCM99v5I88GBvpSMvec+UygGWshEFoBNfLl
         NoCn+MbV6qefgkfOTOEVV5V6N//9UjNKZ2OsHqXWDhD3lNzPjKER3GtkwK6jL+5jwb4d
         2UgLFG1k4oBi2rcC2MqWvzo6M/CV/R5mb16VjF2y1W+lkkDzue0stto7Uy2OJnU5DHy9
         3Eg51ZTLvEjPdLFsFbKsNTyUO5gleuV/2EklAcTlI80ITQDsVX0ibMBy4CQ12spTww5w
         eHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789443973; x=1790048773;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y9xUSer/IeB4JO3MW1K6IRBMq4yOCTNbup2h4OtNttE=;
        b=ZPcE1yUHotWsDarOa3QaC7I7xLCbzBcLhokE5fl51nU5NAUlxQCV0EeZVBZvwQTOn8
         R1ypyDvaNES4AOrneQjSHZqeV/+UnhSI3VBtCPo87m1SLRjUgW080CWQnk38KL66GhKU
         R2I+Onp1WZqiWN9YVGFwOEcNlDADf/V/H0qYKcgWGL5lfaYJ03Ip8pV6er71fVhCBR96
         5LdLusKu6oR/HH+WdDHTwv9lawA6Hsp/xGQZ/kOn6m8UUZW9l7doWia5jIfHvRgmEH2O
         ouP7zx2ZHaGnT2cEee0TqYHheeffLYYhKgulvEF9k8g7zGRB+PjWrLH/u9OraBdMrdB7
         sCAw==
X-Gm-Message-State: AFuF++kqR6c7fpcDL/EJzmKORi+FdjBxn9mrjye62mcBvA51D4Y6MxuQ
	rLKvo4qPREjRS+j5rvQYb6L0d8/JefB4D8CmiLanl+pm16JJaOzUeFO9bCmVm215
X-Gm-Gg: AYBFou045e3+qq73HYisjzFxIqoJ9gViinDawIkWC+6h2f8jCv1GZI1Nd0Vyo6h0dGQ
	vqgpDPqbT3vj6KGe0MXcoRTG6oAhRaYbDhJkOWKkx9rT60YkcULRxktRB7gh8LXqMKCiKSICa8B
	88H2r9dM1jIoAqtBC3TUoYCeeQOVXaOT31eTNnpMovn5+dJRxwGOOGIpGfooG8fntVRnwduLdq8
	togIj6h6l+n3dCIJm0fTklDiiYSqlnNhiWwxgfiHcfzsGcvY7gy7iaj+Rj4t2lu3YGeKQiRjUfC
	eE2VbldKscEroUIWvz8rx8+9klc9Ns8dNFUFx8ZUEEHNavLt2Jrje5g3m4iIb/otKo0gR+QZ5V7
	amnDgtTNhUaNV7YGwMU5w6tclfV2O3OIR/uul95DXW7OiA8DNSsk2GLIw17WvEwfH0iDAQCA9h6
	ft5DnTwTU02fIbwSCa/mnGn/Hndd/lMUSMr6Pt46QCIPQMnxLHkbQt5KFnMHAcukR9aFSv2uQ88
	sPiTy7l7jy64GZeAXz3tqND5kbzOjO0HJvfQvNid+M8EQBE
X-Received: by 2002:a17:90b:4a45:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39dec10b1f1mr10913104a91.24.1789443973309;
        Mon, 14 Sep 2026 20:46:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda24dcbsm2413948a91.5.2026.09.14.20.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 20:46:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c1d89f34-099d-447c-8e7f-1cba94366659@roeck-us.net>
Date: Mon, 14 Sep 2026 20:46:11 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: starfive-wdt: fix PM reference leak in probe
 error path
To: Ivy Lopez <skunkolee@gmail.com>, xingyu.wu@starfivetech.com,
 ziv.xu@starfivetech.com, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260914165022.169877-1-skunkolee@gmail.com>
 <20260915032032.222665-1-skunkolee@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260915032032.222665-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 20:20, Ivy Lopez wrote:
> pm_runtime_resume_and_get() increments the runtime PM usage counter
> and, via starfive_wdt_runtime_resume(), enables the clocks. If a
> later step in probe() fails (reset_init, clock rate check,
> watchdog_start, or watchdog_register_device), control reaches
> err_exit, which calls pm_runtime_disable() but never balances the
> earlier get, leaking the PM usage count.
> 
> Track whether a PM reference is currently held (pm_ref_held) and
> whether the clocks are currently enabled (clocks_on), and use them
> in err_exit to release exactly what was acquired:
> 
>   - if a PM reference is held, put it via pm_runtime_put_sync();
>     only fall back to a manual clock disable if the resulting
>     suspend transition did not actually run (put failure), since
>     the runtime_suspend callback already disables the clocks on a
>     successful put and a redundant call would double-disable them
>     and underflow the clock enable count.
>   - if no PM reference is held but the clocks were enabled directly
>     (runtime PM disabled case), disable them manually.
> 
> Also propagate this accounting to the existing pm_runtime_put_sync()
> call at the end of a successful probe: its usage-count decrement
> happens regardless of the call's return value, so pm_ref_held must
> be cleared immediately after calling it to avoid a second,
> unbalanced put_sync() call if a later step in that path fails and
> falls through to err_exit.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>

I really don't get it. People keep sending new patch revisions as response
to previous patch revisions, even though that is discouraged, but no one
admits where they get the idea from.

I am going to just ignore such submissions in the future. Last warning.

Guenter

