Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8D38C437
	for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635465; cv=none; b=sDsCI+vh6AdRSMlAUhDOaKtOAc74aCfO86rXKHR4gNMiIWXqtNW6ZM2dAQ11E+gGjwckHmqZmNiHhoNKezk0sM3zF1QH9eR6gV5+sqMXgPip6biOTMh7jbC1oPV9OZ3DH7/JrnBI1tCx4Wj3czzK8fAiTW8ExxW3/k66X88R6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635465; c=relaxed/simple;
	bh=QRYJ7Pdyq+3KohkFFMuWrJWVadywxFKf4mo0I2fhD/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw3RE2vb0AzKeDt5u5QguDalcy49fL0gMMxCabnTHXvW4HCxan3PR5IZtu6nwbliepGxWUiXkAOwXVTUHKbLKYRfhy90BIfTpji9FKQlqh3c0V67ni81rycqU7FlxxRG51qbTCWwL6n3ayCGjacEJZhyb2CPKFF8aMFwfYAC+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl76Lp6l; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl76Lp6l"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304e83724bfso6794946eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635462; x=1782240262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sfarXMBVL5my39Ta/nJvwlKpCUhOTLUhEBD0l3g7Ers=;
        b=Nl76Lp6llM3Mp5H1O0VQnMDTOx8Kqmlsll5F3AE7mJugdsLy+4oPHGXtHl0UKabgqj
         1zqCw/qBm0jZPXj4AjPwN/r3C5jicd4HEjVct8E3wbGz7tF6haVQzngprLk335VSU+4x
         oQQFJqbKg8gJOfO1AVOu5NzHQYfvFQNeLnLNFmOMV86Pfc7pRuLJT8cZk3uvRxT4biSm
         /I+FKgSaxtIL0PGorPGjCe6Mueqdlt+/Mrj7pyJPZ9poZNlUgYnAvfMXaLXT46fW4eXZ
         zAg3To1c0JCQxZcaPFApRyIcs1gpBqhR0aPKCduXkTJvNJUEJGNyXaKh3DmRnm7hZ5De
         CugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635462; x=1782240262;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfarXMBVL5my39Ta/nJvwlKpCUhOTLUhEBD0l3g7Ers=;
        b=h9/7nEU+NF++/j9KdtTwuHIsDluEWfgPKWoA8BNceJ5B5KxAnzak8bzsnau+/aZYA3
         X9aT0wqKtVMaEs31sGM4JqD+F1mFpIfNWdI6wGEQMBTcRAdV38nutfyvNS6rGtluP/+F
         QvhuyBtsiDBCv2ppFRsSAcu43VBWnZ3jX2c91HO0m0vxgweDb00NNAmN3p12jlG2tRB0
         u/70V5bAH6bH8sd2lNQty/K0GwpV2ab7rodAoRizorQNvlgq+kFLv17PixoUnbPqSZYf
         gGJammpvK4V1zWITPPuRhzqpHnP7asWrsBZUdR3XD9qRPsZa7oxoJtfA1qpXj5s4UG2C
         vHPg==
X-Forwarded-Encrypted: i=1; AFNElJ/x5LeG5mkCLDR/v+DSd30vsANKBFDTEc1iuVNhNOxQgZ7oJgedeupCl2f5TJvXje3nvqd7ImnQU7p5M7hwAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fEfCC8Mh5BJoL/xmH/yY64fsiOVlgmG/PzUCSvLs7AjSzYg6
	NGd0M9j2jGvlPW11X0hgCAZesiVOlgm63QVwT8awK0OBROGEzSE6V64bnSRoM0XY
X-Gm-Gg: Acq92OGHP5OCiOaJL5oUaMez/GffXW01WTWVi/bryT1vvL+8Zq+1HusA17gWPoJ88ty
	xudzZWiMZKESN4pAZD1BEfm1GegJ9ohlzuY/OSeaNFtXMr7cpMF8UaUkrtIrhb6B3b3O2tvJqfw
	hOLFnmUPx07luZW3uYybJuWfXkyno4ctJG210N1lX4/EhcroQq/J1IEa8qPibKM8B32k7a0jnT2
	iSjaUOnYAH0ycSmVCbE6hBKpPu8vLEPm6XVYobKYKCuCzr2Vyav28Ri9CTIcpCKXR+N0ND/vH0b
	JTymQhQl3+q7ICtaw0o2uza7wqvBSxpYTVHgxrKw44a2r+fa1tG7MPRwZvXV4Nn6wec7/p1JDBh
	N/B6gBYjL58RToNH30J9FN25iAZHhXG4mZkq9YizdeSjXNiIGdGIrMQSTRp3seBWXt8KO7v/g17
	qTjXklJ7clMfGRMSOVyddhwwU4+y5Tb9GCTwC8LYHHNSPBbIPNhZJEcmXX8Pviy9BhodV9CbLF
