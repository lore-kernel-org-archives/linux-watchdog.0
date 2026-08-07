Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D154781
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 03:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074648; cv=none; b=mXx1hsGkW2MjN6nffrwGW+V/8XwUdDXJdbXSUct1TqbWa/HJkUpXaSB21r8u44mEH7Zv5oUWjfauL4Sc0TjgfIWfAtXtFJ/naiKPB1oefnnZMCrIZeUfZ0pQV2wnFO+qCqUFZluy994re0XWOzNtSwpiLJe1kh4sIgXYPd7ihRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074648; c=relaxed/simple;
	bh=mUsjsjkBn8CnyqDl5MUbZ2om5YD5FfWwQug6lrrnYmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceOnVbkeRuW1tS1jIwjiNxGod0qe/EKJJ8MFS6YAv3TirEvhWnLtt3xvcDf58zSUaj/ZulumvRssMSrB/ofU9foclcZXazqxYNP/+WHIl3mLVBBJqgSKs2Z0DiryhXfaxqQ7Z/hy+U42Nrln6Wxw6kr7QvvQmfq2rup5DuVPHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7wMi6FH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7wMi6FH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3169532a91.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 20:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074646; x=1786679446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q6t48m8YUcqzalJhF99ga7spn8OvY4N5ykADPiasa+I=;
        b=S7wMi6FHb6cx4B6q8JuBlEmO5JJRdY7re4rdqMLjAhZjqLLSvyLYRApRwp9K9DKFsE
         qTiAo4rwtESGFZLLKPX4G4+5Qn3RXMd65Dxj3/dydOLWufHwQ/WTD0ojlHjSLIuHNVzF
         PX+EudmpJ1/c3/q81muV/SbLou/Mjik1T5y+BfWpeuf9dA2rAzVzJLc199TsJSd1O1dh
         VKyNTxwdc4WMZjLdza/cdbc+61MqmTKdwv9DjLeIjr/mhNw/6aajKpgS2plrKXRqvECM
         ufSpyXLY0ndYXgzGa32d2LYKjpVbYcuT86+vVI4RNUZPpGOkOpz6movkCxLDSlc6xGZY
         KIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074646; x=1786679446;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6t48m8YUcqzalJhF99ga7spn8OvY4N5ykADPiasa+I=;
        b=RquO3TKmgMIubFLMdlkhc31Fxhkpuuxmsy+fQkrnoCPRxZvVRswiXwupD/zrY6RVo/
         c6YeTKlmK1ZwD0derlWMw2YH6vm49IsCqz45/fKNDL8x6gvu2/Fyl8lTOIuWAFDZYaSU
         7FsOktjznIBwWG7AAVNxLCwLnqsZfRph9ryp0+KlhR76Z5oPUG3U0NXpz/l80S11exDS
         tszGNAMrUYAU+c585k8C/bUPkbJL2GPYTmi2yM2Y+N6VIJSUDf4QusTDmvYrx1qKBnF0
         sRg/R5OAU+GVZugo1CqS6uXcIGqLneMFwJuPs7DIr4oXEH3Fbp4qxj4s1Unc/CSuF5Aa
         fmiA==
X-Forwarded-Encrypted: i=1; AHgh+RrAQ42ZYY8XqYFf+A+dDo3dECv4r4qh/HQh48WMzLwGs0h4VK2Asm8GXhmqSWndbiYX1IQTzSaxB31mbSHl2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34bwK9u7fpwIRc60kmFKsSSkr9LpYV2LFFVcpdNy2uTCDRlhv
	aaQBsH18QqK8KykzyvIx/UWS6k0nMWsrnoFBbpUmKnEgkeOmok+zmGcj
X-Gm-Gg: AR+sD13TGBpA2R4dJ6UtN64L66ixZuRVLwTGFTg1ILbwGtxAXOWdv/5ONvhj5GngyZt
	lEten3KY/kDJE9BKsv835RcHSGZj70yNyVdLeBNiWAiR5xnGsXaKEeqAnfs6JnvU/upxN77xP4x
	+e1FoxLFaqjCoJvzOVOK3G9bjylh4dtrpC0C0wicwZUvaSA36eB2OyUCg/ZZTNbh3aANvoNfjEB
	KnssWRgh9gKZQfczTp2rROFXjt5PAib5JrMPKIoPOI//ge9HhwnmLTTGZSCVXnZwmrj1K+dog6Y
	crdqwnbkYDWHpYjLuOqJMN3CGrM9P4tMwILCxCjAUJyacYu09wOVoHzkb/iwSJZFWgpLUB97rQY
	09X+U25y9RInwLyR5iP10i4W4oX7stEwo606SMK872mtZha3DJVsAOn+H7J1TyCNUjLtGJVtq7l
	WWbwm8AMIGLsT3N/rfjmtDAvrf7GbW8YpuTsmxk+pIB90s6uKyFE/PdOUGJGyi7kHAgaoywRjQH
	B2vUbVKyQY5
X-Received: by 2002:a17:90b:224e:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-3903c5b353bmr16905394a91.12.1786074646123;
        Thu, 06 Aug 2026 20:50:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95c40sm542414a91.8.2026.08.06.20.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:50:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 20:50:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mayank Rungta <mrungta@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: pretimeout: Convert dump pretimeout
 governor to tristate
Message-ID: <604ee620-5d1b-4134-9e92-6d3d54e7cc52@roeck-us.net>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
 <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>

On Thu, Jul 30, 2026 at 03:00:22PM -0700, Mayank Rungta wrote:
> From: Mayank Rungta <mrungta@google.com>
> 
> Commit 645ad41da8b2 ("watchdog: pretimeout: Add "dump" pretimeout
> governor") added the "dump" watchdog pretimeout governor, but restricted
> it to built-in code because trigger_all_cpu_backtrace() was not exported
> to loadable modules.
> 
> Now that CPU backtrace APIs are supported for loadable kernel modules
> via cpumask_backtrace(), convert WATCHDOG_PRETIMEOUT_GOV_DUMP to
> tristate. This allows kernels to deliver the pretimeout governor as a
> loadable kernel module.
> 
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

Applied.

Thanks,
Guenter
