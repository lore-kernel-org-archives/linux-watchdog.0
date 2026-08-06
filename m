Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1447F780
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052418; cv=none; b=qHT063i2SJYSAVbf91BljR4n/dcwz6a7dEODOCDmxglUSc/JCfIcF3j+IJboLsnineuS0CdDuEoGow4iTgr6ywr0ifM34qrZk/y8/IIWs3dbxZAMIira+1aBy4ILIb1fboYcEEMli3IuGd5G1zlKRkukEnJLDDPOqO99NbqxhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052418; c=relaxed/simple;
	bh=cjsbCX9eJ88XtHfMp7TGiVsTzMGUWY5MXjYbpKtT6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oppNCej14N3YTUOkG6RK1PrJowDExuzELEQNkbuRW2tIgcsJWXUrDiVVz0dP2OF7kGTy/ZqWSZIA9wmTAM+BX5BwrNPapbBqYfRo4J4cOgGgD0INKdhaJUdpl+UaSZo1i0aqGfenGRKEp8d1FXCuZ2MP9umlJf8PARc3sKwiC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3wTZXRc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3wTZXRc"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e507b079dso1781228b3a.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052417; x=1786657217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SGZ57YsrCOkfhFnHb/TTHUwfSFARfj9zNgoNA+IWBJs=;
        b=I3wTZXRcKZumAfv9Xpz3bnwd+fAFQAg8uN6ubMESRVVso25mJx2F0MbYgvFbdPp/7r
         +EhZEa21XmPTFi5AuLlB4MBfbHHAVrbRinPhWBxqea1ZXVsusjCSSizDd6zNeLV492dc
         X00Z4XCUpU9i8P90TG0SMfzKkRkutDAK4ZT/DE0lLpeQS4vrp47RVW59l0tLoFcEAqNF
         b984DpxlAQyxb7nqZBRwZzej0kwDELOYQG3jMqinFEVZyCYPFKmP1O/+N9PSLNat0rg5
         mOASXcx7LGjHW4bUoRG7u3chqO09zJ5jKIhjHwBC8doNR/aeX/ni9/upyM4RTMXwogj4
         h4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052417; x=1786657217;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGZ57YsrCOkfhFnHb/TTHUwfSFARfj9zNgoNA+IWBJs=;
        b=ewNYiaX8of866RDxCPwIG4Vdji7IULzOc06Jp9dAKYw0R9YPnqNzxZ9FXg04IT87Jg
         2TQ6AyzimyQjwb+C4BKOTE8gizdq6sjKW0b+1KEUoTnBvpx1haRD3p/5SGiyko+tmCcB
         SZYFXKWLSDhIHhatwcM1Adz5OpztdbYEEHcuaDwy24HiZR/hB+46nLJ3Z2SPmSMQwVcR
         Kro4qlw6RXtlByNrdTkL3hAwopaUk8z/FHTImzXDCzUW7A7MCS9BXfaFq+VuiFn7mT1k
         O4mUuoKanKe3Xksna/43pSJIshp1B4FvDvl1LWOPfTwcmQoVxrvKt0AN8lDf+PHUIa7L
         uCog==
X-Forwarded-Encrypted: i=1; AHgh+RoXffwF2b55YIX5/GgLnpiZNx2OR//Rkemb6dCcY9iz/oTk5kRbwHRw2i3ffATtbHPQ8e9vePy6taybhDNZNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5crupN2YAFMMoOUD4mLgJqybLuhNmPWnjyB0lFSfU+xxutNY
	yMM6bV48UNp36d4cw86XjVCoMwhdzI7IqCq46gvq46S88kg24m4Sxpuz
X-Gm-Gg: AR+sD1055YO23UOQbplA9ImhRwl9NeF7i6Z5niBt2GXefz73va//BNZ4LvrWoaiQXL+
	qcHVVyrYtnS4VzS65+1N6Xds9uIwpr84jYR7KYi7F4Z10YuC+8onl8ElaIKkNbCkvcN5pfQyCKf
	r+OoWCifdZv/fMqK2aWgsQ1QNj4n/0puMvDqfKMcusCA0rAjLTnLy5FETHssdnTjYppYENg6euK
	S2L6FyH2zbUBfs4kD47rZ1jCV2awrArprpbt6IyiZrSBZZ1Sfe30eS7Mjx2r+JksEtBDlqLis2j
	MiZAk/Km8rgkRl6Dni/PZiNhDHUPSyhCVs6Pl2aVXa0IJrH5WgDuef9aeJy+qMJYe7wsYh0S+Xi
	e26Cm3snrazvAT6enFE4TXfmj6c4kMqymbtX2U/F6qjoFrzObgytiHM4q5V12FcuHy2OVujlsx4
	hMcub0Y92S83TuR4bv21G/ql2oUGgBzKUO7m3IUzrIfIi2CMgulpy96wP9BFN5+VnPodgoR+WlJ
	IJvuQ6zyJib
X-Received: by 2002:a05:6a00:b806:b0:847:e2c7:59b6 with SMTP id d2e1a72fcca58-84f2e031181mr20741708b3a.11.1786052416878;
        Thu, 06 Aug 2026 14:40:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8bb48b5esm7068a12.14.2026.08.06.14.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:40:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:40:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mayank Rungta <mrungta@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] nmi: Export CPU backtrace APIs for loadable modules
Message-ID: <6d32cd2e-9fff-436b-8410-c35aa24c5695@roeck-us.net>
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

Just to give an update: I'd love to apply this and the next patch of the
series, but I can not do wo without formal Ack from a maintainer (I did
that once and got burned for it, so it won't happen again).

I'll send an Ack to the next patch of the series, in case someone else
wants to pick it up.

Guenter
