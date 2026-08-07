Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF94B04B3
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074605; cv=none; b=SXCselO1qRc8aJVQG9aTEQkACgqnN8xR92e35aMdcgK1vuOi+/e/Qfuam9j6spN1XqhIIBchiCeC6DhYd3uMWNwCTbI/Z/FZu1yBYmJcsUKSNvK5FkFpYOMmNG3VV29mib1M1TTZMxphvsbmhSSRZuvCpUGx85wF0kviZ4VfMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074605; c=relaxed/simple;
	bh=AY/i+ndZYsAgbQVUtTgf00z+ioZgl7iG7Nhbst5NHM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGgOzSYrv3HLyYDoMnbTOZL8rF4WpL8RAM+u7aQGouAeCHIFP5vFDS9UR3H/KjET4bzhzJnLOXUis8XZ8w1HIPY1uBiFOfSm0ZNcRbGjDWvdRnU0NyXd3c7qTkbu/4dx7WmXMXGBDobhcsQBAz6IhQqWVgZYqiQHu3XTGMcg9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdvOiqNq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdvOiqNq"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2283490a12.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 20:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074603; x=1786679403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7mVd0/DBn4tPXRGTHhnVYEwoos7WeBvVC5LAl4wKORM=;
        b=ZdvOiqNqNo4CCqumLCNnhSGorG9LiJBv3Dk89mTqcrv+i4DXA148odDhavfTw74lMz
         +ey1NRWLnJ8duK/Km979WwfnYsAXF57+6594mOj2p1NHVzZ40DihoXHyqpf/oVLkEjjj
         TFK7P4xWO4Ei1wo2+G3r2OVAtlv/Cxoj6J9baEHKkKo+VwgMtOrktFYn8g0zXwUXE9fL
         ODHcNWktVcI++1zIlOFK5qEnZeiL7/neuxfbI7dTTQVmeMjQ6cD5RBihMTwnC81JaHNI
         B7TNlaoFx7Vls32evO+a/lU4iuqwV77b92DGxYv1wK6Xr0W3urdlpc5b2DgIYiCbNwiF
         lhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074603; x=1786679403;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7mVd0/DBn4tPXRGTHhnVYEwoos7WeBvVC5LAl4wKORM=;
        b=FuKzZ75lPwi4WptOP2lx+hzb/RsbIp/6w81xIWiU/O8SfKhpjTU4tnerqu8BuZ+pv+
         wWtosjV8NGDTrNojvHRgtOxzn6lfML2sYeRDGMz3/p7eKiY8pihYwUHJUTnp/5jnezqX
         edM93gMaDG2AN6NdycNOH0z2tc97Tk68sksnXVJADOim9sgAhsqkMJ5/l77du34p/fW0
         6McBJOKiaVMmaRLiVUat9zL6iUixqpBuCuiRX6JWlPQzqxRR9gJiv/Q+n3Yraz06LURS
         PUyCBEcCzSpx5gX7o7OEAGgEI2Y8nhuLTvWHeIbhH4SluEt5JDi2qtfn9vbWPyepfC/W
         3Ciw==
X-Forwarded-Encrypted: i=1; AHgh+RrkUVLIAXnzb9w6gj2KoNxqF8a/nfofMk9P91KyfossW2rI2skU0+jNRX9ZhbXP9X38rWjxsjUUgAHft9xByw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuM9JQqFFDeTxy4TnCFhnQggN2AN6PLdsjBDzcgOKGm5u6FZ5l
	pzzh7gtayDdANhJ2AVEW0aywLc9e4Fu6DkUhT+nmfQxsmHp5kWQ9q5kk
X-Gm-Gg: AR+sD13DZWdRWn34ywTr1SZFXM27UzEbOqG0B2BMQIkpAhaRK4rnXRQRIZKvualJN0m
	bownCJkwq7DvIZpRK1ntqiquvoVN763P9YFWEbHIt64uuh7dhC2d5FVF2T2MStGMC1HWnKH1xo9
	CfpWchsb+21iOZM7jqlPMReDRTuBGZ40MZA/YbB1PU+N7TbajBYav40pF2PmEsJZnG7/sCHpcvy
	DvigLafNMeeF2Ptc21yuZZAv/O7OT+VZvEpmvBBiwa8mRPeIxM42nIpJxvicieRv6uTKE3ATATv
	sDjvkjIrbZjZHORwQxezL9S1oBwQI5y+4eaq6BFAgP26WkKbfEF3DiUBL5vw7Q6QJLnFDInJss1
	Dpd2ohH0usXrjX2CWPb+pvulND7N1raMLUFUYaGJrxR877JKCKEW5mmlQlwX/JrRxoe9P/9BFfG
	vb5lm/Hypc8bmrkGdVw92kI3EvyWOMLL67YuwEryCjJJWIrpe4X0W4Z4npScKqu5Z08PXm6zrpX
	A==
X-Received: by 2002:a05:6a00:32c7:b0:846:7507:4e07 with SMTP id d2e1a72fcca58-84f2e134696mr24447347b3a.39.1786074603502;
        Thu, 06 Aug 2026 20:50:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1a9f84sm8348a12.8.2026.08.06.20.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:50:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 20:50:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mayank Rungta <mrungta@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] nmi: Export CPU backtrace APIs for loadable modules
Message-ID: <472ddbce-2b70-489d-9af6-03f8aa188b04@roeck-us.net>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
 <20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>

On Thu, Jul 30, 2026 at 03:00:21PM -0700, Mayank Rungta wrote:
> From: Mayank Rungta <mrungta@google.com>
> 
> Currently, CPU backtrace functions cannot be called from loadable
> modules because the underlying helper arch_trigger_cpumask_backtrace()
> is not exported.
> 
> Instead of exporting arch_trigger_cpumask_backtrace() individually
> across every supported architecture, introduce and export a common
> helper, cpumask_backtrace(), in lib/nmi_backtrace.c. Update the four
> inline CPU backtrace macros in include/linux/nmi.h to route through this
> centralized helper.
> 
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

Applied.

Thanks,
Guenter
