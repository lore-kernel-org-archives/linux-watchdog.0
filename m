Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D83F0AB8
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080560; cv=none; b=GQFqS2rq+G4CCAV0/Q9a903o6dkzuoYC6m4VwMYX4x6jXMByyLLEQx5Sw1rRVP6icd0TGp+T4sruAUeDYWmc54Unf/48gsc28/XeaYiOuVeYMwomUxac8mn5fU5MYTVYlb1n59OpS8tokxHrS2lGz9iISiy+J7vaajWoS1d/JCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080560; c=relaxed/simple;
	bh=FHcE3cZ6fwiMxVpjYkw+FYvWo6dydU6bYcNdLdIYu54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmY3KlEz5Jd5n0T1PZXCo3laeZaP8qwd3l3LLBUgRBQG6ocpl/AIpYz9HdVAyx5j9wjOUEBj/4gASC5ITevHq72oFGVH98CqTtUTXfndIG/gYHs0XdvheY/a0wrxw7HkHuyXOXat3P1Lq6AnrW9L7NJ7174l0nKIxhpVOK3A40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C9Q1dLPl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C9Q1dLPl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso29633675e9.0
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790080557; x=1790685357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FHcE3cZ6fwiMxVpjYkw+FYvWo6dydU6bYcNdLdIYu54=;
        b=C9Q1dLPlTIqKTQXe4iQtNDUzZAlq2GTJ2d8qKPzvB/DAXYTioASUz3akGBtO7GbGJW
         q7bmos8QtDnMiMlmiZzziW4Bq5LbD5n8meCGy7ttIUY4yRN6YqLYw4wOXnd0IaOiAOcM
         gvv10G47j61rSKzhIyW36r6dkrRD9M8kOHqsYl0Se/Cr2ElQFN79Qwp1cGw9yDiOGJpx
         yiaWLUkjrX9wjOBlFDPjCwPpVUhsHnIp5hDL1VV9r+WO27fyMTbn2utt8/KnBWWKdPfe
         bYYh2WaTtcSfQRRE4x/yBJ/7bATe0xwNAqM/N0LPP3G7+HByHKQc7g66bESKhn27XYmX
         Fk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080557; x=1790685357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHcE3cZ6fwiMxVpjYkw+FYvWo6dydU6bYcNdLdIYu54=;
        b=0aAU+0hQurSykFvoVYk3RDobMUvxcvoNxr08e8r9gCFKiWVUfhGj6p8yDsFanhFRuN
         4baVWl+MkGYf06P1miUV8Az4gW5KjNUSjh25HvtWKugZhzn9dmzrlG7cFO+llvS3VBPD
         uqDearVkeZ+AUCuXUrPFgsd+mrM3opSPlewyaFjKG7wkErsqILuAufub4+bdYrV9xrMX
         sYx3dm2PAaaA/CRS5vdS98vZXmo3TwqAM7P7cCVCZOh7+f+FjFXfZO72W7O6j2rSZB3i
         Gt4amoVFno1B1xqxgCJbRD5TLSyLBuEd//StxszW+67UycFQREYgI3vX/mn/YawUO0OF
         DfKw==
X-Forwarded-Encrypted: i=1; AKwUvBzNyBF0RlI16d0Ja6W39Dxw7VkeNXhLyEfnPQWjcofdjaldDuQd6E4KTrMMeMDiJxpi4Vxuw5m9ez79RmTvWg==@vger.kernel.org
X-Gm-Message-State: AFuF++mmGXj3EpMZiKtlDWSFYxMu4IRXLfbCOkT8iftX4le1eYzxkitl
	P/AEWSZgFiNbuQBYffuA3uHtCiw8jE6wYnwwgnj45RNJORZGnHj6L6XA7wqPK9TbvHQ=
X-Gm-Gg: AYBFou3SSDnF5peVtmtgD+9xz5l56TBxRSX/4rIS5guzJ6gft3aAKg0hngRrmjr/9Vy
	8x/7L7mqTsbUvxFbId6/vFP//FeIC/xxri+FwvDj+sADikuQR2cdY1Itd4V7j52hazSTURbysog
	Sn9fk6SjxPamuH8FvFfN7ViKvccY5a2HwPnMDL3sSxy2fxYDv6R9ZjbBlY/MBkNem32sMSjThRI
	FrO6NCatxfPl52MDqApZgv9gbK/odicvolopBivQ7S71hP9fYyaeAubw2FoXuSKHvKm/1kqlucu
	hpQQHFFfl/oDJX7O3/O/2Uy9WRyDSZ5wyHnRXx7+3uv79X6M8/gJdK3N5OEtbLkll3ABpcNlk0L
	pk7TFSL/fSZxWhkGvpEhQNdS2X8N73xlo3LXXS1xyKOYsP+t5I+p9wEKAIDOfvJX0QFo5ikh+Qz
	m0VYHDu/L9CN5VxMHiDhQCT1WMk2DfvFES8Xa7lC2OkmT6PsK01NjAVCm22SHwK46GbASbvinH
X-Received: by 2002:a05:600c:154c:b0:49f:c451:b4ab with SMTP id 5b1f17b1804b1-49fc5743c34mr186953035e9.29.1790080556773;
        Tue, 22 Sep 2026 05:35:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad40b32sm41331985e9.9.2026.09.22.05.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:35:56 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:35:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] panic: fix panic_force_cpu= redirect races and
 NMI bypass
Message-ID: <arJ2KqCA7aBgt71r@pathway.suse.cz>
References: <20260916182957.7788-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182957.7788-1-brads@mainlining.org>

On Wed 2026-09-16 18:29:51, Bradley Morgan wrote:
> The panic_force_cpu= parameter redirects a panic to a specific CPU so
> the crash kernel runs there. The redirect code in panic_try_force_cpu()
> had two races and an NMI bypass, all found by Sashiko. This series
> closes them and kills one more hack that the rework turned up.

IMHO, this version is ready to go. It would be great to fix the commit
message in the 4th patch but I think that Andrew could do the fixup.

Best Regards,
Petr
