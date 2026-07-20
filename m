Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDD43B49B
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564083; cv=none; b=Bu0zYu1DSreFCEOOzp/luj+daSzPGUZZcvqTbR0UCPZCcfss0cUjphMPEmczLbRc5JvjMP7r5iiruFBAWDZsPbZLkF6yAO71ymNU5yxQ/hasEtyNODsqWyKvD5G+N3m35yY0dqaKbWPRWrr9ItL5pBFAlQpMqNpzbOMuDIL19w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564083; c=relaxed/simple;
	bh=+cFjyRMEn2voIvnlGBPMebpOM9IzX5EIQ6ziVf5zhtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN8nEZlNZbC34F4MIAswnW4vadU5doVVubVFVH9Lg4cqZjFVjhu+kFgx3NCl926tHjCbKfP9RQAkMEvVocfxZAY0MwBbsySGgcWijfxr8eBKSqZMNL0ph4dCcnWZ7dgnpwjn5O+RkoCfmxzMCUiTtKMIQKVs6ZvrReyC4KpzrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbBsbG4X; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbBsbG4X"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dcbade417so8461486a91.1
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564073; x=1785168873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sQLOHmb/4MK04lvsSVOzvC21hOEOT/YShVhB4Hbys5k=;
        b=XbBsbG4XTWqs2UJWxgD7Qwj3uKoMAaK2tWcwzbU5KNr8oS2Zzv6UERMRU1KUKwh4cx
         B+L6JllAZ0qP5rCvpzKIZPPGSCQM9MOoe7L4STd21fXEQsrcxMzefe3NUS+l9vachoNP
         3gQn471KfQjPLQFubu6cFSE8ePPnb+KZ6pgQ1JXgBbkTkb87muVR1VK9OXCoUE+Gc6zH
         Uw15AL98p2i7GhxRoPg4ZWRmH3LCI9CBkq35xN/UC8HuUL2BlLn7O3Jo8CEn9XR9pHxS
         sXqHjC23YGEXhcC/bf1EZKAIyk6CS/Nq+1U3/rEZrMQClAY3Up/h520OUWx1HFE3yyyr
         OXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564073; x=1785168873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQLOHmb/4MK04lvsSVOzvC21hOEOT/YShVhB4Hbys5k=;
        b=QERyDuWtCpS34cqllNs1nCpvyaZAHhRVEYidfJm+Eji/h2xnJfv1hYc1fSyUyHxORc
         pUmniyFT+lfG9t9QN+RrxHxpNVZbNAfMHJ06XSH/ctjD+A8jlh/SBRxM52oqUr6rDkt5
         dVudv2AenBjE9vIGyxlwPChv6kU87/RzWJYmr2UpYIooAMxb9ucfApwBtqnbv49viOoQ
         KP2B2Ekab9Ab+61P0Y7CrvQREYJEHMhxKYPJoj9+wRXyQ9Dz+TI601TNumN4RQwdX4lE
         /Coj9m+DecFv1gNXnqZXoFod+mnS4sPgvvYEwuGd9A4PP8NynrPavnJdaOJvGNGDlIuB
         8+fA==
X-Forwarded-Encrypted: i=1; AHgh+RqvWSLKIQbiKfSbGKERveyfSnyD4zb/3o7TyeEINUNHifU7g2WmBzKG5MB6/rQv+924TkICqoabmQJF/lJSSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLUCry7jqbYdXtxdYe0o1W3lVt+RwItRe6jWgjcY2mPX5Vy+f
	nqQZe/575wPMG/XzSn2W8wro1CGSIZfZKfDTOZFXhwSQz/dFZduwFxe1
X-Gm-Gg: AR+sD10kxYu5c6SkxrT0E36bpOsJICeB/f24sjO0fFRKYb7+CsdNmi7JnhakD1/u8Zb
	ubTTYTgeUo1xAt0ikLn8XVBK2zSENSb6dh/8N9VuvDd+1fnZP8xcBHMjgiKnJ9WOq/BGzYUDAWC
	GLgLmScct/J7TfySNuJuz85SADgM3HxKpHFtBMKY1+W0hIYhUlJHKNweKaL+AR1kcB5g8FPXlp2
	nuF2u2lr/Cwlv2QyZjal6BIkEy7lk7DCH6aLvYD7jIRCFOEBUCn/13gCSxzUVK6jFwyuVUPZPZ3
	WYINFYRbYwM1GiCt85B0uZuP9rpbeb54ad/H3n6a9fpNJwxocrPYqkBFmCsjGT4gVsd5uJCThti
	vw/Y23DgUi7IzU1kh+xWyJVNaSEGL6Dftf2EdoAqmx354+nujBUuiK/XALraZxylucfrom5E0SG
	RTEI7hh79HXTwst86omHJNpdd3BA==
X-Received: by 2002:a17:90b:4430:b0:38e:63c6:4868 with SMTP id 98e67ed59e1d1-38e63c697b4mr6887344a91.14.1784564073381;
        Mon, 20 Jul 2026 09:14:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2de31a7sm32746520c88.15.2026.07.20.09.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:14:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:14:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rustam Adilov <adilov@disroot.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sander Vanheule <sander@svanheule.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] watchdog: realtek-otto: Change to use regmap API
Message-ID: <9c6d3485-f250-4ac2-aea4-f330f85d534f@roeck-us.net>
References: <20260710074316.46643-1-adilov@disroot.org>
 <20260710074316.46643-2-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710074316.46643-2-adilov@disroot.org>

On Fri, Jul 10, 2026 at 12:43:16PM +0500, Rustam Adilov wrote:
> To make the realtek watchdog driver functional when SWAP_IO_SPACE
> config is enabled, change all of the register access to be done
> by regmap API which helps us to tweak endianness with big-endian
> or little-endian property from within the device tree node.
> 
> Add the REGMAP_MMIO as a select to REALTEK_OTTO_WDT now that the
> regmap is used.
> 
> Signed-off-by: Rustam Adilov <adilov@disroot.org>

The issues reported by Sashiko are pre-existing, so I am going
to apply this patch.

Thanks,
Guenter
