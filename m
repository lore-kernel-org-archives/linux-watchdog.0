Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62696175A75
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522430; cv=none; b=G2K9NA7m4Z2ECvT7VNDlpx1NbBqosBDi4Sh3txlQULeTHiuf1BSziqX8ZjKpcHBDOhscxm3U5td5cav0cPij/Vo1W4ouB3zYK9Wae597RBZjXWDdYrbxcrZksh9PbBCsv2xWMdoEqb7iw8ahnpWNBl8SNg8i3FAdkgpEXwoetn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522430; c=relaxed/simple;
	bh=Nf5b4hiV8cnlwR8spJ7fIsiXOmlVngm3JAm5mITdJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFWjikUENiPLa4AIlHncKznezzXWDrmbTZ4v/ijHqfPrB4Y4BWlr6llLGSTpuPq9g49CZTBE/rnvAITLBY3WCDqW79b/1szHHTh+Q6zt5ytSi1wHRp9BzmF0EaCo7OLbZNyI0djlRwY114YwN65iCglVOvWps+4x3BqW9+6jsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQZo2yzS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQZo2yzS"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-385b78b44a0so800777a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783522428; x=1784127228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OxRfDNQ3dLfR1mgRSIAPI4DwhSKRcL+nwKZX3ZQfJs8=;
        b=kQZo2yzSjS79YdlbO5y5Rnxaq+O1S9od0HbfZBUMaqKnQYYRv9Khwk8QpsUm5YmlTW
         hLaxJSTXLSEevVPFAEe/4MFdFSJz5G7/ln1YSxGrJRiPHIAz4ekOSCOQ+FeN/lqX+JHO
         Fut/opf9eeBF0JASU/cyyxkOMg/aYpJ5/+aiaW8z00hQLpxnvLhF9YNTItgszJRdwsu9
         z5fqevTq4yfvLgro1RRsSRDWCRjjkWINhZ1TBTc9GBXjocYeUPlVQTQIWJcn9uOy313Z
         QMxjxhQCYT+XMZ0dZhZOddFBgvz/6cxIvianKJerJtJ21ut4u+ES3mZAeGtgVdtXxKnT
         RE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522428; x=1784127228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxRfDNQ3dLfR1mgRSIAPI4DwhSKRcL+nwKZX3ZQfJs8=;
        b=O5tNkMAavcP+COdpogk8j5Xwxcz4NgAx4vuVrz05sNkLrnmsnafrPrecCLV8FfvQpl
         rI6TBk2+VrZlf78jlWJ23mC0VMu/osyX7pKduAEhXc806gtfQnbLbiaZWyxaU295FNom
         1k9QF/2EIFbHoBvmBBwIAj1t2taPt8dlyWgR7cQHBtKyPU5drk2CFAGfz5Nc4gVUQupw
         XohmzQJde+lmqLOIUfRRQ8ygn6FC6SNkqcRbGmlab8KXHPMrVAmZDhJZMeLGoVIKsgVK
         eu/QDaeq0HGyCvgEH+e0SV3Y2w3Q1IcvqgADQIOJFsJsrLdK/jRJTeg9BG4PcRBUXkq3
         m3UQ==
X-Forwarded-Encrypted: i=1; AHgh+RqK2KWuo+Ukg/7/2Fv+xjfcHTbVGftOZLofFgQB2dQJ5smtifSRCrRNet1Ey0WdB9wD84m1Nqa6MtjXW/yyVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww08akxoKsKjzGXxtE18WP3JTgCVxCTfBj/EHhPQr26iQp2USf
	3azGLaYSazFFxtk5ZZwy5Q+jIqe/+VUSfbD9u4IFea8eT9j9TWvqvPYQ
X-Gm-Gg: AfdE7cleoPXfLQ6PDPOmlvD9On836qMKcDduvY7ZvPg9iHOoY4KiPnb34TDKHtW9+sG
	f3jca6IRV05DB5xSgezJlKOv7exx1YJeYFc8T9TGO1rj7NKMD0JZuPj8kXRN3Qi6vvZMLSaYCTY
	VGvtKlDE1t3X/Cr9m+SXaKhDzvzMPUc7xOSg4mPgrcKfW8uF2FiGknG42x5qavTTRK37+gvL9YL
	5Gw6Xht0YiVhDEbs/2ztW0VJzNBxe7YUM4ovYElYjDwlQC2K7Kt+9++HOxvlvNT9vEBLv8TMlZ0
	Bw5JR2RfQyYMpARqnkEmp7C495R3smzqqL3qmeK2AS9aEcZyKAZ8y2qvot/tm+RbeUE7Dw+gJkt
	C+ckKRehXiL4YSjdNZEbnD9FTEVrAKL9ijdJqBIlF8+tyx4nUeuFOrI+xo1/TCBD4v7Q5XohuRM
	OQwory0UYbneyzWm7/JJMN3pKZGA==
X-Received: by 2002:a17:90b:554e:b0:37f:ceed:e1d8 with SMTP id 98e67ed59e1d1-389406352cemr2617332a91.12.1783522427666;
        Wed, 08 Jul 2026 07:53:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a32e3sm2893525a91.14.2026.07.08.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:53:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:53:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: take all OF aliases into account when
 assigning id
Message-ID: <15a059c9-b922-4d10-9ee2-3f362b5b603c@roeck-us.net>
References: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>

On Mon, Jun 15, 2026 at 04:57:59PM +0200, Rasmus Villemoes wrote:
> If some, but not all, watchdog devices have device tree aliases, those
> without aliases might (depending on probe order) be assigned an id
> which would otherwise be assigned to one of those with an alias.
> 
> This is problematic when for example watchdog0 is an alias for an
> always-running gpio watchdog that userspace must handle, but the SOC's
> watchdog device(s) get probed first and thus one of those become
> /dev/watchdog0.
> 
> Ensure that ids for devices without a device tree alias are allocated
> from above the highest numbered alias, if any.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> This is similar to how the mmc, i2c, i3c and spi subsystems handle
> device tree aliases and avoid using an id that might be assigned to a
> device/bus that is probed later.

The patch makes sense. Unfortunately, there are systems with aliased
watchdogs which do not enable "watchdog0" (e.g., several Nuvoton based
boards). On such systems, if they do have an unaliased / auto-generated
watchdog, /dev/watchdog0 and with it /dev/watchdog would no longer be
created. This would result in a ABI break.

On top of that, the patch only affects systems with both aliased and
un-aliased watchdogs, which makes me even more concerned.

To apply this or a similar patch, we would have to ensure that there
is no enabled watchdog with ID == 0.

Thanks,
Guenter
