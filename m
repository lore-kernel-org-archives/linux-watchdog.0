Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA633DED1
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331414; cv=none; b=eX5pnKsQFCoNnX9UcLkzs99191pvZPw5Is5e2gN8zEnz95VP6DxTIkrJLYkOTETqPTI9EfRlo/nbCsrEK6ni5Jyd8Gij67X2Q3XLqOj4OrwrWVL+goi7BbDd9V5hUEl+UJ+vAQQuXznXwG1GTd86IMipDEEX8Wg4ZhkghCH9UOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331414; c=relaxed/simple;
	bh=aH1hSKRiNGgf8KsCOPdLdt6ZYkzhPKtquLI/KTWl7J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRdxgppwWzFAufi0rhdxuF1R8vE6OL3gSDs9DwMyLrKjuYOoNO6vSfy7EbGg0rX4GjPH6vMJjiai6VJZKvq0ADr+Qz8WhTz+8dKWN6//CQXg0UMbjbinO61aATSzDIX59LXvATo7uKVmQ3/5g/Jx+OHF/86czZOTFlSgDlvugTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHTHTmU9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHTHTmU9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3811f512167so1515413a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787331412; x=1787936212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QPV8y0+iwn1DcqMSKr5CgKxGQQZzfWYknEvmjue3+2g=;
        b=cHTHTmU9/qL5Du48rzLwaWnWQ3VXojKFOpylCIEPnnNEoqsiWB4hDw8Gay+RMQUNiM
         kugcp4k2M4UaYHSddBF5BV3srQ55MfdxBO9n//0xZ5HDRHvPkGDF2m83XqPtN7vEQI3x
         0lzw7CU0sSIOTfOoNMSBea2UwpPEeXtsUAopZaBG8631LIZGmsrK12GGf2FNCHkaWwD1
         zg7vO4rPiPQptgF3MX/lfmu86+T1EChQPI3E8MXNs+micKEmlRWpHSz3o96f3Q7ANwFG
         u0EpRua8a75IxsIdOFk7qlNhette4UMmfoFRXD23f5L9Z8fTjW2+XsY5lWmpS5U9LlwW
         XdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787331412; x=1787936212;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPV8y0+iwn1DcqMSKr5CgKxGQQZzfWYknEvmjue3+2g=;
        b=I58f30SjWRetpOA4HYvaVexNMX1oJeps0T8QbYq2RZ1CaftXdwLsdWaGMmarxAyczV
         b0QB11RH2evEWoFlKNOM21c0ULQUoFkwV7jGa4M0NV/V0qEikezeRaRBlmm/XG80kZO2
         s4e1oqFDcOSyRFgRCb3Z7qpKFsISYI2wgqIkf6xTshdLmn3n14iZfVNGMZqj+FAG0mUH
         9gUa/PINZHG15k17m4v0MY6oZxuJQXKCAZ9JsQ8Jj9WmQDMriJuggzYccDlTEoue3gov
         29aKcaaAAIpwqaFrAl20VjG+H0Q1hzswfc901UAozn6mKSXYlYKpZqffiryEg7bD0tNe
         S/KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtZf5bDq5YXGmOx1jBjPxkEAuSpKO4R99W1CG6/JM3bLC739FSj3TvDi0IHUQ1gYeQZqdKfGm76K5/MUqKog==@vger.kernel.org
X-Gm-Message-State: AFuF++mWweo7347xXHNLHNKXrqGWe3eg/t2I2rkWIwmh9Fa7gkcFV5Sv
	1Ecmrf+VdTRs/JVXGlOOrnV9OKCOkzcEyIMIPzg/SENx6yY6n0n4cgoCQt+eQg==
X-Gm-Gg: AR+sD101wJaRxp55wYSXgaPBDZTsdyPwWhETEWhs40F1Pgx5+1yTB2XSssfMx2w+apO
	dI95tY6llsW4MZ3YESsD0VakVRrtc6ZyRIjLVkKaeER9IKRKzd31uPhTdHUoJXQ6oIlcBHMUUV0
	PNW63prt59/j9KS18G+pkjtRL+lRM5DomRK5rd+ZPXDPBq6m67rcdKKCANTdq3cwr6j6MonjaOo
	PCJ1QAmBdUcN4Wur/IoZvaZn0Mu9rHNDFSv+8tNp08NtmPmZ3DtOJDw9kdW4KHJUZgXB8r3lxyu
	LyQr8mhsCew6kDC9FEeKUY9qcxCm78qCDkkeemsJ7cAEN3qDR/pdQPPOZNg3Uc2iMXF4dUzw6rk
	Bkg6jtrHOKd1EramH+CntDAT0bQEwk3HwuoAzQfyaYRU3Sd69FebhDK3S6Dn/vYwYeyZF0H4cbu
	fPSroE7ciYRnnxlbclfCkpO7mpF+P74mA/pScld1zX0DrNvpTTLYQH9gqifMQfvo5OJ1XmOGHb8
	Q==
X-Received: by 2002:a17:90b:5844:b0:393:1d92:db5 with SMTP id 98e67ed59e1d1-395c35e1199mr15928060a91.10.1787331412130;
        Fri, 21 Aug 2026 09:56:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c49223c3sm3631209a91.11.2026.08.21.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:56:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Aug 2026 09:56:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christoph Berliner <caberliner@gmail.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: sp5100_tco: allow unreserved MMIO on
 GA-78LMT-USB3
Message-ID: <40b96a8d-02f9-4d29-a165-f137e330124d@roeck-us.net>
References: <20260820231409.8427-1-caberliner@gmail.com>
 <20260821142511.49934-1-caberliner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821142511.49934-1-caberliner@gmail.com>

On Fri, Aug 21, 2026 at 04:25:11PM +0200, Christoph Berliner wrote:
> The Gigabyte GA-78LMT-USB3 firmware programs the legacy SP5100
> watchdog MMIO window at 0xfec000f0. This address falls inside the
> IOAPIC resource, so sp5100_tco fails to reserve it and aborts probing.
> 
> Do not relocate or reprogram the watchdog. Instead, add a narrowly
> scoped DMI quirk for this board which permits use of the
> firmware-provided MMIO address without reserving it.
> 
> The exception is limited to the legacy SP5100 register layout, the
> GA-78LMT-USB3 DMI identity, and the firmware address 0xfec000f0.
> All other systems retain the existing resource reservation behavior.
> 
> On the affected system the watchdog initializes successfully and
> /dev/watchdog0 is registered while the firmware-programmed watchdog
> base remains unchanged at 0xfec000f0 during load and unload.
> 
> Tested on a Gigabyte GA-78LMT-USB3 with AMD SBx00 SMBus controller
> (PCI 1002:4385, revision 0x3c).
> 
> Signed-off-by: Christoph Berliner <caberliner@gmail.com>

Applied.

Thanks,
Guenter
