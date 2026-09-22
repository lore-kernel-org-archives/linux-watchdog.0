Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224153F6B1
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079263; cv=none; b=SZvVtYoLRIgpXuPj0wgO+CXPjm1Ulep85mhPPfz1Bz19riEXSt2uzNXk6yfuQMJipmiEdNpHg3ELQdsBDYNzFURHv7BflcKCB9Q37BJh7RixzylnMiu93WK1LJL8FVWuUnqLzMp/xXUWSbCAIO6pA4bHyN7hiQdjKHr+asvQ2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079263; c=relaxed/simple;
	bh=cO/0lFvTvG66V8qgwEs7/ERoPOBg6ZmC01UnhIS1fPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyNAGRMPCv2FL+Pdq74JBo4smFAxk7Ku9BuB1xCnGI1jHQaLnKbX8Zx4DKXUiszfK0misPYivDQQgi0lTLMWPv6/Sp2ijQvi1VXKmySRjULAOuJy4S9fTbsgZDSZvw8UmGgUiSB1SmjAcxFhBvS9RqFMhZBicC2H2uYAu9d7P7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DPCXSz25; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DPCXSz25"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so21143795e9.1
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790079257; x=1790684057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9ySDq5qC/BHhusKQ7rfEBav6KYimM/IjifTwqmaLzs=;
        b=DPCXSz2564BGs4FqVf9X6ndF8vKXvCkRUO2Xh9PwDTf2lHtzZNYXYQdPAB7EUQjFUW
         dQWguoMCvQ6+ponBsl2KRPXWEa3tKacXHqgS1lkgo8Q+WjJ5aeQFf92PQ7dqutrZedvk
         T/vbPMXj5eHMwZAI96NMPTYm7pHL2ixRKGJMHKC/6wF1aBtmLm3I+vQHGfW5dd0ono6E
         0Ko7MI47yjUp6VNo3qSb/GQwjkNXbDz0V2+dXO4sb6dn/z+5jQvVusz51oaGSefxuMDW
         glPbHbabDUb3RTfMYK2hKxMwJ6jPpiiSudmiRvpzsu+oj1Z64+v7iOIIAsBvjKxVOBab
         LRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079257; x=1790684057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9ySDq5qC/BHhusKQ7rfEBav6KYimM/IjifTwqmaLzs=;
        b=rUMnkFG2puZW3/DmaOu4Z7X2bA8142mdyLvcwm0pDkWzJkf7+mGffuxPyu7UmMSASh
         agb8ypFF3zY8c67cc7gQ8TJoDxUKZIpqen+QPZmNO9VW+eHefzMLE8/LJZizetKURlGj
         RVdVQ9K7MM3Pq5sHGLnjKN++wVTeK/FBvjn7K+DfE9ZwHTlv+KZjp2TYxEV7t5jy+nRe
         xRi9p+JuoiigYwLioYjR3plxgwze9Bn4CcpypswzZkRqZ5y7M5cj0tJRIgK15h0AiSwc
         cKP5PxmhZnvDpW/Bd+8CXeI7dtqT6XYPYK4jQisuLe6kmj44OW10oZOeGSsVXMr0c2Ih
         noIQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/ld2Vj2bst+wONPxXf3F2Ss7YGljsFWXq6gfUYCGZn2J+eIzz2tmVDRbwMVFKRO/10QpevsY+9b5qQk6V7A==@vger.kernel.org
X-Gm-Message-State: AFuF++ks09XzZJnhg0PJlEeHS8dmfGWRsAgDP+TUgKsv0DL3uNbri8IC
	h4mA0HBtIAtnBD4zmXep0fvKb4+Q+rJLJo4ACakms6b+Jgkj62yaeWZ23K0+6/ZIeGGlo4U6LMJ
	WTE6BW9o=
X-Gm-Gg: AYBFou0hhplGeFz/LXi5hNVjW3mgZ1rquhnQGktm8XuJdBIp/3qV1rBB/9ByHKFpkpW
	GJ5BzyO5pxCRXYdIeFjfDta3Sh6NOTF8X5WOsRqkQrl6JriowLm4899rZ9W5lpmre9LbGIyhokl
	LFI+9otS5DEXCOFGwMIu7cd6fa9d7OBZdI8V2v7QeTt8pXGKLmPTvEpUsGe7mGOthjJJGX8MFQ8
	bDEKhgV/ot+b8BNzU/09lCIkhIqBxkCm7sU6ucJgJWw6NHf8tOraghf5VJYzuNY/C42tS2rk8mv
	qWCuudhDPpkrL+vDkj5sEg37bWAI2wGcRlXURBfJqs7DiyAcT4nEfMjBXkjNOBQSN2nXP7Pjh+z
	cmK8WgOZGkHWGj8aIl4FTj7ufR06MMbk4oZ7sUaaJtrW+r+ibJbgHZrzQdZrwLpRGWZNfysz48d
	lsXC/ISFsnJZuuGsL7JXN8AwJZp1+19prOWWND4Il3ECP7iCQON0xpO0/6Y37OImjCPyTb6Sr+
X-Received: by 2002:a05:600c:19cd:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49fc584fc7bmr200822075e9.25.1790079257446;
        Tue, 22 Sep 2026 05:14:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad36439sm72406065e9.6.2026.09.22.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:14:17 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:14:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] panic: restore variable arguments to nmi_panic()
Message-ID: <arJxFybmtD7OBIcL@pathway.suse.cz>
References: <20260916182957.7788-1-brads@mainlining.org>
 <20260916182957.7788-5-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182957.7788-5-brads@mainlining.org>

On Wed 2026-09-16 18:29:55, Bradley Morgan wrote:
> nmi_panic() used to accept variable arguments until commit
> ebc41f20d77f ("panic: change nmi_panic from macro to function")
> flattened it to a final message string. vpanic() did not exist back
> then, so the function had to format through panic("%s", msg).
> 
> Bring the variable arguments back and format with vpanic() directly.
> The next patch makes nmi_panic() try the panic_force_cpu= redirect
> before claiming panic_cpu, which needs the arguments twice: once to
> format the message for the redirected CPU and once for vpanic() when
> no redirect happens. Passing a final string would lose that.

The reasoning is not correct. It would be perfectly fine to pass
the final string.

I would write something like:

<paste>
Bring the variable arguments back and format with vpanic() directly.
The next patch makes nmi_panic() try the panic_force_cpu= redirect before
claiming panic_cpu. panic_try_force_cpu() needs to print the message but
it is used also by panic() which accepts variable argument list.
The string could be formatted only when a CPU gets assigned to process
the redirection.  Otherwise, there might be a race when writing to
the `panic_force_buf`.
</paste>

> No current caller passes a string with format specifiers. The closest
> one is hpwdt_pretimeout(), which builds panic_msg with hex_byte_pack()
> and has only two variants, both plain strings. But the new __printf()
> annotation on nmi_panic() would warn with -Wformat-security there
> because the buffer is passed directly as the format argument, so
> switch it to nmi_panic(regs, "%s", panic_msg).
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
