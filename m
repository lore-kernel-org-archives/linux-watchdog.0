Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379551;
	b=nvkyL2LqJ1S/imswoNV1Q3rfjBlIA0/DcMSTzL+3PQETZ/7Py5tvr6O/P05z1fBPqH66
	 j4ZoLnZpn4JdVUll6nT7Z0baJZinRU2WrXs6ocanB8rr/79M1cgQPbUUNiG9UHFa7b5b3
	 zZcVTCugvV2nHrS7w4L8dJt1H3eijj39hkOK3yEf93eSpol0+Aj5Zwrna4hc0gg3Bg7WR
	 FvnPKt34ZNuGZfMeAneXPzZbQA+zEFjft99I3tq2Bvw9aAk4yziS9uPc+kHFxPA2ShFrA
	 KT3IvfEPTTkelA4oLDt5D8YEdBMbuI6THeYZvi0R3J0YEFlotLUylvHmVAkITJZykIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379551;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5n8eSjKsc7e8/r/fqdfKYxiUDvARY72uPXNUK2wE8wQ=;
	b=3SsvMTWVqsdg1om9HLw4uRquGU5nIW2Y84Mj1FhzGQe/sToZ36VEkamN0wryaohdHpZF
	 N+fGWu9C/0Gh4+s3FkUydhvDe8T1o7Jc2j94Ty0Ltc5sSwQrBYvrqQ0/ld2tIYSf5OEw2
	 TFFr/oVVApHDxKpjfjLJZ+crTH3kzEJgZVm18XAdhO3I2AotxOe6qLdwvMbPohUoX/q6K
	 RNbYwvybTXHTWtbKzW5AUY/0GCAEoKxbujolKy/Fh/Fjplvsz1SYK5xiztxceaRejJpFY
	 98tblksUaH4nhjU+lpIoJcJo92TPuOmN9VoJK2kG5sccUmYR/p4hMvxZP5JnCjCRi9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yObKPwnT;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD339606A31C;
	Fri, 30 Oct 2026 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD339606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yObKPwnT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5n8eSjKsc7e8/r/fqdfKYxiUDvARY72uPXNUK2wE8wQ=; b=yObKPwnThEmClW/F46QIAgvizo
	dHQdP5RQkxO7nAfWhSOfG3GHAFtjezzphWjGqaWEQQSPVXCJyUhXeu8ZDVF6VkgBZRct75CljCX7W
	iwbTYtq5BvR9TbxcAZohLPVDy5hE9DCFwVQy0OCjhzlX3Oad/hGkoza+4D46y6YqO1xxtw39ONLNY
	WTNhmReAUMqKVnL7W/lFq8rBBZ+nbyNBUFpynTj38tdDLlDs7ojUlWJsh/Ytu5bN+NuwU2xeiuw2O
	vcXfigF+TC6TmGGiT1s2P+mfATGeYL58R23ufJ/I+eA0vQDtzSvkM8hKhJKyM/HU9u35PGDmc60n9
	xYswoI+Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMpwc-0000000CB6b-1VHG;
	Fri, 30 Oct 2026 16:59:10 +0000
Message-ID: <6bec1cdf-26fb-4d3f-941e-16f5b52bea2c@infradead.org>
Date: Fri, 30 Oct 2026 09:59:09 -0700
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] MIPS: mm/c-octeon: fix missing function prototype
 warnings
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
References: <20261030164657.2808262-1-rdunlap@infradead.org>
 <20261030164657.2808262-2-rdunlap@infradead.org>
 <sashiko-outbox-191287@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <sashiko-outbox-191287@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/26 9:53 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] MIPS: mm/c-octeon: missing prototypes for cache_parity_error_octeon_*()
> --
> 
> commit 710759b5db134c7d9627997d6bd1fbab4fe6465b
> Author: Randy Dunlap <rdunlap@infradead.org>
> 
> MIPS: mm/c-octeon: fix missing function prototype warnings
> 
> This commit adds missing cache error notifier prototypes to asm/r4kcache.h and
> removes local extern declarations from drivers/edac/octeon_edac-pc.c to address
> -Wmissing-prototypes warnings.
> 
>> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
>> index da1cd1bbdbc5d..8c36d228075f3 100644
>> --- a/arch/mips/include/asm/r4kcache.h
>> +++ b/arch/mips/include/asm/r4kcache.h
>> @@ -31,6 +31,9 @@ extern int mips_sc_init(void);
>>  extern void (*r4k_blast_dcache)(void);
>>  extern void (*r4k_blast_icache)(void);
>>  
>> +extern int register_co_cache_error_notifier(struct notifier_block *nb);
>> +extern int unregister_co_cache_error_notifier(struct notifier_block *nb);
> 
> [Severity: Medium]
> The commit message lists four -Wmissing-prototypes warnings in
> arch/mips/mm/c-octeon.c that this change aims to eliminate:
> 
>   register_co_cache_error_notifier()
>   unregister_co_cache_error_notifier()
>   cache_parity_error_octeon_recoverable()
>   cache_parity_error_octeon_non_recoverable()
> 
> However, asm/r4kcache.h only adds prototypes for
> register_co_cache_error_notifier() and unregister_co_cache_error_notifier().
> 
> In arch/mips/mm/c-octeon.c, cache_parity_error_octeon_recoverable() and
> cache_parity_error_octeon_non_recoverable() are non-static functions called
> from assembly in arch/mips/mm/cex-oct.S:
> 
>   asmlinkage void cache_parity_error_octeon_recoverable(void)
>   {
>           co_cache_error_call_notifiers(0);
>   }
> 
>   asmlinkage void cache_parity_error_octeon_non_recoverable(void)
>   {
>           co_cache_error_call_notifiers(1);
>           panic("Can't handle cache error: nested exception");
>   }
> 
> Should prototypes for cache_parity_error_octeon_recoverable() and
> cache_parity_error_octeon_non_recoverable() also be added here so those two
> warnings are resolved as described in the changelog?
> 

Yes, I'll add those and send v2.

-- 
~Randy

