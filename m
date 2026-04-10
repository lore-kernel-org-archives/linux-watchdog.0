Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E813DBD6C
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834370; cv=none; b=qCwO8WENLlCOBhQ/qf2MW7nxgqsed5TXVABWMfC7XxIBn5ETmHit0mUHthvvVCp1j6V9tIaOFaRVffOJWz1iRpNXnVWuKZpwfOdbhPq9ksmVNiBmgDc11N52IcMUCDwaw4HVvz/lG/xe8lHUPWw+8rKwP2YQPbirKNgh9U3Ch8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834370; c=relaxed/simple;
	bh=MwH/WucLijAHaNDytI577A/CNakmrl5slNZKBtFvgsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAibGWcsw4YjlFHsgwhWjx4iLiMTxoULCuI94bnZeg6pmcRI6631Rhf8ZOGqn9DgysQ27xXYxp3V7zI5ruOSlDPeKnBW/THa/okrvVuldLeFMv1KLuI01PBmyeL3C/fRHgn1zzPlQRgmDGXOcxF8X1y9W9OAl8HOTuC4BewWk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lncuj8yo; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lncuj8yo"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d17b8fbedaso944394eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775834368; x=1776439168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7ObF2b/IFmk4GCUBZOwS78VSlp53MCRHb7XjsIFZ+w=;
        b=Lncuj8yoLuJSO15TPNcLHDWXXUzsPxbBZZ8F1zsD6ClwaW20zlxLYdZLQC7kGqLF9J
         2SCYyFwoAcBEggHMvdWsdxPyGAEn3S8oUidT8oJ7lQSCFADQ9ZhiLSC93epYm8oSySfH
         1M+6r/pDVT9JeEXgnbtQbphyXz7T/DSjPvW6kGMt4zTtpYL3i+Ga1uGKS/znI/QO9Ivf
         PTtgT2PrxzmC6gJeUqACMy+2K4+gPH07zKEmWeOvUHljd0mixlWdNVZtGbCYeJAItMlO
         UpxjLRlnCo4j95hBdA5LWMjwXE54ggQdQUNGMX+yOS1cCVn8jCV2RsE7y3kpr+VyM8YL
         gCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834368; x=1776439168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7ObF2b/IFmk4GCUBZOwS78VSlp53MCRHb7XjsIFZ+w=;
        b=Y/c6YG0i/W5BkgWmMx0h43wHs4TGYAKYe899fzqDNjrYEztJnkNNQfrEkV5WpbGypt
         TSSg0oeN/axiyc7rkojoDKc7d/Z1QEDzl/Iutrxt/Ju93gSaJQ8ZhccMvLKYnznavBaD
         99r2fIwKlx8ZJTxPIm1eX4VzSip4smo1lSOy4RptULbo1q5up/5iUAWXbs33Kn6HelNF
         vOnSrCKzgkbz+qYzluszIOwjDrdfusW+2W3loLqW6inwNS9uaKIr/3EW5OZSYHx7TZ7e
         l3n7O+Rch5XhWAFt6Ec92kffPSORz6hJpG0wxh3UPLTbYxZcqWEbCXg+NIgMrUBy+9z4
         11Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWZUkHTvEkCe+ugX0MpsnCKt36ZspDOqixKIN+DKbPZvtfwOKCJoGBQ6BEhPUawJHWlTUGZ9l7ccTvlY/fskQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPil3COUYXDxIJR7Zm5y++nnOTl4As5wuRWgu1DVWKLOBEyoX
	WLUPYPgnvNBE20+L2vAC1ezAgrkTxKr3lZWAnsu6fEfjZlpL9+kSffS8
X-Gm-Gg: AeBDievnNlF7Tdb53nixeUaN0fr65EpKqEoLEadPrd44zXtzvNah5mQSltnktvYYGgc
	eCeESpQ5UV0AZ8cKxDvn+7aeTSqfKUR3kjDitaeeZKiBPeDmgf9fjXT/Jje4MzLVnyJR/HIGOB9
	ixLfdCptY6Wa8c3zwe9bcvVFPf2MyEBjoyb4kqGfpOOZsQHcU09uET+oWrou/Ju/zV8A9VHn7QY
	9a9Pzz6x3h1umOQRNroous2esGkZtjTMTPinJ2zwDsuFsxnA5FQXNdLRPqT7WaT6GEYAhbXVhmT
	btel5vK+gF2IO9L5l0Qs+9vwpPTmrrHZKTM/Z3nfjHNe0wtRhpyob/LeCgB0bgPOWuiVzhmQnJK
	ZVep8ApTjIN3/549Coxe9u2oNGlWcn05hgTLK6ZXo5Mrhx2CA8Z5g1MXV84KEUBhKRHlsRw1gFV
	+M3bE57XZG9KK7a54Mvc3KOcB7yMXHDoqT4p8lDOmZMRQqgfw=
X-Received: by 2002:a05:7300:5713:b0:2ca:bd22:6102 with SMTP id 5a478bee46e88-2d4101c572cmr4053457eec.14.1775834367665;
        Fri, 10 Apr 2026 08:19:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm4533921eec.27.2026.04.10.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:19:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 08:19:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sunny Patel <nueralspacetech@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Refactored watchdog old doc
Message-ID: <fe3de980-e918-47ae-862a-969a5b117ae0@roeck-us.net>
References: <132f7e64-4fc6-4274-a04e-e53f0b957665@roeck-us.net>
 <20260410072825.19114-1-nueralspacetech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410072825.19114-1-nueralspacetech@gmail.com>

On Fri, Apr 10, 2026 at 12:58:11PM +0530, Sunny Patel wrote:
> Good Point. So again revisited the watchdog core
> api and list out the deprecated one and marked
> as deprecated in doc and also mentioned it just
> for legacy driver and not for newer one.
> 
> As someof the legacy driver still have reference 
> to old api so just marked as deprecated in doc.
> 
> Also checked with other watchdog related api
> which are deprecated in driver but still present 
> in doc but didn't find any.
> 
> ---

The above would show up as commit message, there is no change log, and
this e-mail was sent as response to v1. And I can see that without even
looking at the patch itself.

That makes me wonder what Documentation/process/submitting-patches.rst
is useful for. No one seems to bother reading it. We might as well
just remove it.

Guenter
