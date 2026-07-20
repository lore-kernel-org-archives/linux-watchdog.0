Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09163439332
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564885; cv=none; b=p+XiF14U64Kz0c8ukdf+Q85VqFW/Cm9WjgJJkU6L48wGay9WzEr5i234ICRRBPCW8e1YlJdHAX4h92vi+N/dax1tJpuuAHlFKW2JREVVYcg8T875LFYkB2qYzva5anEjEpgkLqxuJftJUV9H636puEiKADcoVoVq7DQmVLhNe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564885; c=relaxed/simple;
	bh=1ZYnCItsEf53czH/Yt7U9z9dgoM+8zUS7ecqxrdPRnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT4ewYYkrwzdV9fGZwLUNXJodmQ8znCdZp8qlVU+6Lg7inOOsQ/AnfyFaDCjmKIGwOQ1ueUzhI9gJxMi2jBME5wJqdUXBsiLz1xgfKF9vajaPMGvnn9+HfMqqp5YqOJQC9v+HH/gVOOuTBB5YcXxRDjM7Vk6FpWnwsyUQ70fnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc2lKJdm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc2lKJdm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso7219972a12.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564873; x=1785169673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4W2jyVT1aTCWIHlRWLpB726/kn7N4GCRmJiYxphtSys=;
        b=Hc2lKJdmCR6jcskuZS7nrpvq3i6L8dQmBreapCs3i4glM/xXECMuKeCyn4JJil2m/H
         Li1NSZIx+c0S5jiHvO33KAGKoEpV9yE2ZkzgGmZw8uU04HnXgSKLoYnbdZJWO4AKBMdJ
         TFxnoR5S1w8CqD/ezbeOB9I8L+NNBKUMB3IdYE4r24RBqDGKs/R2kAi+EJHm7AHZkD/y
         YNAQCsrnWrtKruqEDFuTBcNWLYIqHsRXkHtDsNOar0kZ/JzU6pfq2LsGSdOkxhzD3Fqj
         pIN8QnuSHggLBg56ZgoLKrqulFiNt8bJgkXo2bF+4GQK1axSWM1lY76n98n5NvV8GbE1
         OpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564873; x=1785169673;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4W2jyVT1aTCWIHlRWLpB726/kn7N4GCRmJiYxphtSys=;
        b=iqmi2s6Husz+xU2aKZV4vZR4G6vpCHewulKMik97eLwhOFqCdR+C1wEIglp7PCUkGF
         9Dbr1glLW/BeQhtwyDCr6fi6yN1qncskbtocPItLQSKnUIzI1m9lfDfjWRJoEt2+S/Wj
         iSJ1iR8/2KYxSelPZ7hp+8QP6J4+YRgHw+ix3Lea1qvKHbSkY3G9iUJiuXMDAbTn9ytO
         ZzGNYVteCPR1jHcqUa9tXeV68mF39jF0yNqy+VTY8Su/XW0DWgDBJXpSBZVYAu73lNcM
         sZJ/tqAbIYbeiAyTxkTbM/GCaVW9/LVZBJpSN5bp4rc0io4UoIyRMdZLuzfIzk8YBdtI
         FUvA==
X-Forwarded-Encrypted: i=1; AHgh+RrrlRrZ+T3op93jaiJ764V4uQ6XMwTpjYC1UxfG6PXBcqyoB0Pw0qg1Lwk7y3vNXAuy+742q3Cv3nsodlzTeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9USk+WLl3YDxuOleq2EWXo6WZkiH/c7LZApJRNPNKDtO8zMKo
	0ktUp5Y5SefdNcMDgl5/hhRIB2STricK6EARS4kGaEBm8cIfLGsAHwqb
X-Gm-Gg: AfdE7clssQzeP8ri9S1eiDYIWuAgtwZp+P3fHMAh9U7xMyvR+LLKCUVa4gee84QitFB
	e3JTElmrLTtg0qD8HQuY9rFswu2vpod8H8sxkGyCyJQ0QchMIxT3UGBdpFflgQYF/tJXADV0pWW
	Kf1ERNUoyOBME8DTp/xeB/4vyGFzJ9Pumtnas421zemPFwIqV9fIXXLTJMer+CPJYn1H9eqn2DT
	EQ18TkF775zlgB39lL4EL2Q56bNmN3bUdawPBXQUJqglVwPAw388LPUWVEBca879Q7WibcRQ/mm
	16HVLxZ/oXl7Iyuk6PV58rlMDFnj9xyPHyfM71dhQLBHIlyifrMiM71rfDH6cCd2+sEwCBTfVNz
	51QhULvifDnY6Vs7xyhcM4ddnXHPBiIYM8m4qn0DkEseBTJIBGStnvVvKh/WlPafjiosbeIvJqb
	QCl5YCIvqLWhq+a3Nz+01AXfmDpw==
X-Received: by 2002:a05:6a21:d8c:b0:3c3:9c95:c0f1 with SMTP id adf61e73a8af0-3c3ad8ecbe0mr16967869637.41.1784564873076;
        Mon, 20 Jul 2026 09:27:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm41332810eec.29.2026.07.20.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:27:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:27:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: take all OF aliases into account when
 assigning id
Message-ID: <01b789bf-d394-4068-9e27-5555b9498eba@roeck-us.net>
References: <20260714105356.2931450-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714105356.2931450-1-linux@rasmusvillemoes.dk>

On Tue, Jul 14, 2026 at 12:53:56PM +0200, Rasmus Villemoes wrote:
> If some, but not all, watchdog devices have device tree aliases, those
> without aliases might (depending on probe order) be assigned an id
> which would otherwise be assigned to one of those with an alias.
> 
> This is problematic when for example watchdog0 is an alias for an
> always-running gpio watchdog that userspace must handle, but the SOC's
> watchdog device(s) get probed first and thus one of those become
> /dev/watchdog0, and then at some point later, the gpio watchdog device
> gets probed and becomes /dev/watchdog5.
> 
> Ensure that ids for devices without a device tree alias are allocated
> from among those where no watchdogX alias exists.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied.

Thanks,
Guenter