X-Received: by 2002:a05:7301:6588:b0:304:c520:4e14 with SMTP id 5a478bee46e88-30bc9cc6b4fmr325739eec.11.1781635462402;
        Tue, 16 Jun 2026 11:44:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm20652545eec.3.2026.06.16.11.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 11:44:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <750d6914-05f2-4e88-81d3-22510e25678b@roeck-us.net>
Date: Tue, 16 Jun 2026 11:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Watchdog: fix pretimeout noop governor logging and
 description
To: Lorenzo Egidio <lorenzoegidioms@gmail.com>,
 linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org
References: <20260616171955.658-1-lorenzoegidioms@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260616171955.658-1-lorenzoegidioms@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 10:19, Lorenzo Egidio wrote:
> Overview
> This review is dedicated to a pretimeout governor implementation of Linux kernel watchdog ("noop"). The overall module organization and the registration mechanism are done rightly and in accordance with the kernel standards. But, two points were noticed that could result in either compilation errors or difficulties in maintainability.
> 1. Potential problem: pr_alert usage with the wdd->id
> Within the callback function:
> static void pretimeout_noop(struct watchdog_device *wdd) { pr_alert("watchdog%d: pretimeout event\n", wdd->id); }
> Problem
> The id field of the struct watchdog_device is not ensured to be present in all Linux kernel versions. Actually, in many recent kernel versions, this field is either missing or not exposed in the public structure API.
> Consequence
> Compilation may fail with the following error at compile time:error: 'struct watchdog_device' has no member named 'id'
> Portability of the code to different kernel versions is lessened as it depends on the details of the internal structure.
> 

Your AI doesn't know what it is talking about.

> Suggestions
> Do not directly access wdd->id. It is better to use a general message or a stable field which is safe across versions if available.
> An example of a safe alternative:
> pr_alert("watchdog: pretimeout event\n");
> 2. Mismatch in MODULE_DESCRIPTION
> The present module declares:
> MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
> Problem
> There is a difference between the module description and the very name of the governor:
> .name = "noop"
> The code clearly states a "noop" governor, but the description talks about a "panic" governor, thereby causing misunderstanding.
> Result
> Developers and maintainers get confused
> The module metadata is not correctly described
> There is a decrease in clarity in logs and documentation
> 
> Suggestion
> Correct the module description to be in line with the actual operation of the implementation.
> Example:
> MODULE_DESCRIPTION("Noop watchdog pretimeout governor");
> Conclusion
> The implementation is good structurally and it fits well with the Linux kernel watchdog governor framework. On the other hand, the usage of wdd->id could result in the incompatibility problem with the different kernel versions and the module metadata carries a description inconsistency that has to be fixed for the better clarity and maintainability.
> 
> Signed-off-by: Lorenzo Egidio <lorenzoegidioms@gmail.com>
> ---
>   drivers/watchdog/pretimeout_noop.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretimeout_noop.c
> index 74ec02b9f..ddb5192fb 100644
> --- a/drivers/watchdog/pretimeout_noop.c
> +++ b/drivers/watchdog/pretimeout_noop.c
> @@ -17,7 +17,7 @@
>    */
>   static void pretimeout_noop(struct watchdog_device *wdd)
>   {
> -	pr_alert("watchdog%d: pretimeout event\n", wdd->id);
> +	pr_alert("watchdog%d: pretimeout event\n");

Seriously ? Your commit description is obviously AI generated,
and (hopefully) so is this code. And, even more obviously,
you did not even try to compile it, or you ignored the error/warning
produced by the compile attempt. And the reasoning is completely
wrong.

Please stop wasting my time.

Guenter

>   }
>   
>   static struct watchdog_governor watchdog_gov_noop = {
> @@ -38,5 +38,5 @@ module_init(watchdog_gov_noop_register);
>   module_exit(watchdog_gov_noop_unregister);
>   
>   MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
> -MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
> +MODULE_DESCRIPTION("Noop watchdog pretimeout governor");
>   MODULE_LICENSE("GPL");

