Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D055427FC
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080138; cv=none; b=IcISYX8UeOaL8P3j57sXXa/HMoTz+e2jmqocDOdB6VowcuMh+p93NTX+igjLKooN86ppfBi39nXiPT0HABaHfnLvbdBKLHRJAUoN3e/AbCqRJW8Dtd/h2YAh1zBkS5Y5unKLidle53OhTD5ZQk9aqnjzD7ZmXOxMmAdNt4yTwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080138; c=relaxed/simple;
	bh=9ABO+5g8GIuYBF0nnHligbWWPyo0s+46M+0WjBQRVx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ/AVEGTPyVM/foJqRrnGvNyo0lyB65SQgY77DIkEVFGB6EdPa/FHlAjgvCHVZFtSWfJbNBFsixwBcZiqBPzSFadHEuVIzZHXKoOYi6JXLyDeA6fNaVL54KjrOPG6caCJ4cmfttBTi3T0W95fx9N1cnEijZc/6jUN++llZfjJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C7c4iJmN; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C7c4iJmN"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso30520185e9.2
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790080135; x=1790684935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lma8hu/u7D8IgJa55SniY71CokbrRGx7Xr4P9sp1efI=;
        b=C7c4iJmNIsshZAleyUJbs1u+RzYaTws1S2oC3WWQhG/qiLVE8XhDgVzEkuvnTgs9ek
         rNWLccOdBL1RH1kl1K7W+vf5BM3NOJkb+XEskHF8f4XiL8Td92f6sEShsxvSVuQUNBl1
         BZWEVTu1ZQXf65V15uTTj8axe0h2Cz6uBIyOw+2iltOoy0OOvVYb4J0esc8/IA8tO7M/
         5U2hAmJtJoy1OHo/43cnQk7Um1XfDRL39Q0V4cjWu1SuAqhq4Gb3lFwZ400lbYw82QNx
         jDtIQBUrxOeEdXg+g+uLkkVfMGRRwoG/gIzWd9l03mUt0m3pPVocEkT5g9hNPNq4Ao2K
         CSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080135; x=1790684935;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lma8hu/u7D8IgJa55SniY71CokbrRGx7Xr4P9sp1efI=;
        b=BDqSCqZOGxmm5rsRzQ8hlrxL9+/ssYxdLc9a7m6f9CKgohplRgHGq0rk2VWiEz+Iga
         3f8p253SmCGbEj4UU8CBywIjIZJ/oGRbzudndTo47J+QcigQ9RjZzMg+pZKPBUnhstr0
         glsmyol3UPG/CL5Ko3dqs/L2/EXgvfcO2rSjFscHdZCgnZM4L5sTCta967BK5xPDtdc1
         Ke0QJV1enUsTrdbXSggohWPCO6J2ilzYpFLaReXWzLE8CUljrchor2Rnkill2OJZZnig
         rxH0uQWzoYHOg0jWYKAh6efNa6uZB4L6aGO+cIOVhVPBPT2QMPt3bFSvDh2hgl0mAnM7
         tscg==
X-Forwarded-Encrypted: i=1; AKwUvBy3stz3I8wPuBKcQJX5dOjCujgQKWwL+W/mvdtjNWjvXv8ntAd+Io4SHD0ysNuxUAyWs+LlhYN1CERMfQOzcg==@vger.kernel.org
X-Gm-Message-State: AFuF++nJEQ4exs+oDpEJbwlbGgtxnABFX249y+vPO/he1SITCqsz7tBe
	sfGIHSkdpAingZ4Tfr/tVDYBa12V7y4GHBWdH4j/mclBAxw5LMQX9FQTFc8DeG53sV1f+dTvFJQ
	xkldn2NE=
X-Gm-Gg: AYBFou3lRsGD42d7a7OEN53V+IleY0BI56bIcoNSw/IeibKmyovQ9PnK8NzGlnxO3ss
	4sEHKloTKbi15GZfZFPkfsogTv5ibaaLYq/RSSRIJGjyHLUCE/J3Uy+aU8Lg/yE9D/lpA/NbhgJ
	mf+gVe50F9tOERD6rers4ELj1RTMjDHueLhnD2beT74HfmU2k1stkw/XiTphv8Uw0mJVf52M4Ao
	yyyC+q75oH6YNqhXzBXoGsQPf16XhW+P8phjuUuJQPVDet3mhIdCOJrYnUZ8bqWQhs6k+QCjBsT
	y5m3PxqIW/9X06ave76aA3+NFUaO+uWjmc8cmoOUX2zBjt1lwAN3eOEefOq0RpGDQyMv4RmI0zE
	hmzy+hJwdG4HpO4j5yCiMLlWuYSpPcYGcG1OaDWwlBwBhCLloltwU0L/vM9rEvq1+2PRen0INkQ
	BYk+dWy+J1irTaNCS6rj1Fxc9i4Z58o3fbBCODRF9AUFameHRa4n1EMCzcx2YIQ5TLdfrzC29m
X-Received: by 2002:a05:600c:4e50:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49fc5728f5amr177123735e9.17.1790080135184;
        Tue, 22 Sep 2026 05:28:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862774882sm4929582f8f.13.2026.09.22.05.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:28:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:28:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] panic: kill the "buffer unavailable" redirect
 fallback
Message-ID: <arJ0hE0bKWoIzYyG@pathway.suse.cz>
References: <20260916182957.7788-1-brads@mainlining.org>
 <20260916182957.7788-7-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182957.7788-7-brads@mainlining.org>

On Wed 2026-09-16 18:29:57, Bradley Morgan wrote:
> The redirect buffer is a disgusting terrible hack. panic_force_buf is
> kmalloc'ed in a late_initcall, and until then the redirect delivers
> this as the panic message:
> 
>   Redirected panic (buffer unavailable)
> 
> The whole point of the redirect is to hand the panic message to the
> target CPU, so the crash kernel boots knowing it panicked and not why.
> And that window is the entire boot, from the early_param to the
> late_initcall, which is exactly when you most want the message.
> 
> Make it a static 1KB buffer and kill the initcall. The cost is 1KB of
> .bss in SMP crash dump builds, and it is only ever touched when
> panic_force_cpu= is set anyway. The local msg variable is gone too,
> the buffer goes directly to panic_smp_redirect_cpu().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Look good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
