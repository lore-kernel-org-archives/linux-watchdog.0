Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37F3C1976
	for <linux-watchdog@vger.kernel.org>; Tue,  3 Feb 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136565; cv=none; b=ONeEqgD0PK9A9EUooTiYsnu586VYydHDddDqeOIgvvOap2I298FaWKVITaxSHvyGFi2YpmH2KL711zAOAR6Us3QaoKvWvBiU2vdM5SX9c8+CHAKzEuOrtSdrprdXVdSaF3jU3X7aoCt+DkY7UpWgh6SUrRr9vGpek3Tu4IXKdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136565; c=relaxed/simple;
	bh=qap9S7WORoUubJqTBtETXU0xFt0az5wDCXk0PrXYzOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgXASsfJWzRlM7oUPql9M/wfGwD9ozJSdv+acG2g1CdWSTL9maDsG1s3SFxwAkm/3DsGP87195mHWbdDeZqFpjqdIpXuEuIJ4MAmplhf6HCXy4Yo7XRZnmiJeqmVHi9OPxA7uIZkZHc7pfbrAsYiUo8kd2MSK1j031b2pUqaqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VBt3hDo9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VBt3hDo9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d256c2e6so4697196f8f.3
        for <linux-watchdog@vger.kernel.org>; Tue, 03 Feb 2026 08:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770136561; x=1770741361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQuo/p5AInQk1R/8pvqh/pjovAKXDnSWHvDzZRsI+LE=;
        b=VBt3hDo9vGybANjrUkwXqw61AVGw+GKLWLzBalRMHC30ytCT/TyulnB7Its5Caic0y
         TDeSGPb16o50+O50oUF1ZJWqWswIFcQ8B4B265ftHqNKeOajGJjIpXG4m/bYkgU5lcsy
         DxmftfxirMJ9SnqJdwVE6NABPND8GB4wsjNEtGQ8f1MZpH8jpVySxLmfmcgrdg8YkjLq
         xqTPFxYk4LFKDg6/+L/uloaF1hPRtYlH0bUS5AThzCEep+xioywe90qDRdkpzZ+h48pu
         TM/JdZN8Zf7hiRuDweHSoDbuDp7iaITj/g8WdQmNaYZUb36u4AU6HEFrxAHJrWi56iYX
         9iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136561; x=1770741361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQuo/p5AInQk1R/8pvqh/pjovAKXDnSWHvDzZRsI+LE=;
        b=gsXiIWx/wjQSW3nrETqo++Lvzw5LFVAYsOXz2/icQiKonUpRaNTnlPVa1a/H106hpi
         cVBGatpd+GSZQi1aNh26cFZgNmlKBUTR5cE43qIsfNNlEhWeeY82hrDxsuq9DdBuqKZ3
         KOQushin5FR7Ml9sjxj54bEG4ih9dKe7L1RHmTypi25zZQS1oHGGb7o0A6Jh6b/IjC2z
         QctEj1yOtM+ZXiReXacdlVKYNVrmoj23FpKOJtUzaWvkwbzRB4sGBv5GSGfPQLPJ8JUE
         V4YS4Qra42i7bw0JHir1YToubIqiu1GaNNtwVPFIRRoiovAWYDT3AOu0UbXP4qzGB0js
         T6/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBVeBbeLG3R0xAkitNjw2yDSyYHO+1A5wtbcIgmgGU0Dg36P4mNVcjabYTGake7OovfvkqJgEzd92mCfqjxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIOlFCjquxKGF7zvvRnNXE8v30kIAI87lI9+QdsIqEOqPVcPe
	may5Kg48cVvBLk3/9y9IogmPKSWOsAg6Ld9lcIE4Jh8UIPJ1E6IQtQK78bhaR79LfDw=
X-Gm-Gg: AZuq6aLQcbcqHBm634WbmCIKs3TGYQnV+q8YrMu9NBsIIWU92gu3f48pnJrsfwEbFZY
	OLaHcpmtbF9pCeiA16/geebgf7U43lUSZX++q5FNMdVEjNoji4WQcNpRTLfoZk09nJK5Mg7D28T
	59OcciAgUnHzQfg69w9H/mxbbRmp/CxNWZMb2C6NpeY8v5xJyN0enH6kUrkCYEiFuwwlGMrF6/3
	S4trfk+PAzf8BZwH1OhaJCZUxxBS8LK7lPLrMlMgJDfflaWr0FYHQJkR5LpRp23yLxmWMyM9r3E
	1IYHV1JFaWV6zncVNC/hEgI+6AeXIAdF16HO8Rh8WJhhYrxXMsUlLK+TMbnoOCDZ4cM4XQ6Z6sv
	PF3tBnBc+4LPbkL7Wp8nxdG9VgrOPpojm2pMcnYZvw3dYl5FGBtgRh62ddEQ7BN3LRSc3mmHlhA
	eilKuWMl0sf8MD4g==
X-Received: by 2002:a05:6000:401e:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-435f3ad7646mr20374411f8f.55.1770136560693;
        Tue, 03 Feb 2026 08:36:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm51375458f8f.8.2026.02.03.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:36:00 -0800 (PST)
Date: Tue, 3 Feb 2026 17:35:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, mm-commits@vger.kernel.org,
	Shouxin Sun <sunshx@chinatelecom.cn>,
	Junnan Zhang <zhangjn11@chinatelecom.cn>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>, Song Liu <song@kernel.org>,
	stable@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] watchdog/hardlockup: Fix UAF in perf event cleanup
 due to migration race
Message-ID: <aYIj7BzCI46iz2wj@pathway.suse.cz>
References: <20260127022238.1182079-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127022238.1182079-1-realwujing@gmail.com>

On Mon 2026-01-26 21:22:24, Qiliang Yuan wrote:
> The hardlockup detector's probe path (watchdog_hardlockup_probe()) can
> be executed in a non-pinned context, such as during the asynchronous
> retry mechanism (lockup_detector_delay_init) which runs in a standard
> unbound workqueue.

[...]

> Refactor hardlockup_detector_event_create() to be stateless by returning
> the created perf_event pointer instead of directly modifying the per-cpu
> 'watchdog_ev' variable. This allows the probe logic to safely manage
> the temporary event. Use cpu_hotplug_disable() during the probe to ensure
> the target CPU remains valid throughout the check.
> 
> Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface for async model")
> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Cc: Song Liu <song@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Jinchao Wang <wangjinchao600@gmail.com>
> Cc: <stable@vger.kernel.org>

Please, do not remove people from Cc, especially when you send new
versions on such a rapid speed.

I was on Cc only for this version. There were no replies. I started
review just to realize that another 4 versions were sent within
a week and they got some proper review and v9 already ended in
linux-next...

Best Regards,
Petr
