Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1D2EF653
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786329510; cv=pass; b=LHDzl9Uu9EaO2ZCvTA/CgfhIBUNqrseyszGllogvcbFyHhmS/EXTtCmB+OMckKNZEre5399PaxnA2HbFruKV+X3a6ZdtRu5DuNChfK2eNj4AX9Vdv985qCI20QhxM5N45w++s+Rj9F65MUpHg7nCs6Vx7ueD127r7Jo+IhxoPKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786329510; c=relaxed/simple;
	bh=vpKqiOCkUSHM8zuiw76Mu/tNq2+x3wFEom9OX0Zzuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPs9oXB4fN94zGOkcyZIhE/DyFrdrrxy0l6qlvKE7/d0IEjhO+fIT5MHU9Q8X+FBpUOHL30iUiP6qS7+D1oTlhZhUWGRvw+gtIzEXUHSMybt9/oRvY1sCvDizobGkAaJh/cFWnqdTs/Xi7KaF8kM8KRlFnW284YykUIIHJURSwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tICSzVuC; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tICSzVuC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf52d15d88so10402795ad.2
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 19:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786329509; cv=none;
        d=google.com; s=arc-20260327;
        b=iCtWqHeJ9IpzN8q7azUQ79HNzB3v1Zyyg8m6nCnfP9K6TWLeXhRH+T+OPlUCwGRG80
         FQbClhaHIat/Kwj+rbh7MPWz+OqpQdGV/R8VMuvoRkmwxkg6Vl7VJFiyRz3kl7qJw+RE
         Cb4kCfQ2wfMaS3rjBmHYqxs6OwQ/oIB+8kNBYP9EOIhQxXohKWGMWWJeDt0LFWbi0f5v
         Fzgn+pgcUAb22Ve5TscKJtyLQ9DpZA5aFfgDpt9UiTieBrC9GsbRQKYsmksnrxFnwJMa
         p//CKTLHjgVmr8Pv4cyrC5zBYzXCQ50LylI1WEEKtm06LgDkMt4zUzQvRx6IyxHTzGoO
         4lQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
        fh=W5YQ4VF/MvT9VEhAyQ7ae06iv9LUbs0cgHMO3+emDzI=;
        b=T1fKGF5G3a5SDsAEJ9y9oaKBaEp2PQ3wmQPPS0N8V6Mmf3weyogQIYyeCuQgPXaweS
         tX4ZrgKR352pKLznz0YwWG/gRSKYSDGzfdppYsY+8Hj4FdElcbk9zkJGPxcaYufm+u22
         XqufZwdu85/iOfDorspTV/ymYw2D9lDcGRY7LHI1qMqPIEfXJEOK4Q4UOYSisBunxEZW
         dCLu9urh/CJcDIZU/TJQQ6kQwDaTS1lzAC5jPJ3dM9vCHilB2KElgJjkGy3OeASssJtx
         mNRXQ/LK906A1UyD5qY6G914Y/g54zSZM/SEyXxD3BxoPKCZjWuKbtv8kZwSMCc6X/J1
         BRPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786329509; x=1786934309; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
        b=tICSzVuC/lTgjQiS6ygZqFpEl1jS8P73NUjK0BWwiwxt4pvy8K7hAs3zEdSx00CWEk
         LXO+9ZfHMyp2ZbwrPYGcLv5A4efOrsxqfsuvy6msD4gxYAJraGmb7sZZZb0THbh2LjoE
         qED6RI0Lw7CYaZOB+nitPZeEtIg8BANvCsKduZ6e+eb+SNx8COx3SBASN2u7oHy7aMq7
         MV8xZAmqG3eYAK0VgnBEw5ptcoS05I3kjtBeuwP0q4nvy9DnULE1c/BSJxcE/0h00qE2
         IRd1UgwdNTTMO0ysvKXBrnD6QMyvCZu95dSCLVgkPTYjGzgWTXdimIdh9kKVcXVfKfp7
         XkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786329509; x=1786934309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
        b=i836pUksHswVVxgZiJpD07tfy//SN/Pm5R+WLTVDvqHSHTenyzJUyXArGSRxwUWr8/
         1yvkzbaATnB42hxrPQPdTadQ7e5Ckj6sOCyB6bZ/yoANXSdvvuuludF2rZ9ARlE2su6o
         72JjByDChm1dVxm31Jcfl9D5lx4uOTNh3j9iUU1L3PzefTvcH7ZfR2HpStQfdGS+5fyy
         O/1j+u0+mtsNnTrfRasuang5EksjTHv2DVCmXk1K0+IBCihxX1Bdx4ArTjqqDJTdQTkN
         QFqgh+DdHOCWPoOASw8tbGN2KNpcAw5ObN+Uqf0ndtff/EEi/u4DpFqXLC0AdfxjfUaO
         N/sA==
X-Forwarded-Encrypted: i=1; AHgh+Rr27hzxlJKGQZUsjvkssGuqq4yeFgUpmWo6vcjvUzG39Ah5cl2HjGa5oDEMZVbutfjm+HPKx9h8LQf0TNey9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxommYQ/ggKkjlvkD8zAS8wsyMsDgIK0LZMP7LekI2U/rn6PWR8
	9vNgOMH42LjJ3CKNf7+U1yIOk6HH43Bi9rT0f0CvOKtiKkVaLEP30F9H0YjTlXq07zsYnYLKGor
	RXym5ZmV4nTJxOZbCERIFzyh0Sk0Xdgo=
X-Gm-Gg: AR+sD137f0u6ZTrBDfn+M74M0gxfI7ZDorpxzsWviZXo/We94XAi6h/U5lC5c4R2lzr
	QHIe7bNmpWjRe191nzcqEeXzXFCkm4VoCCouPtxteWQlX+Z8ZUdagnyA5U6ZryLGOqVmkfm2437
	VrgHFRZC0EEOZFHedMMvk+2E2sgIX1nFrdq7kq6W2vnHFi6BlXjXi6VOhLeUl1EVRnxmpysn+TU
	2akp5ajcA3Y/B9lagHIS6uOAt5T3khVutzIpHvc3ia1FuCDTk36YO8VJ8hhOmJ9EiUjQ1PARToY
	o79Zuk+e653PaFCyfbRzY2cLbD0e8Vv5Im3U+gektuNxld6IvASJ2QRGnyybSCkZH/GsMDnXijV
	XZi2snRPvNBUvcor9CbXz1+/HUR8XE9XFa9WrKN+9zzntppBPkUUbl9nq
X-Received: by 2002:a17:902:d58e:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2d2a8d1d97dmr211697695ad.14.1786329508803; Sun, 09 Aug 2026
 19:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
In-Reply-To: <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 09:38:17 +0700
X-Gm-Features: AUfX_myaPy--xKkkil0mfKwIudM0kq93jPRIr1aFF5iubyuHeV4xAEUrCHwB2E0
Message-ID: <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thank you for your review.

> > +             if (irq < 0 && irq != -ENXIO)
> > +                     return irq;
> >               if (irq > 0) {
>
> This if () is no longer needed.
>

If we remove the if (irq > 0) check, irq can be -ENXIO and would be
passed to devm_request_irq().
I see that the irq argument of devm_request_irq() is an unsigned int.
Would it be safe to pass -ENXIO to it in this case?

Best regards,
Phuc
