Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2749375F87
	for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142181; cv=none; b=bXbcIfhZ1pc/BpHrKXBN2Lz0BvDDAhaJ/HLqXkRWt39uvSCpPNQ6nVGCJWezcQLfShAV5M5NLPFPkG1XeFJseWHVIjty3Q7cOzwNzg5dhNscs8eqCbHGO25VUvYGg367DSLgld0oUlS0wMvq5h8UMxZlUUPwYZOLTUgiRAvfPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142181; c=relaxed/simple;
	bh=c8wwsmifyb2pL3pRoyxMkh0iiOmUNLcnkaqNgFLh19k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAFZyE6m3dA61EL/Wc/Z+HJFoc4cIVQDscamFZOkqMZK6l/v829DbNInGQ3HDgI/oj3EehSRknXq/rkd3MePU97eee9weIkexvOu0W+HrpTIj4SYlSjkjkhcuzka99JKvSyB+HSdIHJAy2eKQDlei7D6wID36V9gLgssM9ZpZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cec6CAua; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lM1sVt4+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cec6CAua";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lM1sVt4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782142178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZv8lf2HlFMbPq29wrkvMcL46ITw+rgkk0A4gwUgT7k=;
	b=Cec6CAuajmg3HjYKL5W0ndK6Phu8QSGuuFiayqN8E2XB6mFgNGX9rC8wekotGwK6Er5Lbz
	t4hf7DoWcYSXoV8YkQl+5PNgzEKs7tUDYx8co2HJy30D4OKWk7JKefXS5SNtrRO+6HuOM+
	JF2GNURGJmjFflMb/mn78O6U04coZtc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-eOT9hU7_OJq8DutO11-mYA-1; Mon, 22 Jun 2026 11:29:37 -0400
X-MC-Unique: eOT9hU7_OJq8DutO11-mYA-1
X-Mimecast-MFC-AGG-ID: eOT9hU7_OJq8DutO11-mYA_1782142177
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51956be1f44so105250451cf.1
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782142177; x=1782746977; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZv8lf2HlFMbPq29wrkvMcL46ITw+rgkk0A4gwUgT7k=;
        b=lM1sVt4+mmMVnuAu/WAWEIRZoEyBk0Qm6UjTclXBqDXV4dqzAFkBIQ41UUM9t85ABC
         cpF2w+RtGgvxC82DSjAMr9876nn1JUFRBqDTi5a/rI7DpHWxbC6lgsrIDF7a+3E89Uic
         nvDB9HahItPbNjByUzWJniLNHPHr9WbpxQn9zvBgUF9DeyS41Gcvlv1bGrUwrtFYkDdY
         TVOJod798r0X1E85jTyzrT0dDJmspLLV3mblF3Nd7gpUr71KywGDekpeRl18VJPpDQd8
         bnmuZ1jBWsDf2NNY4DGMIdqMQxBy4zak6lxLEBV2d0dslKXAQMxBrQw2ojLgjAgy6+Z/
         rk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142177; x=1782746977;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZv8lf2HlFMbPq29wrkvMcL46ITw+rgkk0A4gwUgT7k=;
        b=Ub9A40hK+t7A8HR42cF+0qoi9pJ/z2say9X94rJzCPKsH8BeHA76RqlOrNMwxPNE4j
         9pZkQxSse0HixGtnVGlqoB4KMbVTQakSBefom1JV6O4vYq8fysnoIajwsoo9+vOr70ez
         SwRFb43cPds4tMIR1Hh8njLNffiTE5fE14PsUtC11ilI15yRLHXMKQml1GhPHkWx2rDc
         5VuCJNQzGK4xmWP0jA0XuVe9HnLMv/hKlgroJ/0+x18AQqxN+Alzkp0mZmv0gCmM0ewp
         MmnSZy6AfJs0oXde/yjJm47k4gJUsXxtHidJNuicSlSgan67hr0VGM8aGTWVqoA2YtkU
         WR/A==
X-Forwarded-Encrypted: i=1; AFNElJ/wWJ57nMTW2LnhrE3If9Z0rBMOsGp236XrWcejDTGlUUXA77rYuXPlP2omMaMWAG2uHGGL+xVm7mLAFcM2yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuFT/SsAztrT8vahm5sfLbjob9PKc29lCR/rFh6UCqXWV4X8f
	pRRO3fZDL0nRFJnIrgdlh/atl5+daDA4hsGu34TdHNdW+d/iTbI1EyW0ZVZJ/OdPH15EPddJZCf
	8jN8sJ8Khi0zoLJHsVE+eUO5QP72eAnJZamtrU2wXkWw4+nrxHlHYO7CCVEFCw2KMsze5
X-Gm-Gg: AfdE7cmQx9LMsW7HjpX0+aDv/jQ0FMcBUbRdM9zBi4Yd1PjkEYBQ0ENA/8TUkKVYZIp
	5MAPlTkf64dFD/dnhgm3LOSPQ8lybLqn1bdz9W6gVhqLd0YaOy3h54g6NyTZBmWVnaheVkkOh/H
	S2NRa1qtTx/WmRQPbqJz1228vZS5MOzEJ22t9Zuc6EKZznwClqn9G1i5WzSvzE08ruNhlm3nCqc
	8P7BX856n7NiNHKoHmrOa0FM3On7ARVlj1KHNRiWH0dvXXjjl/40q53iWGWhseoas4Hh338UDLD
	y1nkxRNPF4LC8m01gn0aRN92a1saPFjDBG2BRLoqoMY8En0oL6mysAGNxVzUjJt3xd1ikhQLGdl
	yNGV28oUjArlLmNpOUVL1nk1z7uojVyASR9idUptOXbMCgA==
X-Received: by 2002:a05:622a:946:20b0:517:2a93:474a with SMTP id d75a77b69052e-51a514b9349mr336071cf.0.1782142176777;
        Mon, 22 Jun 2026 08:29:36 -0700 (PDT)
X-Received: by 2002:a05:622a:946:20b0:517:2a93:474a with SMTP id d75a77b69052e-51a514b9349mr335711cf.0.1782142176280;
        Mon, 22 Jun 2026 08:29:36 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0984da98sm70349361cf.15.2026.06.22.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:29:35 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:29:32 -0400
From: Brian Masney <bmasney@redhat.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-sound@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: Fold dbx500 header into db8500
Message-ID: <ajlU3AsNUeviLuj8@redhat.com>
References: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Fri, Jun 19, 2026 at 10:27:10PM +0200, Linus Walleij wrote:
> Move the DBx500 PRCMU definitions into the DB8500 PRCMU
> header and delete the wrapper header.
> 
> Convert users of simple PRCMU wrappers to call the DB8500 helpers
> directly.
> 
> The dbx500-prcmu.h header was the result of an earlier attempt to
> abstract several DBx5x SoC PRCMU units to use the same abstract
> header. They are deleted from the kernel and this is not just
> causing maintenance burden and build errors.
> 
> The stub code is using -ENOSYS in a way checkpatch complains about
> so replace these with -EINVAL while we're at it.
> 
> Assisted-by: Codex:gpt-5-5
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606180825.vUSQntkJ-lkp@intel.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>

For clk:

Acked-by: Brian Masney <bmasney@redhat.com>

